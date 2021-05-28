Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B01F394854
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 23:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbhE1Vbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 17:31:33 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38042 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhE1Vbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 17:31:32 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14SLTnt5129161;
        Fri, 28 May 2021 16:29:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622237389;
        bh=w++KNpKB5+F90E7gVeCKRHcHHvTuUxLfP889YBI8+vM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=kad+0NTOG2DdlyhyisFfW241eyqCD4VRyb6eCu1tYxXwxKy8dDoJyraPRF3vsQdpR
         XqDSjpodfZuu15P7qRTjryH5A3o5Q8LDoY/nGTFsXsQ00cDq099sHpeJLYP/Wh+wPJ
         JI0zUgn8abSPe9QB3OsZx+3KrID8B+pvKCLgHMFE=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14SLTnA5023707
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 May 2021 16:29:49 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 28
 May 2021 16:29:48 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 28 May 2021 16:29:48 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14SLTmdS034243;
        Fri, 28 May 2021 16:29:48 -0500
Date:   Fri, 28 May 2021 16:29:48 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
CC:     Aswath Govindraju <a-govindraju@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] arm64: dts: ti: k3-am65: Add support for UHS-I modes
 in MMCSD1 subsystem
Message-ID: <20210528212948.tmrsean2jj2v6bum@snuggle>
References: <20210511164849.20016-1-a-govindraju@ti.com>
 <7157b8ca-74e4-b7dd-c069-533db6a1cf0c@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7157b8ca-74e4-b7dd-c069-533db6a1cf0c@siemens.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20:34-20210528, Jan Kiszka wrote:
> On 11.05.21 18:48, Aswath Govindraju wrote:
> > UHS-I speed modes are supported in AM65 S.R. 2.0 SoC[1].
> > 
> > Add support by removing the no-1-8-v tag and including the voltage
> > regulator device tree nodes for power cycling.
> > 
> > However, the 4 bit interface of AM65 SR 1.0 cannot be supported at 3.3 V or
> > 1.8 V because of erratas i2025 and i2026 [2]. As the SD card is the primary
> > boot mode for development usecases, continue to enable SD card and disable
> > UHS-I modes in it to minimize any ageing issues happening because of
> > erratas.
> > 
> > k3-am6528-iot2050-basic and k3-am6548-iot2050-advanced boards use S.R. 1.0
> > version of AM65 SoC. Therefore, add no-1-8-v in sdhci1 device tree node of
> > the common iot2050 device tree file.
> > 
> > [1] - https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf, section 12.3.6.1.1
> > [2] - https://www.ti.com/lit/er/sprz452e/sprz452e.pdf
> > 
> > Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> > ---
> > 
> > changes since v2:
> > - moved the no-1-8-v tag to common iot2050 dtsi file.
> > 
> > changes since v1:
> > - added no-1-8-v tag in sdhci1 dt nodes of k3-am6528-iot2050-basic and
> >   k3-am6548-iot2050-advanced boards as they use S.R.1.0 version AM65 SoC.
> > 
> >  .../boot/dts/ti/k3-am65-iot2050-common.dtsi   |  1 +
> >  arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |  1 -
> >  .../arm64/boot/dts/ti/k3-am654-base-board.dts | 33 +++++++++++++++++++
> >  3 files changed, 34 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> > index de763ca9251c..46cc348cd4be 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> > @@ -555,6 +555,7 @@
> >  	pinctrl-0 = <&main_mmc1_pins_default>;
> >  	ti,driver-strength-ohm = <50>;
> >  	disable-wp;
> > +	no-1-8-v;
> >  };
> >  
> 
> Acked-by: Jan Kiszka <jan.kiszka@siemens.com>
> 

Thanks Jan.

Aswath:

It does'nt apply cleanly on my tree as I am picking up patches.. There are
new cleanups and nodes I have picked up, so could be conflicting with
those.

Please rebase and post based on:
https://git.kernel.org/pub/scm/linux/kernel/git/nmenon/linux.git/log/?h=ti-k3-dts-next

I'd suggest you do that on monday OR base on monday's linux-next tag for
the next post.

We need to make sure it does'nt conflict with Suman's repost[1] - So,
lets sync with suman offline to make sure we queue this up in the right
order.



[1] https://lore.kernel.org/linux-arm-kernel/e0da118a-077b-2e04-1e75-1550bcfa3540@ti.com/


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
