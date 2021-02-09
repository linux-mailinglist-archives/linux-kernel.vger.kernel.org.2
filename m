Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597A2314E2E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 12:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhBILYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 06:24:53 -0500
Received: from marcansoft.com ([212.63.210.85]:37974 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229993AbhBILW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 06:22:56 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id C172941EE3;
        Tue,  9 Feb 2021 11:22:08 +0000 (UTC)
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Mark Kettenis <mark.kettenis@xs4all.nl>,
        DTML <devicetree@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-14-marcan@marcan.st>
 <CAK8P3a2Ad+xmmMWgznOHPpxgCXKWFYfpHBqt_49_UuxrwFSq+A@mail.gmail.com>
 <c1bc2a087747c4d9@bloch.sibelius.xs4all.nl>
 <635f1a81-58c8-f3b6-ab3f-1cf6a084aed0@marcan.st>
 <CAK8P3a043eO4p2o6tizR2x7a1TZHMqO7TdX53JC4bTZnbQd9iQ@mail.gmail.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 13/18] arm64: ioremap: use nGnRnE mappings on platforms
 that require it
Message-ID: <11cdf93c-0b25-e1c1-5d18-80ccb4a3f2d9@marcan.st>
Date:   Tue, 9 Feb 2021 20:22:06 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a043eO4p2o6tizR2x7a1TZHMqO7TdX53JC4bTZnbQd9iQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2021 18.15, Arnd Bergmann wrote:
> Right, these are the same ranges that I found in the adt and that Mark
> listed in his code snippet, so it seems we all see the same partitioning
> of the address space. I also see them reflected in the
> /defaults/pmap-io-ranges property in ADT, which seems to have an entry
> for every register range that has some mmio registers, along with what
> appears to be a bitmask of some attributes, and it clearly shows
> the above ranges as having a distinct set of bits from the others
> (in little-endian):
> 
>   00000000 04000000 00000080 00000000 27000080 65494350
>   00000080 04000000 00000080 00000000 27000080 65494350
>   00000080 05000000 00000080 00000000 27000080 65494350
>   00000000 06000000 00000080 00000000 27000080 65494350
>   000000a0 06000000 00000020 00000000 27000080 65494350
>   000000c0 06000000 00000040 00000000 27000080 65494350
>     ^64-bit address       ^64-bit length            ^ 64-bit flags?

That's ASCII :-)

'PCIe'

> 
> As opposed to e.g.
> 
>   0000f002 05000000 00400000 00000000 07400000 54524144

'DART'

>   00800021 05000000 00400000 00000000 07400000 44495344

'DSID'

> Ok, so if we want this to get encoded in a 'struct resource' flag, the PCI
> resources should work just fine as these resources come from the
> PCI layer rather than of_address_to_resource(). I think it would be
> reasonable here to add something to of_address_to_resource() to
> set such a flag if we can find an unused one, and then require the
> drivers for this platform to go through devm_ioremap_resource()
> or similar.

This sounds reasonable. For setting such a flag, I guess looking for a 
property (inherited from parents) would make sense. `mmio-map-mode = 
"nonposted"` or something like that?

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
