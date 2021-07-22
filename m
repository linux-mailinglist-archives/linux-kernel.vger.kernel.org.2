Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389F33D1A9E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 02:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhGUXep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 19:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhGUXeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 19:34:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34DBC061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 17:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JlC7x4HHDcOKXJYHkjPYWZJQfgICJvrDTgByLHtxKD8=; b=CIgPBTORGNndgMQ80q6kGI77rm
        WoNQINcAfsU2DnAI6JmbJNvDcj1Ov4uh2HKB8nWXwbEtb+2YGNkUaGyRZ1WzKG4v1ypHvpMhtk3xD
        8P6UKuiElHOOm/2U6ymEahBCkbLGFlX8+12cRcrjTUQhdBUkgJuFwITT6cneOeY90kTiV7SnYC9Cl
        2FaFXvRbxckywvrtZb1Hemd5JiamMf0JEhPu00XmDivzfz5wUMc0yj9qYQ4jyYOdABR5Cj1qZpAP6
        L99VoK5rop2NnFiD1LB6ujQCRTXttHXmyVxWjqi4U+GgT7Gou5ZxeIfVTgik8ksfTQVSUJID5q6YP
        VqbtGFIQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6MM9-009jO8-HH; Thu, 22 Jul 2021 00:14:44 +0000
Date:   Thu, 22 Jul 2021 01:14:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Qualys Security Advisory <qsa@qualys.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: Make kvmalloc refuse to allocate more than 2GB
Message-ID: <YPi4ZWzoKUvkJMJG@casper.infradead.org>
References: <20210721184131.2264356-1-willy@infradead.org>
 <CAHk-=wjOZQ1yvG+FvP-sDgGaDzmXoxC7KjDMUerw_Z2QYyAHmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjOZQ1yvG+FvP-sDgGaDzmXoxC7KjDMUerw_Z2QYyAHmA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 01:46:09PM -0700, Linus Torvalds wrote:
> On Wed, Jul 21, 2021 at 11:42 AM Matthew Wilcox (Oracle)
> <willy@infradead.org> wrote:
> >
> > It's generally dangerous to allocate such large quantities of memory
> > within the kernel owing to our propensity to use 'int' to represent
> > a length.  If somebody really needs it, we can add a kvmalloc_large()
> > later, but let's default to "You can't allocate that much memory".
> 
> I really think that without the WARN_ON_ONCE(), this is just moving
> that failure point from a known good place ("we know this must not
> succeed") to a possibly bad place ("this might cause silent and
> hard-to-understand failures elsewhere").

To a certain extent, yes.  On the other hand, if you don't have any
error handling on your kvmalloc of 2GB, Qualys seems to have a reliable
way to run you out of vmalloc space, and that's going to get exercised.

My initial thought was to leverage the existing __GFP_NOWARN code:

        if (size > PAGE_SIZE) {
-               kmalloc_flags |= __GFP_NOWARN;
+               if (size <= INT_MAX)
+                       kmalloc_flags |= __GFP_NOWARN;

because that dumps some interesting information (ratelimited), which
might help the sysadmin realise they're under attack.  A WARN_ON_ONCE
is one-and-done, so an attacker can hide their tracks.  Unfortunately,
we actually bail out before getting there:

        if (unlikely(order >= MAX_ORDER)) {
                WARN_ON_ONCE(!(gfp & __GFP_NOWARN));
                return NULL;
        }

... maybe that should call warn_alloc() too.

So I'm now thinking (relative to the earlier patch):

-       if (size > INT_MAX)
+       if (size > INT_MAX) {
+               warn_alloc(flags, NULL, "oversized allocation:%zu", size);
                return NULL;
+       }


