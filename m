Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 795483A1424
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 14:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbhFIMVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 08:21:45 -0400
Received: from mail-mw2nam10on2040.outbound.protection.outlook.com ([40.107.94.40]:39104
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230303AbhFIMVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 08:21:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CrF6/37tgaLzaahqS14rzWwfK/G8g4OukoWshsXGjd1fzvBtpjjoFmdfz9eAdKoNX0dVCxMEOVkFEfD4KfzzheDIxirzXRio+VsGCE7dB8UdKPomOxwuCLyz5IKbvjlDW6Ta3eqRZuNOf2q2ODWe4QMg7LvCrSmrQVh0UGQCXsNPiwiJNCmw3kbOu0Kcp/60hscqbb+K7P0/01BwMmv4JqUsj9hAQV2FgG8TXnvt35mfW2cChlXhKmUX0kSget3fgCxxolDI+gzN0uRZBr7iMnoEmzGy2j/k9b4/NTwnAC+HCVXguKV3g5WtXBfgyiryqdtLnrmajqJN4b4l2h5ijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEIq4wbm/kU0e34YSTZqixkYJx+w7YLZAR/e0EupiVk=;
 b=CBX8+XuLrAq6RNGyxfcv2rni2kugtGrYg1L5npABvvJLl1DCMTVFui4bmRw7b/HIZoDphoy9SwHWg4gf/zNBGBQ1F2TXT30Fg6MPLgWqREDgQaeuJUrFM8XQ52Kd5Ie6QuDIvIp9uzD5EYxYYKDZEg8/zQbXcTOlbmjmtK4v9/2s8ntJDcW6c03HWEjnbDXNYRVo0UOb1q76T31Zq6BM6RgM6Ja/6tS3ShLWWIyBv27jA7MtMyTlGg73C8EgOzVaYYyqI6AfXABi2gb7EHw7E8EQ4kkH+0Wc5FyWwf9kKdf4QGSkHSfd5wYM3fObYopzqN+kxeYaz/TWH1uaHciDog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEIq4wbm/kU0e34YSTZqixkYJx+w7YLZAR/e0EupiVk=;
 b=MOTrU1OreVC7FPvaM8tUZhST+K0/qr6T5Dct4bF3CzCm85exunbafwG0vcUObo88/lXDkFEEKmnc/LLGwsFDfSikA4o7gO9TJN6pwZ/yqxqrl6C62zl32A61riG5t5B11LMXpQobp8v9B2iP0W+xYS1EbIonqmRZ5iA4bDWm6Lc=
Received: from DM5PR06CA0077.namprd06.prod.outlook.com (2603:10b6:3:4::15) by
 SN6PR02MB5072.namprd02.prod.outlook.com (2603:10b6:805:6f::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.24; Wed, 9 Jun 2021 12:19:47 +0000
Received: from DM3NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::e2) by DM5PR06CA0077.outlook.office365.com
 (2603:10b6:3:4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Wed, 9 Jun 2021 12:19:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT024.mail.protection.outlook.com (10.13.5.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 12:19:47 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 05:19:44 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 9 Jun 2021 05:19:44 -0700
Envelope-to: git@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 robh+dt@kernel.org,
 michael@walle.cc,
 krzk@kernel.org,
 viresh.kumar@linaro.org,
 monstr@monstr.eu,
 linux-kernel@vger.kernel.org,
 geert@linux-m68k.org
Received: from [172.30.17.109] (port=57088)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lqxBP-0003oH-A2; Wed, 09 Jun 2021 05:19:43 -0700
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, <git@xilinx.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Walle <michael@walle.cc>,
        "Rob Herring" <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <cover.1623239033.git.michal.simek@xilinx.com>
 <ea3944deffedd8a09f097a54016bf9f2e9ddcb0e.1623239033.git.michal.simek@xilinx.com>
 <CAMuHMdX7J5UK1Y_ghqneppFTHDw=MQTUGcBy6GTeeCPZtcJojg@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 31/31] arm64: zynqmp: Add support for Xilinx Kria SOM
 board
Message-ID: <8404cf0d-08ee-627c-f842-819baf3420eb@xilinx.com>
Date:   Wed, 9 Jun 2021 14:19:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdX7J5UK1Y_ghqneppFTHDw=MQTUGcBy6GTeeCPZtcJojg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7364c6d0-0a7e-424b-c841-08d92b40df29
X-MS-TrafficTypeDiagnostic: SN6PR02MB5072:
X-Microsoft-Antispam-PRVS: <SN6PR02MB50726F2591D7E523C8AAB652C6369@SN6PR02MB5072.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fe3uW/RsSIh7KFkqYedzIm+jDi2t5QHsKhE4a/iIOnKY4LG+R85KxBoiWexS5h7xvR9NUeqZzEf0leCu7StuF7VGpaL9WHD7ejxbDZTCbdc/3HN1+ueWbVVeBpXNMCmy0haYLNXBpr86KMK1/ziKTt1Ab9b1/G+jT+QK2zudHEDoctPZeyaxTvl57lYHbtw2g5Ugv4NDAmIipcqGmVXQrwmMWknJ85UaP5oMb0edaRTS6llRxWEle5SRw5JHkwElABO+kLtfCAEF+yTfDy+ipu5af+Dco8/Cb6ejF7ZIRZGNsj/c/mBDqok8I9841O+CUFn6qAUVIDj+3vDtn9cVtfMaVzuAiPwHcR7L13XgheiDYVI3Y+ACwqU0VFSSVe5A4s1pyYNuL/Y8aV+BDdJR74AwvWr5wynhAliYbu1CXzCwylGA7+1Za7EMOGo2cKvhMN285KU0+BYksw96J73zIUASWDcCs5WesaNTJTafDCwylDEtsxYEGQWCLnsL9ohGWGCWypMSYoBPaf+b5edCqc79gU1DFSaVxak72WRe9h57FYnJr7RJLl0y30ryATs212l40KMwrYfYRAZC+ULWmm5K7hfOFhRtWvRCo9CYpacpwJn+EtpJPLDplcQHX11MY/OgNXX9GVMJkIKp51VIbU7G6AqEE0Z4WnyB4LlYs3kbmty+er4J5Ydrt8ecEo9+AcdNKfeMBQkSO0AkhyF8DA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39850400004)(136003)(46966006)(36840700001)(8676002)(36860700001)(426003)(26005)(44832011)(336012)(36756003)(186003)(31686004)(70586007)(2616005)(478600001)(9786002)(70206006)(8936002)(7636003)(82310400003)(316002)(54906003)(5660300002)(4326008)(36906005)(47076005)(356005)(53546011)(2906002)(110136005)(82740400003)(31696002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 12:19:47.0694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7364c6d0-0a7e-424b-c841-08d92b40df29
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT024.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5072
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 6/9/21 2:04 PM, Geert Uytterhoeven wrote:
> Hi Michal,
> 
> On Wed, Jun 9, 2021 at 1:46 PM Michal Simek <michal.simek@xilinx.com> wrote:
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
> 
> Thanks for your patch!
> 
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dts
>> @@ -0,0 +1,371 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * dts file for KV260 revA Carrier Card
>> + *
>> + * (C) Copyright 2020, Xilinx, Inc.
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
>> +/{
>> +       compatible = "xlnx,zynqmp-sk-kv260-revA",
>> +                    "xlnx,zynqmp-sk-kv260-revY",
>> +                    "xlnx,zynqmp-sk-kv260-revZ",
>> +                    "xlnx,zynqmp-sk-kv260", "xlnx,zynqmp";
>> +
>> +       fragment1 {
>> +               target = <&i2c1>; /* I2C_SCK C23/C24 - MIO from SOM */
>> +
>> +               __overlay__ {
> 
> Please use overlay sugar syntax, which is supported by the dtc
> supplied with the kernel since v4.15.

No problem I will.

Thanks,
Michal

