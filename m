Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E07444ACA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 23:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhKCWV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 18:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhKCWVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 18:21:22 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29888C06127A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 15:18:45 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id r10-20020a056830448a00b0055ac7767f5eso5578942otv.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 15:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KbAK3E9gZ0Rf65SdcooIGvTrnplapjhc1zBGEcQwMw0=;
        b=FxVPe4f6LLQG7z67e383KouBmt/gDlXT01XhIyLpbOX1ubzbbveB/WebH8mdxVvBux
         BoQH4kuafbBqw6mw9q2LJ5bCsnmHZjtsQis9+tdQGfJEaHQtqef8LpIiCNjy4zhacaad
         m2NtcBHHSDnN+apNFNe73D1Cuixq/t5Rdm+xilmYnpWW0EbPBnJ0FHq9wO6rWLyJVII1
         Xg32sN6EyH9QtS5md7S68uOiB819/jerOrmoyhxNGFQeiTm7iCDv8frX9kEA4BZzI620
         aS7Pe8/2CPHahmk+nHDWlTKg9OlZO4wzwtgcpkZHdW1TRpqXLUggXsjQGEn8Lpn4/vUi
         Y7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KbAK3E9gZ0Rf65SdcooIGvTrnplapjhc1zBGEcQwMw0=;
        b=wdM/6bhU47AtyLrMepHZ0k8DRYBJaaeKCpegA2F8VyR/b+DSX4m0lRyhI4jbYKFUOR
         tUNIGnrisCPHZE9TG/rtKS7L+v1CyBn+Ktt+XeqkdZSV6c5x3+W/zclg3gOQUc6pC3Tw
         KCNxxBGgHGY+ayZjVpv5ZXfJgamM7cJG9rJX+bt6YJ1C1uXotCcvAiyl6sgWpyv8o8mC
         2pBSqm7emttBZFXU0B3WzUgSIighbOCZ6xn1jZfW11pi/2jkTK7l0VogiHpimVai5vFz
         poeDJdkakx4zkV2EqcxgT2JJspUr80THjFh7YUbM839r3tGtd9l9fqTzF+QGaNshCcWz
         J/9g==
X-Gm-Message-State: AOAM533sVlbCKUh0SZ/oJHIUeXwdbfigtrQQ5ql9tvIgXkWC8KSg/fIb
        qBmk8uhBsA0g+e90I6haGIqxow==
X-Google-Smtp-Source: ABdhPJwE3gWlnEHH4Dmdjy/djjbu/ePiC4Xgep2d/Vs4xE4zOZ7x255+QMBS6qvbjDXdOMBbreC0yQ==
X-Received: by 2002:a9d:774c:: with SMTP id t12mr28285120otl.282.1635977924469;
        Wed, 03 Nov 2021 15:18:44 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id s21sm879524otp.57.2021.11.03.15.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 15:18:43 -0700 (PDT)
Date:   Wed, 3 Nov 2021 15:20:24 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Fenglin Wu <quic_fenglinw@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        collinsd@codeaurora.org, subbaram@codeaurora.org
Subject: Re: [PATCH v1] dt-bindings: convert qcom,spmi-pmic-arb binding to
 YAML format
Message-ID: <YYMLKCspjdyaKWUK@ripper>
References: <1635836275-8873-1-git-send-email-quic_fenglinw@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635836275-8873-1-git-send-email-quic_fenglinw@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 01 Nov 23:57 PDT 2021, Fenglin Wu wrote:
[..]
> diff --git a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
> new file mode 100644
> index 0000000..05bb114
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
> @@ -0,0 +1,122 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spmi/qcom,spmi-pmic-arb.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SPMI PMIC Arbiter
> +
> +maintainers:
> +  - Fenglin Wu <quic_fenglinw@quicinc.com>
> +
> +description: |
> +  The SPMI PMIC Arbiter is found on Snapdragon chipsets. It is an SPMI
> +  controller with wrapping arbitration logic to allow for multiple
> +  on-chip devices to control a single SPMI master.
> +
> +  The PMIC Arbiter can also act as an interrupt controller, providing
> +  interrupts to slave devices.
> +
> +  See Documentation/devicetree/bindings/spmi/spmi.yaml for the generic
> +  SPMI controller binding requirements for child nodes.
> +
> +properties:
> +  $nodename:
> +    pattern: "^qcom,spmi@.*"

Node names should never contain "qcom,". Seems the agreed upon node
named should be "spmi@.*".

The rest looks like a reasonable conversion to me.

[..]
> +examples:
> +  - |
> +    qcom,spmi@fc4cf000 {

Regards,
Bjorn
