Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B624087C3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 11:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238411AbhIMJMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 05:12:44 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:35918 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236022AbhIMJMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 05:12:43 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UoCWMY7_1631524284;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UoCWMY7_1631524284)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 13 Sep 2021 17:11:25 +0800
Date:   Mon, 13 Sep 2021 17:11:24 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, huyue2@yulong.com,
        zhangwen@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] erofs: fix compacted_{4b_initial, 2b} when
 compacted_4b_initial > totalidx
Message-ID: <YT8VvOyXIDdyD7WI@B-P7TQMD6M-0146.local>
References: <20210913072405.1128-1-zbestahu@gmail.com>
 <YT8QbaAEkqBw//R0@B-P7TQMD6M-0146.local>
 <20210913170016.00007580.zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210913170016.00007580.zbestahu@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 05:00:16PM +0800, Yue Hu wrote:
> On Mon, 13 Sep 2021 16:48:45 +0800
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 
> > Hi Yue,
> > 
> > On Mon, Sep 13, 2021 at 03:24:05PM +0800, Yue Hu wrote:
> > > From: Yue Hu <huyue2@yulong.com>
> > > 
> > > mkfs.erofs will treat compacted_4b_initial & compacted_2b as 0 if
> > > compacted_4b_initial > totalidx, kernel should be aligned with it
> > > accordingly.  
> > 
> > There is no difference between compacted_4b_initial or compacted_4b_end
> > for compacted 4B. Since in this way totalidx for compact 2B won't larger
> > than 16 (number of lclusters in a compacted 2B pack.)
> 
> However, we can see compacted_2b is a big number for this case. It should
> be pointless.

Does it has some real impact?

compacted_4b_initial is only used for the alignment use for the
first compacted_2b so that each compacted_2b pack won't cross
the block (page) boundary. And compacted_4b_end is for the last
lclusters aren't fitted in any compacted_2b pack.

If compacted_4b_initial > totalidx, I think the whole indexes
would be compacted 4B and handled in

	if (lcn < compacted_4b_initial) {
		amortizedshift = 2;
		goto out;
	}

Thanks,
Gao Xiang

> 
> Thanks.
> 
> > 
> > So it can be handled in either compacted_4b_initial or compacted_4b_end
> > cases, because there are all compacted 4B.
> > 
> > Thanks,
> > Gao Xiang
> > 
> > > 
> > > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > > ---
> > >  fs/erofs/zmap.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> > > index 9fb98d8..4f941b6 100644
> > > --- a/fs/erofs/zmap.c
> > > +++ b/fs/erofs/zmap.c
> > > @@ -369,7 +369,10 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
> > >  	if (compacted_4b_initial == 32 / 4)
> > >  		compacted_4b_initial = 0;
> > >  
> > > -	if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B)
> > > +	if (compacted_4b_initial > totalidx) {
> > > +		compacted_4b_initial = 0;
> > > +		compacted_2b = 0;
> > > +	} else if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B)
> > >  		compacted_2b = rounddown(totalidx - compacted_4b_initial, 16);
> > >  	else
> > >  		compacted_2b = 0;
> > > -- 
> > > 1.9.1  
