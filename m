Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4DCA3D00EE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 19:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbhGTRLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 13:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbhGTRJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 13:09:55 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157D5C061767
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 10:50:34 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id o201so176022pfd.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 10:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bVpGcCJNxzJz4xn8B9EL3oLPPEWacI7v/ruWv61Q000=;
        b=Y7yJNDAFs6xZpBBXdJ+56blM+/eQeYeXvl3vCk27oQKpwXjLGQFEex3+MqziTV6Vnm
         tl7NccrMvXMiBGQJsXgEHwOM/ulY1UcrE3JhwUI6MS6X64+cZ49wJM30wPAMobI4ixp0
         XnSx8G0Jo/6dmBGnCj0wFAKIKTa/DS35E7vlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bVpGcCJNxzJz4xn8B9EL3oLPPEWacI7v/ruWv61Q000=;
        b=GTSuBibSpEHEpLMj/aCtLEnW7kSLPoomduPxqwYSfbKyCPvbsE7zooBMCRxB1Olqm2
         5MIyyMBD87rbMvLUNSzaUKGabPejNUTeGEDjwL7oT0tE+UunFbG8ciwI5slhRSmwQ5Wj
         IVWCp7DEFjkP+Yi4Q7KnL0+WwerKYcObK7VBYLlr7xfx7gd70+AFoxCH/+mD7jb6QlP2
         tI6rr1ngFxKtQC1if55xRecHumm5Ofq6o8FBYa/5LOOYW6Wvi0IIrzWKx9k8ULxqJZQw
         CPEBSlcEe3+w0Kg6//abZQgBWlHJes6HpY4cVETB4Hybv6DjcYbELnmF++wYNiTzyUGm
         hGSg==
X-Gm-Message-State: AOAM532LOgah99fRMWdLGSikkBNQpU5LxgdmTJNevrUpOastnRRlyrky
        6WZELHPT/c8qPDgenv4PPlud5g==
X-Google-Smtp-Source: ABdhPJw+3aILAs44wxCIgv56bChOz7Y3d9mZXQ9GF5TniuDGef+oZzkVcX6tuZc4Va86+BDDWA3x6A==
X-Received: by 2002:a63:d757:: with SMTP id w23mr5870300pgi.434.1626803433510;
        Tue, 20 Jul 2021 10:50:33 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:4d0:bf5f:b8cd:2d67])
        by smtp.gmail.com with UTF8SMTPSA id d191sm28036023pga.27.2021.07.20.10.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 10:50:33 -0700 (PDT)
Date:   Tue, 20 Jul 2021 10:50:31 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, tdas@codeaurora.org, agross@kernel.org,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Fixup cpufreq domain info for
 cpu7
Message-ID: <YPcM5w60c5s+mZ4Y@google.com>
References: <1626800953-613-1-git-send-email-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1626800953-613-1-git-send-email-sibis@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 10:39:13PM +0530, Sibi Sankar wrote:
> The SC7280 SoC supports a 4-Silver/3-Gold/1-Gold+ configuration and hence
> the cpu7 node should point to cpufreq domain 2 instead.
> 
> Fixes: 7dbd121a2c58 ("arm64: dts: qcom: sc7280: Add cpufreq hw node")
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> Cc: stable@vger.kernel.org
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index a8c274ad74c4..188c5768a55a 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -200,7 +200,7 @@
>  					   &BIG_CPU_SLEEP_1
>  					   &CLUSTER_SLEEP_0>;
>  			next-level-cache = <&L2_700>;
> -			qcom,freq-domain = <&cpufreq_hw 1>;
> +			qcom,freq-domain = <&cpufreq_hw 2>;
>  			#cooling-cells = <2>;
>  			L2_700: l2-cache {
>  				compatible = "cache";

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
