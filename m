Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8591E422D30
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 17:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbhJEQBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 12:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235588AbhJEQBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 12:01:10 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3F7C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 08:59:19 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id t17-20020a4ac891000000b002b612d6d5e9so5861221ooq.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 08:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=00djha3cJUiesRsrnuvTo5vZvqnDPTyBKubeeIIQ0F0=;
        b=ekQXcTd2TYB9/rZUCU0NDfcFNaGGIwTMMJcMUpBg9JGsAmadTPL0PwuVmydODkGVnv
         KbfwzCTUrQhKZGXD0vWPcBzvBQnGt6Z2gabV6NtQy76+d3GlbckZxuaQK0hyplGvYUav
         3z7pMlYaQLZ0n7aqPgWuCXYCMBdodT0nZipaGgBXxkDRYvf8M7bNF5kH3+Z9Lvduy+Qr
         Cznj5E3t3RBaDnvFgfHRec/sfIT97xXb6VLOBGa00VS9/cBuiCJySD3y2NhyfeDjEKll
         NISU/zO8jwwypmODNZnO2MGxNjPMYPdlusdceSh0MrfCGZIyKPxl2ClixYPWC9zzMxeh
         Cz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=00djha3cJUiesRsrnuvTo5vZvqnDPTyBKubeeIIQ0F0=;
        b=JlPJkIxI+2U1kzfu/oOceu4N27RrrpWv7tpZ9mXIpRmLwZr5QRlKe6/eZ0wo2PCCP/
         yT0AR5WpP/97p/CbTrO8Bxnm02U+DiWQVA8vQ/LLmNTb394011Q+rBzZ9gKvI94TSels
         Vq+UYkDcIC9EpgB8NL1zO1iG7FfpQQV0zMblZvGgAH1fHnq7OLx84tbHFwXpmdUSmciB
         sd7EpB1twvMvUUafwDJQAaB+dYT+BbO4w/3zS+VwYWNxulnfmJiAC8MA0V5WNacv/QsR
         kJQNUdPxLUtHyA0M/OTPsviDQTMugQY7TT5giQkFnIrjyDhag9+hsaveOa0t1MJKII9P
         sUwg==
X-Gm-Message-State: AOAM532Tpm/XzdCfLgKNAmhicEDK5t1Fx7f6L6/dg3NkfbK8uHOoxke0
        5/CPvTAvFITl04fLQaoYS9BOtQ==
X-Google-Smtp-Source: ABdhPJybRM8kXIsFIlYNfqtDwntLVfEP48xQAh3cHLmgqJlesvxMrnHmD+Qq+yRHL8pAllaUSxyW7Q==
X-Received: by 2002:a4a:6412:: with SMTP id o18mr14109107ooc.79.1633449558514;
        Tue, 05 Oct 2021 08:59:18 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id u6sm3574636ooh.15.2021.10.05.08.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 08:59:18 -0700 (PDT)
Date:   Tue, 5 Oct 2021 09:01:00 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     swboyd@chromium.org, mka@chromium.org, evgreen@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, dianders@chromium.org, linux@roeck-us.net,
        rnayak@codeaurora.org, lsrao@codeaurora.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>,
        devicetree@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
Subject: Re: [PATCH v10 1/5] dt-bindings: Introduce SoC sleep stats bindings
Message-ID: <YVx2vEGOtFalhNUH@ripper>
References: <1633425065-7927-1-git-send-email-mkshah@codeaurora.org>
 <1633425065-7927-2-git-send-email-mkshah@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1633425065-7927-2-git-send-email-mkshah@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 05 Oct 02:11 PDT 2021, Maulik Shah wrote:

> From: Mahesh Sivasubramanian <msivasub@codeaurora.org>
> 
> Add device binding documentation for Qualcomm Technologies, Inc. (QTI)
> SoC sleep stats driver. The driver is used for displaying SoC sleep
> statistic maintained by Always On Processor or Resource Power Manager.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Mahesh Sivasubramanian <msivasub@codeaurora.org>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../bindings/soc/qcom/soc-sleep-stats.yaml         | 47 ++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.yaml b/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.yaml
> new file mode 100644
> index 0000000..e50be2d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/qcom/soc-sleep-stats.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. (QTI) SoC sleep stats bindings
> +
> +maintainers:
> +  - Maulik Shah <mkshah@codeaurora.org>
> +
> +description:
> +  Always On Processor/Resource Power Manager maintains statistics of the SoC
> +  sleep modes involving powering down of the rails and oscillator clock.
> +
> +  Statistics includes SoC sleep mode type, number of times low power mode were
> +  entered, time of last entry, time of last exit and accumulated sleep duration.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,rpmh-sleep-stats
> +      - qcom,rpm-sleep-stats
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  # Example of rpmh sleep stats
> +  - |
> +    memory@c3f0000 {

As noted by Rob's bot, "memory" is reserved to describe system ram. I
think we can call this "sram@" instead.

Regards,
Bjorn

> +      compatible = "qcom,rpmh-sleep-stats";
> +      reg = <0x0c3f0000 0x400>;
> +    };
> +  # Example of rpm sleep stats
> +  - |
> +    memory@4690000 {
> +      compatible = "qcom,rpm-sleep-stats";
> +      reg = <0x04690000 0x400>;
> +    };
> +...
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
