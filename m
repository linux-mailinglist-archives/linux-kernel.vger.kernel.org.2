Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93FE3E0666
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 19:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239808AbhHDRQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 13:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239695AbhHDRQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 13:16:13 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C6BC0613D5;
        Wed,  4 Aug 2021 10:15:59 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h14so3043119wrx.10;
        Wed, 04 Aug 2021 10:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c4j6T3m1C4pL+lPcW0oUDbkxI8uRYoCs76i1TtiXvnc=;
        b=sJpff0nnWDGvxC8ZM3ej4RZnYJELHF3NM1ikHDdi1c4Fk36WpZk+hGcOpgXXjwAdSo
         K1EmXD7mCJNKoYowu6E8yC/z2eHUFN6eFBHYxosBSsaTwprZzwW1be5veR7y+ZUflmoC
         cbSlcvu97XJRZyblcAy+wnCdMDj7DNnJdic80yzOhb/+E9KrobeBkPOzt26XBhPq3j/Z
         OcARkok9Z2zQkg/2FoMZZhy1WY4lRcdyaty8Pz/rw4OtZX+9ef2x5B97wVrHRWLwPWip
         xlWqkrvI/t7b4sO9PCkD5oSLAe61LskvLYpa8HGv91FRwlCaKBfIVYV1Ytm+TwF1IOxj
         7Wng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c4j6T3m1C4pL+lPcW0oUDbkxI8uRYoCs76i1TtiXvnc=;
        b=Bu0WyKc0RE3Zhj92N5o7kub+PAZl0CWWcEYlMjc6E5R/rbYnmLr/1IGOHFB2+lUjxp
         UnWOjeWdi/gAgdo2cMtjJf7/eqV66bPZiIqHa2UkyP8A26wADinHiapqOLi4yHlggx0A
         Q7PKdvCU8WJL+/Umme/kQSTjDOYb2o5pypn+RaSLn3HlCBP8El+o5kj8XADqkftazbjV
         vifdwa+D1tYsPCfPS1xHu4N5l1OIEQmqydULUhBPULPwtZIfyBysyfcsrJR8jBpoijfG
         iadalyjOACTgBklowus777GTZgFPJkmFQiQ60JePHgTQSG2Ui5XnMoaHS7tj8CVmK/4p
         Vj3A==
X-Gm-Message-State: AOAM531ZKZqYQucn1uzLGOS5mLT4wUKZ4OwoO4ldN21hiy84qOyTWhWG
        VKR2HchCW6e83AxB0aw3rARUuCVvqxnjaQ==
X-Google-Smtp-Source: ABdhPJwUObN0r34XPKPFfFXf0JVqSRsPVdEbkOCBYZN6v7CvkdaIkZBUf9JibNEtGgRtI50h2yRmIw==
X-Received: by 2002:a5d:55cb:: with SMTP id i11mr446654wrw.158.1628097358323;
        Wed, 04 Aug 2021 10:15:58 -0700 (PDT)
Received: from ziggy.stardust (static-55-132-6-89.ipcom.comunitel.net. [89.6.132.55])
        by smtp.gmail.com with ESMTPSA id z6sm2844141wmp.1.2021.08.04.10.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 10:15:57 -0700 (PDT)
Subject: Re: [PATCH] arm: dts: mt7623: increase passive cooling trip
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210725163451.217610-1-linux@fw-web.de>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <8122ce40-ee45-ff09-cc08-ac4d6ae2bfa5@gmail.com>
Date:   Wed, 4 Aug 2021 19:15:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210725163451.217610-1-linux@fw-web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/07/2021 18:34, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> MT7623/BPI-R2 has idle temperature after bootup from 48 degrees celsius
> increase the passive trip temp threshold to not trottle CPU frequency at
> this temperature
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

pushed to v5.14-next/dts32

Thanks!

> ---
>  arch/arm/boot/dts/mt7623.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
> index b7247ab082aa..11933494e03d 100644
> --- a/arch/arm/boot/dts/mt7623.dtsi
> +++ b/arch/arm/boot/dts/mt7623.dtsi
> @@ -160,7 +160,7 @@ cpu_thermal: cpu-thermal {
>  
>  				trips {
>  					cpu_passive: cpu-passive {
> -						temperature = <47000>;
> +						temperature = <57000>;
>  						hysteresis = <2000>;
>  						type = "passive";
>  					};
> 
