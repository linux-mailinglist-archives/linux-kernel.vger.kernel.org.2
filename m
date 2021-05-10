Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949BF378112
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhEJKRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhEJKR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:17:29 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A24C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 03:16:23 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id i81so15340923oif.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 03:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+r+tNLFDppJOvmy8NbCdwzEyEYcJmtQue/FgZdoGhW8=;
        b=BvHGmvj/MU6iXnVTT9LHkgeyk3C8HUXAoFc8If+T1/AwB6RIXGCn4Jb/w5vi6ZTFK8
         hRntAuz5FqS7qCo7hiowicpuYyekhg1GnFfyorDccLysLhCUpHiUD4TqjAWP95Al4kZB
         dydoQ8CL8Bmz+eTs/3RLK9jqpZoPQKASJIPtZWLeQB0Vap+ehqm1S9au1NsjcGDmIgD6
         QTOEESSTGViGTRQlEq9g5AP0+5+VDYYA6IHyycKqgS9rcklHMoDkGCJKDzLuywRu/nKl
         DsmbQ+NOQFy+sR94KhF///pPcuU/VZ3RMyOE2rI8cjMmBcBLjEl7H3CbAPeZCFSWe+Go
         r2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+r+tNLFDppJOvmy8NbCdwzEyEYcJmtQue/FgZdoGhW8=;
        b=T6WQXmjxe4EM2MvkX8DJaMxMvYz5d6b6fK/tzWVYnwDKR+QIWsknt8vmJ4wLlWK21V
         1Wba3/gkLXr/AH/IpRYmCxrSaOSdyFRutYTkzEqNaY1hwOtL17fhaI4/f4sNU9kOO7Q6
         gHvd1WvffTlcKA+sAWlYhey+dkHNikoa3OetYFMACZkZ3Jbup/cKcy/jss/QfTr4yQj0
         412I5oMM4zDRCAn9rQnLO7ELLR0kfdgMUUgFcMSfyo6mdJ3yZsytdl+K5U66ufRAJm5c
         bvjPcV9xkzKRZW2Nse/WrLLGjDYK9o3soL9zDz1H7iX+1KtXC1llIuy2DC1L4ayupI46
         ULRw==
X-Gm-Message-State: AOAM530/F4y6INp+lNmbyDoPUTc3wN5v2R5QCwd7pCkiqe4EmTV/OiB7
        90fLD2S8imj//qjCAghaNtEXc2x8x7dLBaxZlYUSnw==
X-Google-Smtp-Source: ABdhPJwSDBFbEcohkYa9kei2T3fY2p68vATjwelCr+U/fr3FIi747UjXJitCqcfZqU9z3egz+2iastrbVMo91DPQQGE=
X-Received: by 2002:a05:6808:f0b:: with SMTP id m11mr4145727oiw.12.1620641783048;
 Mon, 10 May 2021 03:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210510070725.3839459-1-vkoul@kernel.org>
In-Reply-To: <20210510070725.3839459-1-vkoul@kernel.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Mon, 10 May 2021 15:46:12 +0530
Message-ID: <CAH=2Ntzn8GTeADAtvzVQ_kEheKYvqAbH8rZJacPk_S6AQ98r7Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: qcom: enable interconnect for SM8350
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2021 at 12:37, Vinod Koul <vkoul@kernel.org> wrote:
>
> Enable the interconnect for SM8350 as a module
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 08c6f769df9a..a382d85c9434 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1148,6 +1148,7 @@ CONFIG_INTERCONNECT_QCOM_OSM_L3=m
>  CONFIG_INTERCONNECT_QCOM_SDM845=y
>  CONFIG_INTERCONNECT_QCOM_SM8150=m
>  CONFIG_INTERCONNECT_QCOM_SM8250=m
> +CONFIG_INTERCONNECT_QCOM_SM8350=m
>  CONFIG_EXT2_FS=y
>  CONFIG_EXT3_FS=y
>  CONFIG_EXT4_FS_POSIX_ACL=y
> --
> 2.26.3

LGTM, so:
Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Thanks.
