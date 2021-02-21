Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC569320BF0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 18:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhBURKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 12:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhBURKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 12:10:35 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D5DC061574;
        Sun, 21 Feb 2021 09:09:54 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 189FC425CB;
        Sun, 21 Feb 2021 17:09:47 +0000 (UTC)
Subject: Re: [PATCH v2 20/25] tty: serial: samsung_tty: Use
 devm_ioremap_resource
To:     Marc Zyngier <maz@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210215121713.57687-1-marcan@marcan.st>
 <20210215121713.57687-21-marcan@marcan.st>
 <20210215185135.onivzktfscv5myh2@kozik-lap>
 <20274436-7275-9734-5a07-d6da46b45c5f@marcan.st>
 <20210220191323.ugmzrtkvcxyqqolj@kozik-lap>
 <5a4b3d7095d1ec4be97ec154109632dc@kernel.org>
 <28128b77-87b4-3595-59fa-44600c5bdbc7@marcan.st>
 <87im6l1n7h.wl-maz@kernel.org>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <5d2e94bd-af24-6521-5ead-479fd7b757f1@marcan.st>
Date:   Mon, 22 Feb 2021 02:09:45 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87im6l1n7h.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2021 23.59, Marc Zyngier wrote:
> Here's what I've been using last time I had to muck with the 4210
> stuff:
> 
> <quote>
> qemu-system-arm \
> 	-kernel arch/arm/boot/zImage -M smdkc210 \
> 	-append "console=ttySAC0,115200n8 earlycon=smh root=/dev/mmcblk0p2 rootwait" \
> 	-nographic -semihosting -smp 2 \
> 	-dtb arch/arm/boot/dts/exynos4210-smdkv310.dtb \
> 	-drive if=sd,driver=null-co -drive if=sd,driver=null-co \
> 	-drive if=sd,file=../vminstall/bullseye32/MsiKFRxxujYIkiKT.img,format=raw
> </quote>
> 
> where the last line points to a standard Debian image created
> separately.

Hah, exynos4210-smdkv310.dtb is what did it. And here I was thinking 
something with "c210" in the name would be more likely to work with qemu 
machine "smdkc210"... :-)

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
