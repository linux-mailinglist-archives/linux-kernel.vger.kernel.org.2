Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA69E421DF3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 07:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhJEFbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 01:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbhJEFbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 01:31:23 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F63C061745;
        Mon,  4 Oct 2021 22:29:33 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id e15so81219634lfr.10;
        Mon, 04 Oct 2021 22:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=+vIY6pMfLbU3rkVnSQNLIvwGL0kSj3gJvo3nTAN60L4=;
        b=flDJwUxMXR0G9rWUCzqnBJnb58FYil6a8ILOxo9t5AR1dBBNiKDGW9mEPiWXYdbGeD
         4QmA+1Tfa/tPiS21EkUbESOzZyGoMWpvuOuVpsvTspGIpvhwqdpnntYrzXoEFxM0m2XF
         oJ37oZ8rVrnJk91Ej72UGwa1i23L9fcSHGeFl1b8iMs8GO+596THBCAVtwcfgplUrl9c
         SHjflMYOsK2wDPykVoNApv4kWU84uU8lHquaQPLDtt2SYIAL4p7Vn0x0d4kaRZ43W37T
         RjCG05hDyaR0ZrSVXd/L3+9c4XZbZRsVcfJOibW0TPc4+IawNBYDMehuj/1D+nwPrCxi
         1Pnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=+vIY6pMfLbU3rkVnSQNLIvwGL0kSj3gJvo3nTAN60L4=;
        b=xYuXHb5DEmGSxmE7qw+/7TkBpZ0F/3ZU71XZQgjMPKwCAebBHjW23NSyd/v/5a1Xgw
         10dp8AvNPKDKja/txFNVn5+RDdkmPYPAK27U13oku5A6T7ysOFSDDUDFM17zfNCsHVJk
         P5X5qj6KZBbfiOGXCsx2zQ4jb8QwltakS5MMeKVxewJlHOOcgEiO/aJXrmL/3LLPjCW+
         vbeN2zKSgpOuiSZgaW1odCsKtJgw1/an8WUMPxRORv8UXdg9ow7Fpeb0+33Z+bb5VTuM
         T/W6/IOeW/KcRutJqFK1NBhbdCRI7GQgSG1SxCeOB2kdCbIbLKBGDp9i5YuCCIrDIZcb
         bO1Q==
X-Gm-Message-State: AOAM533dJ3l88fq+sl7DHjaiHrn8FXWPRhGi2xLCBff4gs07YVkolJcR
        Y1Pxt2N7GZt1ZoXNsz31Sdo=
X-Google-Smtp-Source: ABdhPJxWOUDtuPZ/P74HcZdGWC35Cig9A7YMUcWLZmfTPgFze/1gkLlcqICSQhTyLhta64wLt1AIaA==
X-Received: by 2002:a05:6512:3403:: with SMTP id i3mr1307855lfr.533.1633411771344;
        Mon, 04 Oct 2021 22:29:31 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16e2:8300::5? (dc7vkhyyyyyyyyyyyyyct-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::5])
        by smtp.gmail.com with ESMTPSA id z4sm1810979lfg.178.2021.10.04.22.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 22:29:30 -0700 (PDT)
Message-ID: <ed1956b3-a127-0c22-9d07-c1e2a57691d3@gmail.com>
Date:   Tue, 5 Oct 2021 08:29:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Content-Language: en-US
To:     Shawn Guo <shawnguo@kernel.org>, thanushree.sreerama@emtrion.com
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20210901122826.75209-1-thanushree.sreerama@emtrion.com>
 <20211004042151.GD15650@dragon>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mm: Add support for emtrion emCON-MX8M
 Mini
In-Reply-To: <20211004042151.GD15650@dragon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Nice to see more boards added :) Thanks guys!

On 10/4/21 07:21, Shawn Guo wrote:
> On Wed, Sep 01, 2021 at 02:28:26PM +0200, thanushree.sreerama@emtrion.com wrote:
>> This patch adds support for the emtrion GmbH emCON-MX8M Mini modules.
>> They are available with NXP i.MX 8M Mini equipped with 2 or 4 GB Memory.
>>
>> The devicetree imx8mm-emcon.dtsi is the common part providing all
>> module components and the basic support for the SoC. The support for the
>> avari baseboard in the developer-kit configuration is provided by the
>> emcon-avari dts files.
>>
>> Signed-off-by: Thanushree Sreerama <thanushree.sreerama@emtrion.com>
>> Reviewed by: Frank Erdrich <frank.erdrich@emtrion.com>
>> ---

snip

>> +&i2c3 {
>> +	clock-frequency = <400000>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_i2c3>;
>> +	status = "okay";
>> +
>> +	pmic: bd71837@4b {
> 
> bd71837: pmic@4b
> 
>> +		compatible = "rohm,bd71847";
> 
> So `bd71847: pmic@4b` maybe?
> 
>> +		reg = <0x4b>;
>> +		pinctrl-0 = <&pinctrl_pmic>;
>> +		interrupt-parent = <&gpio3>;
>> +		interrupts = <2 GPIO_ACTIVE_LOW>;

This looks fishy to me. What I would expect to see here is the
IRQ_TYPE_LEVEL_LOW - which equals to 8. (AFAIR the PMIC HW is built to 
work with level active IRQs, and the PMIC does pull the line low when 
IRQ occurs). I don't think the GPIO_ACTIVE_LOW is intended to be used as 
IRQ type specifier(?). I admit I didn't look the IRQ controller your SoC 
has though. The GPIO_ACTIVE_LOW equals to 1 - which actually equals 
IRQ_TYPE_EDGE_RISING.

I probably don't understand something as I don't see how the setup could 
produce any rising edges - because rising edges should occur only when 
we ACK the IRQ. Any explanations/education appreciated here :)

Feel free to ignore this comment if it makes no sense :)

>> +		rohm,reset-snvs-powered;
>> +
>> +		regulators {
>> +			buck1_reg: BUCK1 {
>> +				regulator-name = "BUCK1";
>> +				regulator-min-microvolt = <700000>;
>> +				regulator-max-microvolt = <1300000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +				regulator-ramp-delay = <1250>;
>> +			};
>> +
>> +			buck2_reg: BUCK2 {
>> +				regulator-name = "BUCK2";
>> +				regulator-min-microvolt = <700000>;
>> +				regulator-max-microvolt = <1300000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +				regulator-ramp-delay = <1250>;
>> +				rohm,dvs-run-voltage = <1000000>;
>> +				rohm,dvs-idle-voltage = <900000>;
>> +			};
>> +
>> +			buck3_reg: BUCK3 {
>> +				// BUCK5 in datasheet
>> +				regulator-name = "BUCK3";
>> +				regulator-min-microvolt = <700000>;
>> +				regulator-max-microvolt = <1350000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			buck4_reg: BUCK4 {
>> +				// BUCK6 in datasheet
>> +				regulator-name = "BUCK4";
>> +				regulator-min-microvolt = <3000000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			buck5_reg: BUCK5 {
>> +				// BUCK7 in datasheet
>> +				regulator-name = "BUCK5";
>> +				regulator-min-microvolt = <1605000>;
>> +				regulator-max-microvolt = <1995000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			buck6_reg: BUCK6 {
>> +				// BUCK8 in datasheet
>> +				regulator-name = "BUCK6";
>> +				regulator-min-microvolt = <800000>;
>> +				regulator-max-microvolt = <1400000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			ldo1_reg: LDO1 {
>> +				regulator-name = "LDO1";
>> +				regulator-min-microvolt = <1600000>;
>> +				regulator-max-microvolt = <1900000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			ldo2_reg: LDO2 {
>> +				regulator-name = "LDO2";
>> +				regulator-min-microvolt = <800000>;
>> +				regulator-max-microvolt = <900000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			ldo3_reg: LDO3 {
>> +				regulator-name = "LDO3";
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			ldo4_reg: LDO4 {
>> +				regulator-name = "LDO4";
>> +				regulator-min-microvolt = <900000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			ldo6_reg: LDO6 {
>> +				regulator-name = "LDO6";
>> +				regulator-min-microvolt = <900000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
> 
> You really want to have all these regulators boot-on and always-on?
Following text is more like a note to one who considers changing this 
than actual review comment.

The correctness of this is on a gray area for the BD71847. The BD71847 
regulator's enable state can be either controlled by the SW or by the HW 
state machine. When controlled by the HW state machine, the SW can't 
easily(*) read the regulator status. This could probably/perhaps warrant 
the use of the regulator-boot-on.

Following may not be relevant for a device-tree description - but is 
relevant for one who wants the setup to work:
The BD71837/47/50 have a 'feature' that if a regulator enable state is 
controlled by SW - and if the PMIC goes to SNVS state and not to READY 
state when reset occurs - then at next boot the regulators which were 
controlled by SW do not power-on. In order to avoid potential boot 
failures at reset the BD71837/47/50 regulators which are marked as 
boot-on and always-on are not taken under SW control if reset target is 
SNVS. One could think the condition in driver code is slightly wrong. It 
might not feel ideal that we require both always-on AND boot-on to be 
present in order to not take the regulator under SW control. Probably 
only one of those should be enough? Well, leaving regulators with only 
the always-on defined under the HW state machine control would break 
things with setups that want the regulators to stay on at PMICs SUSPEND 
state. So, in a sense requiring both to be present is correct - and 
having boot-on kind of makes sense.

In this particular case I see the SNVS is used as reset target state and 
both the always-on and boot-on is given to all regulators - which means 
all of the regulators are left under HW state machine control. It's good 
to know what are the implications of changing these properties :)

(*)In most cases the SW is running on i.MX8 core powered by the PMIC. 
This means the PMIC is most probably at RUN state when SW is running. 
AFAIR the current HW state can also be read from the registers. So most, 
or maybe all of the regulator enable states could probably be determined 
by the HW state even when controlled by the HW state machine. I do not 
remember if PMIC has couple of OTP configurable regulators which enable 
state can be different on different HW states depending on the OTP 
settings - or whether that configuration can be read from the PMIC. In 
any case, if we don't have boot-on and always-on, we do take regulators 
under SW control - in which case we can always read the current state. 
If we have a boot-on and always-on, we may leave regulators under HW 
state machine control - and we do not control the state by SW and we do 
not implement any complex logic for reading the state.


Best Regards
--Matti Vaittinen
