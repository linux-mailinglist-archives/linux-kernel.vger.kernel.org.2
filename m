Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767B3430FB2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 07:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhJRFTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 01:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhJRFTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 01:19:47 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396FFC06161C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 22:17:36 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id e63so22773553oif.8
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 22:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zO0FQZnNe26RTnkKcZCv04+XN4JQxCO7Vr6g1O65ABs=;
        b=Gd3BMbCKQNx8NvxZh8Jyhy6tnwmm0mD8ZnvKaNCkKhWLAEsSPvMoNv8o/nBjxeh2GR
         mGSzAX4Yg/ZLqw01f1e3MUPdvSa8aeZe1TyOv46qNXDtxNuGFpjrtQil5/TOFDv9EXkF
         ZCO1qeibVrby2YX/U/5NDvEJPWGMRHJ9klqhVHdZeIG1KE/KHSH7owRenDUJ4p/0XX1L
         SDTklNASabV4ai3ohVMAuWFGX3RBZuG95Zw7ns0KCFNejrpyhVaiCsHVZvQf+YkAxH1d
         jgXvw0xMofbY4RY7Jf527IRCqADs7G0J7gCy2FxnvvFvT4RaUjk43HZMDyYEUDPRpGPW
         NCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zO0FQZnNe26RTnkKcZCv04+XN4JQxCO7Vr6g1O65ABs=;
        b=R+ewYmle2w942F59Q1lfOOWE0GjwW2xPJlIg9t3eC4T7NezTMgrkLsuo/tura9o9YH
         t3HWP9TUEyAd4lbnHqmm2jo4i6x4aXI/lEipCHhlDh9LyQalFZJ1y2QEcoppJRxvemqG
         ijvnBU37ZTRaX8bpNiz2zqMqB0wse0nZsActyGZ+QioqMcnL3PTaueVGe8rKyax6Hg/m
         AX5+e67ae8crLfi+ZfPZj8C758cL3JyGAUpxxVULZgyk0iaH6Pi8Fq+x3W9tLTmveDxM
         z3zz8OM/T9vJQInngpqeadRlWSkv4ntLkauLP0T1jTP3cD2enWPMUypnDsd4gaelTB3+
         G8EQ==
X-Gm-Message-State: AOAM531e8I5I1rl10VLnUcZSopFFe9LdNL5nSbFGgfJJnHM/Ykpf++Ul
        icHhyPgK/h1LeyggV6o90uv8FY4qKPC4wFym17SLBA==
X-Google-Smtp-Source: ABdhPJzHtNzQcA9lrjnzKAQncgTv/9QbWxpryHLtoBwT37Ulymvgti95g3cNbHtZ9F7ImCW4BPCgq5crZKFPJ8m6T2c=
X-Received: by 2002:a05:6808:1686:: with SMTP id bb6mr18292228oib.40.1634534255507;
 Sun, 17 Oct 2021 22:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <20211017204036.2761122-1-bjorn.andersson@linaro.org>
In-Reply-To: <20211017204036.2761122-1-bjorn.andersson@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Mon, 18 Oct 2021 10:47:24 +0530
Message-ID: <CAH=2Nty2yyVa1ow_zEOv3nsjjWg9Cb0CpTyDXAenMPMiBs4NQg@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: Enable Qualcomm LMH driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 18 Oct 2021 at 02:08, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> With the introduction of LMH in '36c6581214c4 ("arm64: dts: qcom:
> sdm845: Add support for LMh node")' the CPUfreq gained a reference for
> the two interrupts from the LMh. This means that if the LMh driver isn't
> enabled CPUfreq will not probe and there's no frequency scaling.
>
> Enable LMh to make CPUfreq functional again on SDM845.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 86224aa3a74b..0ae6cd2748d2 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -577,6 +577,7 @@ CONFIG_TEGRA_BPMP_THERMAL=m
>  CONFIG_TEGRA_SOCTHERM=m
>  CONFIG_QCOM_TSENS=y
>  CONFIG_QCOM_SPMI_TEMP_ALARM=m
> +CONFIG_QCOM_LMH=m
>  CONFIG_UNIPHIER_THERMAL=y
>  CONFIG_WATCHDOG=y
>  CONFIG_SL28CPLD_WATCHDOG=m
> --

Tested on SA8155p-ADP board, so:
Reviewed-and-Tested-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Regards.
