Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6C1402D39
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 18:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345223AbhIGQyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 12:54:31 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36224 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344220AbhIGQya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 12:54:30 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 187GrGH0098537;
        Tue, 7 Sep 2021 11:53:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631033596;
        bh=c5t+8bDLCAqYNBhiSbZDQdAS+c79g+DgQp4d1qxOjwM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=EqvAPmZu1gNUICFeILIGJ20ww4rk9I6Zy7SQo8Z0U2eY6jCviW6ZXkG2GGuFwHeSC
         vswr0fPvHH89QUp6vpZZJu+1NZ22wN2iKXNU6UJnMf5mkvmq97JWeLM8ABiALkoyA+
         0u/grK3F/OcqrP7GmK8f9cpDYihnk9i68F6Qi6W8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 187GrGVg011847
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Sep 2021 11:53:16 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 7
 Sep 2021 11:53:16 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 7 Sep 2021 11:53:16 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 187GrGAA119325;
        Tue, 7 Sep 2021 11:53:16 -0500
Date:   Tue, 7 Sep 2021 11:53:16 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Jan Kiszka <jan.kiszka@siemens.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
Subject: Re: [PATCH 1/3] arm64: dts: ti: iot2050: Flip mmc device ordering on
 Advanced devices
Message-ID: <20210907165316.4s3jrouctcpc3kvo@pessimism>
References: <cover.1631024536.git.jan.kiszka@siemens.com>
 <8e2e435ef67868cb98382b44c51ddb5c8d045d66.1631024536.git.jan.kiszka@siemens.com>
 <20210907151301.7fqwmc7hmcyhhybv@carve>
 <35e0cadf-526c-6402-fb8e-8cdb8b7a0bfe@siemens.com>
 <20210907152746.fbddtkktvx6hb5ti@cattishly>
 <c63a5ac2-77ca-e54c-183c-b3274a9698db@siemens.com>
 <20210907153547.53cc2zx23rx72kqf@thyself>
 <482dddc1-b1f8-15db-a0c5-0d6def5d859f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <482dddc1-b1f8-15db-a0c5-0d6def5d859f@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22:17-20210907, Aswath Govindraju wrote:
> Hi Nishanth,
> 
> On 07/09/21 9:05 pm, Nishanth Menon wrote:
> > On 17:30-20210907, Jan Kiszka wrote:
> >> On 07.09.21 17:27, Nishanth Menon wrote:
> >>> On 17:20-20210907, Jan Kiszka wrote:
> >>>> On 07.09.21 17:13, Nishanth Menon wrote:
> >>>>> On 16:22-20210907, Jan Kiszka wrote:
> >>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>>>>>
> >>>>>> This ensures that the SD card will remain mmc0 across Basic and Advanced
> >>>>>> devices, also avoiding surprises for users coming from the downstream
> >>>>>> kernels.
> >>>>>>
> >>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >>>>>> ---
> >>>>>>  arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts | 5 +++++
> >>>>>>  1 file changed, 5 insertions(+)
> >>>>>>
> >>>>>> diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
> >>>>>> index ec9617c13cdb..d1d5278e0b94 100644
> >>>>>> --- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
> >>>>>> +++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
> >>>>>> @@ -18,6 +18,11 @@ / {
> >>>>>>  	compatible = "siemens,iot2050-advanced", "ti,am654";
> >>>>>>  	model = "SIMATIC IOT2050 Advanced";
> >>>>>>  
> >>>>>> +	aliases {
> >>>>>> +		mmc0 = &sdhci1;
> >>>>>> +		mmc1 = &sdhci0;
> >>>>>> +	};
> >>>>>
> >>>>>
> >>>>> Should we do this at SoC level?
> >>>>>
> >>>>
> >>>> Well, I wouldn't mind - but that would also impact your EVMs. For us,
> >>>> this is fine as we are coming from that ordering above with our
> >>>> downstream kernel/dts.
> >>>>
> >>>
> >>> I think it'd probably be a welcome change. overall we've standardized on
> >>> partuuid.
> >>>
> >>
> >> Yeah, it's more about "dd if=emmc.img of=/dev/mmcblk1 - damn, the wrong
> >> one again."
> >>
> >> Let me know what you prefer, and I'll update my patch.
> > 
> > 
> > Lets do it at SoC level. I will follow it up with a patch for other K3
> > SoCs as well.
> > 
> > 
> > Unless someone has a strong opinion on this approach - if so, speak up
> > with reasons.
> > 
> 
> Making this change in SoC level for all K3 devices would force changes
> to be made in U-Boot too, for consistency. In U-Boot, a major change
> would be required in the environment variables to support this. As I
> don't see any functional advantage by making this change, I feel that
> this change would make things more confusing for users already using the
> K3 devices. At present, the ordering is consistent across all the K3
> devices, I feel that keeping it the same way would be better.
> 
> As for making changes only on IoT boards, if it is okay to have the
> ordering changed between U-Boot and kernel, I don't see any problem
> making this change in kernel alone.


arch/arm64/boot/dts/ti/k3-am65.dtsi has no ordering. u-boot is supposed
to copy from kernel the dtsi files as is. I think having mmc aliases in
kernel is a good thing as we do regard kernel as the canonical dts
source.

If you are suggesting we flip things so that mmc0 is sdhci0 and mmc1 is
sdhci1 -  that might be a valid suggestion - Jan, do you see a problem
in having consistency here (flip the aliases)?


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
