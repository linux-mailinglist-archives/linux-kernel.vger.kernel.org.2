Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B06F40341B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 08:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347670AbhIHGHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 02:07:25 -0400
Received: from goliath.siemens.de ([192.35.17.28]:49603 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbhIHGHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 02:07:22 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 188661Yp012402
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Sep 2021 08:06:01 +0200
Received: from [167.87.38.78] ([167.87.38.78])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 188660hR002071;
        Wed, 8 Sep 2021 08:06:00 +0200
Subject: Re: [PATCH v2 1/4] arm64: dts: ti: k3-am65: Flip mmc device ordering
To:     Nishanth Menon <nm@ti.com>
Cc:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
References: <cover.1631032682.git.jan.kiszka@siemens.com>
 <0dce149347353556e38a0bdf9a9489ffc9cf66d2.1631032682.git.jan.kiszka@siemens.com>
 <20210908024442.jskmqqye432p4nmt@gatherer>
 <674ccec8-c972-a32b-6722-922bf3c55abd@siemens.com>
 <20210908054844.7ym3flo6f2pryd2x@unplug>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <448c6afe-0451-9927-8b8a-a9567cc03a92@siemens.com>
Date:   Wed, 8 Sep 2021 08:06:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210908054844.7ym3flo6f2pryd2x@unplug>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.09.21 07:48, Nishanth Menon wrote:
> On 07:25-20210908, Jan Kiszka wrote:
>> On 08.09.21 04:44, Nishanth Menon wrote:
>>> On 18:37-20210907, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> This ensures that the SD card will remain mmc0 across devices with and
>>>> without eMMC.
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>>  arch/arm64/boot/dts/ti/k3-am65.dtsi | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/ti/k3-am65.dtsi b/arch/arm64/boot/dts/ti/k3-am65.dtsi
>>>> index a9fc1af03f27..785d931a2dd9 100644
>>>> --- a/arch/arm64/boot/dts/ti/k3-am65.dtsi
>>>> +++ b/arch/arm64/boot/dts/ti/k3-am65.dtsi
>>>> @@ -31,6 +31,8 @@ aliases {
>>>>  		i2c4 = &main_i2c2;
>>>>  		i2c5 = &main_i2c3;
>>>>  		ethernet0 = &cpsw_port1;
>>>> +		mmc0 = &sdhci1;
>>>> +		mmc1 = &sdhci0;
>>>
>>> Jan,
>>>
>>> Responding in context of [1]. Suggestion from Aswath is to do the
>>> following instead at SoC level:
>>> +		mmc0 = &sdhci0;
>>> +		mmc1 = &sdhci1;
>>>
>>
>> Then I will leave this up to you and will go back to v1 of this patch
>> (as we require it the other way around).
> 
> Could you elaborate on the rationale as to why the other way around?
> That would probably provide the reasoning to override the SoC generic
> definitions in the board dts/dtsi as the exception case.
> 

As I wrote in v1: We have deployed devices that use mmcblk0 == SD card
in the field. Those should now be migrated to upstream kernel/DT, but
ideally without glitches in the interface.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
