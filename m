Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5CD33291B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 15:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhCIOvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 09:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbhCIOuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 09:50:37 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA35C06174A;
        Tue,  9 Mar 2021 06:50:37 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id q25so27461304lfc.8;
        Tue, 09 Mar 2021 06:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VmMnUYx5z45TL06VTcr6sIhoWx0jVQSuon7KfZDYhWE=;
        b=qZJJYWQXcAXWZdroWrwy+VhVKemOU4qPP5O4cfkfdulDXkn/fZNeP4LhnJa5CEX3J2
         uH9t1FitLaANgbuFicwiaI5ORAbu6h6xQdSrqwo7fDCc5qrW2XIBnHeDlTV1jw4E4Gfj
         vew7aB0ytwhS/VpueLtU32etAH9TlJfgabYDvX/dctHwvCuNR3UumOj9VhZanDoiIKTu
         SXq6lowK3fD72fKQbhHJ4gJx0LgJJt+5if6xE/1WB8yM35Lg2MZ6hRgjRSqL8YsiDdtH
         8DL8U+EKa2wwp4Vywn+Gx7IqkDRNWPRXd3s/81EJUQX7QVbXbj3ke9Tfzr3CdZX4xGFf
         m7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VmMnUYx5z45TL06VTcr6sIhoWx0jVQSuon7KfZDYhWE=;
        b=uXUfszdF34n9PVYmY/46I1NTRUHzNfsGN09hj8L7wGL/pZYqJW3/cdMta5N4p8WDCh
         HC2KCh4Mg/cATWMqfIjKV0CPKqvfMUEzsc19XtZ9Ji0dvoewBJvcGJ5REsrMQ8W2/o6v
         MTQ5g0v2oIdqnNc2XKkkFwJDy23hbjRKvNkzYngN2bsB6FZ1nMu8ZEWCOUigI2LwTTQa
         cql35sWz+duGh2JOu5qUQVrBbbWhe+slb5M52h+VlVeymLyIjxSmbNafHSR8YtRxOXMe
         rPFDMb2Aptw3Q9aXpvzrzDYeDKtNj6WXHFe/oEGUsVip8FYT9m20+g7W19vaCCt7Rkl+
         3+pA==
X-Gm-Message-State: AOAM530/FnkJd1vuI0JhSxFusSPgbwAPrEVwLpTmmMmouobsgraqjAz7
        Pr+KrdEcHZSDXJCyp+/r2VY=
X-Google-Smtp-Source: ABdhPJxZyVfT32/lPr8zonaNLXVBOf8yMxpxMS8SGkDBqv6o0bPeLg4BQq8TzEu7W0RAmgDGug5LXQ==
X-Received: by 2002:a05:6512:2206:: with SMTP id h6mr17723729lfu.239.1615301435821;
        Tue, 09 Mar 2021 06:50:35 -0800 (PST)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id f5sm2003134ljc.8.2021.03.09.06.50.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 06:50:35 -0800 (PST)
Subject: Re: [PATCH 2/3] dt-bindings: phy: brcm,ns-usb2-phy: bind single CRU
 reg
To:     Rob Herring <robh@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vivek Unune <npcomplete13@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20210226114501.31086-1-zajec5@gmail.com>
 <20210226114501.31086-2-zajec5@gmail.com>
 <20210306215232.GA1238918@robh.at.kernel.org>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <a5064481-c1b4-4a12-b046-0d3472a6ec0c@gmail.com>
Date:   Tue, 9 Mar 2021 15:50:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210306215232.GA1238918@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.03.2021 22:52, Rob Herring wrote:
> On Fri, Feb 26, 2021 at 12:45:00PM +0100, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> The old binding was using whole DMU space. It was an overkill. DMU is a
>> big block which contains e.g. CRU which contains e.g. PLLs, PHY, pinctrl
>> and thermal blocks.
>>
>> Rework the binding to directly use a single CRU register that controls
>> USB 2.0 PHY. It's still required to reference CRU generic clkset
>> register so add a syscon for that.
>>
>> For a full DMU & CRU description see arch/arm/boot/dts/bcm5301x.dtsi .
>>
>> The old binding is deprecated now.
>>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> ---
>> This has been verified using dt_binding_check
>>
>> I'd really like to get Rob's ack to make sure I don't do anything stupid
>>
>> It's a reworked version of my abonded 2019 patch:
>> [PATCH V2 1/2] dt-bindings: bcm-ns-usb2-phy: rework binding to use CRU syscon
>> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20190108123907.19816-1-zajec5@gmail.com/
>> ---
>>   .../bindings/phy/brcm,ns-usb2-phy.yaml        | 46 +++++++++++++++----
>>   1 file changed, 36 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/brcm,ns-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/brcm,ns-usb2-phy.yaml
>> index b8b683ce8fa9..8e056d4d205a 100644
>> --- a/Documentation/devicetree/bindings/phy/brcm,ns-usb2-phy.yaml
>> +++ b/Documentation/devicetree/bindings/phy/brcm,ns-usb2-phy.yaml
>> @@ -16,11 +16,20 @@ properties:
>>       const: brcm,ns-usb2-phy
>>   
>>     reg:
>> -    maxItems: 1
>> -    description: DMU (Device Management Unit) address range
>> +    anyOf:
>> +      - maxItems: 1
>> +        description: PHY control register
>> +      - maxItems: 1
>> +        description: DMU (Device Management Unit) address range
>> +        deprecated: true
>>   
>>     reg-names:
>>       const: dmu
>> +    deprecated: true
>> +
>> +  brcm,syscon-clkset:
>> +    description: phandle to syscon for clkset register
>> +    $ref: /schemas/types.yaml#/definitions/phandle
> 
> Don't really need this as it's just a compatible node of the parent
> node.

Thanks


>>   
>>     clocks:
>>       maxItems: 1
>> @@ -34,22 +43,39 @@ properties:
>>   
>>   required:
>>     - reg
>> -  - reg-names
>>     - clocks
>>     - clock-names
>>     - "#phy-cells"
>>   
>> +oneOf:
>> +  - required:
>> +      - brcm,syscon-clkset
>> +  - required:
>> +      - reg-names
>> +
>>   additionalProperties: false
>>   
>>   examples:
>>     - |
>>       #include <dt-bindings/clock/bcm-nsp.h>
>>   
>> -    usb2-phy@1800c000 {
>> -        compatible = "brcm,ns-usb2-phy";
>> -        reg = <0x1800c000 0x1000>;
>> -        reg-names = "dmu";
>> -        clocks = <&genpll BCM_NSP_GENPLL_USB_PHY_REF_CLK>;
>> -        clock-names = "phy-ref-clk";
>> -        #phy-cells = <0>;
>> +    cru-bus@1800c100 {
>> +        compatible = "simple-bus";
> 
> A specific compatible is needed for this block.

I've just sent independently following patch:
[PATCH robh next] dt-bindings: bus: add Broadcom CRU


>> +        ranges = <0 0x1800c100 0x1a4>;
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +
>> +        usb2-phy@64 {
>> +            compatible = "brcm,ns-usb2-phy";
>> +            reg = <0x64 0x4>;
>> +            brcm,syscon-clkset = <&clkset>;
>> +            clocks = <&genpll BCM_NSP_GENPLL_USB_PHY_REF_CLK>;
>> +            clock-names = "phy-ref-clk";
>> +            #phy-cells = <0>;
>> +        };
>> +
>> +        clkset: syscon@80 {
>> +            compatible = "brcm,cru-clkset", "syscon";
>> +            reg = <0x80 0x4>;
>> +        };
> 
> Is this going to expand to 0x1a4/4 child nodes? The problem with one
> node per register is I don't know when it ends and you have to
> constantly update your DT.

I'm sorry, I don't fully understand that expanding question.

Most of CRU subblocks are standalone devices occupying multiple
registers. The last one is thermal@1800c2c0. That "brcm,cru-clkset"
seems to be an exception in the CRU space. clkset is a single
register so it should never become reg = <0x80 0x8>;

The finally documented CRU is expected to look like:

cru-bus@1800c100 {
	compatible = "brcm,cru", "simple-bus";
	reg = <0x1800c100 0x1d0>;
	ranges = <0 0x1800c100 0x1d0>;
	#address-cells = <1>;
	#size-cells = <1>;

	lcpll0@0 {
		compatible = "brcm,nsp-lcpll0";
		reg = <0x0 0x14>;
		(...)
	};

	genpll@40 {
		compatible = "brcm,nsp-genpll";
		reg = <0x40 0x24>;
		(...)
	};

	usb2-phy@64 {
		compatible = "brcm,ns-usb2-phy";
		reg = <0x64 0x4>;
		brcm,syscon-clkset = <&clkset>;
		clocks = <&genpll BCM_NSP_GENPLL_USB_PHY_REF_CLK>;
		clock-names = "phy-ref-clk";
		#phy-cells = <0>;
	};

	clkset: syscon@80 {
		compatible = "brcm,cru-clkset", "syscon";
		reg = <0x80 0x4>;
	};

	pin-controller@c0 {
		compatible = "brcm,bcm4708-pinmux";
		reg = <0xc0 0x24>;
		(...)
	};

	thermal@1c0 {
		compatible = "brcm,ns-thermal";
		reg = <0x1c0 0x10>;
		(...)
	};
};
