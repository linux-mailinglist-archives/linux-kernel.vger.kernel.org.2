Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64BE309D91
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 16:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbhAaNwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 08:52:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:58404 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231290AbhAaL2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 06:28:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B7543AC97;
        Sun, 31 Jan 2021 11:25:27 +0000 (UTC)
Subject: Re: [PATCH v1] arm64: dts: mt8192: add nor_flash device node
From:   Matthias Brugger <matthias.bgg@gmail.com>
To:     Bayi Cheng <bayi.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ikjoon Jang <ikjn@chromium.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        srv_heupstream@mediatek.com
References: <1607589283-31225-1-git-send-email-bayi.cheng@mediatek.com>
 <174ae215-38a1-0bb4-ad72-a3f59d35f2ad@gmail.com>
Message-ID: <ca03bea3-dfbf-9ae7-a02b-e01d9f0c01b9@gmail.com>
Date:   Sun, 31 Jan 2021 12:25:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <174ae215-38a1-0bb4-ad72-a3f59d35f2ad@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2021 11:26, Matthias Brugger wrote:
> 
> 
> On 10/12/2020 09:34, Bayi Cheng wrote:
>> From: bayi cheng <bayi.cheng@mediatek.com>
>>
>> add nor_flash device node
>>
>> Signed-off-by: bayi cheng <bayi.cheng@mediatek.com>
>> ---
>>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
> 
> Applied to v5.11-next/dts64

reverted and replaced with v2.

Thanks!

> 
> Thanks
> 
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>> index e12e024..b15b0d3 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>> @@ -379,6 +379,19 @@
>>  			status = "disabled";
>>  		};
>>  
>> +		nor_flash: spi@11234000 {
>> +			compatible = "mediatek,mt8173-nor";
>> +			reg = <0 0x11234000 0 0xe0>;
>> +			interrupts = <GIC_SPI 431 IRQ_TYPE_LEVEL_HIGH 0>;
>> +			clocks = <&clk26m>,
>> +				 <&clk26m>,
>> +				 <&clk26m>;
>> +			clock-names = "spi", "sf", "axi";
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disable";
>> +		};
>> +
>>  		i2c3: i2c3@11cb0000 {
>>  			compatible = "mediatek,mt8192-i2c";
>>  			reg = <0 0x11cb0000 0 0x1000>,
>>

