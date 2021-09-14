Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9884740A5C2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 07:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239394AbhINFMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 01:12:47 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:27283 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232829AbhINFMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 01:12:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UoLKGKe_1631596285;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UoLKGKe_1631596285)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 14 Sep 2021 13:11:27 +0800
Date:   Tue, 14 Sep 2021 13:11:25 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, huyue2@yulong.com,
        zhangwen@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] erofs: fix compacted_2b if compacted_4b_initial >
 totalidx
Message-ID: <YUAu/YVWmS3hMDsp@B-P7TQMD6M-0146.local>
References: <20210914035915.1190-1-zbestahu@gmail.com>
 <YUAm+kOdKcCzgcEy@B-P7TQMD6M-0146.local>
 <20210914125748.00003cd2.zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210914125748.00003cd2.zbestahu@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 12:57:48PM +0800, Yue Hu wrote:
> On Tue, 14 Sep 2021 12:37:14 +0800
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 
> > On Tue, Sep 14, 2021 at 11:59:15AM +0800, Yue Hu wrote:
> > > From: Yue Hu <huyue2@yulong.com>
> > > 
> > > Currently, the whole indexes will only be compacted 4B if
> > > compacted_4b_initial > totalidx. So, the calculated compacted_2b
> > > is worthless for that case. It may waste CPU resources.
> > > 
> > > No need to update compacted_4b_initial as mkfs since it's used to
> > > fulfill the alignment of the 1st compacted_2b pack and would handle
> > > the case above.
> > > 
> > > We also need to clarify compacted_4b_end here. It's used for the
> > > last lclusters which aren't fitted in the previous compacted_2b
> > > packs.
> > > 
> > > Some messages are from Xiang.
> > > 
> > > Signed-off-by: Yue Hu <huyue2@yulong.com>  
> > 
> > Looks good to me,
> > Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > 
> > (although I think the subject title would be better changed into
> >  "clear compacted_2b if compacted_4b_initial > totalidx"
> 
> Yeah, 'clear' is much better for this change.

Ok, I will update this when later applying.

Thanks,
Gao Xiang

> 
> Thanks.
> 
> >  since 'fix'-likewise words could trigger some AI bot for stable
> >  kernel backporting..)
> > 
> > Thanks,
> > Gao Xiang
> > 
> > > ---
> > >  fs/erofs/zmap.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> > > index 9fb98d8..aeed404 100644
> > > --- a/fs/erofs/zmap.c
> > > +++ b/fs/erofs/zmap.c
> > > @@ -369,7 +369,8 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
> > >  	if (compacted_4b_initial == 32 / 4)
> > >  		compacted_4b_initial = 0;
> > >  
> > > -	if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B)
> > > +	if ((vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B) &&
> > > +	    compacted_4b_initial <= totalidx) {
> > >  		compacted_2b = rounddown(totalidx - compacted_4b_initial, 16);
> > >  	else
> > >  		compacted_2b = 0;
> > > -- 
> > > 1.9.1  
