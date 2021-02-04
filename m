Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E9F30FF94
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 22:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbhBDVr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 16:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhBDVqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 16:46:14 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F65C0611C0;
        Thu,  4 Feb 2021 13:44:19 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 2DF0C425B6;
        Thu,  4 Feb 2021 21:44:14 +0000 (UTC)
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Ard Biesheuvel <ardb@kernel.org>
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-19-marcan@marcan.st>
 <CAK8P3a3v6emxavbyjFhY+WdvH1t4EPMZSjEsSx0M+cRqjRCO1g@mail.gmail.com>
From:   Hector Martin 'marcan' <marcan@marcan.st>
Subject: Re: [PATCH 18/18] arm64: apple: Add initial Mac Mini 2020 (M1)
 devicetree
Message-ID: <de236d0c-579d-c0d9-8d60-77f30889f50c@marcan.st>
Date:   Fri, 5 Feb 2021 06:44:13 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3v6emxavbyjFhY+WdvH1t4EPMZSjEsSx0M+cRqjRCO1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2021 06.29, Arnd Bergmann wrote:
> On Thu, Feb 4, 2021 at 9:39 PM Hector Martin <marcan@marcan.st> wrote:
> 
>> +/ {
>> +       model = "Apple Mac Mini M1 2020";
>> +       compatible = "AAPL,j274", "AAPL,m1", "AAPL,arm-platform";
>> +       #address-cells = <2>;
>> +       #size-cells = <2>;
>> +
>> +       chosen {
>> +               #address-cells = <2>;
>> +               #size-cells = <2>;
>> +               ranges;
>> +
>> +               bootargs = "earlycon";
>> +               stdout-path = "serial0:1500000";
>> +
>> +               framebuffer0: framebuffer@0 {
>> +                       compatible = "AAPL,simple-framebuffer", "simple-framebuffer";
>> +                       reg = <0 0 0 0>; // To be filled by loader
>> +                       // Format properties will be added by loader
>> +                       status = "disabled";
>> +               };
>> +       };
>> +
>> +       memory@800000000 {
>> +               device_type = "memory";
>> +               reg = <0 0 0 0>; // To be filled by loader
>> +       };
>> +
>> +       aliases {
>> +               serial0 = &serial0;
>> +       };
> 
> We tend to split the dts file into one file per SoC and one for the
> specific board. I guess in this case the split can be slightly different,
> but it does feel better to be prepared for sharing a lot of the contents
> between the different products.
> 
> In most cases, you'd want the 'aliases' and 'chosen' nodes to be
> in the board specific file.

I thought about that, but wasn't sure if splitting it up at this early 
stage made much sense since I'm not sure what the split should be, given 
all supported hardware is the same for all 3 released devices.

I'm happy to throw the aliases/chosen nodes into board specific files if 
you think that's a good starting point. Perhaps /memory too? Those 
properties are filled in/patched by the bootloader anyway...

There are also DT overlays; I was wondering if we could use those to 
keep the hierarchy and avoid having many duplicate trees in a 
hypothetical bootloader that embeds support for a large set of hardware, 
having it construct the final devicetree on the fly from SoC + a board 
overlay (and possibly further levels); but I'm not sure how that ties in 
with the device trees that live in the Linux tree. Do you have any 
pointers about this?

For reference, this is our current DT patching code in m1n1:

https://github.com/AsahiLinux/m1n1/blob/main/src/kboot.c

Eventually we're going to build some kind of tooling to automate diffing 
Apple device trees and importing changes/new devices into our own, 
though it will probably be quite a while until that is relevant; at this 
stage hand-maintaining them is perfectly fine (in any case this wouldn't 
be fully automated, so in the end our trees will still be organized 
however we want).

>> +       cpus {
>> +               #address-cells = <2>;
>> +               #size-cells = <0>;
>> +
>> +               cpu0: cpu@0 {
>> +                       compatible = "AAPL,icestorm";
>> +                       device_type = "cpu";
>> +                       reg = <0x0 0x0>;
>> +                       enable-method = "spin-table";
>> +                       cpu-release-addr = <0 0>; // To be filled by loader
>> +               };
> 
> Did you see the discussion on the #armlinux channel about the possibility
> of moving the cpu-enable method to PSCI based on a UEFI runtime
> interface?
> 
> There are a few open questions about what that would look like in the
> end, but Ard has come up with a prototype for the kernel side of it
> (obviously untested), which would interface either into the UEFI side
> of u-boot, or a simple already-instantiated version that could be
> kept inside of m1n1 and stay resident in memory.
> 
> I would like to see that model get adopted here eventually. If
> we manage to get the other patches ready for an initial merge in
> v5.12, we can probably start out with spin-table and move to that
> in a following release though.

I saw it go by but need to review it again; I've been missing too much 
sleep this week :) thanks for the reminder.

I think we might want to start with spin-table for now, given that there 
are no kernel changes needed anyway, but I'm happy to take the protoype 
for a spin (:)) and try implementing it in m1n1.

I do think it's valuable for whatever we do, at this stage, to not 
require u-boot; having that be an integral part of the boot chain is 
perfectly fine in the future but right now it helps to have a simple 
boot chain while we work out the early bring-up, and while u-boot grows 
the required support.

-- 
Hector Martin "marcan" (marcan@marcan.st)
Public Key: https://mrcn.st/pub
