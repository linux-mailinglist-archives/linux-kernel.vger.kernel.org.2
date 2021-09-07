Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64C7402BC6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 17:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345263AbhIGP3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 11:29:02 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59918 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345088AbhIGP3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 11:29:01 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 187FRlfn090525;
        Tue, 7 Sep 2021 10:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631028467;
        bh=R6Fwfw4yCoT2K+/rUzObEsKmUCONj1UZWuAEKdsff4g=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=lYDGWzolleSgSQJHDNMH99Diz7jA83gZOLdqlkD0gSnHKR6zMZDd3jffls82iOCYC
         i1YupKMEvizBrdmSWzX3rL55Ld5PdFtk37ZjsZ1NXtFmbDzNYO6WSA7LZEcWNQxzmp
         Ic86b7iH2XqbCwhYkBNfixZgveW0AapFx85AgBWs=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 187FRlui040440
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Sep 2021 10:27:47 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 7
 Sep 2021 10:27:47 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 7 Sep 2021 10:27:47 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 187FRkXl015106;
        Tue, 7 Sep 2021 10:27:47 -0500
Date:   Tue, 7 Sep 2021 10:27:46 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
Subject: Re: [PATCH 1/3] arm64: dts: ti: iot2050: Flip mmc device ordering on
 Advanced devices
Message-ID: <20210907152746.fbddtkktvx6hb5ti@cattishly>
References: <cover.1631024536.git.jan.kiszka@siemens.com>
 <8e2e435ef67868cb98382b44c51ddb5c8d045d66.1631024536.git.jan.kiszka@siemens.com>
 <20210907151301.7fqwmc7hmcyhhybv@carve>
 <35e0cadf-526c-6402-fb8e-8cdb8b7a0bfe@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <35e0cadf-526c-6402-fb8e-8cdb8b7a0bfe@siemens.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:20-20210907, Jan Kiszka wrote:
> On 07.09.21 17:13, Nishanth Menon wrote:
> > On 16:22-20210907, Jan Kiszka wrote:
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> This ensures that the SD card will remain mmc0 across Basic and Advanced
> >> devices, also avoiding surprises for users coming from the downstream
> >> kernels.
> >>
> >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >> ---
> >>  arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
> >> index ec9617c13cdb..d1d5278e0b94 100644
> >> --- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
> >> +++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
> >> @@ -18,6 +18,11 @@ / {
> >>  	compatible = "siemens,iot2050-advanced", "ti,am654";
> >>  	model = "SIMATIC IOT2050 Advanced";
> >>  
> >> +	aliases {
> >> +		mmc0 = &sdhci1;
> >> +		mmc1 = &sdhci0;
> >> +	};
> > 
> > 
> > Should we do this at SoC level?
> > 
> 
> Well, I wouldn't mind - but that would also impact your EVMs. For us,
> this is fine as we are coming from that ordering above with our
> downstream kernel/dts.
> 

I think it'd probably be a welcome change. overall we've standardized on
partuuid.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
