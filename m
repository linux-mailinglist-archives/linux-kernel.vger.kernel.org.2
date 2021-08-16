Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865143ECE80
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 08:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbhHPGPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 02:15:47 -0400
Received: from mail-mw2nam12on2058.outbound.protection.outlook.com ([40.107.244.58]:45537
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233134AbhHPGPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 02:15:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyO6Gkh1R595IezYNafJaxgZFMiADM+TZGL4bMB+rZcJucOTaxWO8ZiUlzc07iauadwSNVZ8+lzduSqNeooclFUTXxyu+UHFM6sNKecJXKYm2GqS+cOqhl40HEPdTR52wZw9cjLgSDazby4x3EaZ9OU7s697HZhLnXwr+01NFl9f1YliKXXCpMSO4wnDTW2uAdp4Vp4EGGiNtzcfA0msb5tJVZCnT5oYwq+e9PpAs2FH/FI5FI0g8zHnffb4ukG+LZWrdrJ3+wADdhV2t4d5j1/pUFGmX0UwPAdAE5wPp2pVIwM1rtbE1OPOmVbRAJtUNup0MS38rcJYtsXkUWiYjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yY6VotzdDCG5hCIpB7SAiVf+9Yt2W8AYp5Ai9pZ9Wb4=;
 b=OQHsUUy+AJgBRR9J7j86MtfWa7Y3VC1KwZ/oHmCfkQO2p9LGo81HxSDlfkpFRS66a7qOmZb6nqNa4JDKPufvrCvCKQ5xFMVj/mYJ3xT3lEgKZzLCWSuNGVG4Rl+z/sEdmdkDfVCYlGRvZtzxcYUkKvTA49F8dhNx8i0W+y8WAL9AbYOxBoHJ/2MFgJ4lNDiZD1clle49+cI0F5v1ZXfmLPaT0u1YerADOyNvyhAaJY/WSRAxGX3IoQZUBrB08eyYEoeVXUM+453gkIr3sm//hqWfsnMOf2ros0FHUkyk4jV6Zi/ls8hwYFyJypoakwyjMLHrIPVqF0pGe8q05lQR8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yY6VotzdDCG5hCIpB7SAiVf+9Yt2W8AYp5Ai9pZ9Wb4=;
 b=C3zXgGsKurfy1bxmuOoNhfV4KYcalgYrFHD97d4SuiZBafe6LAi3ELSezZhuCP5lK5rfpUYhFwuRMak3kqfeE21AyfLSmi3oWHlKhsdIgTZSTSPmkoaZ/AHbyn+6Ub/MK8jLoH+pYZjm6zeYJB3mkuXNBdm6t/T8WK6qEKhNQB0=
Received: from SN1PR12CA0054.namprd12.prod.outlook.com (2603:10b6:802:20::25)
 by CH0PR02MB7963.namprd02.prod.outlook.com (2603:10b6:610:104::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Mon, 16 Aug
 2021 06:15:11 +0000
Received: from SN1NAM02FT0003.eop-nam02.prod.protection.outlook.com
 (2603:10b6:802:20:cafe::4d) by SN1PR12CA0054.outlook.office365.com
 (2603:10b6:802:20::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend
 Transport; Mon, 16 Aug 2021 06:15:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0003.mail.protection.outlook.com (10.97.4.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Mon, 16 Aug 2021 06:15:11 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 15 Aug 2021 23:14:58 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Sun, 15 Aug 2021 23:14:58 -0700
Envelope-to: git@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 michael@walle.cc,
 krzk@kernel.org,
 geert+renesas@glider.be,
 viresh.kumar@linaro.org,
 monstr@monstr.eu,
 linux-kernel@vger.kernel.org,
 robh@kernel.org
Received: from [172.30.17.109] (port=38216)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mFVth-0006qr-5P; Sun, 15 Aug 2021 23:14:57 -0700
Subject: Re: [PATCH v3 2/2] arm64: zynqmp: Add support for Xilinx Kria SOM
 board
To:     Rob Herring <robh@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <git@xilinx.com>, Viresh Kumar <viresh.kumar@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Michael Walle" <michael@walle.cc>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <cover.1628244703.git.michal.simek@xilinx.com>
 <e780a2fef00e78c44c21cf3b918631bf20262688.1628244703.git.michal.simek@xilinx.com>
 <YRbRcx0b+V0vAgA4@robh.at.kernel.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <390708be-f251-cb14-cd7e-7eec418a060c@xilinx.com>
Date:   Mon, 16 Aug 2021 08:14:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YRbRcx0b+V0vAgA4@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80d5360c-d013-48e0-edf1-08d9607d346b
X-MS-TrafficTypeDiagnostic: CH0PR02MB7963:
X-Microsoft-Antispam-PRVS: <CH0PR02MB79630041E234FFB55B001204C6FD9@CH0PR02MB7963.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rG35cYJxaHkmj4hKGbNtVvylVUsJNmaENj6JYmrJQss9e0gqzgoJM17LjSn8WTnEhV/CDC5RuUMpnpZqZFqwptQuDPqMHhMDT3bPfckK1E1udoOXSCxTFhzc3Aio1eKMZOUDe3TndKYE5u1v43Y8S7OP0UB6liIXaTGxCLatv6zDHoqaUmOzyvH9PGpbJf8F0dmD8Bn/DCGr/PcJbvv6bgfqS0P2WpbfePqFegIFy2geFS+L2RzxpNy65aLDJjP+W+5QpxzzZeaVmHDkTOq+Y+xwTXSG7sjfJuyIzbKd/rQhnw4qWLNG9nLIXoFO64fUsOZa2oVLNX7fxNHrN/ct1T61AFzRZFMzXr2hSNCfKAz3tMM7XVCPGyCwrRabEF+mDbu4y1nUT03ko/qrAxr9vnSU/j5JCX9pZrCdEb31qbksnFANJt1g9qJ1hLjbdd+FVDTqXF/1OtXvHn2W93j2F9f0jGKxxSXZ2i2CixTmNwHUDVukZWtj45AqJtJAFPejxu9+1YnvweJExnoiV4cLuTnVOGAQ6hecGEAbVQj+mlAYDvuV3Gz6q5QTKIx777/RnX950Ox7xVQvUhYP8LqFveOr7dIe6wAXTWIOS190Uy3k5aGHEgQk1lI7aTTDr0qLkK4tS/ouc9Ozo3Az72hkqh67QJlS9MvMDXOyP4nb/KcWJx0LVlhkJe58j/CO8kB0GZd+8jE8PWoLJNmCFwlsy7QDXu4WeKl/d2u7NgzCeXndgVvEp/P9PenADMnCPzYotlF1BEizkxVYU4PEWRWaQ52+G9TzwAnRIhO0cmfr78VYImSqzaDDZ3DTBHCLdGc83r6xRnnHc9D+9Z4kATps/iksWG69X1o3TBg2oVemC2o=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39850400004)(136003)(376002)(346002)(396003)(46966006)(36840700001)(478600001)(36756003)(2906002)(110136005)(70206006)(5660300002)(47076005)(966005)(426003)(82310400003)(70586007)(4326008)(36860700001)(8676002)(54906003)(356005)(53546011)(26005)(7636003)(336012)(31696002)(316002)(36906005)(2616005)(8936002)(31686004)(6666004)(9786002)(186003)(82740400003)(44832011)(83380400001)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 06:15:11.5493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d5360c-d013-48e0-edf1-08d9607d346b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0003.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB7963
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/13/21 10:09 PM, Rob Herring wrote:
> On Fri, Aug 06, 2021 at 12:12:08PM +0200, Michal Simek wrote:
>> There are couple of revisions of SOMs (k26) and associated carrier cards
>> (kv260).
>> SOM itself has two major versions:
>> sm-k26 - SOM with EMMC
>> smk-k26 - SOM without EMMC used on starter kit with preprogrammed firmware
>> in QSPI.
>>
>> SOMs are describing only devices available on the SOM or connections which
>> are described in specification (for example UART, fwuen).
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>> Changes in v3:
>> - Fix led node name
>> - Fix compatible string for xlnx,zynqmp-sk-kv260-revA/Y/Z
>> - Fix headers alignment
>> - Move USB3 PHY properties from DWC3 node to USB node - reported by Manish
>>   Narani
>> - Change dtb names generated with dtbo
>> - Fix emmc comment style
>> -
>>
>> Changes in v2:
>> - Use sugar syntax - reported by Geert
>> - Update copyright years
>> - Fix SD3.0 comment alignment
>> - Remove one newline from Makefile
>>
>> https://www.xilinx.com/products/som/kria.html
>> ---
>>  .../devicetree/bindings/arm/xilinx.yaml       |  31 ++
>>  arch/arm64/boot/dts/xilinx/Makefile           |  13 +
>>  .../boot/dts/xilinx/zynqmp-sck-kv-g-revA.dts  | 335 ++++++++++++++++++
>>  .../boot/dts/xilinx/zynqmp-sck-kv-g-revB.dts  | 318 +++++++++++++++++
>>  .../boot/dts/xilinx/zynqmp-sm-k26-revA.dts    | 289 +++++++++++++++
>>  .../boot/dts/xilinx/zynqmp-smk-k26-revA.dts   |  21 ++
>>  6 files changed, 1007 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dts
>>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dts
>>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
>>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts
>>
>> diff --git a/Documentation/devicetree/bindings/arm/xilinx.yaml b/Documentation/devicetree/bindings/arm/xilinx.yaml
>> index a0b1ae6e3e71..31b86a6363b8 100644
>> --- a/Documentation/devicetree/bindings/arm/xilinx.yaml
>> +++ b/Documentation/devicetree/bindings/arm/xilinx.yaml
>> @@ -116,6 +116,37 @@ properties:
>>            - const: xlnx,zynqmp-zcu111
>>            - const: xlnx,zynqmp
>>  
>> +      - description: Xilinx Kria SOMs
>> +        items:
>> +          - const: xlnx,zynqmp-sm-k26-rev1
>> +          - const: xlnx,zynqmp-sm-k26-revB
>> +          - const: xlnx,zynqmp-sm-k26-revA
>> +          - const: xlnx,zynqmp-sm-k26
> 
> How is having all 4 strings useful? Seems like it should be only 1 of 
> the rev's at a time.

We have added eeprom on SOM and another one on carrier card.
And final DT is combination of them.
And I wanted to keep track which versions are compatible to each other
from software point of view.
revB is fully equal to rev1 HW and it is pretty much just change from
development version to production version.
revA compare to revB has some changes on PCB but still SW compatible.

That's why I wanted to keep track of all versions via compatible strings
and also Xilinx distribution based on this information creates symlinks
to the same DTB to pick up correct DTB based on revision written in eeprom.

Also I don't think this is going against compatible string description
written in DT spec.

"The compatible property value consists of one or more strings that
define the specific programming model for
the device. This list of strings should be used by a client program for
device driver selection. The property
value consists of a concatenated list of null terminated strings, from
most specific to most general. They
allow a device to express its compatibility with a family of similar
devices, potentially allowing a single
device driver to match against several devices."


<snip>

>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dts
>> new file mode 100644
>> index 000000000000..df054e152a77
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dts
>> @@ -0,0 +1,318 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * dts file for KV260 revA Carrier Card
>> + *
>> + * (C) Copyright 2020 - 2021, Xilinx, Inc.
>> + *
>> + * Michal Simek <michal.simek@xilinx.com>
>> + */
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/net/ti-dp83867.h>
>> +#include <dt-bindings/phy/phy.h>
>> +#include <dt-bindings/pinctrl/pinctrl-zynqmp.h>
>> +
>> +/dts-v1/;
>> +/plugin/;
>> +
>> +&{/} {
>> +	compatible = "xlnx,zynqmp-sk-kv260-rev1",
>> +		     "xlnx,zynqmp-sk-kv260-revB",
>> +		     "xlnx,zynqmp-sk-kv260", "xlnx,zynqmp";
> 
> I don't think changing the root compatible in an overlay is a good 
> policy. Do you need this all to be overlays?

Thanks for opening this up. DT overlay is applied in Linux now but in
near future we will have to apply it earlier in u-boot.
And the main question is if you want to see just SOM board compatible
string with k26 or carrier card compatible string (kv260).

I choose to rather see carrier card compatible string which is that
information which make difference. SOM variants are pretty much the
same. The different is only if EMMC is populated or not.
Different silicon is also recorded in eeprom but it can be detected and
sw is pretty much the same but don't need to be.

The boot works in a way that SOM is booting out of QSPI with only DT
with SOM description. Then carrier card is detected and DT overlay is
applied and never removed. And then in Linux other DT overlays are
applied and removed based on application you choose.

If you think that my thinking about carrier card compatible string is
horribly wrong I have no problem to remove them but I need to find a way
how to keep track of carrier revisions which are compatible with this
overlay.


> 
>> +};
>> +
>> +&i2c1 { /* I2C_SCK C23/C24 - MIO from SOM */
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +	pinctrl-names = "default", "gpio";
>> +	pinctrl-0 = <&pinctrl_i2c1_default>;
>> +	pinctrl-1 = <&pinctrl_i2c1_gpio>;
>> +	scl-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>;
>> +	sda-gpios = <&gpio 25 GPIO_ACTIVE_HIGH>;
>> +
>> +	u14: ina260@40 { /* u14 */
>> +		compatible = "ti,ina260";
> 
> Not documented. Please run 'make dtbs_check' and don't add new warnings.

I will remove it.
Did you get a warning? When I was looking at it it didn't come because
this is overlays. Was there any update which changed this?

> 
>> +		#io-channel-cells = <1>;
>> +		label = "ina260-u14";
>> +		reg = <0x40>;
>> +	};
>> +	usbhub: usb5744@2d { /* u43 */
>> +		compatible = "microchip,usb5744";
> 
> Not documented.

I will remove this one too.


Thanks,
Michal
