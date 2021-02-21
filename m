Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7486320B51
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 16:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbhBUPVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 10:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhBUPVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 10:21:01 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A957C061574;
        Sun, 21 Feb 2021 07:20:19 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 8FB74425B9;
        Sun, 21 Feb 2021 15:20:13 +0000 (UTC)
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210215121713.57687-1-marcan@marcan.st>
 <20210218143644.GC89209@C02TD0UTHF1T.local>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 00/25] Apple M1 SoC platform bring-up
Message-ID: <add1937b-183b-17a9-94db-f384801a079e@marcan.st>
Date:   Mon, 22 Feb 2021 00:20:11 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210218143644.GC89209@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/2021 23.36, Mark Rutland wrote:
> IIUC, the CPUs in these parts have some IMP-DEF instructions that can be
> used at EL0 which might have some IMP-DEF state. Our general expectation
> is that FW should configure such things to trap, but I don't know
> whether the M1 FW does that, and I fear that this will end up being a
> problem for us -- even if that doesn't affect EL1/EL2, IMP-DEF state is
> an interesting covert channel between EL0 tasks, and not generally safe
> to use thanks to context-switch and idle, so I'd like to make sure we
> can catch usage and make it SIGILL.
> 
> Do you happen to know whether all of that is configured to trap, and if
> not, is it possible to adjust the bootloader to ensure it is?

Very good point!

If only they were IMP-DEF... they're straight in Unallocated space. I 
spent some time the other day exhaustively searching the chunk of the 
encoding space where it looks like all these "fun" additions are,
at EL2, and I documented what I found here:

https://github.com/AsahiLinux/docs/wiki/HW:Apple-Instructions

I haven't tested things at EL0 yet, but it looks like the stateful 
instructions known to be usable in EL0 (AMX) already default to trap on 
this platform, so we should be safe there. Everything else looks like it 
probably either shouldn't work in EL0 (I sure hope the address 
translation one doesn't...) or is probably stateless. I'll dig deeper 
and test EL0 in the future, but so far things look OK (for some 
questionable values of OK :) ).

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
