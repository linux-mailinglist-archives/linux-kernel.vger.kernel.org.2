Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81E7439078
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 09:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbhJYHjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 03:39:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229491AbhJYHjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 03:39:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E397860C4B;
        Mon, 25 Oct 2021 07:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635147451;
        bh=uKLQhXialvm85kNhH2vtDp6xUlkw3tcxg00ufRsV3ak=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=C71V+fYWGUHABtAoekiIeml9w6NIrztzPD1rKtlxO5du9QbaqHH4PNxpTqTR+Jroj
         jIRwEvmdVhanTx8esAn7W2DKRWuBcnV7p6AFY4UBMlb44VhJ/EIARJ0gMZ0NLcD+co
         OH36ynKymeekQ3VYqDEL3enAlelnmnUsLOdcxup/ZqpIbARBqrNly+z4e1z6vA/SKj
         wMnWm6dNawYdMWSJxDI5yl9YAaP+xZrzwihGKDJWOpcYDiT/3zBqnKO9DwfhPyv1h+
         h8a5y6YGoXdDfTkvb0R8WJyB4ZYGflkFWaUXmAduNnilpehaZ7X2dz7H+zcFFT8yVO
         hAKh17nKZaaMA==
Subject: Re: [PATCH v2] ARM: dts: da850-evm: Change aemif node status from
 "ok" to "okay"
To:     "Nori, Sekhar" <nsekhar@ti.com>
Cc:     bgolaszewski@baylibre.com, lokeshvutla@ti.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>
References: <20210824105512.19242-1-rogerq@kernel.org>
 <20210825161502.ap2clalwfljezoqk@perfume>
From:   Roger Quadros <rogerq@kernel.org>
Message-ID: <24f15759-62a8-e341-b03c-348e7e3cd295@kernel.org>
Date:   Mon, 25 Oct 2021 10:37:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210825161502.ap2clalwfljezoqk@perfume>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sekhar,

On 25/08/2021 19:15, Nishanth Menon wrote:
> On 13:55-20210824, Roger Quadros wrote:
>> As per Device Tree Specification [1], the status parameter of nodes can
>> be "okay", "disabled", etc. "ok" is not a valid parameter.
>>
>> U-boot Driver Model does not recognize status="ok" either and treats
>> the node as disabled.
> 
> ^^ the above comment might be fine to indicate the side effect of
> non-compliance
> 
>>
>> [1] https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.3
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> 
> Reviewed-by: Nishanth Menon <nm@ti.com>

Could you please pick this one if not too late for -next. Thanks.

> 
>> ---
>> Changelog:
>> v2
>> -refer to DT spec instead of schema in commit log.
>>
>>  arch/arm/boot/dts/da850-evm.dts | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
>> index 87c517d65f62..9dc79b5977bf 100644
>> --- a/arch/arm/boot/dts/da850-evm.dts
>> +++ b/arch/arm/boot/dts/da850-evm.dts
>> @@ -415,7 +415,7 @@
>>  &aemif {
>>  	pinctrl-names = "default";
>>  	pinctrl-0 = <&nand_pins>;
>> -	status = "ok";
>> +	status = "okay";
>>  	cs3 {
>>  		#address-cells = <2>;
>>  		#size-cells = <1>;
>> -- 
>> 2.17.1
>>
> 

--
cheers,
-roger
