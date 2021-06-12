Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035843A510C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 23:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhFLVte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 17:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhFLVtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 17:49:33 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A8EC061574
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 14:47:33 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lsBTV-007RbK-Mn; Sat, 12 Jun 2021 21:47:29 +0000
Date:   Sat, 12 Jun 2021 21:47:29 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC 5/9] iov_iter: Add iov_iter_fault_in_writeable()
Message-ID: <YMUrcUXS5jprfGPF@zeniv-ca.linux.org.uk>
References: <20210531170123.243771-1-agruenba@redhat.com>
 <20210531170123.243771-6-agruenba@redhat.com>
 <YLUY/7pcFMibDnRn@zeniv-ca.linux.org.uk>
 <YMUjQYtBCIxHvsYV@zeniv-ca.linux.org.uk>
 <CAHk-=whcnziOWqVESWKJ6Y1_sG2S2AOa1vv5yKzUGs5gM7qYpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whcnziOWqVESWKJ6Y1_sG2S2AOa1vv5yKzUGs5gM7qYpQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2021 at 02:33:31PM -0700, Linus Torvalds wrote:

> That said, reads are obviously much easier, and I'd probably prefer
> the model for writes to be to not necessarily pre-fault anything at
> all, but just write to user space with page faults disabled.

*nod*
I don't like that write pre-fault model at all - note that unlike read
we'll end up with atomic operations, etc. and there's a plenty of
non-obvious ways for that to end up being costly, even assuming it
works correctly in all cases.

	O_DIRECT case is a PITA - there we use GUP and there's no way
to tell GUP that in the current situation we do *NOT* want to hit
->fault()/->page_mkwrite()/etc.  pagefault_disable() won't be even
noticed there...
