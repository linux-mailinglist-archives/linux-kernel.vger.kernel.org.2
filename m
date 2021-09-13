Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0D8408AFD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 14:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239954AbhIMMYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 08:24:36 -0400
Received: from m12-14.163.com ([220.181.12.14]:57964 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236140AbhIMMYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 08:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=MlRAV
        ypdW7YrpBs8Eft4bSn/YCqHOQ7MShrKcxpxoek=; b=Fr/zqI1BmennualLNGtZS
        X8e8GeeEgMosg7cBqU5ei9pYjRz1P6dUGVR+mElVZzrdnstBTiGJv4iAhwQUuX/E
        CQEFqvvcG7521nwQ9bX1o+kbMyUQfCzipJl/A+Q4VMIQSriBSQxbS3j/32mbEpjX
        qNLq3YZTgFmDkmUKFQvrfo=
Received: from rockpi4b (unknown [112.20.66.82])
        by smtp10 (Coremail) with SMTP id DsCowABnSLakQj9hV8tMHg--.7297S2;
        Mon, 13 Sep 2021 20:23:01 +0800 (CST)
Date:   Mon, 13 Sep 2021 20:22:58 +0800
From:   Yue Hu <zbestahu@163.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Yue Hu <zbestahu@gmail.com>, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zhangwen@yulong.com
Subject: Re: [PATCH] erofs: fix compacted_{4b_initial, 2b} when
 compacted_4b_initial > totalidx
Message-ID: <20210913202258.356ba284.zbestahu@163.com>
In-Reply-To: <YT8ztN/F4StUYYNS@B-P7TQMD6M-0146.local>
References: <20210913072405.1128-1-zbestahu@gmail.com>
        <YT8QbaAEkqBw//R0@B-P7TQMD6M-0146.local>
        <20210913170016.00007580.zbestahu@gmail.com>
        <YT8VvOyXIDdyD7WI@B-P7TQMD6M-0146.local>
        <20210913185836.088e7059.zbestahu@163.com>
        <YT8ztN/F4StUYYNS@B-P7TQMD6M-0146.local>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: DsCowABnSLakQj9hV8tMHg--.7297S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF45tF1DCr4kCw4UXrW8JFb_yoW5Gw4Up3
        9rKF48ta4vqF1Iyw1xtw18XFW0vw48Cr4UW34YqFyxKr90yFn5Gr18tFWru3ZrXw13Kr4F
        yr4UWFn3AFy7A3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U-eOXUUUUU=
X-Originating-IP: [112.20.66.82]
X-CM-SenderInfo: p2eh23xdkxqiywtou0bp/1tbitAQNEVSIm3vUmwAAsf
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2021 19:19:16 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Hi Yue,
> 
> On Mon, Sep 13, 2021 at 06:58:36PM +0800, Yue Hu wrote:
> > Hi Xiang,
> > 
> > On Mon, 13 Sep 2021 17:11:24 +0800
> > Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >   
> > > On Mon, Sep 13, 2021 at 05:00:16PM +0800, Yue Hu wrote:  
> > > > On Mon, 13 Sep 2021 16:48:45 +0800
> > > > Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> > > >     
> > > > > Hi Yue,
> > > > > 
> > > > > On Mon, Sep 13, 2021 at 03:24:05PM +0800, Yue Hu wrote:    
> > > > > > From: Yue Hu <huyue2@yulong.com>
> > > > > > 
> > > > > > mkfs.erofs will treat compacted_4b_initial & compacted_2b as 0 if
> > > > > > compacted_4b_initial > totalidx, kernel should be aligned with it
> > > > > > accordingly.      
> > > > > 
> > > > > There is no difference between compacted_4b_initial or compacted_4b_end
> > > > > for compacted 4B. Since in this way totalidx for compact 2B won't larger
> > > > > than 16 (number of lclusters in a compacted 2B pack.)    
> > > > 
> > > > However, we can see compacted_2b is a big number for this case. It should
> > > > be pointless.    
> > > 
> > > Does it has some real impact?  
> > 
> > No real impact to correct result.
> >   
> > > 
> > > compacted_4b_initial is only used for the alignment use for the
> > > first compacted_2b so that each compacted_2b pack won't cross
> > > the block (page) boundary. And compacted_4b_end is for the last
> > > lclusters aren't fitted in any compacted_2b pack.
> > > 
> > > If compacted_4b_initial > totalidx, I think the whole indexes
> > > would be compacted 4B and handled in
> > > 
> > > 	if (lcn < compacted_4b_initial) {
> > > 		amortizedshift = 2;
> > > 		goto out;
> > > 	}  
> > 
> > Yes, it is. 
> > 
> > My point is why we need compacted_2b here for this case. If it's
> > not helpful/used for next code logic, we should remove/avoid it.
> > I think that may cause some misunderstanding and consume unneeded
> > CPU resources.  
> 
> Okay, make sense. If the number of compacted_2b misleads, how about
> just
> 
> 	if ((vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B) &&
> 	    compacted_4b_initial <= totalidx) {
> 		compacted_2b = ...;
> 	} else {
> 		compacted_2b = 0;
> 	}

Looks good. So, the patch title may change a little.

> 
> , and refine the commit message to point out the following facts for
> other folks:
> 
> - compacted_4b_initial is used contain the very first lclusters in order
>   to fulfill the alignment of the first compacted_2b pack;
> 
> - compacted_4b_end is used for the last lclusters which aren't fitted in
>   the previous compacted_2b packs;
> 
> - if compacted_4b_initial > totalidx, the whole indexes will be compacted
>   4B and handled with compacted_4b_initial.

Ok, will add these facts above in v2.

Thanks.

> 
> Thanks,
> Gao Xiang
> 
> > 
> > Thanks.  

