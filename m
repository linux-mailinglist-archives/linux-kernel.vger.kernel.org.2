Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08B330CF42
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 23:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbhBBWoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 17:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235704AbhBBWop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 17:44:45 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D43C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 14:44:04 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id g46so5543579ooi.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 14:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0vZ3YcfNTrEDHTub1a0I5in6++E8pUyLjuHipyelgv0=;
        b=TlroDxZALA7adkHZsaLn1EdLYcWFwjy/3DgjeuOlax5HyLXb2Cp95fHSAlmqX21Ysb
         0mRW1xup6B6Tn6VR8We5RAs/VXNQQvk9sBYcWAtYWa6y58h0R7pfEsKfhtA2V0ksS62D
         pb6fvoYVyg5Cg8MWqgxGN+glnTC0aUG8Xnu+6AT/Tc3INbxegw0vwtwiH7k1C9lCCX3L
         9W4f1CZdzXP12/zH5ccXgZiRcmedOSaG1ZmCZ5s51ItZHvH+JjmwEb2pmxkTRcasuzzp
         DwPIC1OCcbEIUzW3iZTX/8XpVla4lVJYMS4nyZ7atVnZq7sDWkhE68YA9pBFiTwNwTrz
         Oc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0vZ3YcfNTrEDHTub1a0I5in6++E8pUyLjuHipyelgv0=;
        b=VaGIznXSEAzCryAx9cN00hCYoMrKc/Bm9dtL4kjB8MVQ8XZNrUAalNCb3dJF3pRfPo
         4K0jqhZgj8Ke7wkTBnbgd+RmhAEHc6TBPWnwjGBnLTj12ycUpor/GcPJ3J/YLz4uKwi5
         9oLdGMaeKaDZ5ulokoGiF/qF26EN2GV/YeD6Rl7/ng/Lj1sxMlKIxmX0mEVdCRYBykeC
         lxoK6NvE/wo6DPbzQgqZO/PetboRFyIJmWv4gaFmgVEzTvrnDo9s8xyFJo80s9XRA+E2
         hThZQhqdX0Hr3LyM0B45ozzM1Gzx8mj6uItxupcFYU3Ev8KG1/EdHoTgLTmGXqR3cJAg
         oDZw==
X-Gm-Message-State: AOAM532+4yIjYZL5UvopcCGTyX23NFnmM6eITUIgeauH09bXEVADKPjS
        LiLMFWfxMzxAetKO1AO/PNL/kg==
X-Google-Smtp-Source: ABdhPJyQxK7ApxN5cN8J+Y8i+q7EZN3p5maNtMDesuW24WwOPyUgHgXZbgEd5Gzl2zG7lxSemAT0Gg==
X-Received: by 2002:a4a:8c6b:: with SMTP id v40mr28142ooj.23.1612305844299;
        Tue, 02 Feb 2021 14:44:04 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 7sm72819oiz.43.2021.02.02.14.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 14:44:03 -0800 (PST)
Date:   Tue, 2 Feb 2021 16:44:01 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     agross@kernel.org, todor.too@gmail.com, mchehab@kernel.org,
        robh+dt@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        shawnguo@kernel.org, leoyang.li@nxp.com, geert+renesas@glider.be,
        arnd@arndb.de, Anson.Huang@nxp.com, michael@walle.cc,
        agx@sigxcpu.org, max.oss.09@gmail.com,
        angelogioacchino.delregno@somainline.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Azam Sadiq Pasha Kapatrala Syed <akapatra@quicinc.com>,
        Sarvesh Sridutt <Sarvesh.Sridutt@smartwirelesscompute.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Marek <jonathan@marek.ca>
Subject: Re: [PATCH v3 19/22] arm64: defconfig: Build Qcom CAMSS as module
Message-ID: <YBnVsUTapsiosHtF@builder.lan>
References: <20210127144930.2158242-1-robert.foss@linaro.org>
 <20210127144930.2158242-20-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127144930.2158242-20-robert.foss@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27 Jan 08:49 CST 2021, Robert Foss wrote:

> Build camera ISP driver as a module.
> 

Isn't this enabled since b47c5fc15d88 ("arm64: defconfig: Enable
Qualcomm CAMCC, CAMSS and CCI drivers")?

Regards,
Bjorn

> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 838301650a79..cb224d2af6a0 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -640,6 +640,7 @@ CONFIG_VIDEO_RENESAS_FDP1=m
>  CONFIG_VIDEO_RENESAS_FCP=m
>  CONFIG_VIDEO_RENESAS_VSP1=m
>  CONFIG_SDR_PLATFORM_DRIVERS=y
> +CONFIG_VIDEO_QCOM_CAMSS=m
>  CONFIG_VIDEO_RCAR_DRIF=m
>  CONFIG_VIDEO_IMX219=m
>  CONFIG_VIDEO_OV5645=m
> -- 
> 2.27.0
> 
