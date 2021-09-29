Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584B341C3C0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 13:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245187AbhI2Luq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 07:50:46 -0400
Received: from mail-mw2nam10on2065.outbound.protection.outlook.com ([40.107.94.65]:39904
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245139AbhI2Luk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 07:50:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYFE77tfPwbJrsZ/eymOQ+X/0S6BFu3Q1xHWNiFFfoJ/GBkEWr1fiGiGrWnru/hJf7L3s94QbP3hINuLt5MBeJVLfi4nTp2iGst0aZ7UEz9+J0e3ZLZDKblIvqh+o9aWWVDIkXx+njL9GnZzJ+72FWtiPZKtkWYYtebo2XhhBtvj8gSk77NDvfFbz+XSwuyy030ioydeh9tXU+Px6opOydxCcwKf25kTr+hzvaSN6juW7OcXMAqoyMtyuy7VNw1d+9zeFZcFFqZc2Ah/8JgFEnd6lHTv12jF5nnoBr1h7NwvKPbHprxzIKY9/8zOr3RnwGsTk9SG6DHjLJ/4SWM4RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=GrYWszDwyN1z3lRgfdXwf8h83uDkEskXsnjVhhrzj/w=;
 b=YJ+07INkDXEsd5MUTR29xXWK/V6jZiTDlMXL3aSP+81ENH+dCed8/RssNYdfqfKOcWke+Z8wauBB6xxs387xAnR7QXCW7vBx8BuhZF5e18rp0bLFtdhxBvaictsIncF04qTuSfRinIMeCAWBkZ/oaL4InEs89V2qTt7uJTGArXLg0JN/+QD+iZHNE+s3hCsjegcZBS/ZCZV6uyHsH4EiXGAffZ7M0lD7v7Fnx9ze6NUJb+1uSKpBpBgFppTvb/mMC+30JUrJa99njnjtHAXWO/EHAGMvJu7TfLnKA/3TIeqPuJCG02FFHnSTo/L/u9tRr1dK9RpP1zMAhPLQrWMdbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrYWszDwyN1z3lRgfdXwf8h83uDkEskXsnjVhhrzj/w=;
 b=HywlD48Ty9rR04t5DqRb2AZkSg3bpMYFvBbkvXLbMX2QoSHYr9d0tUheCD9pfkfVP9rFtoWxviwHyKfXzqKBDadn9QAU7e2RYs8wheRK5OTd3aKmYMgMOyXmYSqD9/4Lkn54o7P9a944sPLnkGSxW2ftk9PGSuBEw+BhAgyTGZg=
Received: from BN0PR04CA0047.namprd04.prod.outlook.com (2603:10b6:408:e8::22)
 by PH0PR02MB7576.namprd02.prod.outlook.com (2603:10b6:510:5a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Wed, 29 Sep
 2021 11:48:57 +0000
Received: from BN1NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::64) by BN0PR04CA0047.outlook.office365.com
 (2603:10b6:408:e8::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Wed, 29 Sep 2021 11:48:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT032.mail.protection.outlook.com (10.13.3.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Wed, 29 Sep 2021 11:48:57 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 29 Sep 2021 04:48:49 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 29 Sep 2021 04:48:49 -0700
Envelope-to: git@xilinx.com,
 linux-kernel@vger.kernel.org,
 viresh.kumar@linaro.org,
 krzk@kernel.org,
 robh+dt@kernel.org,
 michael@walle.cc,
 linux-arm-kernel@lists.infradead.org,
 geert+renesas@glider.be,
 devicetree@vger.kernel.org,
 monstr@monstr.eu,
 robh@kernel.org
Received: from [10.254.241.49] (port=59420)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mVY4u-0005j7-J4; Wed, 29 Sep 2021 04:48:48 -0700
Subject: Re: [PATCH v5] arm64: zynqmp: Add support for Xilinx Kria SOM board
To:     Rob Herring <robh@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <monstr@monstr.eu>, <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        <linux-arm-kernel@lists.infradead.org>,
        "Michael Walle" <michael@walle.cc>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzk@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, <git@xilinx.com>,
        <linux-kernel@vger.kernel.org>
References: <1ba32590670434b650bacf6410a65579dd30b38b.1632294439.git.michal.simek@xilinx.com>
 <YVIPAGckmsYmrVv1@robh.at.kernel.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <72a2f8e1-eb6e-4642-a88e-36028b7bdae4@xilinx.com>
Date:   Wed, 29 Sep 2021 13:48:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YVIPAGckmsYmrVv1@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a1683f3-6465-4261-fe8c-08d9833f1f13
X-MS-TrafficTypeDiagnostic: PH0PR02MB7576:
X-Microsoft-Antispam-PRVS: <PH0PR02MB7576ACA444DEA31C52065A91C6A99@PH0PR02MB7576.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O6kXnVAoJvBgD/NzcCjSpGkBYbSjnoyoyLZmZs34j/I2bbGtGGJmLP1Vubdg/A1T2fTNwGXOtYFp+RhQcGaEpM7hMYCOmOb5Q7SCwfUX/BkPLbPRAQYf6stJ4Zz38EE3XAW8tA5RPTzsdr2KwkHsFDnRjUsVCdA2ocHSHfsqzEnuH7xt9vPNW8lXK+PylZlhA6xtg5AElrg029iWHBI6MVOC6Avtcg+4Wcqj6slxlZBOeWypSIkcW92E813oXpWUziwCDJWGOVDpC1opjGOD+G8cNdvZL28a8GgMZiSXpwkqb3U4UW0nXltkJ1Ov4GDJjmIrU6is7/3lz4mvfsgLjGZlejnspb8G5qcWLV14cIhZUPkA2RxnuTljcTnJHNn/LaGrwUUSQB4LWpwJZsyIxJLgiPbgO3QkrFxXSwGr73rC/M+TgmdJZlgwuFtnVpuv9hCEQe2MRrvyDD6hvDUjz/d67roVEuaE6F0V/p41LTdDc/y7hJevSlGIT88/brF6/lJCSKCwze0uHG/mWbIaGF16Z1eK8oEM/PyaoqqBix71Gn1U4+nnKplFUVCyFTH+9q3j6wS0QM//BVogr5gzMFf4L6Itpu/jVBebdUbzNliFrlw0qD0xbu3G9+s9n/4IrdImJDlM1fLWC+hH61Irw0jaF89KfW3Lu4QODSPqBFJQR9peXF1Lkcp8LgK74EcMZPoeY7qi5spQALzrxgKsrLEL2f10MCg+NPtaPtWxIacsbcUWYYVTzW4bzZHvhypar+o1ZqMB6U1P9FuWOaJh5pIrk8o48p+lKKJgoWHQ6apKDP8v5YcBRFwsuZhALtGCbEn49bm2Ag1KmGJD6zqI7pLZWYfj8Bg1/OYwVytTMF+px9JBSWTrPK36SuqR+XMA
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(356005)(26005)(54906003)(110136005)(4326008)(8936002)(82310400003)(70206006)(70586007)(8676002)(186003)(36906005)(316002)(83380400001)(36756003)(6666004)(36860700001)(47076005)(7636003)(53546011)(966005)(31686004)(5660300002)(31696002)(2906002)(7416002)(2616005)(426003)(508600001)(336012)(44832011)(9786002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 11:48:57.5728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1683f3-6465-4261-fe8c-08d9833f1f13
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7576
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/27/21 8:35 PM, Rob Herring wrote:
> On Wed, 22 Sep 2021 09:07:32 +0200, Michal Simek wrote:
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
>> When SOM boots out of QSPI it uses limited number of peripherals defined by
>> the specification and present in sm(k)-k26 dtses.
>> Then a carrier card (CC) detection is happening and DT overlay is applied
>> to brings new functionality. That's why DT overlays are used. The name is
>> composed together with SOM name and CC name that's why DT overlays with
>> these names are generated to make sure they can be used together.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>> Changes in v5:
>> - Extend commit message.
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
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

Applied.
M
