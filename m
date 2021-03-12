Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A6C33947F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 18:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbhCLRQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 12:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbhCLRPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:15:53 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0A1C061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 09:15:53 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id u198so22592917oia.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 09:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pvchLbk+2G4U5j0PwGj7xyuqRcTZH67zQqFO94yNuvU=;
        b=tKPk2xZTceJXS43oKJamnXnPMIzm8bcpytkotTjSNMyZBeFF3g1e/pIVWTqdmw4pLs
         GMWIJ6X3ldMYNvr68gKAvHobIGCEENGgWKZStnRA6ZEcQUrWL4nM6PSWVDi2SalIQ1bo
         suSFYuEyMvA6CBlnC0kYzVCjUu8rvtlaPARl6EHVpfbfsjWVxOt3XQqZuPBO3UXBKc6O
         wyAAbEekysmXntj9LYfBCyKEh2z/AU4MZsYpCftb3iWdzmrnuHyqtXFnFOFshjCTxLf9
         HnWfkw5OoVRV0hkzionwmFu7qEHZ1ovnkvB5x2ywiM1pBWg6JJ86DS5nv/PV2bYBQrHW
         LTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pvchLbk+2G4U5j0PwGj7xyuqRcTZH67zQqFO94yNuvU=;
        b=ZDmw4ain2A5MXRvhBEljifHS3CW3IkcBMN/vXCJXzN9sjjQUCoKIAgGNNvHJYjTAXj
         MzT3HAM0xUL6C4a269Ou3c2L45cAwmrB77B43EU/pcTdXE69mAP6E2GBe/1BAAsfCpqg
         42OatEK74idvX3kULs8ghU80ZP9uHbA0MCAfhOl8ll+C1pbw4sfDdqqdQzsluVeoIA3X
         kkIkXDBVCfh6d8Eqtw+oGBfYfyCAD1Yqc18ysBHjYdk880RKLdHca9qRepF54YiIhFH3
         opr+1ar2ZFJ2WamR0W5vyPFhCCfNqgbwG1Lvgbc3Wuy/MTgLbg5HI1oCnpJ1yJ7qZ/94
         P09g==
X-Gm-Message-State: AOAM532pHtEimPKQJHBh4gm9XMJaAQpFhMVKNoLYKrIStdO8mbKRkF+x
        /XZEn6K0kfc0WbY4aHYFYaOOLg==
X-Google-Smtp-Source: ABdhPJxBOPsChzmgafvAwq2jsLAkkq45RsjjQECvcqN/UlDhfQwtBR3gqVC35NBzSFbpxGR2ss4cjw==
X-Received: by 2002:a05:6808:a90:: with SMTP id q16mr10254447oij.77.1615569353000;
        Fri, 12 Mar 2021 09:15:53 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id g34sm1597034otg.51.2021.03.12.09.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 09:15:52 -0800 (PST)
Date:   Fri, 12 Mar 2021 11:15:50 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     swboyd@chromium.org, mka@chromium.org, evgreen@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, dianders@chromium.org, linux@roeck-us.net,
        rnayak@codeaurora.org, ilina@codeaurora.org, lsrao@codeaurora.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/4] dt-bindings: Introduce SoC sleep stats bindings
Message-ID: <YEuhxqDRly658D9S@builder.lan>
References: <1612448508-9179-1-git-send-email-mkshah@codeaurora.org>
 <1612448508-9179-2-git-send-email-mkshah@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612448508-9179-2-git-send-email-mkshah@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 04 Feb 08:21 CST 2021, Maulik Shah wrote:

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
>  .../bindings/soc/qcom/soc-sleep-stats.yaml         | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.yaml b/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.yaml
> new file mode 100644
> index 0000000..1e012ba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.yaml
> @@ -0,0 +1,46 @@
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
> +  - Lina Iyer <ilina@codeaurora.org>
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
> +examples:
> +  # Example of rpmh sleep stats
> +  - |
> +    rpmh-sleep-stats@c3f0000 {
> +      compatible = "qcom,rpmh-sleep-stats";
> +      reg = <0 0x0c3f0000 0 0x400>;

The example is built with #address-cells = <1> and #size-cells = <1>, so
this needs to be reg = <0x0c3f0000 0x400>.

Regards,
Bjorn

> +    };
> +  # Example of rpm sleep stats
> +  - |
> +    rpm-sleep-stats@4690000 {
> +      compatible = "qcom,rpm-sleep-stats";
> +      reg = <0 0x04690000 0 0x400>;
> +    };
> +...
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
