Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1679454C01
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 18:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239406AbhKQRel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 12:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhKQRek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 12:34:40 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B81C061570;
        Wed, 17 Nov 2021 09:31:41 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id b184-20020a1c1bc1000000b0033140bf8dd5so2702523wmb.5;
        Wed, 17 Nov 2021 09:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/8znBzxWnYUTFtm0bh/WbwD/k2I/6DqFEZbIjaU/ygs=;
        b=WiEoGbxhcag/Yj2EyGJiVwKT2nTwgzHlm69xKBxuzGEip5ZYycyA9VIfH2kGrcCOnp
         ZWVuxQ/8ZkzV0rhjvEeyLZVy/LqQLMJHnCQK3JAG2FzmLpcDwETxAN79z7IrLqpZZexx
         IwiAqKuC7gl9FwaqG3VWZhyAuOJG8gUN/j8xDsxYl+nLJcViczrL2HZe/KXakM6LdsYP
         p/YBFd2U135adbNU8mMcejENpwyVkS+TVgkm4j/HmaFTejhLWHDBQGZqaMh2hczHJ4Mf
         bxyUjLTcLAIP3Ki/43YCQfR2+kjXaxga6tFnYT4xugE3ZwBZ6KI+4rpc5n9Ww3+Ae+Cl
         X+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/8znBzxWnYUTFtm0bh/WbwD/k2I/6DqFEZbIjaU/ygs=;
        b=VL9WjudFkYsHe8k3GrQjVERetaVSNghzr52wsIORfIYT0bQNHSvfuz8sAHDLoD7N48
         GW8cE9aS+acqRMf/vZJRz8H2cBuchAredov+miKnAKH3OH9B0dGgwqp+I300qYvzPeaK
         whWAidocJRhIsScbUj+G2dkwUD9HkU4N+ucWtTQ6MYZo5vIP7nzmd5AugVr4W0yVJ2iX
         X4xQuxjAfpYpfLi16imxeVkP+7+MvuyEu474W6I9raHBDOciTjN8A3OhmS2zJynu48i1
         8hqSw6c4oXQ7hFNm5u+UjdAzu8W1g+c3BpbsAQjzMcodbNil4GJ9hnROfTSbgKssJTO6
         AYyg==
X-Gm-Message-State: AOAM531uHL+BFLphTu1e9HcDfLR/nRl/Tj8jNSoXRc3PS4vcyLn725zp
        OXPNeptmord7cL5z4qySv14=
X-Google-Smtp-Source: ABdhPJw26WVzu3C/ccQ1PDjQq/w4b2/WnMQ9AUtYFX2IWmI+T/7SZnVIS5jVm8onWml++0683aXSQQ==
X-Received: by 2002:a1c:9842:: with SMTP id a63mr1656413wme.102.1637170299994;
        Wed, 17 Nov 2021 09:31:39 -0800 (PST)
Received: from [192.168.0.18] (static-160-219-86-188.ipcom.comunitel.net. [188.86.219.160])
        by smtp.gmail.com with ESMTPSA id g18sm511817wrv.42.2021.11.17.09.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 09:31:39 -0800 (PST)
Message-ID: <24067294-2e86-fcd6-8a47-95d56ff5e569@gmail.com>
Date:   Wed, 17 Nov 2021 18:31:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] arm64: dts: mediatek: mt8183-evb: Add node for thermistor
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211110192631.4182485-1-fparent@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20211110192631.4182485-1-fparent@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2021 20:26, Fabien Parent wrote:
> Add node to be able to read the temperature for the thermistor
> connected to AUXIN0.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Applied to v5.16-next/dts64

Thanks

> ---
>   arch/arm64/boot/dts/mediatek/mt8183-evb.dts | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> index 7bc0a6a7fadf..f3fd3cca23e9 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> @@ -36,6 +36,14 @@ scp_mem_reserved: scp_mem_region {
>   			no-map;
>   		};
>   	};
> +
> +	ntc@0 {
> +		compatible = "murata,ncp03wf104";
> +		pullup-uv = <1800000>;
> +		pullup-ohm = <390000>;
> +		pulldown-ohm = <0>;
> +		io-channels = <&auxadc 0>;
> +	};
>   };
>   
>   &auxadc {
> 
