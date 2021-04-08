Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62293589D9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 18:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbhDHQfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 12:35:03 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44626 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbhDHQfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:35:01 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 138GYeGl051984;
        Thu, 8 Apr 2021 11:34:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617899680;
        bh=nLUTBiorp5Os08gZKDmsVcD9Hpijn0XmkEbQWDxvW+M=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Hs5/eaDNRPilF1Uj3nv3RLiwnVL9mbgqmHwLZYzH7WHE7Lwrl8Bsg4DCBvRK8ddaq
         ljmY2Y358UdoxWGfOPPxmbOv9TK52xGRYwntTNtjwsYF33jKA1HqUqf2OS8VrVcXlt
         5KOH5InHcNtrVmWDn9V4Ec4q5oYDp1SHf4+ze8qg=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 138GYeOn090958
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Apr 2021 11:34:40 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 8 Apr
 2021 11:34:40 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 8 Apr 2021 11:34:40 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 138GYdUV057016;
        Thu, 8 Apr 2021 11:34:39 -0500
Date:   Thu, 8 Apr 2021 11:34:39 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Arnd Bergmann <arnd@kernel.org>
CC:     <soc@kernel.org>, Olof Johansson <olof@lixom.net>,
        <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] arm64: dts: TI K3 updates for v5.13
Message-ID: <20210408163439.x7pz7bitwmu7aenl@freckled>
References: <20210405155336.smohb7uzkperqwuz@reflex>
 <161789493785.1630479.2066806618809349698.b4-ty@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <161789493785.1630479.2066806618809349698.b4-ty@arndb.de>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:24-20210408, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> On Mon, 5 Apr 2021 10:53:36 -0500, Nishanth Menon wrote:
> > Please pull the following device tree changes for v5.13 cycle.
> > 
> > The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:
> > 
> >   Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)
> > 
> > are available in the Git repository at:
> > 
> > [...]
> 
> Merged into arm/dt, thanks!

Thanks.
> 
> There are a couple added warnings from 'make W=1 dtbs_check' though:
> 
> ti/k3-am64-main.dtsi:376.40-385.4: Warning (simple_bus_reg): /bus@f4000/interrupt-controller0: missing or empty reg/ranges property
> ti/k3-am64-main.dtsi:45.13-135.4: Warning (simple_bus_reg): /bus@f4000/dmss: missing or empty reg/ranges property
> ti/k3-am64-mcu.dtsi:77.39-86.4: Warning (simple_bus_reg): /bus@f4000/bus@4000000/interrupt-controller1: missing or empty reg/ranges property
> 
> ti/k3-am642-evm.dt.yaml: bus@4000000: interrupt-controller1: {'type': 'object'} is not allowed for {'compatible': ['ti,sci-intr'], 'ti,intr-trigger-type': [[1]], 'interrupt-controller': True, 'interrupt-parent': [[1]], '#interrupt-cells': [[1]], 'ti,sci': [[4]], 'ti,sci-dev-id': [[5]], 'ti,interrupt-ranges': [[0, 104, 4]], 'phandle': [[5]]}
> ti/k3-am642-evm.dt.yaml: bus@f4000: dmss: {'type': 'object'} is not allowed for {'compatible': ['simple-mfd'], '#address-cells': [[2]], '#size-cells': [[2]], 'dma-ranges': True, 'ranges':  'phandle': [[7]]}}
> ti/k3-am642-evm.dt.yaml: bus@f4000: interrupt-controller0: {'type': 'object'} is not allowed for {'compatible': ['ti,sci-intr'], 'ti,intr-trigger-type': [[1]], 'interrupt-controller': True, 'interrupt-parent': [[1]], '#interrupt-cells': [[1]], 'ti,sci': [[4]], 'ti,sci-dev-id': [[3]], 'ti,interrupt-ranges': [[0, 32, 16]], 'phandle': [[15]]}
> ti/k3-am642-evm.dt.yaml: flash@0: 'cdns,read-delay', 'cdns,tchsh-ns', 'cdns,tsd2d-ns', 'cdns,tshsl-ns', 'cdns,tslch-ns' do not match any of the regexes: '^partition@', 'pinctrl-[0-9]+'
> ti/k3-am642-sk.dt.yaml: bus@4000000: interrupt-controller1: {'type': 'object'} is not allowed for {'compatible': ['ti,sci-intr'], 'ti,intr-trigger-type': [[1]], ...
> ti/k3-am642-sk.dt.yaml: bus@f4000: dmss: {'type': 'object'} is not allowed for {'compatible': ['simple-mfd'], ...
> ti/k3-am642-sk.dt.yaml: bus@f4000: interrupt-controller0: {'type': 'object'} is not allowed for {'compatible': ['ti,sci-intr'], 'ti,intr-trigger-type': [[1]], 'interrupt-controller': True, 'interrupt-parent': [[1]], '#interrupt-cells': [[1]], 'ti,sci': [[4]], 'ti,sci-dev-id': [[3]], 'ti,interrupt-ranges': [[0, 32, 16]], 'phandle': [[11]]}
> ti/k3-am642-sk.dt.yaml: flash@0: 'cdns,read-delay', 'cdns,tchsh-ns', 'cdns,tsd2d-ns', 'cdns,tshsl-ns', 'cdns,tslch-ns' do not match any of the regexes: '^partition@', 'pinctrl-[0-9]+'
> ti/k3-j7200-common-proc-board.dt.yaml: flash@0: 'cdns,read-delay', 'cdns,tchsh-ns', 'cdns,tsd2d-ns', 'cdns,tshsl-ns', 'cdns,tslch-ns' do not match any of the regexes: '^partition@', 'pinctrl-[0-9]+'
> 
> 
> merge commit: 4b8cf90637f295ff1cb1f4bdfde134dab1196296


We have a bunch of problems with interrupt controller definitions -
attempts in [1] [2] did'nt seem to come to any form of conclusion yet.

Cdns is a convert from txt to yaml and is queued on Marks' tree[3]

These issues pre-existed in existing definitions and/or convertion
from txt and we are already working to make sure we try and reach a
conclusion soon[4]. I am guessing from your note that it is high time we
put our foot down on txt bindings and clean yamls, I will ensure we
follow up on that.


[1] https://lore.kernel.org/linux-devicetree/CAL_Jsq++DyiKG9smQGx9FAPDJnVrezcXNb0Y5uh-5_2GBzTQpQ@mail.gmail.com/#t
[2] https://lore.kernel.org/linux-arm-kernel/20210311215914.pgpz2yymmfqlainl@episode/ 
[3] https://lore.kernel.org/linux-arm-kernel/161726952255.2486.16196604421904035265.b4-ty@kernel.org/
[4] https://lore.kernel.org/linux-arm-kernel/20210311134908.jsh2lywtwzvlyvbc@finally/
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
