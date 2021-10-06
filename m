Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F3842396F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 10:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237732AbhJFIN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 04:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237719AbhJFIN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 04:13:26 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2431C061755
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 01:11:34 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r18so6163581wrg.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 01:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9OIT44edDqhnGcPsXwKRYyfZsxM6X7lKnSGhmPugj4o=;
        b=AkzijW1NUig2pFBN+TBFIHQgkZOBzSBISqx0JFFxN/yUpOIlOeRb56UX4156V6+5pq
         eTUWP2aK9HRyvrR4xu+85pTXuqmYar6D9bqx1x7m1zWEEm70ouL1A580vNgPtUyQFh/K
         py2LrW8ovqtcMG9Xi+utODHRnwH+clOs2r1KFoPC2JvturPxJFgVx+QytKSOAIfPs0VH
         B1oDL8nWLxH25O5nYj9SCJeS8YQv7V9Yscw4WqOFefTUzekwueQgoCUEXuTGinmmulri
         pRTK8421PvPx64A9DzLBYcuz1of1ZgG6yXu71rrtNiG4wxFoi3diwedVcnepnTBvSpcx
         Qo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9OIT44edDqhnGcPsXwKRYyfZsxM6X7lKnSGhmPugj4o=;
        b=t9cwJdPfdhAPDNhO2gh/Yko+pptAWKp49kHgzKBT/papMkg0cZ23W9RG44NXtb6glF
         JLC7v6jEgDkv18+5cpT581dUQ2LFGknxL0Ola5AF9j7kltEoQ5MsV+ZqN1rxmjYRzblo
         JWu2FYq5yj8DRDlWrKlnBX/79+fDYysgNI41TCzZw+SG5yzKKWTk+y1cdtMT5cWT8WXk
         sGbPkiPFEkbWZ5Nor6+XlY+vRmrYS1TKs40yKgHabHUD5wZj3lkdNeMea3pmnLPLihN6
         nfUqy2b+OEFzZ17wnYTgxFbm3gY2XsddyAzWQkPSy5G/LqQpZQ9Eio1pmvS7qY7682d0
         aZ7g==
X-Gm-Message-State: AOAM532CDrKw3Qh0K0qf22aOvMzTxSyR6yMs8qipfkgx7woE4ZUFbiMl
        zv0WOIRCgOVWNcJrJ5cPz2rHJg==
X-Google-Smtp-Source: ABdhPJyCMZ6sEfAv4WHL2fGIYMRQhfCIbT9SNSGwn9L/806DFnp3brpn8OnsI/mfxkp0i08PLXxzGw==
X-Received: by 2002:a05:6000:168b:: with SMTP id y11mr26826929wrd.350.1633507893262;
        Wed, 06 Oct 2021 01:11:33 -0700 (PDT)
Received: from google.com ([95.148.6.175])
        by smtp.gmail.com with ESMTPSA id v10sm20808913wri.29.2021.10.06.01.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 01:11:32 -0700 (PDT)
Date:   Wed, 6 Oct 2021 09:11:31 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH v2 3/3] mfd: sprd: Add SPI device ID table
Message-ID: <YV1aMxkbqXKnEy2b@google.com>
References: <20210924143347.14721-1-broonie@kernel.org>
 <20210924143347.14721-4-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210924143347.14721-4-broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2021, Mark Brown wrote:

> Currently autoloading for SPI devices does not use the DT ID table, it uses
> SPI modalises. Supporting OF modalises is going to be difficult if not
> impractical, an attempt was made but has been reverted, so ensure that
> module autoloading works for this driver by adding a SPI device ID table.
> 
> Fixes: 96c8395e2166 ("spi: Revert modalias changes")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Baolin Wang <baolin.wang7@gmail.com>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> ---
>  drivers/mfd/sprd-sc27xx-spi.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
