Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498A535A26B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 17:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbhDIPzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 11:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbhDIPzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 11:55:35 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697F7C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 08:55:22 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id z15so6208756oic.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 08:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7FhH3HxnPhik9wr89dR/sW0eRHTu8hPyuSyg+W7XtPs=;
        b=dnk8I5QzyMjjItJpGxLSIwh4o4JkMyOpncSyroDFsJ1xGvGiZGFQoorYMliGZJzXZg
         BKbNZA/c9tmuUwlG7u7WVtl5GpJF3u48HtvA9+TgVxb7+Q5yqE2npdQ+SFvqLIns3o82
         17Hamlac8BB4PUMIksNM1+tw2v9h3iUAbfdRj4Uwa52itndgwIYRzYtrG+jIH4+q/Uew
         WTqrCsQijhimidHjsvltK7l+/glCt0CONdkZ2/JTFDCRO9M3HGQh9lHscfRR61LbVwja
         J2HM/J9T/YMYaAwDML0oNx3l1Zdupijh8XfaJK3mZOXTtCpN6ctcpXbZlIOkLBEayOOp
         ntlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7FhH3HxnPhik9wr89dR/sW0eRHTu8hPyuSyg+W7XtPs=;
        b=olNE/jNAjvyUhixTiwQdVQXVCej9JsUNAKSu/qJ9fW4saMLG+ngJRLYc2Bk3rp6jTU
         KWp6rhWNvveLGAJxHUyxeG4msjVXQ10N/sJsme9kl2fvUjCuaYPDlrtLPdxjTRlv9RYY
         bDXYe/RmFyc5e9efjl0cqeTVJWBxdGNeiy3g8QP1tZr1up5s8Ob0xNY7E3DS1/TLjnW9
         yZ2Y6j3aQi0Vw3xISv0KcDB0ijsR5k9/0nOX7qI2QIDvo/557gn3+G58ON6X4r/KXiMH
         qoFKXexCfLonDw1NpN4J3p7NUaV7LU/482VvC2y6psdOCgN0Md3WHGvnd+by8WMQTsCb
         xMkA==
X-Gm-Message-State: AOAM533c94F4ec5dHbBQIglLaPrGw9DdqIDYbN2dv5gsAp1Vnq6oT7td
        JBSaHxLkOcH5l6RCioZ9nQmo1A==
X-Google-Smtp-Source: ABdhPJz3Dh7G+iRZvpx0N80r9hJXBOQByK4B4InfbL8YiBVAUS7tQEets07umN9tgXMnbtswDzprlw==
X-Received: by 2002:aca:de06:: with SMTP id v6mr10044632oig.91.1617983721822;
        Fri, 09 Apr 2021 08:55:21 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w199sm576723oif.41.2021.04.09.08.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 08:55:21 -0700 (PDT)
Date:   Fri, 9 Apr 2021 10:55:19 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: mfd: pm8008: Add IRQ listing
Message-ID: <20210409155519.GX904837@yoga>
References: <cover.1617927259.git.gurus@codeaurora.org>
 <2607ca31fce40ecdb1e8c96dac0fb688c26ad722.1617927259.git.gurus@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2607ca31fce40ecdb1e8c96dac0fb688c26ad722.1617927259.git.gurus@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 08 Apr 19:38 CDT 2021, Guru Das Srinagesh wrote:

> Add a header file listing all of the IRQs that Qualcomm Technologies,
> Inc. PM8008 supports. The constants defined in this file may be used in
> the client device tree node to specify interrupts.
> 
> Change-Id: I13fb096da54458f2882e8d853a3ad9c379e7d5a9

Please remember to drop the Change-Id when posting to the mailing lists.


We typically don't have defines for the IRQ numbers, but I don't mind.
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> ---
>  include/dt-bindings/mfd/qcom-pm8008.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 include/dt-bindings/mfd/qcom-pm8008.h
> 
> diff --git a/include/dt-bindings/mfd/qcom-pm8008.h b/include/dt-bindings/mfd/qcom-pm8008.h
> new file mode 100644
> index 0000000..eca9448
> --- /dev/null
> +++ b/include/dt-bindings/mfd/qcom-pm8008.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2021 The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef __DT_BINDINGS_MFD_QCOM_PM8008_H
> +#define __DT_BINDINGS_MFD_QCOM_PM8008_H
> +
> +/* PM8008 IRQ numbers */
> +#define PM8008_IRQ_MISC_UVLO	0
> +#define PM8008_IRQ_MISC_OVLO	1
> +#define PM8008_IRQ_MISC_OTST2	2
> +#define PM8008_IRQ_MISC_OTST3	3
> +#define PM8008_IRQ_MISC_LDO_OCP	4
> +#define PM8008_IRQ_TEMP_ALARM	5
> +#define PM8008_IRQ_GPIO1	6
> +#define PM8008_IRQ_GPIO2	7
> +
> +#endif
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
