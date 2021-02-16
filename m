Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B92E31CBF6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 15:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhBPObF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 09:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhBPOa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 09:30:57 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C03C061574;
        Tue, 16 Feb 2021 06:30:16 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id AAB2E42037;
        Tue, 16 Feb 2021 14:30:10 +0000 (UTC)
Subject: Re: [PATCH v2 02/25] dt-bindings: arm: apple: Add bindings for Apple
 ARM platforms
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
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
 <20210215121713.57687-3-marcan@marcan.st>
 <20210215174803.5oalkkmotpc7d7vm@kozik-lap>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <9729c3c2-787e-2894-ddfb-fc9c07d74086@marcan.st>
Date:   Tue, 16 Feb 2021 23:30:08 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210215174803.5oalkkmotpc7d7vm@kozik-lap>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2021 02.48, Krzysztof Kozlowski wrote:
> On Mon, Feb 15, 2021 at 09:16:50PM +0900, Hector Martin wrote:
>> +description: |
>> +  Apple ARM ("Apple Silicon") platforms should contain compatible strings
>> +  in the following format:
>> +
>> +  - apple,j274 (board/device ID)
>> +  - apple,m1 (SoC name)
>> +  - apple,arm-platform (Apple Silicon)
> 
> This description is irrelevant because the rules come from schema below.
> Maybe instead write few words about the platform? Or describe how to get
> the board/device ID if it is not obvious?

Good point. Actually, I've gone back and forth over this a few times,
but I'm going to change the SoC name. Apple calls these things by 5
different names, but the only two that make any sense to consider are
the marketing name ("m1") and the SoC name ("t8103"). I'm going to
switch to the latter (so `apple,t8103`).

In the past, Apple have dual-sourced SoCs with different IDs under the
same marketing name, and Apple themselves name most of their compatible
properties after the lowest-compatible SoC name, so I'm going to go with
that after all. This will save us grief in the future if they do that
again, and I think I get to pick the color of this bike shed :)

Given that, I expanded a bit on the description. Let me know what you think:

description: |
   ARM platforms using SoCs designed by Apple Inc., branded "Apple Silicon".

   This currently includes devices based on the "M1" SoC, starting with the
   three Mac models released in late 2020:

   - Mac mini (M1, 2020)
   - MacBook Pro (13-inch, M1, 2020)
   - MacBook Air (M1, 2020)

   The compatible property should follow this format:

   compatible = "apple,<targettype>", "apple,<socid>", "apple,arm-platform";

   <targettype> represents the board/device and comes from the `target-type`
   property of the root node of the Apple Device Tree, lowercased. It can be
   queried on macOS using the following command:

   $ ioreg -d2 -l | grep target-type

   <socid> is the lowercased SoC ID. Apple uses at least *five* different
   names for their SoCs:

   - Marketing name ("M1")
   - Internal name ("H13G")
   - Codename ("Tonga")
   - SoC ID ("T8103")
   - Package/IC part number ("APL1102")

   Devicetrees should use the the lowercased SoC ID, to avoid confusion if
   multiple SoCs share the same marketing name. This can be obtained from
   the `compatible` property of the arm-io node of the Apple Device Tree,
   which can be queried as follows on macOS:

   $ ioreg -n arm-io | grep compatible

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
