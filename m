Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B7C4283EB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 23:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbhJJVwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 17:52:41 -0400
Received: from ixit.cz ([94.230.151.217]:50218 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231390AbhJJVwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 17:52:39 -0400
Received: from [192.168.1.138] (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 416CE20064;
        Sun, 10 Oct 2021 23:50:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1633902637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b9MJGCRTU/VSRZRpCmWOJgpaIftdrOSYufu7oVXOfyk=;
        b=igOmL62ggbv1tWAiJ6Lw6Bu0T0Wpg0gYQDJdsbzoJI3aE89G7kU8evMtaeKk+w+8sYV523
        YX2Eh08pt+/xTFD7qhRVx3T3ABlGjOouL8sWVV93MAEXdaN/57oZidoHcifs4dXhqYfFoN
        szwF69hD/ajd02S/SFLd/kJz0X6UglQ=
Date:   Sun, 10 Oct 2021 23:49:08 +0200
From:   David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH] WIP: dt-bindings: arm: hwmon: gpio-fan: Convert txt
 bindings to yaml
To:     Rob Herring <robh@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        ~okias/devicetree@lists.sr.ht, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Message-Id: <W97S0R.8W2XT6A4XCW4@ixit.cz>
In-Reply-To: <1633894316.403809.3158663.nullmailer@robh.at.kernel.org>
References: <20211009104309.45117-1-david@ixit.cz>
        <1633894316.403809.3158663.nullmailer@robh.at.kernel.org>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




On Sun, Oct 10 2021 at 14:31:56 -0500, Rob Herring <robh@kernel.org> 
wrote:
> On Sat, 09 Oct 2021 12:43:09 +0200, David Heidelberg wrote:
>>  Convert fan devices connected to GPIOs to the YAML syntax.
>> 
>>  Signed-off-by: David Heidelberg <david@ixit.cz>
>>  ---
>>   .../devicetree/bindings/hwmon/gpio-fan.txt    | 41 -----------
>>   .../devicetree/bindings/hwmon/gpio-fan.yaml   | 69 
>> +++++++++++++++++++
>>   2 files changed, 69 insertions(+), 41 deletions(-)
>>   delete mode 100644 
>> Documentation/devicetree/bindings/hwmon/gpio-fan.txt
>>   create mode 100644 
>> Documentation/devicetree/bindings/hwmon/gpio-fan.yaml
>> 
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for 
> dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/1538743
> 
> 
> fan: 'gpio-fan,speed-map' is a required property
> 	arch/arm/boot/dts/kirkwood-nas2big.dt.yaml
> 	arch/arm/boot/dts/kirkwood-net2big.dt.yaml
This sounds correct.

> 
> gpio-fan: gpio-fan,speed-map: 'anyOf' conditional failed, one must be 
> fixed:
> 	arch/arm/boot/dts/gemini-dlink-dir-685.dt.yaml
> 	arch/arm/boot/dts/gemini-dlink-dns-313.dt.yaml
> 
Look like two arrays instead one expected.

> gpio_fan: gpio-fan,speed-map: 'anyOf' conditional failed, one must be 
> fixed:
> 	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
Look like two arrays instead one expected.

> 
> gpio-fan: gpio-fan,speed-map: 'oneOf' conditional failed, one must be 
> fixed:
> 	arch/arm/boot/dts/gemini-dlink-dir-685.dt.yaml
> 	arch/arm/boot/dts/gemini-dlink-dns-313.dt.yaml
> 
Look like three arrays instead one expected.

> gpio_fan: gpio-fan,speed-map: 'oneOf' conditional failed, one must be 
> fixed:
> 	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
> 
Look like two arrays instead one expected.

I can send patches to solve these warnings.

David
> 


