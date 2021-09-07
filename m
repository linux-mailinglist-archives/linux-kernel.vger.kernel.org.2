Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2345D402D5C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 19:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345457AbhIGRBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 13:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345465AbhIGRBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 13:01:44 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23368C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 10:00:38 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id w19-20020a17090aaf9300b00191e6d10a19so2561337pjq.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 10:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A0sxVmfddG/iMYR9MPhr5LGq+Hc/rulYoKrv0lmk57k=;
        b=imvK2NfqcweTnq3DfQ3kxb1hyyCHKaJdKjFFwmOFRNGcCgTtZXib10r3SXVdX1Z5Zt
         Kt14UJeK58D6y9CsD5v7TZqu2/sd20G9+0vs2OYRr8FGpQQ1FWzWh1ikUF/TG8DDkyp0
         F0YDBFXr2ZX4jkAZRc3ZlmB3vjDSLMZ+u8QirCOPIIHgiDF+hzptraPt4Akrd159DF7P
         +b60+gZLISbc5rHbH9LOExA+6YeVK+nFwZOyUw37yjrfvIUq8ljRgh16mCAua3Upkbyd
         EoMyC4xOdUhiEVTkEOKy8zk5EZ0cDxt4dZet2AYVdDEZTxF/MbZDftoJ8niCrKZDCf9I
         yRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=A0sxVmfddG/iMYR9MPhr5LGq+Hc/rulYoKrv0lmk57k=;
        b=pQCr9JsWnEhXe00JBfzFHE6vgn5/e9BWpuuUpr5/aYM/yyQ+8abv98E8/3k5P0K3xS
         HFPjCB82OQ9KthUBdnp+IyeKNKPwuDwOVqcBcZufzWplK9jFwnuBlsE5Jc+itINEmXjv
         Lab7f45YfmWhYJiWdcGSH0U+eB3fqE2C8AYVcSB496DsUD4EQ4NwkEn9vZjuim2Jamx7
         MgC3dqTGYpdmGtCNDA518pionhUKfvnxYbM6hq3Hzx0cHHVIC0MoXP0xxcLGnKLKM2S7
         EQUNOaCKCeFETN/SoT0GYGM/7haa1pncJA1rFJjUEfXzlJoTZAir76fsdEEQg10qBHh1
         /4bw==
X-Gm-Message-State: AOAM533qgBmdwXtT2NoIB2UKgySXNBNV+RUyU9riQa4kBbdnnFTJrLA7
        W7bSPLX78eeWJGlnqKMWpFc=
X-Google-Smtp-Source: ABdhPJx0GYgkTG9aSzp+VK4h1B583iwbvg8d5XIm7VPSBrTdzAq48wrj6nO/RR1gnckHyHtksmcp2g==
X-Received: by 2002:a17:90a:55cb:: with SMTP id o11mr5682682pjm.244.1631034037561;
        Tue, 07 Sep 2021 10:00:37 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:998a:2486:f524:8502])
        by smtp.gmail.com with ESMTPSA id i8sm11545909pfo.117.2021.09.07.10.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 10:00:37 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 7 Sep 2021 10:00:35 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        YongTaek Lee <ytk.lee@samsung.com>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
Subject: Re: (2) [PATCH] zram_drv: allow reclaim on bio_alloc
Message-ID: <YTeas6sPrvQKmUHG@google.com>
References: <YTXTe3U8RrvSAynl@infradead.org>
 <20210906052926.6007-1-jaewon31.kim@samsung.com>
 <CGME20210906052847epcas1p1f53f1ad04ad785d53f64eef150969c34@epcms1p6>
 <20210906091448epcms1p6bcc1f11b0da18e215219e6868ed07914@epcms1p6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210906091448epcms1p6bcc1f11b0da18e215219e6868ed07914@epcms1p6>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaewon,

On Mon, Sep 06, 2021 at 06:14:48PM +0900, Jaewon Kim wrote:
> > 
> > 
> >--------- Original Message ---------
> >Sender : Christoph Hellwig <hch@infradead.org>
> >Date : 2021-09-06 17:39 (GMT+9)
> >Title : Re: [PATCH] zram_drv: allow reclaim on bio_alloc
> > 
> >On Mon, Sep 06, 2021 at 02:29:26PM +0900, Jaewon Kim wrote:
> >> The read_from_bdev_async is not called on atomic context. So GFP_NOIO is
> >> available rather than GFP_ATOMIC. If there were reclaimable pages with
> >> GFP_NOIO, we can avoid allocation failure and page fault failure.
> >> 
> >> Reported-by: Yong-Taek Lee <ytk.lee@samsung.com>
> >> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>

Looks reasonable to me.
Feel free to add after dealing with Christoph's comment.

Acked-by: Minchan Kim <minchan@kernel.org>

Thank you.

> >> ---
> >>  drivers/block/zram/zram_drv.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> >> index fcaf2750f68f..53be528a39a2 100644
> >> --- a/drivers/block/zram/zram_drv.c
> >> +++ b/drivers/block/zram/zram_drv.c
> >> @@ -587,7 +587,7 @@ static int read_from_bdev_async(struct zram *zram, struct bio_vec *bvec,
> >>  {
> >>          struct bio *bio;
> >>  
> >> -        bio = bio_alloc(GFP_ATOMIC, 1);
> >> +        bio = bio_alloc(GFP_NOIO|__GFP_HIGHMEM, 1);
> > 
> >Passing __GFP_HIGHMEM to bio_alloc does not make any sense whatsoever.
> > 
> Correct, let me remove __GFP_HIGHMEM if I send v2 patch.
> Thank you
