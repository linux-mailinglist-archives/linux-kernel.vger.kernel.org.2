Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA9D313201
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 13:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhBHMQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbhBHL56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 06:57:58 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A16C061756;
        Mon,  8 Feb 2021 03:57:00 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id B7ED441E96;
        Mon,  8 Feb 2021 11:56:55 +0000 (UTC)
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, robh+dt@kernel.org,
        Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Olof Johansson <olof@lixom.net>
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-19-marcan@marcan.st>
 <20210208110441.25qc6yken4effd6c@kozik-lap>
From:   Hector Martin 'marcan' <marcan@marcan.st>
Subject: Re: [PATCH 18/18] arm64: apple: Add initial Mac Mini 2020 (M1)
 devicetree
Message-ID: <cd67b2ce-9676-31b4-85f7-de1ec9b2bf72@marcan.st>
Date:   Mon, 8 Feb 2021 20:56:53 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210208110441.25qc6yken4effd6c@kozik-lap>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2021 20.04, Krzysztof Kozlowski wrote:
> apple
> 
> Don't make things different for this one platform (comparing to all
> other platforms). Apple is not that special. :)

AAPL is the old vendor prefix used in the PowerPC era. I'm happy to use 
`apple`, as long as we're OK with having two different prefixes for the 
same vendor, one for PPC and one for ARM64. I've seen opinions go both 
ways on this one :)

>> + * Copyright 2021 Hector Martin <marcan@marcan.st>
> 
> A lot here might be difficult to reverse-egineer or figure out by
> ourself, so usually people rely on vendor sources (the open source
> compliance package). Didn't you receive such for the iOS (or whatever
> was on your Mac)?

Apple source drops are sparse (they don't even include things like the 
irqchip driver, only the very core OS code) and APSL licensed, which is 
a license incompatible with the GPL. Worse, they've moved to a 
partial-blob model with the M1; M1-compatible XNU source code drops now 
include a .a blob with startup and CPU-specific code, for which no 
source code is provided. (to be clear: Apple does not ship Linux for 
these machines)

Honestly, beyond what's in this patchset and a few more details about 
CPU registers like performance monitoring stuff that exist in public XNU 
drops but I haven't looked into yet, Apple's source code drops are going 
to be practically useless to us from here on out. It's all binaries 
after this.

Apple device trees are not open source at all; those are provided by 
iBoot and ship with device firmware, which is not openly licensed. Those 
device trees are OF-inspired, but otherwise in a different format and 
structure to Linux device trees.

Since there is zero Apple-published code or data with a license 
compatible with the Linux kernel to be used here, there can be zero 
copyright lines claiming any submissions are copyright Apple from us, 
because that would imply a license violation has occurred. I am treating 
this as I would any other no-source reverse engineering project, that 
is, ensuring that I only look at Apple code (binaries, source, 
devicetrees, whatever) to understand how the hardware functions, build 
documentation for it (at least in my head, but I am also trying to 
document things on our wiki as I go), and then write original code to 
drive it from Linux, unrelated to whatever Apple was doing.

We're also trying to avoid looking at any Apple stuff in general as much 
as possible, preferring black-box approaches where feasible, to minimize 
exposure. For example, I only looked at an (outdated, arm32 era) AIC 
register name list in XNU to write the AIC driver; there is no actual 
AIC driver code in the source, and instead of decompiling Apple's binary 
blob AIC driver module, I figured out how the hardware actually worked 
via probing and experimentation. The entire userspace GPU stack is being 
reverse engineered via a black-box approach, without any decompilation. 
I'm going to see what I can do about the kernel driver in the future, 
and prefer some kind of mmio tracing solution if I can get it all to 
work on macOS.

As for this file specifically: while I am obviously looking at Apple's 
DTs to figure out things like register offsets and what hardware exists, 
those are facts, and facts are not copyrightable, and thus Apple does 
not hold any copyright interest over this code as I submitted it. Short 
of verbatim copying and pasting of entire nodes with bespoke property 
names (which would never fly here anyway because Apple does things very 
differently from Linux DTs when you get down into the details), it would 
be extremely hard to argue that translating hardware information from 
decompiled Apple DTs to Linux DTs would constitute a copyright 
violation, since the entire purpose of DTs is to describe hardware facts.

You can read more about our reverse engineering and copyright policy at 
https://alx.sh/re - if you have any suggestions or spot anything 
problematic, please let me know.

(I'm actually probably going to change that copyright line to "The Asahi 
Linux Contributors" for v2, if that's okay with the kernel folks, to be 
in line with our other projects; I defaulted to my name since so far I'm 
the only contributor to these files, but I expect other people to throw 
PRs at me in the future and the history to end up with more names here)

> I guess Rob will comment on the dt-bindings more... but for me a generic
> "arm-platform" is too generic. What's the point of it? I didn't see any
> of such generic compatibles in other platforms.

This is a hack for patches #11/#12 to use, and I expect it will go away 
once we figure out how to properly handle that problem (which needs 
further discussion). Sorry for the noise, this should not be there in 
the final version.

>> +		bootargs = "earlycon";
> 
> This should not be hard-coded in DTS. Pass it from bootloader.

My apologies, this was garbage left over from before I had bootargs 
support in the bootloader. Will be gone for v2.

>> +	clk24: clk24 {
> 
> Just "clock". Node names should be generic.

Really? Almost every other device device tree uses unique clock node names.

>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <24000000>;
>> +		clock-output-names = "clk24";
> 
> What clock is it? Part of board or SoC? Isn't it a work-around for
> missing clock drivers?

The clock topology isn't entirely known yet; I'm submitting this as an 
initial bring-up patchset and indeed there should be a clockchip driver 
in the future. The UART driver wants a clock to be able to calculate 
baud rates. I figured we can get away with a fixed-clock for now while 
that part of the SoC gets figured out.

Ack on all the other comments, will fix for v2.

Thanks for the review!

-- 
Hector Martin "marcan" (marcan@marcan.st)
Public Key: https://mrcn.st/pub
