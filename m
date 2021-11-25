Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B4645D7F9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 11:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354553AbhKYKNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 05:13:00 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:32882 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348074AbhKYKLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 05:11:00 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1APA7eZq025119;
        Thu, 25 Nov 2021 04:07:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637834860;
        bh=dxUYeqKsigxChZuCE55XHKCRDEyPw0OJvF7ruVYvGeU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=prMo48tmRywHvj/lAIkiBsf7kHqbS5V/AKDbuP+Cq5aAaXZpvoPF6FEOElH1NceeM
         squA5ZZyb+uPtlkGysz3s7aH0gv+PC2wjaq2n9LbgEeXxEHDaikOIBO5N9FY/uT5zN
         TYgT9rsPa+MvYuHGrfg7UqP76hXoZcHQ/NxOzvG8=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1APA7eEs066857
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Nov 2021 04:07:40 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 25
 Nov 2021 04:07:40 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 25 Nov 2021 04:07:40 -0600
Received: from [172.24.145.91] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1APA7bKJ049184;
        Thu, 25 Nov 2021 04:07:38 -0600
Subject: Re: [PATCH] ASoC: dt-bindings: davinci-mcasp: convert McASP bindings
 to yaml schema
To:     Rob Herring <robh@kernel.org>
CC:     <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
        <broonie@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>, <kishon@ti.com>
References: <20211122091525.2290-1-j-choudhary@ti.com>
 <1637685269.740254.3442929.nullmailer@robh.at.kernel.org>
From:   Jayesh Choudhary <j-choudhary@ti.com>
Message-ID: <d72bac88-8f56-35cd-a953-270a1ed4d34b@ti.com>
Date:   Thu, 25 Nov 2021 15:37:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1637685269.740254.3442929.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/11/21 10:04 pm, Rob Herring wrote:
> On Mon, 22 Nov 2021 14:45:25 +0530, Jayesh Choudhary wrote:
>> Convert the bindings for McASP controllers for TI SOCs
>> from txt to YAML schema.
>>
>> Adds additional properties 'clocks', 'clock-names', 'power-domains'
>> and '#sound-dai-cells' which were not there in txt file.
>> Adds 'dmas' and 'dma-names' in the example which were not there in
>> txt file.
>> Changes 'interrupts' and 'interrupt-names' from optional to
>> required properties.
>>
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>   .../bindings/sound/davinci-mcasp-audio.txt    |  86 ----------
>>   .../bindings/sound/davinci-mcasp-audio.yaml   | 161 ++++++++++++++++++
>>   2 files changed, 161 insertions(+), 86 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
>>   create mode 100644 Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml
>>
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/1557927
> 
> 
> mcasp@0: clock-names: Additional items are not allowed ('ahclkx', 'ahclkr' were unexpected)
> 	arch/arm/boot/dts/am571x-idk.dt.yaml
> 	arch/arm/boot/dts/am571x-idk.dt.yaml
> 	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
> 	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
> 	arch/arm/boot/dts/am572x-idk.dt.yaml
> 	arch/arm/boot/dts/am572x-idk.dt.yaml
> 	arch/arm/boot/dts/am574x-idk.dt.yaml
> 	arch/arm/boot/dts/am574x-idk.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
> 	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
> 	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
> 	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
> 	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
> 	arch/arm/boot/dts/dra71-evm.dt.yaml
> 	arch/arm/boot/dts/dra71-evm.dt.yaml
> 	arch/arm/boot/dts/dra72-evm.dt.yaml
> 	arch/arm/boot/dts/dra72-evm.dt.yaml
> 	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
> 	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
> 	arch/arm/boot/dts/dra76-evm.dt.yaml
> 	arch/arm/boot/dts/dra76-evm.dt.yaml
> 	arch/arm/boot/dts/dra7-evm.dt.yaml
> 	arch/arm/boot/dts/dra7-evm.dt.yaml
> 
> mcasp@0: clock-names: Additional items are not allowed ('ahclkx' was unexpected)
> 	arch/arm/boot/dts/am571x-idk.dt.yaml
> 	arch/arm/boot/dts/am571x-idk.dt.yaml
> 	arch/arm/boot/dts/am571x-idk.dt.yaml
> 	arch/arm/boot/dts/am571x-idk.dt.yaml
> 	arch/arm/boot/dts/am571x-idk.dt.yaml
> 	arch/arm/boot/dts/am571x-idk.dt.yaml
> 	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
> 	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
> 	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
> 	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
> 	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
> 	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
> 	arch/arm/boot/dts/am572x-idk.dt.yaml
> 	arch/arm/boot/dts/am572x-idk.dt.yaml
> 	arch/arm/boot/dts/am572x-idk.dt.yaml
> 	arch/arm/boot/dts/am572x-idk.dt.yaml
> 	arch/arm/boot/dts/am572x-idk.dt.yaml
> 	arch/arm/boot/dts/am572x-idk.dt.yaml
> 	arch/arm/boot/dts/am574x-idk.dt.yaml
> 	arch/arm/boot/dts/am574x-idk.dt.yaml
> 	arch/arm/boot/dts/am574x-idk.dt.yaml
> 	arch/arm/boot/dts/am574x-idk.dt.yaml
> 	arch/arm/boot/dts/am574x-idk.dt.yaml
> 	arch/arm/boot/dts/am574x-idk.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
> 	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
> 	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
> 	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
> 	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
> 	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
> 	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
> 	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
> 	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
> 	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
> 	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
> 	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
> 	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
> 	arch/arm/boot/dts/dra71-evm.dt.yaml
> 	arch/arm/boot/dts/dra71-evm.dt.yaml
> 	arch/arm/boot/dts/dra71-evm.dt.yaml
> 	arch/arm/boot/dts/dra71-evm.dt.yaml
> 	arch/arm/boot/dts/dra71-evm.dt.yaml
> 	arch/arm/boot/dts/dra71-evm.dt.yaml
> 	arch/arm/boot/dts/dra72-evm.dt.yaml
> 	arch/arm/boot/dts/dra72-evm.dt.yaml
> 	arch/arm/boot/dts/dra72-evm.dt.yaml
> 	arch/arm/boot/dts/dra72-evm.dt.yaml
> 	arch/arm/boot/dts/dra72-evm.dt.yaml
> 	arch/arm/boot/dts/dra72-evm.dt.yaml
> 	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
> 	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
> 	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
> 	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
> 	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
> 	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
> 	arch/arm/boot/dts/dra76-evm.dt.yaml
> 	arch/arm/boot/dts/dra76-evm.dt.yaml
> 	arch/arm/boot/dts/dra76-evm.dt.yaml
> 	arch/arm/boot/dts/dra76-evm.dt.yaml
> 	arch/arm/boot/dts/dra76-evm.dt.yaml
> 	arch/arm/boot/dts/dra76-evm.dt.yaml
> 	arch/arm/boot/dts/dra7-evm.dt.yaml
> 	arch/arm/boot/dts/dra7-evm.dt.yaml
> 	arch/arm/boot/dts/dra7-evm.dt.yaml
> 	arch/arm/boot/dts/dra7-evm.dt.yaml
> 	arch/arm/boot/dts/dra7-evm.dt.yaml
> 	arch/arm/boot/dts/dra7-evm.dt.yaml
> 
> mcasp@0: clock-names: ['fck', 'ahclkx', 'ahclkr'] is too long
> 	arch/arm/boot/dts/am571x-idk.dt.yaml
> 	arch/arm/boot/dts/am571x-idk.dt.yaml
> 	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
> 	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
> 	arch/arm/boot/dts/am572x-idk.dt.yaml
> 	arch/arm/boot/dts/am572x-idk.dt.yaml
> 	arch/arm/boot/dts/am574x-idk.dt.yaml
> 	arch/arm/boot/dts/am574x-idk.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
> 	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
> 	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
> 	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
> 	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
> 	arch/arm/boot/dts/dra71-evm.dt.yaml
> 	arch/arm/boot/dts/dra71-evm.dt.yaml
> 	arch/arm/boot/dts/dra72-evm.dt.yaml
> 	arch/arm/boot/dts/dra72-evm.dt.yaml
> 	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
> 	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
> 	arch/arm/boot/dts/dra76-evm.dt.yaml
> 	arch/arm/boot/dts/dra76-evm.dt.yaml
> 	arch/arm/boot/dts/dra7-evm.dt.yaml
> 	arch/arm/boot/dts/dra7-evm.dt.yaml
> 
> mcasp@0: clock-names: ['fck', 'ahclkx'] is too long
> 	arch/arm/boot/dts/am571x-idk.dt.yaml
> 	arch/arm/boot/dts/am571x-idk.dt.yaml
> 	arch/arm/boot/dts/am571x-idk.dt.yaml
> 	arch/arm/boot/dts/am571x-idk.dt.yaml
> 	arch/arm/boot/dts/am571x-idk.dt.yaml
> 	arch/arm/boot/dts/am571x-idk.dt.yaml
> 	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
> 	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
> 	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
> 	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
> 	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
> 	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
> 	arch/arm/boot/dts/am572x-idk.dt.yaml
> 	arch/arm/boot/dts/am572x-idk.dt.yaml
> 	arch/arm/boot/dts/am572x-idk.dt.yaml
> 	arch/arm/boot/dts/am572x-idk.dt.yaml
> 	arch/arm/boot/dts/am572x-idk.dt.yaml
> 	arch/arm/boot/dts/am572x-idk.dt.yaml
> 	arch/arm/boot/dts/am574x-idk.dt.yaml
> 	arch/arm/boot/dts/am574x-idk.dt.yaml
> 	arch/arm/boot/dts/am574x-idk.dt.yaml
> 	arch/arm/boot/dts/am574x-idk.dt.yaml
> 	arch/arm/boot/dts/am574x-idk.dt.yaml
> 	arch/arm/boot/dts/am574x-idk.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
> 	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
> 	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
> 	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
> 	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
> 	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
> 	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
> 	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
> 	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
> 	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
> 	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
> 	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
> 	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
> 	arch/arm/boot/dts/dra71-evm.dt.yaml
> 	arch/arm/boot/dts/dra71-evm.dt.yaml
> 	arch/arm/boot/dts/dra71-evm.dt.yaml
> 	arch/arm/boot/dts/dra71-evm.dt.yaml
> 	arch/arm/boot/dts/dra71-evm.dt.yaml
> 	arch/arm/boot/dts/dra71-evm.dt.yaml
> 	arch/arm/boot/dts/dra72-evm.dt.yaml
> 	arch/arm/boot/dts/dra72-evm.dt.yaml
> 	arch/arm/boot/dts/dra72-evm.dt.yaml
> 	arch/arm/boot/dts/dra72-evm.dt.yaml
> 	arch/arm/boot/dts/dra72-evm.dt.yaml
> 	arch/arm/boot/dts/dra72-evm.dt.yaml
> 	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
> 	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
> 	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
> 	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
> 	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
> 	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
> 	arch/arm/boot/dts/dra76-evm.dt.yaml
> 	arch/arm/boot/dts/dra76-evm.dt.yaml
> 	arch/arm/boot/dts/dra76-evm.dt.yaml
> 	arch/arm/boot/dts/dra76-evm.dt.yaml
> 	arch/arm/boot/dts/dra76-evm.dt.yaml
> 	arch/arm/boot/dts/dra76-evm.dt.yaml
> 	arch/arm/boot/dts/dra7-evm.dt.yaml
> 	arch/arm/boot/dts/dra7-evm.dt.yaml
> 	arch/arm/boot/dts/dra7-evm.dt.yaml
> 	arch/arm/boot/dts/dra7-evm.dt.yaml
> 	arch/arm/boot/dts/dra7-evm.dt.yaml
> 	arch/arm/boot/dts/dra7-evm.dt.yaml
> 
> mcasp@0: clocks: [[155, 0, 0], [155, 0, 24], [155, 0, 28]] is too long
> 	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
> 
> mcasp@0: clocks: [[156, 0, 0], [156, 0, 24], [156, 0, 28]] is too long
> 	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
> 	arch/arm/boot/dts/dra71-evm.dt.yaml
> 
> mcasp@0: clocks: [[157, 0, 0], [157, 0, 24], [157, 0, 28]] is too long
> 	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
> 	arch/arm/boot/dts/dra72-evm.dt.yaml
> 	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
> 	arch/arm/boot/dts/dra76-evm.dt.yaml
> 	arch/arm/boot/dts/dra7-evm.dt.yaml
> 
> mcasp@0: clocks: [[158, 0, 0], [158, 0, 24], [158, 0, 28]] is too long
> 	arch/arm/boot/dts/am571x-idk.dt.yaml
> 	arch/arm/boot/dts/am572x-idk.dt.yaml
> 	arch/arm/boot/dts/am574x-idk.dt.yaml
> 	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
> 
> mcasp@0: clocks: [[91, 340, 0], [156, 0, 24], [91, 340, 28]] is too long
> 	arch/arm/boot/dts/dra71-evm.dt.yaml
> 
> mcasp@0: clocks: [[91, 348, 0], [91, 348, 24]] is too long
> 	arch/arm/boot/dts/dra71-evm.dt.yaml
> 
> mcasp@0: clocks: [[91, 364, 0], [91, 364, 24]] is too long
> 	arch/arm/boot/dts/dra71-evm.dt.yaml
> 
> mcasp@0: clocks: [[91, 388, 0], [91, 388, 24]] is too long
> 	arch/arm/boot/dts/dra71-evm.dt.yaml
> 
> mcasp@0: clocks: [[91, 396, 0], [91, 396, 24]] is too long
> 	arch/arm/boot/dts/dra71-evm.dt.yaml
> 
> mcasp@0: clocks: [[91, 504, 0], [91, 504, 24]] is too long
> 	arch/arm/boot/dts/dra71-evm.dt.yaml
> 
> mcasp@0: clocks: [[91, 508, 0], [91, 508, 24]] is too long
> 	arch/arm/boot/dts/dra71-evm.dt.yaml
> 
> mcasp@0: clocks: [[92, 340, 0], [155, 0, 24], [92, 340, 28]] is too long
> 	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
> 
> mcasp@0: clocks: [[92, 340, 0], [156, 0, 24], [92, 340, 28]] is too long
> 	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
> 
> mcasp@0: clocks: [[92, 340, 0], [157, 0, 24], [92, 340, 28]] is too long
> 	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
> 	arch/arm/boot/dts/dra72-evm.dt.yaml
> 	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
> 	arch/arm/boot/dts/dra7-evm.dt.yaml
> 
> mcasp@0: clocks: [[92, 340, 0], [158, 0, 24], [92, 340, 28]] is too long
> 	arch/arm/boot/dts/am571x-idk.dt.yaml
> 	arch/arm/boot/dts/am572x-idk.dt.yaml
> 	arch/arm/boot/dts/am574x-idk.dt.yaml
> 	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
> 
> mcasp@0: clocks: [[92, 348, 0], [92, 348, 24]] is too long
> 	arch/arm/boot/dts/am571x-idk.dt.yaml
> 	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
> 	arch/arm/boot/dts/am572x-idk.dt.yaml
> 	arch/arm/boot/dts/am574x-idk.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
> 	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
> 	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
> 	arch/arm/boot/dts/dra72-evm.dt.yaml
> 	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
> 	arch/arm/boot/dts/dra7-evm.dt.yaml
> 
> mcasp@0: clocks: [[92, 364, 0], [92, 364, 24]] is too long
> 	arch/arm/boot/dts/am571x-idk.dt.yaml
> 	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
> 	arch/arm/boot/dts/am572x-idk.dt.yaml
> 	arch/arm/boot/dts/am574x-idk.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
> 	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
> 	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
> 	arch/arm/boot/dts/dra72-evm.dt.yaml
> 	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
> 	arch/arm/boot/dts/dra7-evm.dt.yaml
> 
> mcasp@0: clocks: [[92, 388, 0], [92, 388, 24]] is too long
> 	arch/arm/boot/dts/am571x-idk.dt.yaml
> 	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
> 	arch/arm/boot/dts/am572x-idk.dt.yaml
> 	arch/arm/boot/dts/am574x-idk.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
> 	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
> 	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
> 	arch/arm/boot/dts/dra72-evm.dt.yaml
> 	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
> 	arch/arm/boot/dts/dra7-evm.dt.yaml
> 
> mcasp@0: clocks: [[92, 396, 0], [92, 396, 24]] is too long
> 	arch/arm/boot/dts/am571x-idk.dt.yaml
> 	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
> 	arch/arm/boot/dts/am572x-idk.dt.yaml
> 	arch/arm/boot/dts/am574x-idk.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
> 	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
> 	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
> 	arch/arm/boot/dts/dra72-evm.dt.yaml
> 	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
> 	arch/arm/boot/dts/dra7-evm.dt.yaml
> 
> mcasp@0: clocks: [[92, 504, 0], [92, 504, 24]] is too long
> 	arch/arm/boot/dts/am571x-idk.dt.yaml
> 	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
> 	arch/arm/boot/dts/am572x-idk.dt.yaml
> 	arch/arm/boot/dts/am574x-idk.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
> 	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
> 	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
> 	arch/arm/boot/dts/dra72-evm.dt.yaml
> 	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
> 	arch/arm/boot/dts/dra7-evm.dt.yaml
> 
> mcasp@0: clocks: [[92, 508, 0], [92, 508, 24]] is too long
> 	arch/arm/boot/dts/am571x-idk.dt.yaml
> 	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
> 	arch/arm/boot/dts/am572x-idk.dt.yaml
> 	arch/arm/boot/dts/am574x-idk.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
> 	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
> 	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
> 	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
> 	arch/arm/boot/dts/dra72-evm.dt.yaml
> 	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
> 	arch/arm/boot/dts/dra7-evm.dt.yaml
> 
> mcasp@0: clocks: [[94, 340, 0], [157, 0, 24], [94, 340, 28]] is too long
> 	arch/arm/boot/dts/dra76-evm.dt.yaml
> 
> mcasp@0: clocks: [[94, 348, 0], [94, 348, 24]] is too long
> 	arch/arm/boot/dts/dra76-evm.dt.yaml
> 
> mcasp@0: clocks: [[94, 364, 0], [94, 364, 24]] is too long
> 	arch/arm/boot/dts/dra76-evm.dt.yaml
> 
> mcasp@0: clocks: [[94, 388, 0], [94, 388, 24]] is too long
> 	arch/arm/boot/dts/dra76-evm.dt.yaml
> 
> mcasp@0: clocks: [[94, 396, 0], [94, 396, 24]] is too long
> 	arch/arm/boot/dts/dra76-evm.dt.yaml
> 
> mcasp@0: clocks: [[94, 504, 0], [94, 504, 24]] is too long
> 	arch/arm/boot/dts/dra76-evm.dt.yaml
> 
> mcasp@0: clocks: [[94, 508, 0], [94, 508, 24]] is too long
> 	arch/arm/boot/dts/dra76-evm.dt.yaml
> 
> mcasp@0: dma-names: ['tx'] is too short
> 	arch/arm/boot/dts/omap4-droid4-xt894.dt.yaml
> 	arch/arm/boot/dts/omap4-droid-bionic-xt875.dt.yaml
> 	arch/arm/boot/dts/omap4-duovero-parlor.dt.yaml
> 	arch/arm/boot/dts/omap4-kc1.dt.yaml
> 	arch/arm/boot/dts/omap4-panda-a4.dt.yaml
> 	arch/arm/boot/dts/omap4-panda.dt.yaml
> 	arch/arm/boot/dts/omap4-panda-es.dt.yaml
> 	arch/arm/boot/dts/omap4-sdp.dt.yaml
> 	arch/arm/boot/dts/omap4-sdp-es23plus.dt.yaml
> 	arch/arm/boot/dts/omap4-var-dvk-om44.dt.yaml
> 	arch/arm/boot/dts/omap4-var-stk-om44.dt.yaml
> 
> mcasp@0: dmas: [[119, 8]] is too short
> 	arch/arm/boot/dts/omap4-droid4-xt894.dt.yaml
> 	arch/arm/boot/dts/omap4-droid-bionic-xt875.dt.yaml
> 	arch/arm/boot/dts/omap4-kc1.dt.yaml
> 
> mcasp@0: dmas: [[124, 8]] is too short
> 	arch/arm/boot/dts/omap4-duovero-parlor.dt.yaml
> 
> mcasp@0: dmas: [[127, 8]] is too short
> 	arch/arm/boot/dts/omap4-panda-a4.dt.yaml
> 	arch/arm/boot/dts/omap4-panda.dt.yaml
> 	arch/arm/boot/dts/omap4-sdp.dt.yaml
> 	arch/arm/boot/dts/omap4-sdp-es23plus.dt.yaml
> 
> mcasp@0: dmas: [[130, 8]] is too short
> 	arch/arm/boot/dts/omap4-var-dvk-om44.dt.yaml
> 	arch/arm/boot/dts/omap4-var-stk-om44.dt.yaml
> 
> mcasp@0: dmas: [[132, 8]] is too short
> 	arch/arm/boot/dts/omap4-panda-es.dt.yaml
> 
> mcasp@0: interrupt-names: ['tx'] is too short
> 	arch/arm/boot/dts/omap4-droid4-xt894.dt.yaml
> 	arch/arm/boot/dts/omap4-droid-bionic-xt875.dt.yaml
> 	arch/arm/boot/dts/omap4-duovero-parlor.dt.yaml
> 	arch/arm/boot/dts/omap4-kc1.dt.yaml
> 	arch/arm/boot/dts/omap4-panda-a4.dt.yaml
> 	arch/arm/boot/dts/omap4-panda.dt.yaml
> 	arch/arm/boot/dts/omap4-panda-es.dt.yaml
> 	arch/arm/boot/dts/omap4-sdp.dt.yaml
> 	arch/arm/boot/dts/omap4-sdp-es23plus.dt.yaml
> 	arch/arm/boot/dts/omap4-var-dvk-om44.dt.yaml
> 	arch/arm/boot/dts/omap4-var-stk-om44.dt.yaml
> 
> mcasp@0: interrupts: [[0, 109, 4]] is too short
> 	arch/arm/boot/dts/omap4-droid4-xt894.dt.yaml
> 	arch/arm/boot/dts/omap4-droid-bionic-xt875.dt.yaml
> 	arch/arm/boot/dts/omap4-duovero-parlor.dt.yaml
> 	arch/arm/boot/dts/omap4-kc1.dt.yaml
> 	arch/arm/boot/dts/omap4-panda-a4.dt.yaml
> 	arch/arm/boot/dts/omap4-panda.dt.yaml
> 	arch/arm/boot/dts/omap4-panda-es.dt.yaml
> 	arch/arm/boot/dts/omap4-sdp.dt.yaml
> 	arch/arm/boot/dts/omap4-sdp-es23plus.dt.yaml
> 	arch/arm/boot/dts/omap4-var-dvk-om44.dt.yaml
> 	arch/arm/boot/dts/omap4-var-stk-om44.dt.yaml
> 
> mcasp@0: 'num-serializer' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	arch/arm/boot/dts/am335x-cm-t335.dt.yaml
> 	arch/arm/boot/dts/am335x-sbc-t335.dt.yaml
> 
> mcasp@0: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	arch/arm/boot/dts/am335x-sl50.dt.yaml
> 
> mcasp@0: 'rt-num-evt' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	arch/arm/boot/dts/am335x-wega-rdk.dt.yaml
> 
This particular error looks like a typo error in the dts file. I will 
send a seperate patch to fix it.

> mcasp@100000: interrupt-names:0: 'tx' was expected
> 	arch/arm/boot/dts/da850-enbw-cmc.dt.yaml
> 	arch/arm/boot/dts/da850-evm.dt.yaml
> 	arch/arm/boot/dts/da850-lcdk.dt.yaml
> 	arch/arm/boot/dts/da850-lego-ev3.dt.yaml
> 
> mcasp@100000: interrupt-names: ['common'] is too short
> 	arch/arm/boot/dts/da850-enbw-cmc.dt.yaml
> 	arch/arm/boot/dts/da850-evm.dt.yaml
> 	arch/arm/boot/dts/da850-lcdk.dt.yaml
> 	arch/arm/boot/dts/da850-lego-ev3.dt.yaml
> 
> mcasp@100000: interrupts: [[54]] is too short
> 	arch/arm/boot/dts/da850-enbw-cmc.dt.yaml
> 	arch/arm/boot/dts/da850-evm.dt.yaml
> 	arch/arm/boot/dts/da850-lcdk.dt.yaml
> 	arch/arm/boot/dts/da850-lego-ev3.dt.yaml
> v2 patch will take care of rest of the arm SoC errors as well.

> mcasp@2b00000: 'op-mode' is a required property
> 	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dt.yaml
> 
> mcasp@2b00000: 'serial-dir' is a required property
> 	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dt.yaml
> 
> mcasp@2b00000: 'tdm-slots' is a required property
> 	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dt.yaml
> 
> mcasp@2b10000: 'op-mode' is a required property
> 	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dt.yaml
> 
> mcasp@2b10000: 'serial-dir' is a required property
> 	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dt.yaml
> 
> mcasp@2b10000: 'tdm-slots' is a required property
> 	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dt.yaml
> 
> mcasp@2b20000: 'op-mode' is a required property
> 	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dt.yaml
> 
> mcasp@2b20000: 'serial-dir' is a required property
> 	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dt.yaml
> 
> mcasp@2b20000: 'tdm-slots' is a required property
> 	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dt.yaml
> 
For these arm64 SoC errors, a patch has already been sent that disables 
the nodes in the dtsi file since some required properties are added via 
overlay.

Patch link: 
https://lore.kernel.org/all/20211117053806.10095-1-j-choudhary@ti.com/

Warm Regards,
Jayesh
