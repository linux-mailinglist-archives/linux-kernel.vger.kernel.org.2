Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130DF3B3FE5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 10:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhFYJBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 05:01:23 -0400
Received: from mail-dm6nam12on2040.outbound.protection.outlook.com ([40.107.243.40]:36280
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229956AbhFYJBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 05:01:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d40KW1OIxDXcl2+BZOSSHGwRIonw60rOYo0mMWl+QNhGvZBAgSM49v93eZ0q0zTxaf7LPodRUmL7z0t3ajhTSI/ViUrKsCSbChBaU7cz5YunNA4SxpbJEEjdSsr/YHDMMZfRzn30A5ZDhbXHmvR4nxFx4WEIyaWNDwtWv7qrNPqGgeG8sjgTZqlrNVICgUo3G4GrkfbfIm7XFNm+3jBSjPqJnUehxW9aFyL4VSfux2sVFS7UqdMuMGHsbJey6shtPgstoD0ulPyg92bG9kn1gI96/bcX5gVvqbNAVKG8jLWtNQPlAURIHNlXiiV0jme1xMHIzrqCmi1po6/iemYLlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hr7k/NNjXly0+nR+lFiJpP4TNtOlHxSV1bjhP2XQjcs=;
 b=PpY3edE/jUX6aaOQA8NiKi+wlNTIFIe8+kkZnlGH2mfAgHH2K2jPVWsanNBrANpY0i64nbeZP7rHNbNa6VCXFvZ6/pL09vH9BAEapiSyPb/rdLYWGszaCsU2A4bCHdY8eB4og3SSqbhYjVc+/X/++ScCshuqljuw8wvu5eAM+saLRuYDvGD5DDcXiTXdpeoIp1VrvCNJ+ANCCD23zaJL7xo6coFZDC6M6+eVOc4VsmTJq+0ECSJ1z6OjpO4sbEWMLZG63JXW3KUcqlxLEweBBgjBrWjveDY9LY8EBCZ0KWhtQoESls0qxdZ1QXwZqe6OysaaIS2P+64aXhh4sh/zJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hr7k/NNjXly0+nR+lFiJpP4TNtOlHxSV1bjhP2XQjcs=;
 b=sXc3OCZ+9UOLpzIeJ3e21iEJVAibMu2W8+fHH8zibGsPHhcN/5UwM/9EMGOemsN5rgb0ix2kNPzrh3b0MFdu6fugPw4Kung1wtjpyyC0n9SlJQTxxa8THLfzMpTJKSncwwbIxJ34aTk7n0h1Di6FZ/f+ehSmEkssRgca1U4k3O8=
Received: from SN7PR04CA0117.namprd04.prod.outlook.com (2603:10b6:806:122::32)
 by DM5PR0201MB3463.namprd02.prod.outlook.com (2603:10b6:4:78::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.23; Fri, 25 Jun
 2021 08:58:58 +0000
Received: from SN1NAM02FT0053.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:122:cafe::a2) by SN7PR04CA0117.outlook.office365.com
 (2603:10b6:806:122::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Fri, 25 Jun 2021 08:58:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0053.mail.protection.outlook.com (10.97.4.115) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Fri, 25 Jun 2021 08:58:58 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 25 Jun 2021 01:58:57 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 25 Jun 2021 01:58:56 -0700
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
Received: from [172.30.17.109] (port=39272)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lwhfr-0002ls-IQ; Fri, 25 Jun 2021 01:58:55 -0700
Subject: Re: [PATCH v2 33/33] arm64: zynqmp: Add support for Xilinx Kria SOM
 board
To:     Rob Herring <robh@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <git@xilinx.com>, Viresh Kumar <viresh.kumar@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Michael Walle" <michael@walle.cc>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <cover.1623684253.git.michal.simek@xilinx.com>
 <97588ccfcdc21c53f732d3948ae85abed6539256.1623684253.git.michal.simek@xilinx.com>
 <20210624203604.GA1938341@robh.at.kernel.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <d23617e2-e897-9bf7-eb6e-96bfe3cf7af1@xilinx.com>
Date:   Fri, 25 Jun 2021 10:58:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210624203604.GA1938341@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4a226f0-7807-44f2-754f-08d937b7781d
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3463:
X-Microsoft-Antispam-PRVS: <DM5PR0201MB34635D75825A1E9B5DB0AF36C6069@DM5PR0201MB3463.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wroN7qjS2Shp9lK+0eagNnE8Sy8p6Y0c6JnKBG67YN3LEiKlKUfZo13vsBgbeOFsxxmd8vc/sed8amHitn6PAFGgyX4dkdzDKg9zi8F6eY/jgZxceVwfQp05chZQVIsvDxxWLDCsV24eJJUTJhtHBSHF0hdeT1fdWGWg8KAMbqhDyExhdFJsqBvXafn95ZopYy6VDiFkCJdwBMovz8WU/wBIbI2649c8MwcnIGK8dUTomlZIITB8qZu/j4OlaAcE/QvdvXusmAJly1Tp92FlMt0tj3I4pFepwFTkuSN+sgdviq2B7Mofk9Kl5mHqbYdKRrA4eodijoqqbv7oT5xQkHldXpUwJth7JLWO6bfxiEVhKk4sbUuR3ECb6j1mR4pd4X2qL4Q4Wrc5hG+oVggUK556K5XkplNWsgv+Tg7cTqCSF8btF/dVThKVDCDLCQDRTgKmUajmi/nFKgSkOra+snT35mtROfkWQl1XK6qIwjJbXZEScsXE1CtbjmBvFhqq/SIBotlTaImidyNMDWkzTUfcpclm2yFcR4wgYWy5kaKAqp1SxToLF+zwwKEMoZ0FdMzgevHPy0ymg0wmnA5n3IhT3khySbsCropdl4jo44cMwrLowTCihv0mLKI4zxEhZSqxit1P5TPfZ0yrgmh9yjPiSuOXoYe+y02vp88LDJ1djQR1CKaOS6gxaoPlmk+9+dnTSzXt91Xo4CnvbKSGSdZmqcNkI76Xtn56XcvtT+xYxOaKaGibGGYvl4MWTmOeqluDEF6e+PSf3j4h19NMIF75F7buhdH+GS1HVhb+qGXqJQ9t40YpvBturO9326oe0zCV1knr24I90hE2Q8v61UeGrgqz2eU0VM7jH0pbf8k3H6lAeQ2WO0R9uODdTpEU
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(36840700001)(46966006)(82310400003)(53546011)(36756003)(70206006)(966005)(47076005)(4326008)(478600001)(426003)(26005)(44832011)(36860700001)(2616005)(70586007)(31696002)(83380400001)(336012)(31686004)(7636003)(82740400003)(186003)(8676002)(9786002)(316002)(5660300002)(36906005)(356005)(8936002)(110136005)(2906002)(6666004)(54906003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 08:58:58.2565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a226f0-7807-44f2-754f-08d937b7781d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0053.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3463
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/24/21 10:36 PM, Rob Herring wrote:
> On Mon, Jun 14, 2021 at 05:25:41PM +0200, Michal Simek wrote:
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
>> Changes in v2:
>> - Use sugar syntax - reported by Geert
>> - Update copyright years
>> - Fix SD3.0 comment alignment
>> - Remove one newline from Makefile
>>
>> https://www.xilinx.com/products/som/kria.html
>> ---
>>  .../devicetree/bindings/arm/xilinx.yaml       |  31 ++
>>  arch/arm64/boot/dts/xilinx/Makefile           |  10 +
>>  .../boot/dts/xilinx/zynqmp-sck-kv-g-revA.dts  | 335 ++++++++++++++++++
>>  .../boot/dts/xilinx/zynqmp-sck-kv-g-revB.dts  | 318 +++++++++++++++++
>>  .../boot/dts/xilinx/zynqmp-sm-k26-revA.dts    | 289 +++++++++++++++
>>  .../boot/dts/xilinx/zynqmp-smk-k26-revA.dts   |  21 ++
> 
> It does not appear to me that the schema matches the dts files. You did 
> check that, right?

I can double check but I have updated xilinx.yaml to match it.


> 
>>  6 files changed, 1004 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dts
>>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dts
>>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
>>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts
>>
>> diff --git a/Documentation/devicetree/bindings/arm/xilinx.yaml b/Documentation/devicetree/bindings/arm/xilinx.yaml
>> index a0b1ae6e3e71..1a4a03dfaf7f 100644
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
> 
> So rev1 is compatible with revB is compatible with revA, but revA and 
> revB don't exist on their own?

HW wise they of course exist.
revB(development version) is identical with rev1(production version).
And there are some HW changes between revA and revB but without impact
on SW. That's why all 3 are listed.
Board version is recorded in eeprom and based on it the right compatible
dt should be taken.

> 
>> +          - const: xlnx,zynqmp-sm-k26
>> +          - const: xlnx,zynqmp
>> +
>> +      - description: Xilinx Kria SOMs (starter)
>> +        items:
>> +          - const: xlnx,zynqmp-smk-k26-rev1
>> +          - const: xlnx,zynqmp-smk-k26-revB
>> +          - const: xlnx,zynqmp-smk-k26-revA
>> +          - const: xlnx,zynqmp-smk-k26
>> +          - const: xlnx,zynqmp
>> +
>> +      - description: Xilinx Kria Carrier Cards (revA/Y/Z)
>> +        items:
>> +          - const: xlnx,zynqmp-sk-kv260-revZ
>> +          - const: xlnx,zynqmp-sk-kv260-revY
>> +          - const: xlnx,zynqmp-sk-kv260-revA
>> +          - const: xlnx,zynqmp-sk-k260
>> +          - const: xlnx,zynqmp
>> +
>> +      - description: Xilinx Kria Carrier Cards (revB/1)
>> +        items:
>> +          - const: xlnx,zynqmp-sk-kv260-rev1
>> +          - const: xlnx,zynqmp-sk-kv260-revB
>> +          - const: xlnx,zynqmp-sk-k260
>> +          - const: xlnx,zynqmp
>> +
>>  additionalProperties: true
>>  
>>  ...
>> diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xilinx/Makefile
>> index 083ed52337fd..8e43bef2c57e 100644
>> --- a/arch/arm64/boot/dts/xilinx/Makefile
>> +++ b/arch/arm64/boot/dts/xilinx/Makefile
>> @@ -17,3 +17,13 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu104-revA.dtb
>>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu104-revC.dtb
>>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu106-revA.dtb
>>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu111-revA.dtb
>> +
>> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k26-revA.dtb
>> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k26-revA.dtb
>> +
>> +som-AA-dtbs := zynqmp-sm-k26-revA.dtb zynqmp-sck-kv-g-revA.dtbo
>> +som-AB-dtbs := zynqmp-sm-k26-revA.dtb zynqmp-sck-kv-g-revB.dtbo
>> +starter-AA-dtbs := zynqmp-smk-k26-revA.dtb zynqmp-sck-kv-g-revA.dtbo
>> +starter-AB-dtbs := zynqmp-smk-k26-revA.dtb zynqmp-sck-kv-g-revB.dtbo
>> +
>> +dtb-$(CONFIG_ARCH_ZYNQMP) += som-AA.dtb som-AB.dtb starter-AA.dtb starter-AB.dtb
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dts
>> new file mode 100644
>> index 000000000000..59d5751e0634
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dts
>> @@ -0,0 +1,335 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * dts file for KV260 revA Carrier Card
>> + *
>> + * (C) Copyright 2020 - 2021, Xilinx, Inc.
>> + *
>> + * SD level shifter:
>> + * "A" – A01 board un-modified (NXP)
>> + * "Y" – A01 board modified with legacy interposer (Nexperia)
>> + * "Z" – A01 board modified with Diode interposer
>> + *
>> + * Michal Simek <michal.simek@xilinx.com>
>> + */
>> +
>> + #include <dt-bindings/gpio/gpio.h>
>> + #include <dt-bindings/net/ti-dp83867.h>
>> + #include <dt-bindings/phy/phy.h>
>> + #include <dt-bindings/pinctrl/pinctrl-zynqmp.h>
>> +
>> +/dts-v1/;
>> +/plugin/;
>> +
>> +&{/} {
>> +	compatible = "xlnx,zynqmp-sk-kv260-revA",
>> +		     "xlnx,zynqmp-sk-kv260-revY",
>> +		     "xlnx,zynqmp-sk-kv260-revZ",
> 
> The order above is Z, Y, A.


This is overlay which is not checked but I will fix the order to match it.

Thanks,
Michal
