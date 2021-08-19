Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5053F1424
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 09:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhHSHND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 03:13:03 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:39008 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229909AbhHSHNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 03:13:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UjzCI5U_1629357133;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UjzCI5U_1629357133)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 19 Aug 2021 15:12:14 +0800
Date:   Thu, 19 Aug 2021 15:12:12 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peng Tao <tao.peng@linux.alibaba.com>,
        Eryu Guan <eguan@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>,
        Tao Ma <boyu.mt@taobao.com>
Subject: Re: [PATCH v2 2/2] erofs: support reading chunk-based uncompressed
 files
Message-ID: <YR4ETD4sPl356Ci9@B-P7TQMD6M-0146.local>
References: <20210818070713.4437-1-hsiangkao@linux.alibaba.com>
 <20210819063310.177035-1-hsiangkao@linux.alibaba.com>
 <20210819063310.177035-2-hsiangkao@linux.alibaba.com>
 <e5daab20-ed0a-70de-1f37-0613454a52c3@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e5daab20-ed0a-70de-1f37-0613454a52c3@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joseph,

On Thu, Aug 19, 2021 at 02:37:50PM +0800, Joseph Qi wrote:
> 
> 
> On 8/19/21 2:33 PM, Gao Xiang wrote:

...

> > diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> > index d13e0709599c..4408929bd6f5 100644
> > --- a/fs/erofs/inode.c
> > +++ b/fs/erofs/inode.c
> > @@ -2,6 +2,7 @@
> >  /*
> >   * Copyright (C) 2017-2018 HUAWEI, Inc.
> >   *             https://www.huawei.com/
> > + * Copyright (C) 2021, Alibaba Cloud
> >   */
> >  #include "xattr.h"
> >  
> > @@ -122,7 +123,9 @@ static struct page *erofs_read_inode(struct inode *inode,
> >  		/* total blocks for compressed files */
> >  		if (erofs_inode_is_data_compressed(vi->datalayout))
> >  			nblks = le32_to_cpu(die->i_u.compressed_blocks);
> > -
> > +		else if (vi->datalayout == EROFS_INODE_CHUNK_BASED)
> > +			/* fill chunked inode summary info */
> > +			vi->chunkformat = le16_to_cpu(die->i_u.c.format);
> 
> Better to add braces for if/else.

Thanks for the kind suggestion. Here is single statement, I've checked
coding-style in Documentation. It's no necessary to use brace for this.
And checkpatch didn't report anything.

Also, I found some reference at
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/vmscan.c?h=v5.13#n3066

But anyway, I could update it when applying, either looks good to me.

Thanks,
Gao Xiang
