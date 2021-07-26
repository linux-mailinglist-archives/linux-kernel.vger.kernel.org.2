Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF753D50E6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 03:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbhGZArT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 20:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhGZArS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 20:47:18 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF365C061757
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 18:27:46 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id i1so9707049plr.9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 18:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4nvyo5pUPccLHA9vRdzeaMvZAx6+cAUa7rg3pe0FbOM=;
        b=KWKbbQRoPzAW2Yb+wO0MXH1a6k6com/5pz3aFoxYvZorMVuI2GU1qg1Ha/HeLo5fdY
         Dwsg7ehyW0zHR/Nuob8V6XRpksVN6e4DSPGQa3UPUwEzOpW5MspHCGnj5MAz+0ivPV3G
         qKu/VjQAy8Xb1J9ULkQ4/8j0x6KIDi5PDwRnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4nvyo5pUPccLHA9vRdzeaMvZAx6+cAUa7rg3pe0FbOM=;
        b=t2S2P2XjhmWwPZWnxRZ3T7n8XAs7J6PPETMA7HxhW/vGywgKGs8y4Yq2q8WEkOPmPL
         YB0VINe3DAn7+WT1kEHber2NHvdYh3gdCs84a0WXZTY79sFSz3CkWA79oucbWl3QIV1/
         K+KppVriBZhO9/QATl5GvhCQBq9w+MzdhSynAfk7sXeFAJtk66yPZaqZxoRNK2Qzsy86
         cFpxPRZaxZWRYF5e8vGj5FdTLvmVNWnCN3/vfxjmMPBm6Q9U8CGJdlSJ82N+T8OmQi/J
         a7SB+XVeQGrs5IlnZ67HMS6agUQCh6h03Dcd4Ct/wCmhc+JprPDfXEgX4Ahj8+VnwRvs
         Rvqw==
X-Gm-Message-State: AOAM530OK4cUFbfeJBgWpqwjMMKuFRcxdS3Fzq3eeBAmP7BirYo+V1eA
        adPSRLyL+NlMt3pmXgaf7T9nQg==
X-Google-Smtp-Source: ABdhPJxhomRbBRYLCoMmhBURponq8oqvv1C8uhTdHQ+vmUzKU/LwgEFLC2xeA62o5/t4s0IhMqZRuA==
X-Received: by 2002:a65:4289:: with SMTP id j9mr15956235pgp.256.1627262865981;
        Sun, 25 Jul 2021 18:27:45 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:967a:60e8:38b7:1227])
        by smtp.gmail.com with ESMTPSA id h19sm38890719pfo.161.2021.07.25.18.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 18:27:45 -0700 (PDT)
Date:   Mon, 26 Jul 2021 10:27:40 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Huangzhaoyang <huangzhaoyang@gmail.com>
Cc:     Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] driver: zram: fix wrong counting on pages_store
Message-ID: <YP4PjMnw1OZtARQC@google.com>
References: <1626763658-27748-1-git-send-email-huangzhaoyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626763658-27748-1-git-send-email-huangzhaoyang@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/07/20 14:47), Huangzhaoyang wrote:
> It makes the statistic confused when counting pages_store in during writeback.
> pages_store should just reflect the swapped pages on ZRAM, while bd_writes be
> responsible for writeback things.
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  drivers/block/zram/zram_drv.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index cf8deec..6bdaa9d 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -765,7 +765,6 @@ static ssize_t writeback_store(struct device *dev,
>  		zram_set_flag(zram, index, ZRAM_WB);
>  		zram_set_element(zram, index, blk_idx);
>  		blk_idx = 0;
> -		atomic64_inc(&zram->stats.pages_stored);

Yeah, I think we don't need it here.

Minchan, what do you think?
