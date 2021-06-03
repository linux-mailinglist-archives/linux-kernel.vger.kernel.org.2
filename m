Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA91439A9B1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 20:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhFCSFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 14:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhFCSFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:05:23 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB82C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 11:03:38 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id x18so6413028ila.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 11:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6Ob9fN3eHmxejSCkba7i1gC+Yl9GGWt/OzvnuxIALQw=;
        b=paVepX0VnqMe8YBRXCY7eHE/0n6xXvBQNbLJvBmfN3wOMegjaKdslfblqpqiucU+Cp
         fiUpmrDG6u7+ok89LGdVRGozVPyCF9jWnQlFgpJFYMm0/8m3kcwTZ3SFjzknda8UBWvi
         58H8RmovxQR6GpI0A47fN/L2WVkCpxB554lXY+I4r5blY7B8zxX3vomkrE2wHf+Vf4gz
         fyhmUEkfK9GlwcWjteoNileGVMkR/k3qDR8tvoL3TB0DFKwwWUYwYk2Br+6eOv5GkCbq
         6mOv0IuRSwF9+sPdpC608OFuupKa5CV2P2JqKhEDyLmAsUn960ROdvuYUVsqfZaGOeFl
         SuzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6Ob9fN3eHmxejSCkba7i1gC+Yl9GGWt/OzvnuxIALQw=;
        b=PyFmIQ3Ew28sKaXIUVpBMbXika8JoXXIKIy/m0wuSLxzCW7ivGhnHX2FiKyNHu5WYU
         2UpRHfRNTdqeOUR49LJ9mj2fFXPoVdD1LsNFGH/sB+xRUw4Bx62k426hmZFma4OlmqtI
         ttwxZ7D66mzXnlrDeR85oTataOOc3wlf5qYcmCpGP3pWGxqq7LZFoqF95yBMNaMqIwHn
         QpyjVe647GcLScoxXy44Paq6XlyzJjE1Nk2WsVE8pJ1+9FhsTwy2ki16Caca+Pmn+GYJ
         yKhq+FfSRZD2bxG0GsHQHQIJVzR+yG15Xc+hkV61Twq8GhFo3pGXOK6Mh9XDd2fVzaV0
         SC1g==
X-Gm-Message-State: AOAM531/wQszKGai6M603gIq4SVRbREjSAfE3HroHdq28ufWkgbJPi5s
        dM9WM1xUpIpg7C6XAlnWjH3nerHX6MIDbIdH
X-Google-Smtp-Source: ABdhPJzGAIJoYGGO+qgsBYG8XqqUFYBQYiAq0Zbx+HUR+ZZ8zj9HkilaFJyuTtxWZMynAWzYbbGIgQ==
X-Received: by 2002:a92:608:: with SMTP id x8mr461607ilg.217.1622743417937;
        Thu, 03 Jun 2021 11:03:37 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id r11sm2210347ilt.81.2021.06.03.11.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 11:03:37 -0700 (PDT)
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm845-mtp: enable IPA
From:   Alex Elder <elder@linaro.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200519123258.29228-1-elder@linaro.org>
Message-ID: <a9904eae-3de3-8b40-f0be-790c787133bc@linaro.org>
Date:   Thu, 3 Jun 2021 13:03:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20200519123258.29228-1-elder@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/20 7:32 AM, Alex Elder wrote:
> Enable IPA on the SDM845 MTP.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
> 
> v2: This device uses the AP--not the modem--for early initialization.

Ping.  This patch didn't get accepted (over a year ago!),
but it still applies cleanly on top-of-tree.  If you
would like me to re-send it, let me know.  Thanks.

https://lore.kernel.org/lkml/20200519123258.29228-1-elder@linaro.org/

					-Alex

> 
>   arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> index 1372fe8601f5..91ede9296aff 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> @@ -448,6 +448,11 @@
>   	clock-frequency = <400000>;
>   };
>   
> +&ipa {
> +	status = "okay";
> +	memory-region = <&ipa_fw_mem>;
> +};
> +
>   &mdss {
>   	status = "okay";
>   };
> 

