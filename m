Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173953A50C8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 23:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbhFLVOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 17:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhFLVOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 17:14:38 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583CCC061574
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 14:12:38 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lsAvh-007RAr-8b; Sat, 12 Jun 2021 21:12:33 +0000
Date:   Sat, 12 Jun 2021 21:12:33 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC 5/9] iov_iter: Add iov_iter_fault_in_writeable()
Message-ID: <YMUjQYtBCIxHvsYV@zeniv-ca.linux.org.uk>
References: <20210531170123.243771-1-agruenba@redhat.com>
 <20210531170123.243771-6-agruenba@redhat.com>
 <YLUY/7pcFMibDnRn@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLUY/7pcFMibDnRn@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 05:12:31PM +0000, Al Viro wrote:

> > +int iov_iter_fault_in_writeable(struct iov_iter *i, size_t bytes)
> > +{
> > +	size_t skip = i->iov_offset;
> > +	const struct iovec *iov;
> > +	int err;
> > +	struct iovec v;
> > +
> > +	if (!(i->type & (ITER_BVEC|ITER_KVEC))) {
> > +		iterate_iovec(i, bytes, v, iov, skip, ({
> > +			err = fault_in_pages_writeable(v.iov_base, v.iov_len);
> > +			if (unlikely(err))
> > +				return err;
> > +		0;}))
> > +	}
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(iov_iter_fault_in_writeable);
> 
> I really don't like that.  Conflicts with iov_iter patches are not hard to
> deal with, but (like fault_in_pages_writeable() itself) it's dangerous as
> hell - fault-in for read is non-destructive, but that is *not*.  Existing
> users have to be careful with it and there are very few of those.  Adding
> that as a new primitive is inviting trouble; at the very least it needs
> a big fat "Don't use unless you really know what you are doing" kind of
> warning.

Actually, is there any good way to make sure that write fault is triggered
_without_ modification of the data?  On x86 lock xadd (of 0, that is) would
probably do it and some of the other architectures could probably get away
with using cmpxchg and its relatives, but how reliable it is wrt always
triggering a write fault if the page is currently read-only?

I mean, something like
	do {
		r0 = r = *p
		atomically [if (*p == r) *p = r; r = *p;]
	} while (r != r0);
would look like a feasible candidate, but what if the processor
"optimizes" that cmpxchg to simple load, seeing that new value is
equal to expected old one?
