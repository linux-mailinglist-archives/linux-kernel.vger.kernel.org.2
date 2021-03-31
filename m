Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D07934FBE0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 10:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbhCaIsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 04:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbhCaIsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 04:48:19 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D31C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 01:48:19 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id r12so28870018ejr.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 01:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Jw2MD2OVUN2L21+7k+pXcxOK0uQsnTVYELI5AAg+AkY=;
        b=N6AbPRG1/jexye9J3XSF/KVyFynlBjBHEGDDiwfMG2iS7qwopHOzmadPAlEsnJ/Txd
         92IvkFuQ4ZoTTObNz6j6Xo4RMlaGpCWnNo6+6YU+gedEwvDpt1f8sg20FIIQ70ZQ/UbD
         ezNPlgj7oB+weWU/zY6ZRj68DLYZ+05eEw/tucOZuq/+VHzxckeL3zJzBRFF2GNCQUji
         9UU9sgxE7yQswn7oMij1dchRrLk7yWOtLFGGdnBG/0wN50DUeDkgUfZZPDfX/dlo0ThW
         /JZe7uDDAxNuJrLwyf4zc/AR5yTR4WM3rWy7nrTNzLNuwPvOTDjTMFPp9W8oIpmGjOmw
         VdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jw2MD2OVUN2L21+7k+pXcxOK0uQsnTVYELI5AAg+AkY=;
        b=Hc5Vto1I/ALxesIXjV/If+1PHWhUfWSBXYqKe3fJV4FQue0xmbGthS/CktTrEvj4+X
         VdJSp8odsEiWHo8fZdNhZZKfIZU67Yhb39KBa1UUW6qc/Z/VlMSOwqTU1ltWDV/klOTn
         ye6Vqu/Mw6GXGrDI7DhQKWYieV2CNxpk5FGgnmIz+998VzAWeyJg36ktB4YFrbOw8YdU
         askLA3YIFVXypWsJ0KzFdfZV4K83M+rQKeCii0Nd5iuZ2QQmk0IrA2a+J2bHbWQYnHUF
         25qg2OuG+fOOm6bihVcStZBSRY4fqoE1LsV4Woa7dCdon79hr/HoOfVErXG1lZKX9LQ+
         NBqw==
X-Gm-Message-State: AOAM53329t0VkjuKbmsrg9zE0CmYHCjTsxItWSCStSbGNXjrKFWRNNUG
        jUl6axDvZCPtCklkPSNhxXWyRA==
X-Google-Smtp-Source: ABdhPJxMG+Qcy0BWZowpO27oqiWDUSa4Bq/QIaScnqsyZ5QJaPumFqthf+jlWlKNmpJN7j+YrlH0aQ==
X-Received: by 2002:a17:906:2bc3:: with SMTP id n3mr2374169ejg.418.1617180497855;
        Wed, 31 Mar 2021 01:48:17 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id a22sm740177ejr.89.2021.03.31.01.48.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Mar 2021 01:48:17 -0700 (PDT)
Subject: Re: [PATCH v7 2/2] arm64: dts: qcom: Add sound node for
 sc7180-trogdor-coachz
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rohitkr@codeaurora.org,
        dianders@chromium.org, swboyd@chromium.org, judyhsiao@chromium.org
References: <20210314061054.19451-1-srivasam@codeaurora.org>
 <20210314061054.19451-3-srivasam@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <3dcbe1d3-3f6b-e9e8-f347-883b330e3404@linaro.org>
Date:   Wed, 31 Mar 2021 09:48:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210314061054.19451-3-srivasam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/03/2021 06:10, Srinivasa Rao Mandadapu wrote:
> This is a trgodor variant, required to have sound node variable
> for coachz specific platform.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

>   arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
> index 4ad520f00485..e2ffe71c2d52 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
> @@ -89,6 +89,16 @@ &sn65dsi86_out {
>   	data-lanes = <0 1 2 3>;
>   };
>   
> +&sound {
> +	compatible = "google,sc7180-coachz";
> +	model = "sc7180-adau7002-max98357a";
> +	audio-routing = "PDM_DAT", "DMIC";
> +};
> +
> +&sound_multimedia0_codec {
> +	sound-dai = <&adau7002>;
> +};
> +
>   /* PINCTRL - modifications to sc7180-trogdor.dtsi */
>   
>   &en_pp3300_dx_edp {
> 
