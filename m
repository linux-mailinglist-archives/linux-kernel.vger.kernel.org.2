Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A2538B03D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 15:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240075AbhETNnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 09:43:45 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35938 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239100AbhETNnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 09:43:08 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14KDfeRf038341;
        Thu, 20 May 2021 08:41:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1621518100;
        bh=NzysMlm/BUH/w03D45s98fi6UMQpfCETbmthl1hZcMc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=vLB1IazODqqfLSF4SRyxPeVKfUiQtkNqCRJHIbcEQWq29Oa2A4HjBHl0q7IVeeZ+3
         Rp+4Q2i12cZNS53OxEbrUI7HfPS/MOwBG7x7DLcieBTX6oYdlU+IxLERV6DYRh5m3Y
         zSRa2wJhEH5/9/eZJAoKpj1aZVNX0Fd6glirq8pk=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14KDfep3112909
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 May 2021 08:41:40 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 20
 May 2021 08:41:40 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 20 May 2021 08:41:40 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14KDfeuO094474;
        Thu, 20 May 2021 08:41:40 -0500
Date:   Thu, 20 May 2021 08:41:40 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH 1/4] arm64: dts: ti: k3-j721e-main: Fix external refclk
 input to SERDES
Message-ID: <20210520134140.qzjl7td7ojoqudok@snippet>
References: <20210512151209.27560-1-kishon@ti.com>
 <20210512151209.27560-2-kishon@ti.com>
 <20210512185157.q5sr2xqf3w5igfte@imagines>
 <68c95cf1-84fa-2194-7bb1-e3c60e7f1fc0@ti.com>
 <20210513140137.5uvftgtsku3xfobz@engraving>
 <81b7dc76-0918-0a95-5715-cf701e638bbe@ti.com>
 <20210517140519.4ltzvw3k74z72urz@dingo>
 <3529e35f-0bef-fd8c-515a-6d4552f2467d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3529e35f-0bef-fd8c-515a-6d4552f2467d@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18:48-20210520, Kishon Vijay Abraham I wrote:
> Hi Nishanth,
> 
> On 17/05/21 7:35 pm, Nishanth Menon wrote:
> > On 14:00-20210517, Kishon Vijay Abraham I wrote:
> >> Hi Nishanth,
> >>
> >> On 13/05/21 7:31 pm, Nishanth Menon wrote:
> >>> On 17:41-20210513, Kishon Vijay Abraham I wrote:
> >>>> Hi Nishanth,
> >>>>
> >>>> On 13/05/21 12:21 am, Nishanth Menon wrote:
> >>>>> On 20:42-20210512, Kishon Vijay Abraham I wrote:
> >>>>>> Rename the external refclk inputs to the SERDES from
> >>>>>> dummy_cmn_refclk/dummy_cmn_refclk1 to cmn_refclk/cmn_refclk1
> >>>>>> respectively. Also move the external refclk DT nodes outside the
> >>>>>> cbass_main DT node. Since in j721e common processor board, only the
> >>>>>> cmn_refclk1 is connected to 100MHz clock, fix the clock frequency.
> >>>>>>
> >>>>>> Fixes: afd094ebe69f ("arm64: dts: ti: k3-j721e-main: Add WIZ and SERDES PHY nodes")
> >>>>>
> >>>>> Assume we want this part of 5.13 fixes?
> >>>>
> >>>> This doesn't fix any functionality. Okay for me to go in 5.14 along with
> >>>> the rest of the series.
> >>>
> >>>
> >>>>>
> >>>>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >>>>>> ---
> >>>>>>  .../dts/ti/k3-j721e-common-proc-board.dts     |  4 ++
> >>>>>>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 58 ++++++++++---------
> >>>>>>  2 files changed, 34 insertions(+), 28 deletions(-)
> >>>>>>
> >>>>>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> >>>>>> index 60764366e22b..86f7ab511ee8 100644
> >>>>>> --- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> >>>>>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> >>>>>> @@ -635,6 +635,10 @@
> >>>>>>  	status = "disabled";
> >>>>>>  };
> >>>>>>  
> >>>>>> +&cmn_refclk1 {
> >>>>>> +	clock-frequency = <100000000>;
> >>>>>> +};
> >>>>>> +
> >>>>>>  &serdes0 {
> >>>>>>  	serdes0_pcie_link: link@0 {
> >>>>>>  		reg = <0>;
> >>>>>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> >>>>>> index c2aa45a3ac79..002a0c1520ee 100644
> >>>>>> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> >>>>>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> >>>>>> @@ -8,6 +8,20 @@
> >>>>>>  #include <dt-bindings/mux/mux.h>
> >>>>>>  #include <dt-bindings/mux/ti-serdes.h>
> >>>>>>  
> >>>>>> +/ {
> >>>>>> +	cmn_refclk: cmn-refclk {
> >>>>>> +		#clock-cells = <0>;
> >>>>>> +		compatible = "fixed-clock";
> >>>>>> +		clock-frequency = <0>;
> >>>>>> +	};
> >>>>>> +
> >>>>>> +	cmn_refclk1: cmn-refclk1 {
> >>>>>
> >>>>> Just curious: why cant we use the standard nodenames with clock?
> >>>>
> >>>> We can use standard names here. Is there any defined nodename for
> >>>> clocks? clk or clock? Don't see $nodename defined for clocks in
> >>>> dt-schema repository.
> >>>
> >>> Looking at the fixed-clock example, lets go with clock
> >>
> >> Since I have two clocks here adding clock@0 and clock@1 introduces the
> >> following error.
> >> /home/a0393678/repos/linux-wip/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dt.yaml:
> >> /: clock@0: 'anyOf' conditional failed, one must be fixed:
> >>         'reg' is a required property
> >>         'ranges' is a required property
> >>
> >> The current "fixed-clock" binding doesn't allow adding "reg" property.
> >> We'll stick to non standard names? or do you think the binding has to be
> >> fixed?
> > 
> > Look at other fixed-clock examples in other arm64 examples
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/freescale/imx8mm.dtsi#n147
> > is a good one.. Binding is fine, IMHO.
> 
> Ah Thanks. It only has to be prefixed with clock-.


Yep - also, though I think it is self evident, I will explicitly state
as well: since dts should represent hardware, using names like "dummy"
does'nt belong to dts - it would indicate something of a software
construct. Knowing what you are trying to describe, I do understand it
is not a "software construct", but please avoid using similar naming
which may create misunderstanding.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
