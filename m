Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893333374D6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 15:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbhCKOB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 09:01:28 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56944 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbhCKOBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:01:20 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12BE0vjb116591;
        Thu, 11 Mar 2021 08:00:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615471257;
        bh=WvJ7vSe+3n1B+l5sPC4b7fxMkGHK+qe49RIACQeSqvI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Ymg9SQzC6w1NlSaMLj8Dh6Gv1u4DIvncibhxP2/FOM8di/KmQIKYs4d1/tdV/3egw
         CwZSI9+0oBCx9Ct5gRuaAgR7kAEtSi4ZtK0iWE0bxpMlrUlu+mddyLov6CW6+AdUd/
         PeH3HJ6iJZ1h6VLYAqXCa//1/wPPoKVQux/kkW7U=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12BE0vhg118056
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Mar 2021 08:00:57 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 11
 Mar 2021 08:00:56 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 11 Mar 2021 08:00:56 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12BE0usa042122;
        Thu, 11 Mar 2021 08:00:56 -0600
Date:   Thu, 11 Mar 2021 08:00:56 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Le Jin <le.jin@siemens.com>,
        Bao Cheng Su <baocheng.su@siemens.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v4 3/3] arm64: dts: ti: Add support for Siemens IOT2050
 boards
Message-ID: <20210311140056.fzvke3rrg6c2uuoa@uncouth>
References: <cover.1615369068.git.jan.kiszka@siemens.com>
 <9bff40f434e5298890e5d139cc36cc46a0ca2d76.1615369068.git.jan.kiszka@siemens.com>
 <20210311131754.i5ewls6hgeitcgre@astonish>
 <8d076ff1-cdac-941f-e796-a2e6dba792ab@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8d076ff1-cdac-941f-e796-a2e6dba792ab@siemens.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14:44-20210311, Jan Kiszka wrote:
> On 11.03.21 14:17, Nishanth Menon wrote:
> > On 10:37-20210310, Jan Kiszka wrote:
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >> +	spidev@0 {
> >> +		compatible = "rohm,dh2228fv";
> >> +		spi-max-frequency = <20000000>;
> >> +		reg = <0>;
> > 
> > Jan,
> > 
> > As part of my final sanity checks, I noticed that we missed this: is a checkpatch warning
> > 
> > WARNING: DT compatible string "rohm,dh2228fv" appears un-documented -- check ./Documentation/devicetree/bindings/
> > #629: FILE: arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi:581:
> > 		compatible = "rohm,dh2228fv";
> > 
> > I cannot pick up nodes that are'nt documented as yaml in
> > 	Documentation/devicetree
> > 
> > I know this is irritating to find such nodes that already have previous
> > users and the person coming last gets to deal with "new rules".. but
> > sorry for catching this so late.
> > 
> > Here are the options that come to mind:
> > 
> > option 1) - drop the node and resubmit.
> > 
> > option 2) - get the documentation into linux master tree and then submit
> > the patches.
> > 
> 
> As you said, I'm not setting a precedence here:
> 
> arch/arm/boot/dts/imx28-cfa10049.dts:                   compatible = "rohm,dh2228fv";
> arch/arm/boot/dts/rv1108-elgin-r1.dts:          compatible = "rohm,dh2228fv";
> arch/arm/boot/dts/socfpga_cyclone5_socdk.dts:           compatible = "rohm,dh2228fv";
> drivers/spi/spidev.c:   { .compatible = "rohm,dh2228fv" },
> 
> Was just just never documented as binding? Or why is no one allowed to 
> use this anymore? What is to be used instead for spidev?

See [1] compare the compatibles against
Documentation/devicetree/bindings -> I think you should describe what
your hardware really is though.

Unfortunately devicetree migration has been far from being smooth.. it
was like chewing an elephant - linux community had to attack it in
pieces..

Yes - it was unfortunately one of those cases where the driver support
was introduced long back and no binding was introduced at that time (it
was'nt mandatory then).. then we added a mandatory requirement that it
be documented in txt.. over years realized things are'nt great with
unstructured txt description of binding, now moving on converting
existing txt files to yaml and schemas to static check the dts...
evolution over the years, I guess.

I am on a fight internally as well to have all our legacy txt files
converted over to yaml.. and am having to put up a stance - see [2]

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/spi/spidev.c#n678
[2] https://lore.kernel.org/linux-arm-kernel/20210311134908.jsh2lywtwzvlyvbc@finally/T/#u

> 
> > 
> > I think we should just drop the node and resubmit - since this is a more
> > intrusive change and I don't have your platform handy, I am going to
> > suggest you make a call :(
> 
> This breaks userspace here, and we would need to carry that node on top.
> 

Uggh... that sucks.. but I think that would be lower tradeoff to make
than me (as it stands now) having to drop the patch series.

> BTW, I already brought up the topic internally to get you some boards 
> for testing.

Thanks.. While it might help me personally to get some on my internal
farm, it might be good to get them on kernelci as well on the longer
run.

> 
> I've done that and addressed all that I could (former patch 4). We 
> import those from k3, and I don't feel confident how to resolve them.
> See also v1 of this patch.

Yeah - i noticed that upstream dt-schema has gotten even more stricter
even though the dts has remained the same.. I need to spend time in
digging at it.

At this point the only big kicker is the checkpatch stuff which I cant
let through - if i do that arnd will probably kick everything from my
PR out :( - which I cant do.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
