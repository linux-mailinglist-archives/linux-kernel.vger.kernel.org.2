Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14DCE396757
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbhEaRqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbhEaRq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 13:46:29 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E4CC0612A3
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 10:12:36 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lnlSp-0032Lo-CH; Mon, 31 May 2021 17:12:31 +0000
Date:   Mon, 31 May 2021 17:12:31 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC 5/9] iov_iter: Add iov_iter_fault_in_writeable()
Message-ID: <YLUY/7pcFMibDnRn@zeniv-ca.linux.org.uk>
References: <20210531170123.243771-1-agruenba@redhat.com>
 <20210531170123.243771-6-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531170123.243771-6-agruenba@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 07:01:19PM +0200, Andreas Gruenbacher wrote:
> Add the equivalent of iov_iter_fault_in_readable(), but for pages that
> will be written to.
> 
> While at it, fix an indentation error in iov_iter_fault_in_readable().

> +int iov_iter_fault_in_writeable(struct iov_iter *i, size_t bytes)
> +{
> +	size_t skip = i->iov_offset;
> +	const struct iovec *iov;
> +	int err;
> +	struct iovec v;
> +
> +	if (!(i->type & (ITER_BVEC|ITER_KVEC))) {
> +		iterate_iovec(i, bytes, v, iov, skip, ({
> +			err = fault_in_pages_writeable(v.iov_base, v.iov_len);
> +			if (unlikely(err))
> +				return err;
> +		0;}))
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL(iov_iter_fault_in_writeable);

I really don't like that.  Conflicts with iov_iter patches are not hard to
deal with, but (like fault_in_pages_writeable() itself) it's dangerous as
hell - fault-in for read is non-destructive, but that is *not*.  Existing
users have to be careful with it and there are very few of those.  Adding
that as a new primitive is inviting trouble; at the very least it needs
a big fat "Don't use unless you really know what you are doing" kind of
warning.
