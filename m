Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C5332E151
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 06:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhCEFON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 00:14:13 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50896 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhCEFOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 00:14:10 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1255E3nh078090;
        Thu, 4 Mar 2021 23:14:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614921243;
        bh=Hil26d5EMhmIypDQtZPF9LmSciGeygxpCyytRBHQ5D0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=pGdNDbL1q0wiS0mdML6g9U4uagMSnmX3k7eDPi+R20LDG0YGNp4ThmQ0dYnXqbXc8
         q7BtPyknmbX5vWxC744ctS6/DJOEW+OJ0znzKrk/nqn/fJkj7ruGFaDwsnmqQJa5aF
         sHwZAnu3azoDGHJ0JUByj7n4oq43i0Mo3PZHBILY=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1255E3YI020328
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Mar 2021 23:14:03 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 4 Mar
 2021 23:14:03 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 4 Mar 2021 23:14:03 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1255E3Cl102945;
        Thu, 4 Mar 2021 23:14:03 -0600
Date:   Thu, 4 Mar 2021 23:14:03 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Aswath Govindraju <a-govindraju@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-j721e-main: Update the speed modes
 supported and their itap delay values for MMCSD subsystems
Message-ID: <20210305051403.y4lzv5woisimzlgb@persuader>
References: <20210225132736.26429-1-a-govindraju@ti.com>
 <969c38e2-01e8-55a1-b97e-cf72f07fcd62@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <969c38e2-01e8-55a1-b97e-cf72f07fcd62@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10:59-20210301, Kishon Vijay Abraham I wrote:
> On 25/02/21 6:57 pm, Aswath Govindraju wrote:
> > According to latest errata of J721e [1], HS400 mode is not supported
> > in MMCSD0 subsystem (i2024) and SDR104 mode is not supported in MMCSD1/2
> > subsystems (i2090). Therefore, replace mmc-hs400-1_8v with mmc-hs200-1_8v
> > in MMCSD0 subsystem and add a sdhci mask to disable SDR104 speed mode.
> > 
> > Also, update the itap delay values for all the MMCSD subsystems according
> > the latest J721e data sheet[2]
> > 
> > [1] - https://www.ti.com/lit/er/sprz455/sprz455.pdf
> > [2] - https://www.ti.com/lit/ds/symlink/tda4vm.pdf
> > 
> > Fixes: e6dc10f200da ("arm64: dts: ti: j721e-main: Add SDHCI nodes")
> > Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> 
> Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>


In some offline testing, I realized that the patch wont apply cleanly to e6dc10f200da

cd48ce86a4d0c1ffec86aa46a26da993c9af5f53 might be a better candidate for
this - I will drop the patch from my queue in the morning, could you
update the patch with a new rev with appropriate Fixes?
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
