Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632DB37FF6A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 22:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbhEMUrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 16:47:35 -0400
Received: from 212-129-56-80.ip.rebuild.sh ([212.129.56.80]:51728 "EHLO
        rebuild.sh" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232934AbhEMUre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 16:47:34 -0400
Received: from [192.168.97.21] (81-67-152-104.rev.numericable.fr [81.67.152.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by rebuild.sh (Postfix) with ESMTPSA id 025862000D;
        Thu, 13 May 2021 22:46:22 +0200 (CEST)
From:   =?UTF-8?B?VGhvbWFzIOKAnGlsbHdpZWNreuKAnCBEZWJlc3Nl?= 
        <dev@illwieckz.net>
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <6941f046-d9a6-7603-0338-e7831917a540@illwieckz.net>
 <MN2PR12MB448814C93AA0664284E1DA32F7EA0@MN2PR12MB4488.namprd12.prod.outlook.com>
 <0ce2f491-ab60-8965-0292-4da44ebf7fc7@illwieckz.net>
 <488fd133-fcae-2fdb-5b7a-86131f97efdf@illwieckz.net>
 <MN2PR12MB4488D3F9625D8F48F9832502F7519@MN2PR12MB4488.namprd12.prod.outlook.com>
Subject: Re: On disabling AGP without working alternative (PCI and PCIe are
 also affected)
Message-ID: <99519074-041f-df69-d09b-a4b71402dde0@illwieckz.net>
Date:   Thu, 13 May 2021 22:46:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <MN2PR12MB4488D3F9625D8F48F9832502F7519@MN2PR12MB4488.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 13/05/2021 à 21:02, Deucher, Alexander a écrit :
> [AMD Public Use]
> 
> I don't think I have a functional AGP system anymore, but I do have PCIe capable systems and they work fine.  
> Does this patch[1], help by any chance?  The change to add support for root ports with addressing limitations seemed to break a lot of old systems,
> but never really got resolved.  If not, your best bet is probably to try and bisect if something broke your system(s).
> 
> Alex
> 
> [1] - https://www.spinics.net/lists/amd-gfx/msg52961.html

The more modern PCIe systems seems to not be affected when running PCIe
cards. I would not be surprised if modern PCIe hosts rely on features
that were supported in the past and then, the old features are not
really tested.

For example while reading the Linux code in October I noticed the code
was referencing different mask lenght, what if only the implementation
for the newer length works or something like that?

But well, the patch you linked is touching the exact code that made me
wondering about it:

```
	dma_bits = 40;
	if (rdev->flags & RADEON_IS_AGP)
		dma_bits = 32;
	if ((rdev->flags & RADEON_IS_PCI) &&
	    (rdev->family <= CHIP_RS740))
		dma_bits = 32;
```

If I'm right this code sets this value to 40 by default, then sets it to
32 if GPU is AGP or if GPU is PCI and identifier is smaller or equal to
RS740.

I see no RADEON_IS_PCIE so I assume both PCIe and AGP cards running with
radeon.agpmode -1 with identifiers greater than RS740 are probably
keeping this value as 40.

It's interesting to notice the PCI HD 4350 (RV710) will use 40 bits,
given it is after RS740 in drivers/gpu/drm/radeon/radeon_family.h

If an AGP card is running with radeon.agpmode = -1, how is it reported,
RADEON_IS_AGP or RADEON_IS_PCI?

If RADEON_IS_PCI, the AGP Radeon HD4670 (RV730) will use 40 bits, given
it is after RS740 in drivers/gpu/drm/radeon/radeon_family.h

I had some memories of having tried to force everything to 32 in that
part of the code, but then, I still got problems but different ones.

From https://lkml.org/lkml/2020/11/9/1054:

> ## drm/radeon: make all PCI GPUs use 32 bits DMA bit mask
>
> https://lkml.org/lkml/2020/11/5/307
>
> This one is not enough to fix PCI GPUs but it is enough to prevent
> to fail r600_ring_test on ATI PCI devices. Note that Nvidia PCI GPUs
> can't be fixed by this, and this uncovers other bug with AGP GPUs when
> AGP is disabled at build time. Also, this patch may makes PCI GPUs
> working on a non-optimal way on platform that accepts them with 40-bit
> DMA bit mask (like Intel-based computers that already work without any
> patch).

So I was wondering if there was a similar issue elsewhere in the code.

I see the patch at https://www.spinics.net/lists/amd-gfx/msg52961.html
is also setting in that code another variable I haven't touched:
rdev->need_dma32

I'll try to set both dma_bits to 32 and rdev->need_dma32 unconditionally
and see if I notice a difference with this or that GPU.

Note that the issue with the PCI HD 4350 (RV710) does not need an AGP
host to be tested, only an AMD host (reproduced from K8 to Piledriver),
but unfortunately now the PCI variant of this card seems to be very hard
to find (I doubt the PCIe one is affected).

Thank you for your answer and you attention!

-- 
Thomas “illwieckz” Debesse
I wish to be personally CC'ed the answers/comments posted to the list in
response to my posting.
