Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20844506D4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 15:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbhKOO3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 09:29:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59356 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231902AbhKOO21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 09:28:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636986330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0xi5SdYzOCiQ3wcsyCBT9yaWipl83NDOOBepkQK2e4I=;
        b=UI2GjsJLQljUvdqZ9jHax5Qb0bMHzVm4W63YpGPhTuv5gPWmJc1HQw1tQ0ipeTlF6JOuGa
        nrUa4XbO4hqPdoDrYb1CeJY6Xb6nHC3NcOZP6SVoSjh+v4+ypIkbRQOwe7DVlIFZDzwgaT
        1p+tQcn1zT/12ikXDeT3Zw7VH3MFd/Q=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-p6zmaO9IMXaAoiZInlqh0w-1; Mon, 15 Nov 2021 09:25:29 -0500
X-MC-Unique: p6zmaO9IMXaAoiZInlqh0w-1
Received: by mail-qk1-f198.google.com with SMTP id p18-20020a05620a057200b00467bc32b45aso11125239qkp.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 06:25:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0xi5SdYzOCiQ3wcsyCBT9yaWipl83NDOOBepkQK2e4I=;
        b=kxtTDrjCPZpZ8x1qKIQzvYZ3H/9x/67A1BrGf7eKGS5vFdrM9NfUyNyf11dI2thU9i
         yjueoQHywCWr++8lG02TPmfGdf6M0ZegUfEG7jiXXYxgeDGv6WDhV6k9pDvn9nLPomwA
         cChO3ogarIIvsvXoqy7+Jhfk3O44SAPLMjJMIRfLyb6ZJbAJmucjpfpM7hwFdpzOyicQ
         UAf9y2nJCF7UMi4TMV4Awmo7KNf3Mb7SroQrNf7O8+Wyj+ZWUw9UHgmTmA/PXrg/9QLV
         XFipen1tPdeIid17cMdnqvapqFcZzWv7z2k0XJResjL8+LSkRIfWoCTYeCYbkTF76TVb
         WFqw==
X-Gm-Message-State: AOAM5328Sf2L7ZwazJK6bqF2vuv/8q75qMO9NhwiqtspsEaL/WvkebEh
        RH+Cj21dbB2Yu5Kg5mjHUaSevop2Z6d9FA2zxEMc4e8xa9eVTqhVpf8H0LmrlV/lcKOxFmE19d6
        Oe4mpJJ+CFBRRGnyqvl3WJCkD
X-Received: by 2002:a05:6214:500b:: with SMTP id jo11mr37416272qvb.64.1636986328947;
        Mon, 15 Nov 2021 06:25:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxwxinVaOYZuJYOoG92E4VGwrNYk43hGTO3M7WBplGjZp1A6GfnChJ3ORMv39sMvL8/DtiZLA==
X-Received: by 2002:a05:6214:500b:: with SMTP id jo11mr37416236qvb.64.1636986328672;
        Mon, 15 Nov 2021 06:25:28 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id t11sm6354632qkp.56.2021.11.15.06.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 06:25:28 -0800 (PST)
Date:   Mon, 15 Nov 2021 09:25:26 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Ian Kent <raven@themaw.net>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2 1/2] vfs: check dentry is still valid in get_link()
Message-ID: <YZJt1rN7TK8eh7xj@bfoster>
References: <163694289979.229789.1176392639284347792.stgit@mickey.themaw.net>
 <163694306216.229789.2523433978081516384.stgit@mickey.themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <163694306216.229789.2523433978081516384.stgit@mickey.themaw.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 10:24:22AM +0800, Ian Kent wrote:
> When following a trailing symlink in rcu-walk mode it's possible for
> the dentry to become invalid between the last dentry seq lock check
> and getting the link (eg. an unlink) leading to a backtrace similar
> to this:
> 
> crash> bt
> PID: 10964  TASK: ffff951c8aa92f80  CPU: 3   COMMAND: "TaniumCX"
> …
>  #7 [ffffae44d0a6fbe0] page_fault at ffffffff8d6010fe
>     [exception RIP: unknown or invalid address]
>     RIP: 0000000000000000  RSP: ffffae44d0a6fc90  RFLAGS: 00010246
>     RAX: ffffffff8da3cc80  RBX: ffffae44d0a6fd30  RCX: 0000000000000000
>     RDX: ffffae44d0a6fd98  RSI: ffff951aa9af3008  RDI: 0000000000000000
>     RBP: 0000000000000000   R8: ffffae44d0a6fb94   R9: 0000000000000000
>     R10: ffff951c95d8c318  R11: 0000000000080000  R12: ffffae44d0a6fd98
>     R13: ffff951aa9af3008  R14: ffff951c8c9eb840  R15: 0000000000000000
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>  #8 [ffffae44d0a6fc90] trailing_symlink at ffffffff8cf24e61
>  #9 [ffffae44d0a6fcc8] path_lookupat at ffffffff8cf261d1
> #10 [ffffae44d0a6fd28] filename_lookup at ffffffff8cf2a700
> #11 [ffffae44d0a6fe40] vfs_statx at ffffffff8cf1dbc4
> #12 [ffffae44d0a6fe98] __do_sys_newstat at ffffffff8cf1e1f9
> #13 [ffffae44d0a6ff38] do_syscall_64 at ffffffff8cc0420b
> 
> Most of the time this is not a problem because the inode is unchanged
> while the rcu read lock is held.
> 
> But xfs can re-use inodes which can result in the inode ->get_link()
> method becoming invalid (or NULL).
> 
> This case needs to be checked for in fs/namei.c:get_link() and if
> detected the walk re-started.
> 
> Signed-off-by: Ian Kent <raven@themaw.net>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  0 files changed
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 1946d9667790..9a48a6106516 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1760,8 +1760,11 @@ static const char *pick_link(struct nameidata *nd, struct path *link,
>  	if (!res) {
>  		const char * (*get)(struct dentry *, struct inode *,
>  				struct delayed_call *);
> -		get = inode->i_op->get_link;
> +		get = READ_ONCE(inode->i_op->get_link);
>  		if (nd->flags & LOOKUP_RCU) {
> +			/* Does the inode still match the associated dentry? */
> +			if (unlikely(read_seqcount_retry(&link->dentry->d_seq, last->seq)))
> +				return ERR_PTR(-ECHILD);
>  			res = get(NULL, inode, &last->done);
>  			if (res == ERR_PTR(-ECHILD) && try_to_unlazy(nd))
>  				res = get(link->dentry, inode, &last->done);
> 
> 

