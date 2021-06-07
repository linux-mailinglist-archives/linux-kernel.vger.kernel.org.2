Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995D439DD94
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 15:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhFGNaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 09:30:35 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57686 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhFGNad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 09:30:33 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 157DSWtf099640;
        Mon, 7 Jun 2021 08:28:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623072512;
        bh=CaZqYj5EZxPTj7DhtzGVu+Dqfzm+eEXQgihsaOxDftE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Mr1tUqpqvzSJ3tj4ZT22EqDYfKFWKXoaH8KfgXHoB9jcu3PLSygfzjXn24Sd1LZfL
         L7pXE6bVKoqw09xf6TzfobAhJ2R1PvGd/zJh1IMi5sWE8ZSAswGxVwSIhoMQ4bJp8j
         mXcAwl+FhNwEPgKnTFc7rf85KzG4ffkKsFhH2eII=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 157DSW57108560
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Jun 2021 08:28:32 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 7 Jun
 2021 08:28:31 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 7 Jun 2021 08:28:31 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 157DSVow115781;
        Mon, 7 Jun 2021 08:28:31 -0500
Date:   Mon, 7 Jun 2021 08:28:31 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Suman Anna <s-anna@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am64-main: Update the location of ATF
 in SRAM and increase its max size
Message-ID: <20210607132831.byouctbdr62hqbpi@sneeze>
References: <20210604164308.16693-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210604164308.16693-1-a-govindraju@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22:13-20210604, Aswath Govindraju wrote:
> Due to a limitation for USB DFU boot mode, SPL load address has to be less
> than  or equal to 0x70001000. So, load address of SPL and ATF have been
> moved to 0x70000000 and 0x701a0000 respectively.
> 
> Also, the maximum size of ATF has been increased to 0x1c000 [1].
> 
> Therefore, update ATF's location and maximum size accordingly in the device
> tree file.
> 
> [1] - https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/commit/?id=2fb5312f61a7de8b7a70e1639199c4f14a10b6f9
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
> 
> Link to corresponding U-Boot series that makes the ATF load address update,
> - https://patchwork.ozlabs.org/project/uboot/list/?series=247265
> 
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index ca59d1f711f8..7ae28992097f 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -14,7 +14,7 @@
>  		ranges = <0x0 0x00 0x70000000 0x200000>;
>  
>  		atf-sram@0 {
	@0 should be @1a0000 ?
> -			reg = <0x0 0x1a000>;
> +			reg = <0x1a0000 0x1c000>;
>  		};
>  	};
>  
> -- 
> 2.17.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
