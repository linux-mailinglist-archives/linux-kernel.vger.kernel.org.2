Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53263C17B6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 19:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhGHRIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 13:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbhGHRIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 13:08:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6F8C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 10:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3fx3PknPwALzsgoH1BEN/LFvMNGd9Ult799sX+NQQtw=; b=ewNur+WRDTeCU1XmdHtflzT0wV
        BqTeEy3EhFKg1dnvnfooIBavr8RUDn3TLbL5etUV5VednLO7QODNyRteMI/Wp16CEHxARoWJHVKLe
        UQI3+ESuZjRuSlIbD5X+Aeyr4E9PTs2coRXnevJ/t1+VyNMGH30nMW4i0I+80SEOBQ3Q4s9FXRZA1
        h63kI1ofm68YL5xyjTUoyz6O9Dh5LTmmU6hinmg1sOffSJ6Kof1upMqfAnYlgrqVKbUsZ4nNoGlZM
        n8WK9px4nrQ+IIcYEp2s0ebhvZF6lqE+B3DlrPM7od9jcIxvkSLd0ii0yOvqGcfTor4RqEU8xBTvS
        oMLe0knQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m1XSq-00DfW0-R8; Thu, 08 Jul 2021 17:05:31 +0000
Date:   Thu, 8 Jul 2021 18:05:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        Zqiang <qiang.zhang@windriver.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+127fd7828d6eeb611703@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/page_alloc: Avoid page allocator recursion with
 pagesets.lock held
Message-ID: <YOcwWBJw4uZH8X3f@casper.infradead.org>
References: <20210708081434.GV3840@techsingularity.net>
 <YOb5OrkqjWu4TODN@optiplex-fbsd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOb5OrkqjWu4TODN@optiplex-fbsd>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2021 at 09:10:18AM -0400, Rafael Aquini wrote:
> > There are a number of ways it could be fixed. The page owner code could
> > be audited to strip GFP flags that allow sleeping but it'll impair the
> > functionality of PAGE_OWNER if allocations fail. The bulk allocator
> > could add a special case to release/reacquire the lock for prep_new_page
> > and lookup PCP after the lock is reacquired at the cost of performance.
> > The patches requiring prep could be tracked using the least significant

If we're nitpicking changelogs, then s/patches/pages/

> > bit and looping through the array although it is more complicated for
> > the list interface. The options are relatively complex and the second
> > one still incurs a performance penalty when PAGE_OWNER is active so this
> > patch takes the simple approach -- disable bulk allocation of PAGE_OWNER is
>                                                             ^^^^
> Minor nit: s/of/if
> 
> > active. The caller will be forced to allocate one page at a time incurring
> > a performance penalty but PAGE_OWNER is already a performance penalty.

The thought occurs that all pages allocated this way will have the same
stack.  Someone suitably motivated could:

 - Refcount the stacks managed by page_owner
 - Generate the stack in the caller of alloc_bulk
 - Pass the stack in to a new __set_page_owner()

That's a lot of work; I'm not going to do it, and I don't think Mel
should either.  But if someone's looking for something to do ...
