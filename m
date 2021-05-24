Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6074F38E7B4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 15:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbhEXNeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 09:34:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:45482 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232536AbhEXNeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 09:34:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1621863162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fngeBbRzIW6nlJ53AZGy5yxd7oCB3Cr2B2bVvOTUNdc=;
        b=XTyEwbIZBGXyQcJK6Alb1Wiun1N6b43M0EZsGKCU22bwWVwRBNktzmdkcWvTz3ad/p9PoK
        M9Nthn86LE95WVBDq6aSSOCSv0JnCjegq9IlOiyBGSZZrcQFRJFr+PWdqPYEfxVTRk0wc1
        KvV6oOwsR56UpbcrEkYoI9Gy/ceEriI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1621863162;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fngeBbRzIW6nlJ53AZGy5yxd7oCB3Cr2B2bVvOTUNdc=;
        b=PhvcpzL9yDwab/l7WMWp5NGSwCfEkMCdsnH49mgihRYhe9cK6xFP41ULq8nDq1f4UMxcLM
        Mw4JT63AGD1u4uAQ==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5E791AB6D;
        Mon, 24 May 2021 13:32:42 +0000 (UTC)
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org
References: <20210516230551.12469-1-afaerber@suse.de>
 <20210516230551.12469-4-afaerber@suse.de> <87h7j1vhq7.wl-maz@kernel.org>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Subject: Re: [PATCH 3/9] arm64: dts: rockchip: Prepare Rockchip RK1808
Message-ID: <7ef183f1-00f8-13c4-1fd3-eae9e0bbf74c@suse.de>
Date:   Mon, 24 May 2021 15:32:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <87h7j1vhq7.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.05.21 11:21, Marc Zyngier wrote:
> On Mon, 17 May 2021 00:05:45 +0100,
> Andreas Färber <afaerber@suse.de> wrote:
>>
>> Add an initial Device Tree for Rockchip RK1808 SoC.
>> Based on shipping TB-RK1808M0 DTB.
>>
>> Signed-off-by: Andreas Färber <afaerber@suse.de>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk1808.dtsi | 203 +++++++++++++++++++++++
>>  1 file changed, 203 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/rockchip/rk1808.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk1808.dtsi b/arch/arm64/boot/dts/rockchip/rk1808.dtsi
>> new file mode 100644
>> index 000000000000..af2b51afda7d
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/rockchip/rk1808.dtsi
[...]
>> +		gic: interrupt-controller@ff100000 {
>> +			compatible = "arm,gic-v3";
>> +			reg = <0xff100000 0x10000>, /* GICD */
>> +			      <0xff140000 0xc0000>, /* GICR */
> 
> This is obviously wrong. You have two CPUs, and yet describe a range
> that spans 6. I guess this is a copy paste from rk3399 again?

Not on my part at least. As indicated, these numbers are what ships in
the DTB on the RK1808 card, as per dtc -I dtb -O dts. Could be a mistake
by Rockchip, of course.

Are you suggesting 0xc0000/6*2 = 0x40000 for two CPUs here?
Works as bad as before - investigation still ongoing with latest next.

As for "obviously": The GICv3 YAML binding has no description for me to
validate those numbers: "GIC Redistributors (GICR), one range per
redistributor region" - says nothing about correlation to number of CPUs
or size per CPU, and the examples are not explaining either: 0x200000
has no number of CPUs associated, and by my calculation 0x800000 for 32
CPUs results in 0x40000 per CPU; but then again the examples also have
GICC etc. at diverging 0x2000 size.

>> +			      <0xff300000 0x10000>, /* GICC */
>> +			      <0xff310000 0x10000>, /* GICH */
>> +			      <0xff320000 0x10000>; /* GICV */
>> +			interrupt-controller;
>> +			#interrupt-cells = <3>;
>> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges;
>> +
>> +			gic_its: msi-controller@ff120000 {
>> +				compatible = "arm,gic-v3-its";
>> +				reg = <0xff120000 0x20000>;
>> +				msi-controller;
>> +				#msi-cells = <1>;
>> +			};
> 
> What uses the ITS?

DT-wise seemingly only the __symbols__ table (named just "its" there, I
notice), so we could drop (or rename) the label if you prefer.

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
