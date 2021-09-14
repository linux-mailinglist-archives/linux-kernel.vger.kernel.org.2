Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4EDB40A5AC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 06:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239272AbhINE7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 00:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbhINE7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 00:59:03 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08C0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 21:57:46 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id u18so11639435pgf.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 21:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D4LVaOvMmQ70E4qW2vDWFmGBELkJCXPkZqyGHnKOmKs=;
        b=TGB04PEPuMcUxrZ020LUMyuCOfwLO5ZmT24uXjInd2ifJ6ZlFMybNLG9m9O7yAK3zw
         1etKaqxliDAeqpGLIuOMra/2q0A4MmM5BKPiB12HdFU/OcHwpsJvAvjbe+DDT+II70db
         P8O/c0XoIRimNy6JHSl0yTIBviNxKKablBtdhU4a2r24TwVH8buS26KQ14RfjgWXhqh/
         OBjop0frwtSK9+DjafzHeq7q8rRzSGqQG2BkFymjtxGrtrabYV2/B5r2pLQrW479Xy/u
         EOIcTtLMoQT5joytfg/NO4xIJu3lUQsEXoF+qaVnS2AcoWG0GP+cxfKm3yDx+Lauy0aR
         CqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D4LVaOvMmQ70E4qW2vDWFmGBELkJCXPkZqyGHnKOmKs=;
        b=O8w62NbBztFg5lHEeeRY40zSEjO0kavLXAAhnKrSEarTR6a/6d5z+2aHxyNNNAknl8
         AAIao92uomTCgd66Vz3y3z4OeA5cGDMk0ehIg/0OFZnRlaH4yf+MtQw8oe2WaNY2POsN
         xK0T4P/V850hTF0d/C9l48cqAgQ4XXuBK89exrBWGWs4LO1nVQE6EhV6GzeYNh16N/+f
         o20I2eLuuqu9gtQfPTYTeHxsu71FrsAvFfL/651muMz8pxcgNkKKfyqIoTJek5fZcSTq
         xI5SlW/4tOUkM+xrU6wLcw8SP4/Hi61FDvsCPeACJjK1kEsd7qYn978DkKLsoBdqmY0r
         XDgg==
X-Gm-Message-State: AOAM532tu50CHvkr8qRmlNiAx7fXsQq3JhFTmb7S32tQ7Kr6wQHWGpvT
        SDmvDfpBoQSR4ASFKZTkVz4=
X-Google-Smtp-Source: ABdhPJyGEWZLlLE4uzs0uDEFk3wJOwobzmkM46m2moyVAU+MWl07EGvtqqq48GQ+wXFUD37pIw3r5A==
X-Received: by 2002:a62:16c8:0:b0:43d:d6b8:f38 with SMTP id 191-20020a6216c8000000b0043dd6b80f38mr2931552pfw.9.1631595465996;
        Mon, 13 Sep 2021 21:57:45 -0700 (PDT)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id o11sm8811383pfd.124.2021.09.13.21.57.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Sep 2021 21:57:45 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:57:48 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, huyue2@yulong.com,
        zhangwen@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] erofs: fix compacted_2b if compacted_4b_initial >
 totalidx
Message-ID: <20210914125748.00003cd2.zbestahu@gmail.com>
In-Reply-To: <YUAm+kOdKcCzgcEy@B-P7TQMD6M-0146.local>
References: <20210914035915.1190-1-zbestahu@gmail.com>
        <YUAm+kOdKcCzgcEy@B-P7TQMD6M-0146.local>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2021 12:37:14 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On Tue, Sep 14, 2021 at 11:59:15AM +0800, Yue Hu wrote:
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > Currently, the whole indexes will only be compacted 4B if
> > compacted_4b_initial > totalidx. So, the calculated compacted_2b
> > is worthless for that case. It may waste CPU resources.
> > 
> > No need to update compacted_4b_initial as mkfs since it's used to
> > fulfill the alignment of the 1st compacted_2b pack and would handle
> > the case above.
> > 
> > We also need to clarify compacted_4b_end here. It's used for the
> > last lclusters which aren't fitted in the previous compacted_2b
> > packs.
> > 
> > Some messages are from Xiang.
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>  
> 
> Looks good to me,
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> (although I think the subject title would be better changed into
>  "clear compacted_2b if compacted_4b_initial > totalidx"

Yeah, 'clear' is much better for this change.

Thanks.

>  since 'fix'-likewise words could trigger some AI bot for stable
>  kernel backporting..)
> 
> Thanks,
> Gao Xiang
> 
> > ---
> >  fs/erofs/zmap.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> > index 9fb98d8..aeed404 100644
> > --- a/fs/erofs/zmap.c
> > +++ b/fs/erofs/zmap.c
> > @@ -369,7 +369,8 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
> >  	if (compacted_4b_initial == 32 / 4)
> >  		compacted_4b_initial = 0;
> >  
> > -	if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B)
> > +	if ((vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B) &&
> > +	    compacted_4b_initial <= totalidx) {
> >  		compacted_2b = rounddown(totalidx - compacted_4b_initial, 16);
> >  	else
> >  		compacted_2b = 0;
> > -- 
> > 1.9.1  

