Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B40414253
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 09:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbhIVHKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 03:10:10 -0400
Received: from mail-mw2nam10on2082.outbound.protection.outlook.com ([40.107.94.82]:31457
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232946AbhIVHKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 03:10:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOShiwvtPH9VGCk1P+ORYEhyVimu/wng8Y8D0HqMLxD45+NB0cudq7tBuEZkD5xyNZmtLrmqtZNvdvdbzxRKZMNrnQAyK3NRCJ7gDumMzV1yr9GctTndQKOwYms2KZp3c+Q4EbvCyHE0N/R7aVeXSushPwv8LbO+0noIwYWoxWUGsKmpeQxHdtPfDzYKPBJq333J3MA0IUbkIdq4a9tgQTIxAYyHD/7p5gBP/dazGqLYbP6fv8iwWn+5upQ117ts+xZ8VYv6jsci3EtmfwlSSfkC+6vgaJFqTrMaakVu0TfUWmPllcqXxkZ03lWm1LKe/DcLRL1kVYxwls81v4yD2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+jmF33gIO8dbwov0cBCsgVTUvCo7J0iw/wLecVQWmm4=;
 b=Lmgs74UcZRXdFMQWWZmORXTVg4ocClmuH0CEBndQDds1m8WyD0e7wCGocJUA4vrzOJgQn6WqRg2YGTJmfjMsLilX4P8/VVjUN9cxhXQdRv6VgKB3TRqh64Op7u/UYJXSYuWnx8sn82vXUeGIuWaFuhBXfwXyC6GSKSSpan02TEkzTSRFRa8Zb9ZMEdXrJ+15tR1aldcFH0ma0LsLHb04ZDh2Qg6FeDa2ra1h+QHBlXpqamAwQMROZ9w4ERI5daaP7ceE0ww7DwmJO5wayrJSfuftRcNh6GldIcg610qNrQoaD/Yai6lS3XRXGIDOX1CtW2XHP6yYTpV2q0XRKzG/QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jmF33gIO8dbwov0cBCsgVTUvCo7J0iw/wLecVQWmm4=;
 b=F6lgvGmsqqBIT0jhtoabaj48raHzMlGyXtOT3JYbuvxssFvtx0agnny36zW/x2ZDhmScK9OEhNLLG4hbMTpvM2SBjZFRISG6828MVjZJUArJaf7Jfxt3LsGXtYzQuRw+KVmQJWTwXVRdUcXJYQpAY9FSsnHVhrE+I/rN2ls/sys=
Received: from SA0PR11CA0054.namprd11.prod.outlook.com (2603:10b6:806:d0::29)
 by BL0PR02MB4260.namprd02.prod.outlook.com (2603:10b6:208:42::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Wed, 22 Sep
 2021 07:08:36 +0000
Received: from SN1NAM02FT0028.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:d0:cafe::b0) by SA0PR11CA0054.outlook.office365.com
 (2603:10b6:806:d0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Wed, 22 Sep 2021 07:08:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0028.mail.protection.outlook.com (10.97.4.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Wed, 22 Sep 2021 07:08:36 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 22 Sep 2021 00:08:09 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 22 Sep 2021 00:08:09 -0700
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
Received: from [10.254.241.49] (port=42866)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mSwMS-000GWD-Cp; Wed, 22 Sep 2021 00:08:08 -0700
Subject: Re: [PATCH v4] arm64: zynqmp: Add support for Xilinx Kria SOM board
To:     Rob Herring <robh@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <git@xilinx.com>, Viresh Kumar <viresh.kumar@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Michael Walle" <michael@walle.cc>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <ed0e6aa670ac59eabbabe7552883416248ad6c89.1631697878.git.michal.simek@xilinx.com>
 <YUpO7j1kDJ2kmvsW@robh.at.kernel.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <57b9543f-b1a7-8c96-5ed6-63b937cee3fa@xilinx.com>
Date:   Wed, 22 Sep 2021 09:08:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YUpO7j1kDJ2kmvsW@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ac88b4d-92fd-4ea3-a086-08d97d97cbec
X-MS-TrafficTypeDiagnostic: BL0PR02MB4260:
X-Microsoft-Antispam-PRVS: <BL0PR02MB4260BADCA232CDCE21245CF6C6A29@BL0PR02MB4260.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YlIWiMhyvGNClAepaLql/xPNv14/K6i6dKZB9YIFWOHB3GCV6jq+hzHOVuUxGdFIiUjhHlum+UD57EI3/b4sreduSX4NfI+toaZ6BUp/hqTYFbYEngr4JMoRnB44N1Fn+vp1MEtuMkClwSEN+hKY0uRaFkSpSxeRUo3cRa1KVnpRvdHpI/jx7rDU6+rJbN0yV2wIB4/rt+uj3qOQ7/pJtpEUH55mCoUz5U4DYAtxSwUyanX6xuVPBUi8DlfOlqb97zxhhe735IpeGoRELzlXSZT/Mgkql3729fsL6UxMGyDRsj0O3+GbRDnMLatXAWzKAuuTdlMTxmqsjHismgBIqjFg3Ml3U7pkiPTl+95pu4I9oQueZvJjWTee8x4jrVrlWdMOhHcmO6sD7HhcFgCbG8yjf5XnSlzmtk9N70ZOZlG9nem3JCuQEUEJELjcv7ewU17ml0iXUni/KM1uCK5sYUcgYpp6i27XGjT9cbUzoJCvM4s0A71La4gtotX+V7HuZpvQi4OSdLPXWycTv0YIitVOVjl6d98r6UBIFe8n/oT+I0qvN1RM95+Z0+a5pXw8bak6SCysYbTRxObrql/Zhhshed/qFzATUIxgxVcPhv5Py4YTGLRx9ztLU+qmFidzCUxXHVgD67/FuvZ9BGeoof3noCT8qpDOZpLgrYdtgQ5K0mtQw082Wgn2y+0ce9M82fDK2kfKkU+XPzlid24umFbTQqocJKf5DL8Baq4Ve5pOpjvCLOltQ0G0lKNzb9kfGhUjj4h7ySMp0k0zciL5KWOjTjtBsChrrnsFT2QIDWzhdmO8I8p17TG24aC5dRSV1VnrWJGBQ4LB51kSFPnqoBgZRaaYFF8gu/QLZsVDRIoYzM4Oj+oll4aWw17CAIZj
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(508600001)(44832011)(2616005)(2906002)(8676002)(31686004)(966005)(9786002)(54906003)(316002)(110136005)(36906005)(70586007)(70206006)(4326008)(5660300002)(426003)(336012)(53546011)(26005)(8936002)(31696002)(36756003)(186003)(47076005)(36860700001)(83380400001)(6666004)(7636003)(356005)(82310400003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 07:08:36.3642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac88b4d-92fd-4ea3-a086-08d97d97cbec
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0028.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4260
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/21/21 11:30 PM, Rob Herring wrote:
> On Wed, Sep 15, 2021 at 11:24:58AM +0200, Michal Simek wrote:
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
>> Changes in v4:
>> - Remove ina260 and usb5744 nodes
>> - Remove compatible string from overlays
>>
>> Changes in v3:
>> - Fix led node name
>> - Fix compatible string for xlnx,zynqmp-sk-kv260-revA/Y/Z
>> - Fix headers alignment
>> - Move USB3 PHY properties from DWC3 node to USB node - reported by Manish
>>   Narani
>> - Change dtb names generated with dtbo
>> - Fix emmc comment style
>>
>> Changes in v2:
>> - Use sugar syntax - reported by Geert
>> - Update copyright years
>> - Fix SD3.0 comment alignment
>> - Remove one newline from Makefile
>>
>> https://www.xilinx.com/products/som/kria.html
>> Based on
>> https://lore.kernel.org/r/cover.1628244703.git.michal.simek@xilinx.com
>>
>> ---
>>  .../devicetree/bindings/arm/xilinx.yaml       |  16 +
>>  arch/arm64/boot/dts/xilinx/Makefile           |  13 +
>>  .../boot/dts/xilinx/zynqmp-sck-kv-g-revA.dts  | 315 ++++++++++++++++++
>>  .../boot/dts/xilinx/zynqmp-sck-kv-g-revB.dts  | 298 +++++++++++++++++
>>  .../boot/dts/xilinx/zynqmp-sm-k26-revA.dts    | 289 ++++++++++++++++
>>  .../boot/dts/xilinx/zynqmp-smk-k26-revA.dts   |  21 ++
>>  6 files changed, 952 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dts
>>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dts
>>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
>>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts
>>
>> diff --git a/Documentation/devicetree/bindings/arm/xilinx.yaml b/Documentation/devicetree/bindings/arm/xilinx.yaml
>> index a0b1ae6e3e71..4dc0e0195974 100644
>> --- a/Documentation/devicetree/bindings/arm/xilinx.yaml
>> +++ b/Documentation/devicetree/bindings/arm/xilinx.yaml
>> @@ -116,6 +116,22 @@ properties:
>>            - const: xlnx,zynqmp-zcu111
>>            - const: xlnx,zynqmp
>>  
>> +      - description: Xilinx Kria SOMs
>> +        items:
>> +          - const: xlnx,zynqmp-sm-k26-rev1
>> +          - const: xlnx,zynqmp-sm-k26-revB
>> +          - const: xlnx,zynqmp-sm-k26-revA
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
>>  additionalProperties: true
>>  
>>  ...
>> diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xilinx/Makefile
>> index 083ed52337fd..4e159540d031 100644
>> --- a/arch/arm64/boot/dts/xilinx/Makefile
>> +++ b/arch/arm64/boot/dts/xilinx/Makefile
>> @@ -17,3 +17,16 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu104-revA.dtb
>>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu104-revC.dtb
>>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu106-revA.dtb
>>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu111-revA.dtb
>> +
>> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k26-revA.dtb
>> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k26-revA.dtb
>> +
>> +sm-k26-revA-sck-kv-g-revA-dtbs := zynqmp-sm-k26-revA.dtb zynqmp-sck-kv-g-revA.dtbo
>> +sm-k26-revA-sck-kv-g-revB-dtbs := zynqmp-sm-k26-revA.dtb zynqmp-sck-kv-g-revB.dtbo
>> +smk-k26-revA-sm-k26-revA-sck-kv-g-revA-dtbs := zynqmp-smk-k26-revA.dtb zynqmp-sck-kv-g-revA.dtbo
>> +smk-k26-revA-sm-k26-revA-sck-kv-g-revB-dtbs := zynqmp-smk-k26-revA.dtb zynqmp-sck-kv-g-revB.dtbo
> 
> I assume there is some value in these being overlays? I probably asked 
> that already too, but don't remember. Please explain in the commit 
> message so we capture that.

I have sent v5 version with explanation in commit message.

Thanks,
Michal
