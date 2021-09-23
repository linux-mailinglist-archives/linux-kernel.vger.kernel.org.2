Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA83B415ED3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 14:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241161AbhIWMwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 08:52:39 -0400
Received: from m12-16.163.com ([220.181.12.16]:55630 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241054AbhIWMwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 08:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=MA6an
        ncPT404+0JP8U+6QBqErtbmvMBOlNOEcO3V478=; b=lVCIawqwAtSDLrmh7VTG/
        zhRQzxQUhWYPJQnSuMW4RR7P17pJVu1fpC6pbWkR8rtlPCiYs4ZthO08RQDr+GiQ
        gsCha+acC4xqvlcHmS0fe0tgS07FUGzEOe2xezLyy8Ns46XWgZoo00tmcvsMQZv3
        Nk+G1iJ7/iUXpJ3XFkHPQ8=
Received: from rockpi4b (unknown [112.20.66.231])
        by smtp12 (Coremail) with SMTP id EMCowADn9goPeExhiW+xBw--.45S2;
        Thu, 23 Sep 2021 20:50:34 +0800 (CST)
Date:   Thu, 23 Sep 2021 20:50:22 +0800
From:   Yue Hu <zbestahu@163.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Yue Hu <zbestahu@gmail.com>, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zhangwen@yulong.com
Subject: Re: [PATCH] erofs: fix compacted_2b if compacted_4b_initial >
 totalidx
Message-ID: <20210923205022.76ea5e4f.zbestahu@163.com>
In-Reply-To: <YUxp1rsN0Ce88YQI@B-P7TQMD6M-0146.local>
References: <20210914035915.1190-1-zbestahu@gmail.com>
        <YUAm+kOdKcCzgcEy@B-P7TQMD6M-0146.local>
        <20210914125748.00003cd2.zbestahu@gmail.com>
        <YUxp1rsN0Ce88YQI@B-P7TQMD6M-0146.local>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: EMCowADn9goPeExhiW+xBw--.45S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF1rAF4UWr1rWryxCry8Krg_yoW8trW3p3
        yDGF48ta40qryfCF1xtr1rJF1xt397Kr18Xw1YqF10gr90vFn7Jr18tF98uF1UWw13Gr40
        va1jgwnxZFWjy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ud-BiUUUUU=
X-Originating-IP: [112.20.66.231]
X-CM-SenderInfo: p2eh23xdkxqiywtou0bp/1tbitBoXEVSIm+8+MgAAsM
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2021 19:49:42 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On Tue, Sep 14, 2021 at 12:57:48PM +0800, Yue Hu wrote:
> > On Tue, 14 Sep 2021 12:37:14 +0800
> > Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >   
> > > On Tue, Sep 14, 2021 at 11:59:15AM +0800, Yue Hu wrote:  
> > > > From: Yue Hu <huyue2@yulong.com>
> > > > 
> > > > Currently, the whole indexes will only be compacted 4B if
> > > > compacted_4b_initial > totalidx. So, the calculated compacted_2b
> > > > is worthless for that case. It may waste CPU resources.
> > > > 
> > > > No need to update compacted_4b_initial as mkfs since it's used to
> > > > fulfill the alignment of the 1st compacted_2b pack and would handle
> > > > the case above.
> > > > 
> > > > We also need to clarify compacted_4b_end here. It's used for the
> > > > last lclusters which aren't fitted in the previous compacted_2b
> > > > packs.
> > > > 
> > > > Some messages are from Xiang.
> > > > 
> > > > Signed-off-by: Yue Hu <huyue2@yulong.com>    
> > > 
> > > Looks good to me,
> > > Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > > 
> > > (although I think the subject title would be better changed into
> > >  "clear compacted_2b if compacted_4b_initial > totalidx"  
> > 
> > Yeah, 'clear' is much better for this change.
> > 
> > Thanks.
> >   
> > >  since 'fix'-likewise words could trigger some AI bot for stable
> > >  kernel backporting..)
> > > 
> > > Thanks,
> > > Gao Xiang
> > >   
> > > > ---
> > > >  fs/erofs/zmap.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> > > > index 9fb98d8..aeed404 100644
> > > > --- a/fs/erofs/zmap.c
> > > > +++ b/fs/erofs/zmap.c
> > > > @@ -369,7 +369,8 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
> > > >  	if (compacted_4b_initial == 32 / 4)
> > > >  		compacted_4b_initial = 0;
> > > >  
> > > > -	if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B)
> > > > +	if ((vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B) &&
> > > > +	    compacted_4b_initial <= totalidx) {  
> 
> btw, I've fixed up the build error due to redundant brace '{' when

Thanks.

> applying...
> 
> Thanks,
> Gao Xiang
> 
> > > >  		compacted_2b = rounddown(totalidx - compacted_4b_initial, 16);
> > > >  	else
> > > >  		compacted_2b = 0;
> > > > -- 
> > > > 1.9.1    


