Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2503A5164
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 01:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhFLXkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 19:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhFLXkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 19:40:23 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6AEC061574
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 16:38:22 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lsDCj-007TCx-0F; Sat, 12 Jun 2021 23:38:17 +0000
Date:   Sat, 12 Jun 2021 23:38:16 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC 5/9] iov_iter: Add iov_iter_fault_in_writeable()
Message-ID: <YMVFaPZtg7ijvYe2@zeniv-ca.linux.org.uk>
References: <20210531170123.243771-1-agruenba@redhat.com>
 <20210531170123.243771-6-agruenba@redhat.com>
 <YLUY/7pcFMibDnRn@zeniv-ca.linux.org.uk>
 <YMUjQYtBCIxHvsYV@zeniv-ca.linux.org.uk>
 <CAHk-=whcnziOWqVESWKJ6Y1_sG2S2AOa1vv5yKzUGs5gM7qYpQ@mail.gmail.com>
 <YMUrcUXS5jprfGPF@zeniv-ca.linux.org.uk>
 <CAHk-=wgoBx_GzTQMj_HQGAR+f+7VRJ6JbU9UBfuPHKLfTVMPGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgoBx_GzTQMj_HQGAR+f+7VRJ6JbU9UBfuPHKLfTVMPGQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2021 at 04:17:30PM -0700, Linus Torvalds wrote:
> On Sat, Jun 12, 2021 at 2:47 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >         O_DIRECT case is a PITA - there we use GUP and there's no way
> > to tell GUP that in the current situation we do *NOT* want to hit
> > ->fault()/->page_mkwrite()/etc.  pagefault_disable() won't be even
> > noticed there...
> 
> Well, we could change that.
> 
> And we do have get_user_pages_fast_only() these days.

FWIW, I'm looking through the users of iov_iter_get_pages{,_alloc}()
right now; their semantics feels somewhat wrong.  Will follow up
when I finish looking through that pile...
