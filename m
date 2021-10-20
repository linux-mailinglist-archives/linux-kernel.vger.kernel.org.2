Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9D9434BD3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 15:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhJTNKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 09:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhJTNKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 09:10:35 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB25DC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 06:08:21 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id h193so7074725pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 06:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IIgapTldr0u9gixvVV/tHeXt0CPLif8wkTF6Jw6YKQo=;
        b=IBSg2WpWNnvyLUI70hiFZaUEiugtNf5oDnPVXlwELkbs5+DiCHoXc3yuawgakmWDN+
         3VXTKlJq6rg01zjXHpch47IUTNMLtA74HQKeaBvLT7AP3vGu1sBzQjkBAqSYN2QkmXeS
         xO5Pabn3fwClj+X60cFXw3tmdHVcug2K0j0wVVQV976fXDQGec0h7YUwLOmJYHOX/LHm
         eaONE6ibASJfS6kqlMYo+BTg2kcfTSMLYVKkPDc4bjgX32oAPNNsC//LC7+ALLORExpH
         VyoYa6ogZ2sBpXDhfkRa6fERGh8fYr2kqZM1ADcvYZxw3k12skwjwN4ZO577+FORjOc3
         czCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IIgapTldr0u9gixvVV/tHeXt0CPLif8wkTF6Jw6YKQo=;
        b=IBoZtqQI9AqhGYiyNebsIyxsfk/xYnuFfRPSFV0JXz7K8m1B+eA56KXE2a5br8cBFW
         p63h/fEL0cWDBZy+0A8LvkJYfGLFLGMK9Au5XEz6ghzEZpHpelhb2JUVKIUpgPO1+ueH
         Jm/z7JrFD59Kj5o2xGhtDI3gj7L7V7W3JyWjOAvWWFf6t7NTacxVeGwSYyPgN28RUPmT
         Mv75dET2P/It3h9rIAxHBIKdI2uV7/8tsCD+5cL4ugzNOTgXLryfAF0ku8w7dkTbeSu2
         U+Oj4sSsWf+Q8h7ktaPu4T4rSQwgdTcvRYuHRcXC6f021QUiD6WAW1O6ED6+tG41NplM
         io/A==
X-Gm-Message-State: AOAM531QoLvYLPaC3VCtmeiRmI1Sk+kFaB1YgRxd3gzV1LSdG/bUF110
        SNzDsyFIfKa+B0jdwstqvxvzyg==
X-Google-Smtp-Source: ABdhPJwMotWZBMWF1EiUTkbclLVG9IDrdNd7pUWTmadpqFWss6S/sPvOQY9PgdyWpxeJ4EaOe7ORJA==
X-Received: by 2002:a63:470b:: with SMTP id u11mr33208625pga.441.1634735301302;
        Wed, 20 Oct 2021 06:08:21 -0700 (PDT)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id qe17sm2840762pjb.39.2021.10.20.06.08.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Oct 2021 06:08:21 -0700 (PDT)
Date:   Wed, 20 Oct 2021 21:08:14 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        rnayak@codeaurora.org, lsrao@codeaurora.org, stephan@gerhold.net
Subject: Re: [PATCH] soc: qcom: qcom_stats: Fix client votes offset
Message-ID: <20211020130813.GE7231@dragon>
References: <1634719753-26064-1-git-send-email-mkshah@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634719753-26064-1-git-send-email-mkshah@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 02:19:13PM +0530, Maulik Shah wrote:
> Client votes starts at 0x20 offset. Correct the offset.
> 
> Reported-and-suggested-by: Shawn Guo <shawn.guo@linaro.org>
> Fixes: 1d7724690344 ("soc: qcom: Add Sleep stats driver")
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>

Reviewed-by: Shawn Guo <shawn.guo@linaro.org>

> ---
>  drivers/soc/qcom/qcom_stats.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/qcom_stats.c b/drivers/soc/qcom/qcom_stats.c
> index 817505b..131d24c 100644
> --- a/drivers/soc/qcom/qcom_stats.c
> +++ b/drivers/soc/qcom/qcom_stats.c
> @@ -22,7 +22,7 @@
>  #define LAST_ENTERED_AT_OFFSET	0x8
>  #define LAST_EXITED_AT_OFFSET	0x10
>  #define ACCUMULATED_OFFSET	0x18
> -#define CLIENT_VOTES_OFFSET	0x1c
> +#define CLIENT_VOTES_OFFSET	0x20
>  
>  struct subsystem_data {
>  	const char *name;
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
