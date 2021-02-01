Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4400630A413
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 10:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbhBAJKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 04:10:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:48960 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232662AbhBAJKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 04:10:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5E090AE72;
        Mon,  1 Feb 2021 09:09:02 +0000 (UTC)
Subject: Re: [PATCH v2 3/3] arm64: dts: mediatek: mt8183: Add domain supply
 for mfg
From:   Matthias Brugger <matthias.bgg@gmail.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20210129101208.2625249-1-hsinyi@chromium.org>
 <20210129101208.2625249-4-hsinyi@chromium.org>
 <6d24fad2-84ac-1cd1-128b-cc36b115502e@gmail.com>
Message-ID: <26423e96-bbb5-a7c0-576f-5dc41801715f@gmail.com>
Date:   Mon, 1 Feb 2021 10:09:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <6d24fad2-84ac-1cd1-128b-cc36b115502e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2021 13:05, Matthias Brugger wrote:
> 
> 
> On 29/01/2021 11:12, Hsin-Yi Wang wrote:
>> Add domain supply node.
>>
>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>> ---
> 
> Applied to v5.11-next/dts64
> 

I just realiezed that we will also need a patch for the MT8183 EVB. I'll leave
this series in, but please provide a follow-up patch for the dts.

Thanks.
Matthias

> Thanks
> 
>>  arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 4 ++++
>>  arch/arm64/boot/dts/mediatek/mt8183.dtsi       | 2 +-
>>  2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
>> index bf2ad1294dd30..ebd53755d538a 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
>> @@ -709,6 +709,10 @@ cros_ec {
>>  	};
>>  };
>>  
>> +&mfg {
>> +	domain-supply = <&mt6358_vgpu_reg>;
>> +};
>> +
>>  &soc_data {
>>  	status = "okay";
>>  };
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>> index 5b782a4769e7e..bda283fa92452 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>> @@ -360,7 +360,7 @@ power-domain@MT8183_POWER_DOMAIN_MFG_ASYNC {
>>  					#size-cells = <0>;
>>  					#power-domain-cells = <1>;
>>  
>> -					power-domain@MT8183_POWER_DOMAIN_MFG {
>> +					mfg: power-domain@MT8183_POWER_DOMAIN_MFG {
>>  						reg = <MT8183_POWER_DOMAIN_MFG>;
>>  						#address-cells = <1>;
>>  						#size-cells = <0>;
>>

