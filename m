Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D228634C42D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 08:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhC2G4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 02:56:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52622 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230252AbhC2G4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 02:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617000963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4GdsC9nTr5c3d2LljxYrJ0LZy9p6iV8bgPQvynNu1wU=;
        b=L9Q6TOwuns2dX/aweeRPK31yIDt//HbDucCKk+4s841B3FJqw+OnmaLhFS+xmGShuBl3jd
        LWWDOOGeSokRX9fcKORSywLVZSQah6+vZD+nGlFDYx/aTlohjD4RLdO7UM1odB3J8OY9XT
        GD97ULwdHbGjlYzHjarLwaVfW2jdE2M=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-xOnGxEnqMxi4sEOGIpeacg-1; Mon, 29 Mar 2021 02:56:01 -0400
X-MC-Unique: xOnGxEnqMxi4sEOGIpeacg-1
Received: by mail-pg1-f199.google.com with SMTP id r1so9836228pgg.12
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 23:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4GdsC9nTr5c3d2LljxYrJ0LZy9p6iV8bgPQvynNu1wU=;
        b=kt2LPyRs51XGHl0eZfWdwJCjlpBn8II4ORIkAnH5znj+o5wsclw2vgo7RBJPJXP5tA
         PshgzdcHhEP/LtIU3yIqCarJ1lS/fsotyD8Fyun8pM4ec+SUA5mTmM4wftnNlG21gJ4q
         Mnh31B/uTEDjPHQrWtO7r/PkXhlfxeGzj16w/Fy0OGgSZ4NbEkduomuHEWcR3WUCMJZs
         DGobfpF+40t3eo4qKhz3mBkrP8Jhg5h1VRsoG9MYf8aI49vq+Zr/gvRdanBqTJSCZ3/G
         mOfmApJLQ+ktmDD2ozW+lop1HmpG9Fnb05PUNujMuqAEkWDAUpESP3CFkduhB1cWKPWC
         Qleg==
X-Gm-Message-State: AOAM531oeTgAxXxK/IlQR/LS+Hc7AKtXDghFAoQ/N3CvGtaqbnlicE2a
        +u5y/XXMLxr0oFnxgNNsUtXuQwifLzOsGhGwCMXk/XKIW+4rDhzp9T5hVn9BcL9TEZ/+lXNVe/p
        I0K4f/UZXdFdP92PnxQDBKh/s
X-Received: by 2002:a17:90a:de90:: with SMTP id n16mr25478493pjv.10.1617000960142;
        Sun, 28 Mar 2021 23:56:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVnvIpHWr9jmHxyVlRZhQuRAZlLVivU+kZ7hoLnDagGVhYbw2c+KNBs3otjq+KdmCPzMh86Q==
X-Received: by 2002:a17:90a:de90:: with SMTP id n16mr25478473pjv.10.1617000959917;
        Sun, 28 Mar 2021 23:55:59 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f6sm16425302pfk.11.2021.03.28.23.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 23:55:59 -0700 (PDT)
Date:   Mon, 29 Mar 2021 14:55:49 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Gao Xiang <hsiangkao@aol.com>, linux-erofs@lists.ozlabs.org,
        Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] erofs: add on-disk compression configurations
Message-ID: <20210329065549.GB3281654@xiangao.remote.csb>
References: <20210329012308.28743-1-hsiangkao@aol.com>
 <20210329012308.28743-5-hsiangkao@aol.com>
 <f24bd7dc-54c3-1c19-a461-97ddca778c06@huawei.com>
 <20210329063625.GA3293200@xiangao.remote.csb>
 <3c0bf7e5-0924-3d85-56db-35a2d39dbb8d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3c0bf7e5-0924-3d85-56db-35a2d39dbb8d@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 02:43:48PM +0800, Chao Yu wrote:

...

> > > > +
> > > > +static int erofs_load_compr_cfgs(struct super_block *sb,
> > > > +				 struct erofs_super_block *dsb)
> > > > +{
> > > > +	struct erofs_sb_info *sbi;
> > > > +	struct page *page;
> > > > +	unsigned int algs, alg;
> > > > +	erofs_off_t offset;
> > > > +	int size, ret;
> > > > +
> > > > +	sbi = EROFS_SB(sb);
> > > > +	sbi->available_compr_algs = le16_to_cpu(dsb->u1.available_compr_algs);
> > > > +
> > > > +	if (sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS) {
> > > > +		erofs_err(sb,
> > > > +"try to load compressed image with unsupported algorithms %x",
> > > 
> > > Minor style issue:
> > > 
> > > 			"try to load compressed image with unsupported "
> > > 			"algorithms %x",
> > > 			sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS);
> > 
> > If I remembered correctly, kernel code style suggests "don't break the print
> > message, it'd more easy to grep". Actually such style above is from XFS, and
> > can pass checkpatch.pl check, see:
> > 
> > (fs/xfs/xfs_log_recover.c) xlog_recover():
> > 		/*
> > 		 * Version 5 superblock log feature mask validation. We know the
> > 		 * log is dirty so check if there are any unknown log features
> > 		 * in what we need to recover. If there are unknown features
> > 		 * (e.g. unsupported transactions, then simply reject the
> > 		 * attempt at recovery before touching anything.
> > 		 */
> > 		if (XFS_SB_VERSION_NUM(&log->l_mp->m_sb) == XFS_SB_VERSION_5 &&
> > 		    xfs_sb_has_incompat_log_feature(&log->l_mp->m_sb,
> > 					XFS_SB_FEAT_INCOMPAT_LOG_UNKNOWN)) {
> > 			xfs_warn(log->l_mp,
> > "Superblock has unknown incompatible log features (0x%x) enabled.",
> > 				(log->l_mp->m_sb.sb_features_log_incompat &
> > 					XFS_SB_FEAT_INCOMPAT_LOG_UNKNOWN));
> > 			xfs_warn(log->l_mp,
> > "The log can not be fully and/or safely recovered by this kernel.");
> > 			xfs_warn(log->l_mp,
> > "Please recover the log on a kernel that supports the unknown features.");
> > 			return -EINVAL;
> > 		}
> > 
> > If that does't look ok for us, I could use > 80 line for this instead,
> > but I tend to not break the message ..
> 
> Xiang,
> 
> Ah, I didn't notice this is following above style, if it's fine to you,
> let's use some tabs in front of message line, though it will cause
> exceeding 80 line warning.
> 

I found a reference here,
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?h=v5.11#n99
also vaguely remembered some threads from Linus, but hard to find now :-(

ok, I will insert tabs instead, thanks for the suggestion!

Thanks,
Gao Xiang


> Thanks,

