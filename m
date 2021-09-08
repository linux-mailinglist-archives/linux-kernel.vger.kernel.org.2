Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0704033C0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 07:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245160AbhIHF0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 01:26:35 -0400
Received: from david.siemens.de ([192.35.17.14]:57386 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234923AbhIHF0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 01:26:30 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 1885PAmb012724
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Sep 2021 07:25:11 +0200
Received: from [167.87.38.78] ([167.87.38.78])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1885P9wE009143;
        Wed, 8 Sep 2021 07:25:10 +0200
Subject: Re: [PATCH v2 1/4] arm64: dts: ti: k3-am65: Flip mmc device ordering
To:     Nishanth Menon <nm@ti.com>
Cc:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
References: <cover.1631032682.git.jan.kiszka@siemens.com>
 <0dce149347353556e38a0bdf9a9489ffc9cf66d2.1631032682.git.jan.kiszka@siemens.com>
 <20210908024442.jskmqqye432p4nmt@gatherer>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <674ccec8-c972-a32b-6722-922bf3c55abd@siemens.com>
Date:   Wed, 8 Sep 2021 07:25:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210908024442.jskmqqye432p4nmt@gatherer>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.09.21 04:44, Nishanth Menon wrote:
> On 18:37-20210907, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This ensures that the SD card will remain mmc0 across devices with and
>> without eMMC.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  arch/arm64/boot/dts/ti/k3-am65.dtsi | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am65.dtsi b/arch/arm64/boot/dts/ti/k3-am65.dtsi
>> index a9fc1af03f27..785d931a2dd9 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am65.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am65.dtsi
>> @@ -31,6 +31,8 @@ aliases {
>>  		i2c4 = &main_i2c2;
>>  		i2c5 = &main_i2c3;
>>  		ethernet0 = &cpsw_port1;
>> +		mmc0 = &sdhci1;
>> +		mmc1 = &sdhci0;
> 
> Jan,
> 
> Responding in context of [1]. Suggestion from Aswath is to do the
> following instead at SoC level:
> +		mmc0 = &sdhci0;
> +		mmc1 = &sdhci1;
> 

Then I will leave this up to you and will go back to v1 of this patch
(as we require it the other way around).

Jan

>>  	};
>>  
>>  	chosen { };
>> -- 
>> 2.31.1
>>
> [1] https://lore.kernel.org/all/4cb6e76e-479f-5e06-778a-4788be53afb9@siemens.com/
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
