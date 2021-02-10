Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50483166A0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 13:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbhBJM2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 07:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhBJMZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:25:03 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0688C06174A;
        Wed, 10 Feb 2021 04:24:22 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 8CBC341FA3;
        Wed, 10 Feb 2021 12:24:18 +0000 (UTC)
To:     Will Deacon <will@kernel.org>
Cc:     SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-14-marcan@marcan.st>
 <CAK8P3a2Ad+xmmMWgznOHPpxgCXKWFYfpHBqt_49_UuxrwFSq+A@mail.gmail.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 13/18] arm64: ioremap: use nGnRnE mappings on platforms
 that require it
Message-ID: <475f7586-cabf-1169-8800-cdd2c012a5a6@marcan.st>
Date:   Wed, 10 Feb 2021 21:24:15 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2Ad+xmmMWgznOHPpxgCXKWFYfpHBqt_49_UuxrwFSq+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will, I'm pulling you in at Marc's suggestion. Do you have an opinion 
on what the better solution to this problem is?

The executive summary is that Apple SoCs require nGnRnE memory mappings 
for MMIO, except for PCI space which uses nGnRE. ARM64 currently uses 
nGnRE everywhere. Solutions discussed in this thread and elsewhere include:

1. Something similar to the current hacky patch (which isn't really 
intended as a real solution...); change ioremap to default to nGnRnE 
using some kind of platform-level flag in the DT, then figure out how to 
get the PCI drivers to bypass that. This requires changing almost every 
PCI driver, since most of them use plain ioremap().

2. A per-device DT property that tells of_address_to_resource to set a 
flag in the struct resource, which is then used by 
devm_ioremap_resource/of_iomap to pick a new ioremap_ variant for nGnRnE 
(introduce ioremap_np() for nonposted?) (PCI would work with this 
inasmuch as it would not support it, and thus fall back to the current 
nGnRE default, which is correct for PCI...). This requires changing 
DT-binding drivers that we depend on to not use plain ioremap() (if any 
do so), but that is a finite subset (unlike PCI which involves 
potentially every driver, because thunderbolt).

3. Encode the mapping type in the address of child devices, either 
abusing the high bits of the reg or introducing an extra DT cell there, 
introduce a new OF bus type that strips those away via a ranges mapping 
and sets flags in the struct resource, similar to what the PCI bus does 
with its 3-cell ranges, then do as (2) above and make 
devm_ioremap_resource/of_iomap use it:

On 09/02/2021 07.57, Arnd Bergmann wrote:
> #define MAP_NONPOSTED 0x80000000
> 
> arm-io { /* name for adt, should be changed */
>       compatible = "apple,m1-internal-bus";
>       #address-cells = <2>; /* or maybe <3> if we want */
>       #size-cells = <2>;
>       ranges =
>                 /* on-chip MMIO */
>                 <(MAP_NONPOSTED | 0x2) 0x0   0x2 0x0 0x1 0x0>,
> 
>                /* first PCI: 2GB control, 4GB memory space */
>               <(MAP_NONPOSTED | 0x3) 0x80000000  0x3 0x80000000  0x0 0x80000000>,
>                <0x4 0x0   0x4 0x0  0x1 0x0>,
[...]

> The MAP_NONPOSTED flag then gets interpreted by the .translate() and
> .get_flags() callbacks of "struct of_bus" in the kernel, where it is put into
> a "struct resource" flag, and interpreted when the resource gets mapped.
> 
> The PCI host controller nests inside of the node above, and (in theory)
> uses the same trick to distinguish between prefetchable and non-prefetchable
> memory, except in practice this is handled in device drivers that already
> know whether to call ioremap() or ioremap_wc().

4. Introduce a new top-level DT element in the style of reserved-memory, 
that describes address ranges and the mapping type to use. This could be 
implemented entirely in arch code, having arm64's ioremap look up the 
address in a structure populated from this.

As an additional wrinkle, earlycon is almost certainly going to need a 
special path to handle this very early, before OF stuff is available; it 
also uses fixmap instead of ioremap, which has its own idea about what 
type of mapping to use.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
