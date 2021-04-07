Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66285356F96
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 17:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353234AbhDGPAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 11:00:55 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47890 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349032AbhDGPAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:00:50 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 137Exbmk048300;
        Wed, 7 Apr 2021 09:59:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617807577;
        bh=/LiwkSl+d9oB8w2mVfuYxk28m0/JH5VX5KYZXVM3SSs=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=VeiVCP8CQZAD5vvSKMA3S4CU6X4nPVqRS5NymJ2GSIJu5LbpFsybPW/SVNphxrJXv
         7l4lZsRLRIqW3s+2km5g/ZkjAcAAiPdqyWQ23nY5+erAh452T45DJkICKlr2J2XtT6
         qKDYY8HE06nFWAz63Xh0dgwmNXEBND4B+tpEtk6o=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 137Exbqe070213
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Apr 2021 09:59:37 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 7 Apr
 2021 09:59:37 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 7 Apr 2021 09:59:37 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 137Exbp6056069;
        Wed, 7 Apr 2021 09:59:37 -0500
Date:   Wed, 7 Apr 2021 09:59:37 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am65: Add support for UHS-I modes in
 MMCSD1 subsystem
Message-ID: <20210407145937.prvue66guhdls2fw@immovably>
References: <20210407104303.25950-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210407104303.25950-1-a-govindraju@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:13-20210407, Aswath Govindraju wrote:
> UHS-I speed modes are supported in AM65 S.R. 2.0 SoC[1].
> 
> Add support by removing the no-1-8-v tag and including the voltage
> regulator device tree nodes for power cycling.
> 
> [1] - https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf, section 12.3.6.1.1
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>

> ---
> 
> test logs:
> https://pastebin.ubuntu.com/p/vpYbY9QWh8/
> 
Thanks, but I dont plan on queuing this for 5.13-rc1 (my PR is already
out). but it does trigger an interesting discussion..

>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |  1 -
>  .../arm64/boot/dts/ti/k3-am654-base-board.dts | 33 +++++++++++++++++++
>  2 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index cb340d1b401f..632f32fce4a1 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -301,7 +301,6 @@
>  		ti,otap-del-sel = <0x2>;
>  		ti,trm-icp = <0x8>;
>  		dma-coherent;
> -		no-1-8-v;
>  	};
>  

Jan - this will break your IOT SR1.0 boards, no? with all the SR1.0,
2.0, 2.1 coming along, the plan for TI was to support older revs via
overlays hoping that older boards will eventually get replaced or die
out of lack of use.. but you do have production on 1.0 -> so would you
rather handle this in overlay OR IOT boards dts introduce no-1-8-v
property?


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
