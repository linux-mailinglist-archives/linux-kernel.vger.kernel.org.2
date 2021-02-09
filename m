Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6493315B95
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbhBJAsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:48:17 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42540 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbhBIWFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:05:40 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 119K4nE9030722;
        Tue, 9 Feb 2021 14:04:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1612901090;
        bh=iHtaRt0rdQ050Pw5DtS3xF31a7ZdIBVGeqY2mViRxuI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=GQY6Q5gp40KDOmvNfGjZGuuzctU4aJb8P5RsWXnG/PZ8fWuoR2zOQVCJZIoLkEPZc
         N3Tte+KoDdBP8dJxu+GP5UsFCJXjGAiiU1UuV1AwcoMd630JzQnVGdt7mPKGHQK9v3
         ofhvuVRT1u77yCK0o73DyfKfXuF6mhdxV7II08uQ=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 119K4npN117575
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Feb 2021 14:04:49 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 9 Feb
 2021 14:04:49 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 9 Feb 2021 14:04:49 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 119K4nwb035576;
        Tue, 9 Feb 2021 14:04:49 -0600
Date:   Tue, 9 Feb 2021 14:04:49 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Le Jin <le.jin@siemens.com>,
        Bao Cheng Su <baocheng.su@siemens.com>
Subject: Re: [PATCH] arm64: dts: ti: Add support for Siemens IOT2050 boards
Message-ID: <20210209200449.v4mq2fiqto5o37nd@sleeve>
References: <367f1249-700e-38f2-36de-46fb0be61c5b@siemens.com>
 <20210209144427.np6kpecc2jbh2wa7@tingling>
 <5dc27777-eede-c4b4-8b21-1ac15a2e2617@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5dc27777-eede-c4b4-8b21-1ac15a2e2617@siemens.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18:40-20210209, Jan Kiszka wrote:
> On 09.02.21 15:44, Nishanth Menon wrote:
> > Jan,
> > 
> > A few quick scan comments below, you might need to post based off
> > 5.12-rc1 once available..
> > 
> > Also, I see a bit of warnings with dtbs_check, which probably needs a
> > little more digging into (pcie insists to get a device_type property,
> > etc..)
> > 
> > you could use kernel_patch_verify or https://github.com/nmenon/kernel_patch_verify/blob/master/Dockerbuild.md
> > 
> > it throws up a report like this https://pastebin.ubuntu.com/p/SdkZr432z3/
> > 
> 
> Ok, will have a look - is that checkpatch on steroids?

It does a bit more than execute checkpatch.. you can see the script 
https://github.com/nmenon/kernel_patch_verify/blob/master/kernel_patch_verify

as well, but depending on files, for example: with dts, it does a
dtbs_check, W=2 build, converts dtb to dts and back to dtb to wiggle out
as many issues that people seem to hit against..

There are other solutions out there (patman etc).. in effect just a
wrapper script around standard kernel based checkers..

> 
> > So, many of my comments below are just first pass parse of that log -> I
> > usually do recommend building with W=2 and dtbs_check (with yamlint etc)
> > to make sure things are a bit sane. Will be good to have additional
> > eyes.
> > 
> > On 11:21-20210209, Jan Kiszka wrote:
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> Add support for two Siemens SIMATIC IOT2050 variants, Basic and
> >> Advanced. They are based on the TI AM6528 and AM6548 SOCs.
> >>
> >> Based on original version by Le Jin.
> > 
> > Might be good to add links to the boards as well (if available), for
> > future reference.
> > 
> 
> Sure, though stability of links is not under my control. But I could
> additionally drop https://github.com/siemens/meta-iot2050 here.

hmm.. Something of a reference for folks may be 5 or 10 years down the
road, as to answer "what is this board"? Upto you though..

[...]

> >> diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> >> new file mode 100644
> >> index 000000000000..de05937dbb60
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> >> @@ -0,0 +1,649 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright (c) Siemens AG, 2018-2021
> >> + *
> > 
> > Optional: might be nice to add a oneliner comment for reuse scope..
> > 
> 
> You mean something like "Common bits for IOT2050 basic and advanced boards"?

Yeah, that'd help.

[...]

> >> +	gpio-line-names =
> >> +		"wkup_gpio0-base", "", "", "", "UART0-mode1", "UART0-mode0",
> >> +			"UART0-enable", "UART0-terminate", "", "WIFI-disable",
> >> +		"", "", "", "", "", "", "", "", "", "",
> >> +		"", "A4A5-I2C-mux", "", "", "", "USER-button", "", "", "","IO0",
> >> +		"IO1", "IO2", "", "IO3", "IO17-direction",
> >> +			"A5", "IO16-direction", "IO15-direction",
> >> +			"IO14-direction", "A3",
> >> +		"", "IO18-direction", "A4", "A2", "A1",
> >> +			"A0", "", "", "IO13", "IO11",
> >> +		"IO12", "IO10";
> > 
> > Any chance of intending this consistently?
> 
> There is in fact a plan behind this way: I intended every 10 entries, to
> ease counting the pins (and that proved to be valuable more than once
> already).

AAAh.. interesting.. as long as you find it useful, I am ok with it.. it
was'nt obvious to me the first look..

[...]

> >> diff --git a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
> >> new file mode 100644
> >> index 000000000000..bb9ab4fdd74e
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
> >> @@ -0,0 +1,56 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright (c) Siemens AG, 2018-2021
> >> + *
> >> +	cpus {
> >> +		cpu-map {
> >> +			/delete-node/ cluster1;
> >> +		};
> >> +		/delete-node/ cpu@100;
> >> +		/delete-node/ cpu@101;
> >> +	};
> > 
> > Personally, I'd prefer this (handling efuse spins in board files or
> > even overlays) instead of having to create 100s of dtsi per SoC for
> > every permutation & combination of TI efused devices and handle these
> > in board files. I do see examples of similar usage elsewhere in:
> > 
> > $ git grep /delete-node/ arch/arm64/boot/dts/
> > 
> > But, if someone has a different opinion, feel free to pipe up with a
> > reasonable way to prevent file explosion.
> > 

Just a side note to folks (since I got a couple of private poked
on this) -> if we do see a pattern going forward where the efuse
parts have more *upstream* boards coming online, we will consider
spawning off dtsi - but I don't see that yet and I don't really want
to create a explosion of real and imagined unused dtsi combinations
"just because someone might need it". There is always the overlay
option for all the other variants that may or maynot exist.

Jan, on patch itself: I might have missed an unused l2-cache (2nd
cluster) entry.. Might be good to check dtb-> dts and give it a glance
if the right set of nodes are present.

> >> diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
> >> new file mode 100644
> >> index 000000000000..aa1ef081ef22
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
> >> @@ -0,0 +1,57 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright (c) Siemens AG, 2018-2021
> >> + *
> >> + * Authors:
> >> + *   Le Jin <le.jin@siemens.com>
> >> + *   Jan Kiszka <jan.kiszk@siemens.com>
> >> + */
> >> +
> >> +/dts-v1/;
> >> +
> >> +#include "k3-am65-iot2050-common.dtsi"
> > [...]
> > 
> 
> Thanks for the review! Will come up with v2 soon, once all the points
> are resolved.

Thanks Jan. Glad to see this moving :)

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
