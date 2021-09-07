Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB703402BE9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 17:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345340AbhIGPhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 11:37:01 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33904 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345270AbhIGPhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 11:37:00 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 187FZl26094843;
        Tue, 7 Sep 2021 10:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631028947;
        bh=dIkAlr8MdwBVgAEkJnLIXNbbsnHvLWkb+7zsTqPfSGY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=HTEdrMwMBpJ+5bMIUVCg20nOmrmh1Arm7XUhds3ThCpOs14en8tA/DPDa+ycQhPqD
         vvPxe0ZFuvmzjxF5HvnsjzhbidZsbv5pPPaIuE0JK7Mja3Gq5u66r8I1zFFd3fTjLU
         cQp4b7EJf6klxXukUzStRwe0nNBzYycoj7oH8hdQ=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 187FZllb021672
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Sep 2021 10:35:47 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 7
 Sep 2021 10:35:47 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 7 Sep 2021 10:35:47 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 187FZlkO099332;
        Tue, 7 Sep 2021 10:35:47 -0500
Date:   Tue, 7 Sep 2021 10:35:47 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
Subject: Re: [PATCH 1/3] arm64: dts: ti: iot2050: Flip mmc device ordering on
 Advanced devices
Message-ID: <20210907153547.53cc2zx23rx72kqf@thyself>
References: <cover.1631024536.git.jan.kiszka@siemens.com>
 <8e2e435ef67868cb98382b44c51ddb5c8d045d66.1631024536.git.jan.kiszka@siemens.com>
 <20210907151301.7fqwmc7hmcyhhybv@carve>
 <35e0cadf-526c-6402-fb8e-8cdb8b7a0bfe@siemens.com>
 <20210907152746.fbddtkktvx6hb5ti@cattishly>
 <c63a5ac2-77ca-e54c-183c-b3274a9698db@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c63a5ac2-77ca-e54c-183c-b3274a9698db@siemens.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:30-20210907, Jan Kiszka wrote:
> On 07.09.21 17:27, Nishanth Menon wrote:
> > On 17:20-20210907, Jan Kiszka wrote:
> >> On 07.09.21 17:13, Nishanth Menon wrote:
> >>> On 16:22-20210907, Jan Kiszka wrote:
> >>>> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>>>
> >>>> This ensures that the SD card will remain mmc0 across Basic and Advanced
> >>>> devices, also avoiding surprises for users coming from the downstream
> >>>> kernels.
> >>>>
> >>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >>>> ---
> >>>>  arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts | 5 +++++
> >>>>  1 file changed, 5 insertions(+)
> >>>>
> >>>> diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
> >>>> index ec9617c13cdb..d1d5278e0b94 100644
> >>>> --- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
> >>>> +++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
> >>>> @@ -18,6 +18,11 @@ / {
> >>>>  	compatible = "siemens,iot2050-advanced", "ti,am654";
> >>>>  	model = "SIMATIC IOT2050 Advanced";
> >>>>  
> >>>> +	aliases {
> >>>> +		mmc0 = &sdhci1;
> >>>> +		mmc1 = &sdhci0;
> >>>> +	};
> >>>
> >>>
> >>> Should we do this at SoC level?
> >>>
> >>
> >> Well, I wouldn't mind - but that would also impact your EVMs. For us,
> >> this is fine as we are coming from that ordering above with our
> >> downstream kernel/dts.
> >>
> > 
> > I think it'd probably be a welcome change. overall we've standardized on
> > partuuid.
> > 
> 
> Yeah, it's more about "dd if=emmc.img of=/dev/mmcblk1 - damn, the wrong
> one again."
> 
> Let me know what you prefer, and I'll update my patch.


Lets do it at SoC level. I will follow it up with a patch for other K3
SoCs as well.


Unless someone has a strong opinion on this approach - if so, speak up
with reasons.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
