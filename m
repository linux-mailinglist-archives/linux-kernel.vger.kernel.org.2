Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6BB345A56
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhCWJFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhCWJFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:05:17 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9118C061756
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:05:16 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id r12so25814242ejr.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NaxMk1X4JgQvNguaXzrkddVGWdXTSwTVvMkeeopGQCc=;
        b=EkcarqZKUy0ymiF4kWv0Lkwrc9OXZEDWInUH5Be+lbkNWzuZ0bH1/rBhCpRwLiqTdt
         rBd/jZXsSc+/gr0W5vVDjKeAbBiJNnqL4d8FVLGBZgt06UhuthKl3hoG91vBLikuJLNs
         4XHZBPrXItBGRVsuFFU+Aay2UuLxvNpfwAp+UJOTSQ35dL31Q2B9wQ2HZT8KRflMEb7C
         pXRPGCU0Nclm8CvMHG0ni3P5qwx4l1n1LIqBhgxjANlEzftOTvwqxahdOlKmHDfAvEyg
         qLjBEZ5ypgC1Nmdp+HiBhrAcllw0tq/I+5iHIj2uYWO+CKOFFc2s9MXEMg7ZkLbOmQms
         BM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NaxMk1X4JgQvNguaXzrkddVGWdXTSwTVvMkeeopGQCc=;
        b=BkFDsWp899ZSD0iCz7lMmHWu0z4DEm/SYkynehLo2sXRJJuLi/Ix4gANcmyVW4Suyw
         WjHLnJN701Xbc+37GYHTTlwJy9EJI3OmvyZk4UIwY6tBMau2PYUISPIsXMu8EKxUTB7g
         5pF2UcuAJB7x74VaPC+Xc4YtgWY8EI89OzoTifNsnBQOj8FE/7x7NIw6tt2lrLd6aoxw
         C0Ii/aPflsRFErfM4hlmbOnwarXkLNPvDth6KB8z2eO7uzOI0hgpGQXJJyULgIhMphye
         PFpuDnRubDctTNmyyBMSKiqqtH93I8ZIAaRVjHT4YMJEsHgCo3oTbv0iGO92/KoWXLSq
         PyEw==
X-Gm-Message-State: AOAM532xNneZNParLOjtT2fqvOBIVO8OXu6698BS+Nb4PnA/+bLrmkAC
        08dAxu+kPkrXMqgQEHbGQp8BOQ==
X-Google-Smtp-Source: ABdhPJzVzXe2FBZymosCx+Rjdu4KKVi7Zq3N3gYPqVzkCfVULSYBS8mOmRdLM8ry58+y1DxBB4xE/w==
X-Received: by 2002:a17:907:720a:: with SMTP id dr10mr3843386ejc.375.1616490315603;
        Tue, 23 Mar 2021 02:05:15 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id be27sm12873864edb.47.2021.03.23.02.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 02:05:15 -0700 (PDT)
Date:   Tue, 23 Mar 2021 09:05:13 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     matthias.bgg@kernel.org
Cc:     robh+dt@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH 3/7] mfd: mt6397: Drop of_compatible for regulator
Message-ID: <20210323090513.GJ2916463@dell>
References: <20210312145545.26050-1-matthias.bgg@kernel.org>
 <20210312145545.26050-3-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210312145545.26050-3-matthias.bgg@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2021, matthias.bgg@kernel.org wrote:

> From: Matthias Brugger <mbrugger@suse.com>
> 
> For regulators a compatible string is superfluous. Drop the string.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> ---
>  drivers/mfd/mt6397-core.c | 3 ---
>  1 file changed, 3 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
