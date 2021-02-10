Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECBA3164BB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 12:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhBJLLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 06:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhBJLIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 06:08:38 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEFEC06174A;
        Wed, 10 Feb 2021 03:07:56 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 3B9FC41FA3;
        Wed, 10 Feb 2021 11:07:52 +0000 (UTC)
To:     Tony Lindgren <tony@atomide.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>, devicetree@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        soc@kernel.org, robh+dt@kernel.org,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-19-marcan@marcan.st>
 <20210208110441.25qc6yken4effd6c@kozik-lap>
 <cd67b2ce-9676-31b4-85f7-de1ec9b2bf72@marcan.st>
 <YCOzLSqdsr83xf0b@atomide.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 18/18] arm64: apple: Add initial Mac Mini 2020 (M1)
 devicetree
Message-ID: <4481998a-27f6-951e-bb4f-a9d2b95f211f@marcan.st>
Date:   Wed, 10 Feb 2021 20:07:49 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YCOzLSqdsr83xf0b@atomide.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2021 19.19, Tony Lindgren wrote:
> * Hector Martin 'marcan' <marcan@marcan.st> [210208 12:05]:
>> On 08/02/2021 20.04, Krzysztof Kozlowski wrote:
> ...
> 
>>>> +	clk24: clk24 {
>>>
>>> Just "clock". Node names should be generic.
>>
>> Really? Almost every other device device tree uses unique clock node names.
> 
> Yeah please just use generic node name "clock". FYI, we're still hurting
> because of this for the TI clock node names years after because the drivers
> got a chance to rely on the clock node name..
> 
> Using "clock" means your clock driver code won't get a chance to wrongly
> use the node name and you avoid similar issues.

That means it'll end up like this (so that we can have more than one 
fixed-clock):

clocks {
     #address-cells = <1>;
     #size-cells = <0>;

     clk123: clock@0 {
         ...
         reg = <0>
     }

     clk456: clock@1 {
         ...
         reg = <1>
     }
}

Correct?

Incidentally, there is just one example in the kernel tree of doing this 
right (in arch/arm/boot/dts/imx6qdl-tx6.dtsi). All the others that use 
non-mmio clocks called `clock`, including the various tegra devicetrees, 
violate the DT spec by not including a dummy reg property matching the 
unit-address.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
