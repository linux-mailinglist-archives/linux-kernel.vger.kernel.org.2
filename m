Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C5E3144E3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 01:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhBIA0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 19:26:41 -0500
Received: from marcansoft.com ([212.63.210.85]:33500 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229646AbhBIA0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 19:26:36 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 1B24A4207F;
        Tue,  9 Feb 2021 00:25:49 +0000 (UTC)
To:     Mark Kettenis <mark.kettenis@xs4all.nl>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     devicetree@vger.kernel.org, maz@kernel.org,
        linux-kernel@vger.kernel.org, soc@kernel.org, robh+dt@kernel.org,
        olof@lixom.net, linux-arm-kernel@lists.infradead.org
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-14-marcan@marcan.st>
 <CAK8P3a2Ad+xmmMWgznOHPpxgCXKWFYfpHBqt_49_UuxrwFSq+A@mail.gmail.com>
 <c1bc2a087747c4d9@bloch.sibelius.xs4all.nl>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 13/18] arm64: ioremap: use nGnRnE mappings on platforms
 that require it
Message-ID: <635f1a81-58c8-f3b6-ab3f-1cf6a084aed0@marcan.st>
Date:   Tue, 9 Feb 2021 09:25:47 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <c1bc2a087747c4d9@bloch.sibelius.xs4all.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2021 08.20, Mark Kettenis wrote:
> It is only PCI mmio space that needs to be nGnRE.  The PCI host
> controller register space itself needs nGnRnE just like all other
> integrated peripherals (or at least it works that way).

This is correct. Actually, as I just discovered, nGnRE writes to MMIO 
are not silently blackholed, but rather raise an SError. A certain other 
Linux loader masks those SErrors in a vendor register completely 
unnecessarily, which is why this isn't apparent when you use it. I never 
noticed this myself until now because when I first ran into it, it was 
breaking the UART, so of course I'd never see the SErrors, and I didn't 
try again after I learned more about the L2C SError control mechanism :-)

Testing now, it seems we can actually fairly neatly figure out where 
nGnRE is allowed and where not, as writes that fail due to that raise a 
SError with L2C_ERR_INF=3.

I probed writing to i<<28 for i = [0..255], using nGnRE. This reveals 
that nGnRE writes are allowed (i.e. either succeed or error out 
differently) in the following ranges:

0x400000000 - 0x4ffffffff (apciec0)
0x580000000 - 0x67fffffff (apciec1)
0x6a0000000 - 0x6ffffffff (apcie)

Which matches the `ranges` properties of the respective apcie devices in 
the ADT. The first two are obviously the TB3 ports, amd have more 
features (three ranges instead of two, presumably IO port ranges are 
supported on those, there's some extra DMA stuff, etc).

So the hardware behavior is to block nGnRE everywhere except in those 
ranges (i.e. the nGnRnE fault takes precedence over other errors, like 
the address not existing at all).

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
