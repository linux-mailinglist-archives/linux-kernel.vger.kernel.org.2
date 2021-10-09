Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661EF42776C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 06:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbhJIEtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 00:49:47 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:43687 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229596AbhJIEtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 00:49:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Ur3l3OA_1633754867;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Ur3l3OA_1633754867)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 09 Oct 2021 12:47:48 +0800
Date:   Sat, 9 Oct 2021 12:47:46 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org,
        Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        huyue2@yulong.com, zhangwen@yulong.com
Subject: Re: [PATCH v2 2/3] erofs: introduce the secondary compression head
Message-ID: <YWEe8nPqFEusXkKP@B-P7TQMD6M-0146.local>
References: <20211008200839.24541-1-xiang@kernel.org>
 <20211008200839.24541-3-xiang@kernel.org>
 <20211009115032.00002f26.zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211009115032.00002f26.zbestahu@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yue,

On Sat, Oct 09, 2021 at 11:50:32AM +0800, Yue Hu wrote:
> On Sat,  9 Oct 2021 04:08:38 +0800
> Gao Xiang <xiang@kernel.org> wrote:
> 
> > From: Gao Xiang <hsiangkao@linux.alibaba.com>
> > 
> > Previously, for each HEAD lcluster, it can be either HEAD or PLAIN
> > lcluster to indicate whether the whole pcluster is compressed or not.
> > 
> > In this patch, a new HEAD2 head type is introduced to specify another
> > compression algorithm other than the primary algorithm for each
> > compressed file, which can be used for upcoming LZMA compression and
> > LZ4 range dictionary compression for various data patterns.
> > 
> > It has been stayed in the EROFS roadmap for years. Complete it now!
> > 
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > ---
> >  fs/erofs/erofs_fs.h |  8 +++++---
> >  fs/erofs/zmap.c     | 36 +++++++++++++++++++++++++++---------
> >  2 files changed, 32 insertions(+), 12 deletions(-)
> > 
> > diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> > index b0b23f41abc3..f579c8c78fff 100644
> > --- a/fs/erofs/erofs_fs.h
> > +++ b/fs/erofs/erofs_fs.h
> > @@ -21,11 +21,13 @@
> >  #define EROFS_FEATURE_INCOMPAT_COMPR_CFGS	0x00000002
> >  #define EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER	0x00000002
> >  #define EROFS_FEATURE_INCOMPAT_CHUNKED_FILE	0x00000004
> > +#define EROFS_FEATURE_INCOMPAT_COMPR_HEAD2	0x00000008
> >  #define EROFS_ALL_FEATURE_INCOMPAT		\
> >  	(EROFS_FEATURE_INCOMPAT_LZ4_0PADDING | \
> >  	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
> >  	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER | \
> > -	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE)
> > +	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE | \
> > +	 EROFS_FEATURE_INCOMPAT_COMPR_HEAD2)
> >  
> >  #define EROFS_SB_EXTSLOT_SIZE	16
> >  
> > @@ -314,9 +316,9 @@ struct z_erofs_map_header {
> >   */
> >  enum {
> >  	Z_EROFS_VLE_CLUSTER_TYPE_PLAIN		= 0,
> > -	Z_EROFS_VLE_CLUSTER_TYPE_HEAD		= 1,
> > +	Z_EROFS_VLE_CLUSTER_TYPE_HEAD1		= 1,
> >  	Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD	= 2,
> > -	Z_EROFS_VLE_CLUSTER_TYPE_RESERVED	= 3,
> > +	Z_EROFS_VLE_CLUSTER_TYPE_HEAD2		= 3,
> >  	Z_EROFS_VLE_CLUSTER_TYPE_MAX
> >  };
> >  
> > diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> > index 9d9c26343dab..03945f15ceae 100644
> > --- a/fs/erofs/zmap.c
> > +++ b/fs/erofs/zmap.c
> > @@ -69,11 +69,17 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
> >  	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
> >  
> >  	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX) {
> > -		erofs_err(sb, "unknown compression format %u for nid %llu, please upgrade kernel",
> > +		erofs_err(sb, "unknown HEAD1 format %u for nid %llu, please upgrade kernel",
> >  			  vi->z_algorithmtype[0], vi->nid);
> >  		err = -EOPNOTSUPP;
> >  		goto unmap_done;
> >  	}
> > +	if (vi->z_algorithmtype[1] >= Z_EROFS_COMPRESSION_MAX) {
> > +		erofs_err(sb, "unknown HEAD2 format %u for nid %llu, please upgrade kernel",
> > +			  vi->z_algorithmtype[1], vi->nid);
> > +		err = -EOPNOTSUPP;
> > +		goto unmap_done;
> > +	}
> 
> Seems duplicated a little, how about below code?
> 
> 	if (vi->z_algorithmtype[i] >= Z_EROFS_COMPRESSION_MAX ||
> 	    vi->z_algorithmtype[++i] >= Z_EROFS_COMPRESSION_MAX) {
>                 erofs_err(sb, "unknown HEAD%u format %u for nid %llu, please upgrade kernel",
> 			  i, vi->z_algorithmtype[i], vi->nid);
> 		err = -EOPNOTSUPP;
> 		goto unmap_done;
> 	}

Yeah, good simplification. I will update it and rename `i' to `headnr'
here.

Thanks,
Gao Xiang
