Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEE73A8D56
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 02:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbhFPAWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 20:22:15 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38524 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhFPAWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 20:22:13 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15G0K5ne074883;
        Tue, 15 Jun 2021 19:20:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623802806;
        bh=713m7ox17RpKP+zQNq94oDjsDSR0p1WGE2XZKVpjeZk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=IW/qZTBqL73SN2piaPHeg1gcLzjWYtt+WdiuYWPiou3g/xnEwgnKkYjsfHskdAk8D
         X/cXhkyyO/iXhnP6pZSxc9ztfagEY8eYrVDcnklfcA86ANUlrxZc7aug/CV/ldd5lv
         a17MLVe0iYqi2wQPJHzu3++7PivCEXOqjgVNjr8o=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15G0K5U8063611
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Jun 2021 19:20:05 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 15
 Jun 2021 19:20:05 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 15 Jun 2021 19:20:05 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15G0K5sX073612;
        Tue, 15 Jun 2021 19:20:05 -0500
Date:   Tue, 15 Jun 2021 19:20:05 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, Suman Anna <s-anna@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] arm64: dts: ti: k3-am64-main: Update the location
 of TF-A
Message-ID: <20210616002005.c5vxes67pltuxiry@liking>
References: <20210615174325.22853-1-a-govindraju@ti.com>
 <20210615174325.22853-4-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210615174325.22853-4-a-govindraju@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23:13-20210615, Aswath Govindraju wrote:
> Due to a limitation for USB DFU boot mode, SPL load address has to be less
> than  or equal to 0x70001000. So, load address of SPL and TF-A have been
> moved to 0x70000000 and 0x701c4000 respectively.
> 
> Therefore, update TF-A's location in the device tree node.

One additional topic to add is the dependency on bootloader update for
this as well. I know things are chicken or egg kind of problem, but
will be good to mention requires newer version than 2021.xx version of
u-boot as this is an "breaking" change. And, if we block both regions
off for bootloader compatibility, that is not feasible given the
limited SRAM available as well.

> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index 6a883f4349cb..7ab3652dfdfb 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -24,8 +24,8 @@
>  		#size-cells = <1>;
>  		ranges = <0x0 0x00 0x70000000 0x200000>;
>  
> -		tfa-sram@0 {
> -			reg = <0x0 0x1c000>;
> +		tfa-sram@1c4000 {
> +			reg = <0x1c4000 0x1c000>;
>  		};
>  
>  		dmsc-sram@1e0000 {
> -- 
> 2.17.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
