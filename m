Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E5941C343
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 13:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245683AbhI2LTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 07:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245671AbhI2LTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 07:19:49 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C05C06161C;
        Wed, 29 Sep 2021 04:18:08 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 33D548281E;
        Wed, 29 Sep 2021 13:18:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1632914285;
        bh=dGc4HjvZ/w/JGXHTxOzP8+/A2IJCNhU36kbfb8OcODs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=rZUu0BmrtcFmpE05PQ0K8pJq9SLJ0TGzjmO+ozo52scz0uuK5v4SRjPlFeFqMjVLl
         b35mTHB4MYWG0sEzdbpkeY6IozQqvASG0gFd6wbisfsbNjqCi0VafJGrZpvqdeWLiA
         UgSWQ007LgodFu6lg7gUaanPGFZq319PynJAQO+ia1pDsxyzPmapmrkyOcqzr4BoNr
         mMfGfI56taBA4Rn0NlfrmUcF8xd5Owrb9b8Ea4uBtcrcSxtyKllHgpH3GHRJE1lljF
         1AzrsfDa0T4AH69m1Qxpi/nCMFMlu5UEhTrcb5sQPrt/pKmc4OsY8r2ew7ar5wrEf+
         fo2RtkBdT94qQ==
Subject: Re: [PATCH 1/1] ARM: dts: stm32: fix AV96 board SAI2B pin muxing on
 stm32mp15
To:     Olivier Moysan <olivier.moysan@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20210927114553.21843-1-olivier.moysan@foss.st.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <beb6e7c8-f3c8-fc4e-6017-fea5690b9f33@denx.de>
Date:   Wed, 29 Sep 2021 13:18:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210927114553.21843-1-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/21 1:45 PM, Olivier Moysan wrote:
> Fix SAI2B pin muxing for AV96 board on STM32MP15.
> The label "sai2a-4" is defined twice. Change redundant label to "sai2b-4".
> 
> Fixes: dcf185ca8175 ("ARM: dts: stm32: Add alternate pinmux for SAI2 pins on stm32mp15")
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>   arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> index 5b60ecbd718f..b9cc9e0dd4fc 100644
> --- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> @@ -1235,7 +1235,7 @@
>   		};
>   	};
>   
> -	sai2b_pins_c: sai2a-4 {
> +	sai2b_pins_c: sai2b-4 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('F', 11, AF10)>; /* SAI2_SD_B */
>   			bias-disable;

This mp1 pinmuxing is a total mess, sigh.

Can you please also fix sai1a-4 and sai1a-5, which should really be 
sai1a-2 and sai1a-sleep-2 ? Same as the sai2b-4 and sai2b-5 should be 
sai2b-2 and sai2b-sleep-2 .

With that, it would be perfect, thank you.

[...]
