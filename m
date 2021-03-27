Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8CDA34B610
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 11:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhC0KUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 06:20:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35182 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231267AbhC0KUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 06:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616840449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Iohr6m49kXpruLbyu6Jjrq1tJB8EijNtO1XFnYRAYkA=;
        b=Q/jeTaZy7+duDlKcv3JCD85VO+VHFU9AlYe1id4HMgydRMZpQKwyP+900k9jdU8C9mXvwh
        71GoUAs/BkDZPhKvOvSEIvX7/QOSO+xLk8X4IvLcva9ITpdgaZn6Pc5iPfcRyezQU8udXH
        nwZFtWKWcHxnzv4lftOBGL73ursl2Rk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-oWbJQbIUNvSOsr2LtXBFbA-1; Sat, 27 Mar 2021 06:20:47 -0400
X-MC-Unique: oWbJQbIUNvSOsr2LtXBFbA-1
Received: by mail-pl1-f200.google.com with SMTP id 17so3944914plj.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 03:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Iohr6m49kXpruLbyu6Jjrq1tJB8EijNtO1XFnYRAYkA=;
        b=B1ip2d8Ws3QMHtCT3YexIgkfNGha7VkOEpw1EIZdAPqMD87ewSkNkQVwTJbNfkAv02
         kOuJuDCjcKDC01c2xYBjCs/Yvt8LpQkGSsLFemY93Ugc1CIvgSXrR0u8a8M1wlwM3ZiS
         zgeLgnrcGceeyUsuZUJy9rPKYaqzbNjvZoUdEY5S5G6qAY1mLsOrXaXnum9nDy8gIoP1
         df9Fmp92M8ZNO9tQz39bXeezKKw3m3CXEhWjjXmgXKXaUNRuPtYTG5lYof2csS8wZiYt
         f3ILEs3Wf3ljNSF+mTpyoUV4bXx49Karw3Q8tfQOQM4+yDe9LkY937lesoiMdPsPgkQc
         zCvA==
X-Gm-Message-State: AOAM530QWRvCvIRVFy+gapJlXaruiqCYssFggTsP0r0T7DuMw/N+8OCc
        zzNqrMZw7OikLRYQK3/DrJ6Iim4tiMDd9LMQcz4bI20Jbu/Da1miMAct8P/y5C9PsMbns5b6Pe4
        AagBZmx0P1xoE3+4Oj9XrTbOP
X-Received: by 2002:a17:90a:5d10:: with SMTP id s16mr17940386pji.126.1616840446513;
        Sat, 27 Mar 2021 03:20:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylMuo26yauvlRzltRPYVWiF63PKE/EzgtsMieWbTzfxUNaiOYW3vspNONHDCz0l5pdB9TZ9Q==
X-Received: by 2002:a17:90a:5d10:: with SMTP id s16mr17940369pji.126.1616840446262;
        Sat, 27 Mar 2021 03:20:46 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z1sm11802846pfn.127.2021.03.27.03.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 03:20:46 -0700 (PDT)
Date:   Sat, 27 Mar 2021 18:20:35 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Gao Xiang <hsiangkao@aol.com>, linux-erofs@lists.ozlabs.org,
        Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] erofs: add on-disk compression configurations
Message-ID: <20210327102035.GC2995728@xiangao.remote.csb>
References: <20210327034936.12537-1-hsiangkao@aol.com>
 <20210327034936.12537-5-hsiangkao@aol.com>
 <7a2b76ff-f86f-79ce-d6e9-f8c359f90ae4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7a2b76ff-f86f-79ce-d6e9-f8c359f90ae4@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On Sat, Mar 27, 2021 at 05:46:44PM +0800, Chao Yu wrote:
> On 2021/3/27 11:49, Gao Xiang wrote:
> > From: Gao Xiang <hsiangkao@redhat.com>
> > 
> > Add a bitmap for available compression algorithms and a variable-sized
> > on-disk table for compression options in preparation for upcoming big
> > pcluster and LZMA algorithm, which follows the end of super block.
> > 
> > To parse the compression options, the bitmap is scanned one by one.
> > For each available algorithm, there is data followed by 2-byte `length'
> > correspondingly (it's enough for most cases, or entire fs blocks should
> > be used.)
> > 
> > With such available algorithm bitmap, kernel itself can also refuse to
> > mount such filesystem if any unsupported compression algorithm exists.
> > 
> > Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
> > ---
> >   fs/erofs/decompressor.c |   2 +-
> >   fs/erofs/erofs_fs.h     |  16 +++--
> >   fs/erofs/internal.h     |   5 +-
> >   fs/erofs/super.c        | 145 +++++++++++++++++++++++++++++++++++++++-
> >   4 files changed, 161 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> > index 97538ff24a19..27aa6a99b371 100644
> > --- a/fs/erofs/decompressor.c
> > +++ b/fs/erofs/decompressor.c
> > @@ -41,7 +41,7 @@ int z_erofs_load_lz4_config(struct super_block *sb,
> >   		}
> >   		distance = le16_to_cpu(lz4->max_distance);
> >   	} else {
> > -		distance = le16_to_cpu(dsb->lz4_max_distance);
> > +		distance = le16_to_cpu(dsb->u1.lz4_max_distance);
> >   	}
> >   	EROFS_SB(sb)->lz4.max_distance_pages = distance ?
> > diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> > index 1322ae63944b..ef3f8a99aa5f 100644
> > --- a/fs/erofs/erofs_fs.h
> > +++ b/fs/erofs/erofs_fs.h
> > @@ -18,15 +18,18 @@
> >    * be incompatible with this kernel version.
> >    */
> >   #define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
> > -#define EROFS_ALL_FEATURE_INCOMPAT		EROFS_FEATURE_INCOMPAT_LZ4_0PADDING
> > +#define EROFS_FEATURE_INCOMPAT_COMPR_CFGS	0x00000002
> > +#define EROFS_ALL_FEATURE_INCOMPAT		\
> > +	(EROFS_FEATURE_INCOMPAT_LZ4_0PADDING | \
> > +	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS)
> > -/* 128-byte erofs on-disk super block */
> > +/* erofs on-disk super block (currently 128 bytes) */
> >   struct erofs_super_block {
> >   	__le32 magic;           /* file system magic number */
> >   	__le32 checksum;        /* crc32c(super_block) */
> >   	__le32 feature_compat;
> >   	__u8 blkszbits;         /* support block_size == PAGE_SIZE only */
> > -	__u8 reserved;
> > +	__u8 sb_extslots;	/* superblock size = 128 + sb_extslots * 16 */
> >   	__le16 root_nid;	/* nid of root directory */
> >   	__le64 inos;            /* total valid ino # (== f_files - f_favail) */
> > @@ -39,7 +42,11 @@ struct erofs_super_block {
> >   	__u8 uuid[16];          /* 128-bit uuid for volume */
> >   	__u8 volume_name[16];   /* volume name */
> >   	__le32 feature_incompat;
> > -	__le16 lz4_max_distance;
> > +	union {
> > +		/* bitmap for available compression algorithms */
> > +		__le16 available_compr_algs;
> > +		__le16 lz4_max_distance;
> > +	} __packed u1;
> >   	__u8 reserved2[42];
> >   };
> > @@ -195,6 +202,7 @@ enum {
> >   	Z_EROFS_COMPRESSION_LZ4	= 0,
> >   	Z_EROFS_COMPRESSION_MAX
> >   };
> > +#define Z_EROFS_ALL_COMPR_ALGS		(1 << (Z_EROFS_COMPRESSION_MAX - 1))
> >   /* 14 bytes (+ length field = 16 bytes) */
> >   struct z_erofs_lz4_cfgs {
> > diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> > index 46b977f348eb..f3fa895d809f 100644
> > --- a/fs/erofs/internal.h
> > +++ b/fs/erofs/internal.h
> > @@ -75,6 +75,7 @@ struct erofs_sb_info {
> >   	struct xarray managed_pslots;
> >   	unsigned int shrinker_run_no;
> > +	u16 available_compr_algs;
> >   	/* pseudo inode to manage cached pages */
> >   	struct inode *managed_cache;
> > @@ -90,6 +91,7 @@ struct erofs_sb_info {
> >   	/* inode slot unit size in bit shift */
> >   	unsigned char islotbits;
> > +	u32 sb_size;			/* total superblock size */
> >   	u32 build_time_nsec;
> >   	u64 build_time;
> > @@ -233,6 +235,7 @@ static inline bool erofs_sb_has_##name(struct erofs_sb_info *sbi) \
> >   }
> >   EROFS_FEATURE_FUNCS(lz4_0padding, incompat, INCOMPAT_LZ4_0PADDING)
> > +EROFS_FEATURE_FUNCS(compr_cfgs, incompat, INCOMPAT_COMPR_CFGS)
> >   EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
> >   /* atomic flag definitions */
> > @@ -454,7 +457,7 @@ static inline int z_erofs_load_lz4_config(struct super_block *sb,
> >   				  struct erofs_super_block *dsb,
> >   				  struct z_erofs_lz4_cfgs *lz4, int len)
> >   {
> > -	if (lz4 || dsb->lz4_max_distance) {
> > +	if (lz4 || dsb->u1.lz4_max_distance) {
> >   		erofs_err(sb, "lz4 algorithm isn't enabled");
> >   		return -EINVAL;
> >   	}
> > diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> > index 1ca8da3f2125..c5e3039f51bf 100644
> > --- a/fs/erofs/super.c
> > +++ b/fs/erofs/super.c
> > @@ -122,6 +122,138 @@ static bool check_layout_compatibility(struct super_block *sb,
> >   	return true;
> >   }
> > +#ifdef CONFIG_EROFS_FS_ZIP
> > +/* read variable-sized metadata, offset will be aligned by 4-byte */
> > +static void *erofs_read_metadata(struct super_block *sb, struct page **pagep,
> > +				 erofs_off_t *offset, int *lengthp)
> > +{
> > +	struct page *page = *pagep;
> > +	u8 *buffer, *ptr;
> > +	int len, i, cnt;
> > +	erofs_blk_t blk;
> > +
> > +	*offset = round_up(*offset, 4);
> > +	blk = erofs_blknr(*offset);
> > +
> > +	if (!page || page->index != blk) {
> > +		if (page) {
> > +			unlock_page(page);
> > +			put_page(page);
> > +		}
> > +		page = erofs_get_meta_page(sb, blk);
> > +		if (IS_ERR(page))
> > +			goto err_nullpage;
> > +	}
> > +
> > +	ptr = kmap(page);
> > +	len = le16_to_cpu(*(__le16 *)&ptr[erofs_blkoff(*offset)]);
> > +	if (!len)
> > +		len = U16_MAX + 1;
> > +	buffer = kmalloc(len, GFP_KERNEL);
> > +	if (!buffer) {
> > +		buffer = ERR_PTR(-ENOMEM);
> 
> Caller expects valid page w/o kmapped or a NULL page, right? it needs
> to call kunmap() here? or out label can be relocated above kunmap()?

Yeah, I misplaced it by mistake, thanks for pointing out!

Thanks,
Gao Xiang

> 
> Thanks,
>

