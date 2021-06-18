Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0FA3AD0E2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 19:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbhFRRGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 13:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbhFRRGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 13:06:09 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0845C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 10:03:59 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id v22-20020a0568301416b029044e2d8e855eso1131508otp.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 10:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hS6Ph+TqVJWLf/2tgtcoPQIPDI6nxlHVB3e8hgJ1e5s=;
        b=z6K4EVsU5YmuAv8fyPRqVbdKQTLOUqGuWhR8Vbrpz9IY8Dbp7GvP3hv7FniKulj9X+
         KA9DrJZsU0ZXwAJvolbkpK6hQOy/L3D2S1ajmkiAzAsKcv+Wt4e9nfgh7XO8a/TNh/WR
         OVIQh+Zk0Tt76WVwkmkueaycQPHP3zJRl94E3971SdMjHmXHhcngUS75P+ZeUNgX609D
         6slySbsCttF8lpeV+wnlWs/wM7tfDk9gM/bKmqoxAgvKaR4PX/0h9v2rkveILJqPae8v
         Rxqvs0Y0iaYUmi2P3g523btyZ91EX2tEiyO90FnXn620hKdadJnbnS9xoHJHDnQ+QvV5
         ZZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hS6Ph+TqVJWLf/2tgtcoPQIPDI6nxlHVB3e8hgJ1e5s=;
        b=J8nkIo5KkEzNG/H4TGvvEWOVlKhKWwxvt0a1nowX2tPTO7jwCi0loqMjE6vufL7+FP
         MVG5VgvtEBVLyoVHNVN9X50WNwaLT4RJppn6InDwnpMO4zoqNTjM2casyfF2ArQb5UPB
         pcDV9nSxoIW0bh3tsIAhI2tr8s3nXAehpcYfCY05698lLAqptbr/T6lzeU6lF2/kAH91
         INorGzzgR70K5E0i1N7MXMo3BXqkJh/68pUbI/GrWhs6lychNwsyCp5VSC7qbQae1XHw
         DsuLB3Noj4gfnzjlhmcsfVARrc3f7LpxeAyMdH0TNm1eBaGQulbJYWOx/gINq/47s9PM
         ZSAQ==
X-Gm-Message-State: AOAM532rSk19aBdd7shS+FreV9xOPQ6rboVBXDutk6u2gFirjAW+17FP
        ibsNCdT53beK8R7ilyVy+zU+SZo4MbhYAQ==
X-Google-Smtp-Source: ABdhPJz8D52Hor6uFvXUI9Taldgxm9IHzYZgejikA1YYxSPQ5zdIORsVPxFwalrB+BGvVXA8wpxxTQ==
X-Received: by 2002:a9d:389:: with SMTP id f9mr7726513otf.213.1624035839270;
        Fri, 18 Jun 2021 10:03:59 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id n20sm2255333otj.11.2021.06.18.10.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 10:03:58 -0700 (PDT)
Date:   Fri, 18 Jun 2021 12:03:56 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] soc: qcom: geni: move GENI_IF_DISABLE_RO to
 common header
Message-ID: <YMzR/H3QyQeEB2hB@yoga>
References: <20210618141839.3777270-1-vkoul@kernel.org>
 <20210618141839.3777270-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618141839.3777270-2-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 18 Jun 09:18 CDT 2021, Vinod Koul wrote:

> GENI_IF_DISABLE_RO is used by geni spi driver as well to check the
> status if GENI, so move this to common header qcom-geni-se.h
> 
> Also, add FIFO_IF_DISABLE define.
> 

Afaict these registers relates to the hardware block that is primarily
owned by the individual engine-drivers, would it not make sense to move
them all to the shared header file?

(The patch itself still looks ok, but needs the consuming patch to be
merged)

Regards,
Bjorn

> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/soc/qcom/qcom-geni-se.c | 1 -
>  include/linux/qcom-geni-se.h    | 4 ++++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
> index 5bdfb1565c14..fe666ea0c487 100644
> --- a/drivers/soc/qcom/qcom-geni-se.c
> +++ b/drivers/soc/qcom/qcom-geni-se.c
> @@ -104,7 +104,6 @@ static const char * const icc_path_names[] = {"qup-core", "qup-config",
>  #define GENI_OUTPUT_CTRL		0x24
>  #define GENI_CGC_CTRL			0x28
>  #define GENI_CLK_CTRL_RO		0x60
> -#define GENI_IF_DISABLE_RO		0x64
>  #define GENI_FW_S_REVISION_RO		0x6c
>  #define SE_GENI_BYTE_GRAN		0x254
>  #define SE_GENI_TX_PACKING_CFG0		0x260
> diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
> index 7c811eebcaab..5114e2144b17 100644
> --- a/include/linux/qcom-geni-se.h
> +++ b/include/linux/qcom-geni-se.h
> @@ -63,6 +63,7 @@ struct geni_se {
>  #define SE_GENI_STATUS			0x40
>  #define GENI_SER_M_CLK_CFG		0x48
>  #define GENI_SER_S_CLK_CFG		0x4c
> +#define GENI_IF_DISABLE_RO		0x64
>  #define GENI_FW_REVISION_RO		0x68
>  #define SE_GENI_CLK_SEL			0x7c
>  #define SE_GENI_DMA_MODE_EN		0x258
> @@ -105,6 +106,9 @@ struct geni_se {
>  #define CLK_DIV_MSK			GENMASK(15, 4)
>  #define CLK_DIV_SHFT			4
>  
> +/* GENI_IF_DISABLE_RO fields */
> +#define FIFO_IF_DISABLE			(BIT(0))
> +
>  /* GENI_FW_REVISION_RO fields */
>  #define FW_REV_PROTOCOL_MSK		GENMASK(15, 8)
>  #define FW_REV_PROTOCOL_SHFT		8
> -- 
> 2.31.1
> 
