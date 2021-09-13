Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143E44087B2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 11:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238389AbhIMJBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 05:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235890AbhIMJB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 05:01:29 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858EBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 02:00:14 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id f3-20020a17090a638300b00199097ddf1aso6087687pjj.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 02:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VkpJ0ngl+MoG+ZOZwlNHaKDQYip+ieFhBWnmpJwyR7I=;
        b=kBpAPqK3g4R8wFMAdR40WxYIRIRgjY2dtlxtTWoM0n2TM0vNpUO9DdJIagGY7WdlOv
         JyLh+Jhr5EvO/R364B5Y7IznobfoKS26FNX36oIVDidA7rmBYzt0giJeg4Bun8yslmkq
         XdEnMZ72o7N0Qpan97hOZD11iKw+I/gJU+Akv00hBJPRb0wIF3XJF8FRGCpKPzS2Qfyp
         h4KKt+gGsUnIG7oZiM37zRYF+BkKKjohSGejcWxwZ8giY2Ga8lquOOc/1YAIV6faEPZ4
         1c3Rh0hZSZytMVgwhfUYHbm5KIt0kQfM73uTLEbVUzUwxj3sxUEuxHFO0yaoRtr7iGag
         EvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VkpJ0ngl+MoG+ZOZwlNHaKDQYip+ieFhBWnmpJwyR7I=;
        b=AEIQmjRiAm3bq2b3SfiJRXVTPWnqZbnSgM94IY+A0WRGHj3YbLa4LdP6j+uM9qDPb3
         XcOTzebkyb+8UJUFK+Vj1hVE/pc3cuprELOE6KQ7wU3bPVMDkUQXmJ4/V7BrlA6m45Ib
         sBN53pUjYqB9StG6cjPNIWczkanC0eAG3Di9yy7rw2T3zYVHMpq4zddw1YSn20sWvREF
         BqqmBHVU6pAw50kDFwXf0ECBnXUwt0JwbkxpF3d1UBcBSLTLtzleT+/qeoMAyFucVdsc
         TYR2V+9YUXWKvoDhynoydlCMEwC0hfwqrSlArbM8g+6+rrWpvBqisVJ3EGPLdQFR1tUs
         A91g==
X-Gm-Message-State: AOAM532Mldb5XP+H1F8iS7lscIWmtiPIECuXljuWW2RrevNrOakTtrP9
        Phe5SnWbOoqaJ92oCwHYYrA=
X-Google-Smtp-Source: ABdhPJwHLwwJSnil6LxlzpTe1aIE0cj1zgWJzPmjo2kTx3RcMUdCQo0BwN6k+wi4yDGJ8bujJDvkTg==
X-Received: by 2002:a17:90a:af92:: with SMTP id w18mr11750582pjq.98.1631523614113;
        Mon, 13 Sep 2021 02:00:14 -0700 (PDT)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id z62sm3113984pjj.53.2021.09.13.02.00.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Sep 2021 02:00:13 -0700 (PDT)
Date:   Mon, 13 Sep 2021 17:00:16 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, huyue2@yulong.com,
        zhangwen@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] erofs: fix compacted_{4b_initial, 2b} when
 compacted_4b_initial > totalidx
Message-ID: <20210913170016.00007580.zbestahu@gmail.com>
In-Reply-To: <YT8QbaAEkqBw//R0@B-P7TQMD6M-0146.local>
References: <20210913072405.1128-1-zbestahu@gmail.com>
        <YT8QbaAEkqBw//R0@B-P7TQMD6M-0146.local>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2021 16:48:45 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Hi Yue,
> 
> On Mon, Sep 13, 2021 at 03:24:05PM +0800, Yue Hu wrote:
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > mkfs.erofs will treat compacted_4b_initial & compacted_2b as 0 if
> > compacted_4b_initial > totalidx, kernel should be aligned with it
> > accordingly.  
> 
> There is no difference between compacted_4b_initial or compacted_4b_end
> for compacted 4B. Since in this way totalidx for compact 2B won't larger
> than 16 (number of lclusters in a compacted 2B pack.)

However, we can see compacted_2b is a big number for this case. It should
be pointless.

Thanks.

> 
> So it can be handled in either compacted_4b_initial or compacted_4b_end
> cases, because there are all compacted 4B.
> 
> Thanks,
> Gao Xiang
> 
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > ---
> >  fs/erofs/zmap.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> > index 9fb98d8..4f941b6 100644
> > --- a/fs/erofs/zmap.c
> > +++ b/fs/erofs/zmap.c
> > @@ -369,7 +369,10 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
> >  	if (compacted_4b_initial == 32 / 4)
> >  		compacted_4b_initial = 0;
> >  
> > -	if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B)
> > +	if (compacted_4b_initial > totalidx) {
> > +		compacted_4b_initial = 0;
> > +		compacted_2b = 0;
> > +	} else if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B)
> >  		compacted_2b = rounddown(totalidx - compacted_4b_initial, 16);
> >  	else
> >  		compacted_2b = 0;
> > -- 
> > 1.9.1  

