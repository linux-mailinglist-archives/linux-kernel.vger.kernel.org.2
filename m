Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237D6344571
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 14:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhCVNTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 09:19:20 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56766 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbhCVNPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:15:32 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12MDDPSJ042511;
        Mon, 22 Mar 2021 08:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616418805;
        bh=iCgNRQuii6EPW6xTe/5aPAx9+RQvJYKEp/7TdTegbE4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Jl0qkODPTimr2zL66rPcl1DbY7pceipZGZjhSzBqrCE+y5fk/XKQe7GwQMyAHIVcq
         9YUGTB/ppbKpHX5rPHr7lPz0BgG+mF3/q8HnhT6RcgITpUqxiAZW6OE7czu8uyxExL
         6F9nfL6CwjHWWCK2riQjdk2/PguhErHjsn0vF/9s=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12MDDO59119099
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Mar 2021 08:13:24 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 22
 Mar 2021 08:13:24 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 22 Mar 2021 08:13:24 -0500
Received: from [172.24.145.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12MDDLVL028897;
        Mon, 22 Mar 2021 08:13:22 -0500
Subject: Re: [PATCH v6 3/3] arm64: dts: ti: k3-j7200: Add support for higher
 speed modes and update delay select values for MMCSD subsystems
To:     Nishanth Menon <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210319034422.17630-1-a-govindraju@ti.com>
 <20210319034422.17630-4-a-govindraju@ti.com>
 <20210322122321.tpvvhr2jqao7rgjd@tingle>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <20417053-e169-b76e-93b6-2bb3b3ac88da@ti.com>
Date:   Mon, 22 Mar 2021 18:43:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210322122321.tpvvhr2jqao7rgjd@tingle>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On 22/03/21 5:53 pm, Nishanth Menon wrote:
> On 09:14-20210319, Aswath Govindraju wrote:
>> The following speed modes are now supported in J7200 SoC,
>> - HS200 and HS400 modes at 1.8 V card voltage, in MMCSD0 subsystem [1].
>> - UHS-I speed modes in MMCSD1 subsystem [1].
>>
>> Add support for UHS-I modes by adding voltage regulator device tree nodes
>> and corresponding pinmux details, to power cycle and voltage switch cards.
>> Set respective tags in sdhci0 and remove no-1-8-v tag from sdhci1
>> device tree nodes.
>>
>> Also update the delay values for various speed modes supported, based on
>> the revised january 2021 J7200 datasheet[2].
>>
>> [1] - section 12.3.6.1.1 MMCSD Features, in
>>       https://www.ti.com/lit/ug/spruiu1a/spruiu1a.pdf,
>>       (SPRUIU1A – JULY 2020 – REVISED JANUARY 2021)
>>
>> [2] - https://www.ti.com/lit/ds/symlink/dra821u.pdf,
>>       (SPRSP57B – APRIL 2020 – REVISED JANUARY 2021)
>>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> ---
> [...]
> 
>> +
>> +	vdd_sd_dv_pins_default: vdd_sd_dv_pins_default {
> 
> 	Nope. Use:
> 		vdd_sd_dv_pins_default: vdd-sd-dv-pins-default
> 

Corrected this in the respin(v7).

Thanks,
Aswath
