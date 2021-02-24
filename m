Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A76324050
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238290AbhBXOuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 09:50:52 -0500
Received: from mail-mw2nam10on2065.outbound.protection.outlook.com ([40.107.94.65]:65408
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236287AbhBXNk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 08:40:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xcak57L66rkA4gDhn1UklF9Qvb04IJB3Ma+GgN3K4TeE94C3KPjn4t6qdDui3W5WzTRgmQrqy5IA4YezvsYSNTYItnzr+LSDoaytFZma9/6rqc1AKSUNz0Nj/wB4ebdSAaSTYX9sZc+HCzfVxjFLk8P8W3j2wmuXCOIY8N4CWBcJLjihx9vpT8bodLCcSQDDfyRYJTxWQqHlqmKVpPA1HohH1k9WMCWAYedkq/In70ROj4O9nO5cgtIDGHc8OaABFRDZK78QE2buLDFyZI+++0/kb0zgdJDAkvrCwvvK0cnAo9Y+B3ARqUfObwaffWdgKO19Z2dAOh8Y2buyKn9RHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uddiR23nLbTsu2JRly06j6Eu4X74EACaUVKQuDImbdc=;
 b=VM8601qzYurPsBLA9Tc26MPxYFQ162LXIT/6WLGcWyc+E/t14GwewK/MOosFYEZKQ79zHpALES4iIXhaiSHskVhYVsCauZEKssVy5Omq4keTgQZIfei79WCjsI6EoG28hAL/HyM/aNKUHZjKMTMwEUDJnv31x2Yq0Tskgif8fvQ0xsrPn2FP/FjIm/LXLMujO2cWmZZQ2EuvZAjF8W6WZWUNPFeIpwhSLLR1K2FdecT0oj/iaX2dtjivh3doRfid37JUSjqNm/X8Hi9JgXTmqx1wMaxKSwZcq8jk+iwaylUmaHwHbDL9Dktl2JNlNUmSBeJa0IUcOdGkNjCCgw7ldQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=the-dreams.de smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uddiR23nLbTsu2JRly06j6Eu4X74EACaUVKQuDImbdc=;
 b=nYJOfdwOBXaMouSeUhtiC8fUZWIUO2dMdF8ryb1kuoLamuuZqrRXrFrY7YnR7mXVavfJqWQ3+S/Qlqco5zan5TZ+dyEzHw+qrImhXyX2R5dWgVv5WfNXQtWrEhefBIGW3BhTr1cUwQciKwualc+3FwUhk3bOLGaTCXtlGUXPUgc=
Received: from MN2PR13CA0016.namprd13.prod.outlook.com (2603:10b6:208:160::29)
 by BN6PR02MB3186.namprd02.prod.outlook.com (2603:10b6:405:67::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Wed, 24 Feb
 2021 13:38:21 +0000
Received: from BL2NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:160:cafe::eb) by MN2PR13CA0016.outlook.office365.com
 (2603:10b6:208:160::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.11 via Frontend
 Transport; Wed, 24 Feb 2021 13:38:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; the-dreams.de; dkim=none (message not signed)
 header.d=none;the-dreams.de; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT029.mail.protection.outlook.com (10.152.77.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3890.19 via Frontend Transport; Wed, 24 Feb 2021 13:38:19 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 24 Feb 2021 05:37:50 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 24 Feb 2021 05:37:50 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 wsa@the-dreams.de,
 linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 gregkh@linuxfoundation.org,
 monstr@monstr.eu,
 linux-kernel@vger.kernel.org,
 robh@kernel.org
Received: from [172.30.17.109] (port=46528)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lEuMP-0004Bz-LM; Wed, 24 Feb 2021 05:37:50 -0800
To:     Rob Herring <robh@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michal Simek" <monstr@monstr.eu>, git <git@xilinx.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>
References: <cover.1612867682.git.michal.simek@xilinx.com>
 <076994fc051e9230a3fef9e3eb5ec932104ef16a.1612867682.git.michal.simek@xilinx.com>
 <20210210222241.GA2901449@robh.at.kernel.org>
 <584bfee2-17a6-5935-b61c-b49824bcf857@xilinx.com>
 <CAL_JsqJedhX6typpUKbnzV7CLK6UZVjq3CyG9iY_j5DLPqvVdw@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: misc: Add binding for Microchip
 usb5744 hub
Message-ID: <2f0f4e86-cf9d-03d7-a3a6-8f2284facaaa@xilinx.com>
Date:   Wed, 24 Feb 2021 14:37:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJedhX6typpUKbnzV7CLK6UZVjq3CyG9iY_j5DLPqvVdw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 372b979d-669a-4371-219e-08d8d8c972e5
X-MS-TrafficTypeDiagnostic: BN6PR02MB3186:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR02MB31860C504EAFF70E59DDA038C69F9@BN6PR02MB3186.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tChDGo2A/70Nr3DDu+LrGeUwyhlfC4OiC92T6HUeSGDVKTi7IF+S/kiSR5G5VfRrq+n99uDPmtJ4ipywxcFDVKcnCNe/xQoxn9UmuAiTUHCwMFvV7gCmCWxqxWSA2K6CgjhqMRnoDKTqaaDs0AHZU9WvWngPJcv1kbLn6eK/izYzcW2carc3BxMy0ytd0B8XouUe1r0eirHi+gNMb+sBJmH0v5YPi6XL5RNHqx2OJhql6AYstts/WF2MquyKG1SwVc5AnLbdtgbeg2eg9kamKuXumj5O8mMqMFtMVroqw2cAXWmqbGlf4aEQ87B92n/emBQeghjX9wkk8otww80ghJXDx/LXEEuRmAwd4MhPYITwm4c5ktpq7/ymXKXx04yNA0zqiTmzE6bugW0+hpxfZVtamNqNZNQRP8gtwO8PbknI1sDXWEMN3cr1nNZ9DSkn+MXWHWdUtMfm8MbyE+IDZg0Sj7+wDKcMRB+1lnOe1D21iWkdTkfgXmxFX2zldAwUEslMY0b4X5wmBPQwOgGdmKYqQ4SDS6jNJuW1cpH9/MHaH8D4MEakWj4CCALWuOfTH19LYPCtDM5A5KmZdvmB/2gN8NA0C07/XpItMe4aRht5KBFnl/7J7lqagu4P7fxC3cSyiSdGclVtGJLYO/dUgMyAwJYO3SIticuAKfpzEQieqyuVdpNJe8cpZFFpOYkTI5bIDMEwVJhbN2cQR83KW73+rGeD5TdcEnI6ll1iISC5XO49UuR87LvUXDE8zHnSwEdxOyDqGr3DlFoIn1zUo/nG4Zu7G6LCfT+vbrgo2zw=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(346002)(376002)(46966006)(36840700001)(8936002)(7636003)(36860700001)(478600001)(44832011)(8676002)(36756003)(110136005)(356005)(31686004)(316002)(54906003)(83380400001)(186003)(2906002)(53546011)(5660300002)(70586007)(70206006)(26005)(31696002)(426003)(82310400003)(82740400003)(2616005)(6666004)(9786002)(336012)(4326008)(47076005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 13:38:19.9021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 372b979d-669a-4371-219e-08d8d8c972e5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT029.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB3186
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2/11/21 3:42 PM, Rob Herring wrote:
> On Thu, Feb 11, 2021 at 3:35 AM Michal Simek <michal.simek@xilinx.com> wrote:
>>
>> Hi Rob,
>>
>> On 2/10/21 11:22 PM, Rob Herring wrote:
>>> On Tue, Feb 09, 2021 at 11:48:09AM +0100, Michal Simek wrote:
>>>> From: Piyush Mehta <piyush.mehta@xilinx.com>
>>>>
>>>> Added dt binding for usb5744 driver.
>>>>
>>>> Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
>>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>>> ---
>>>>
>>>> Changes in v2: None
>>>>
>>>>  .../bindings/usb/microchip,usb5744.yaml       | 56 +++++++++++++++++++
>>>>  MAINTAINERS                                   |  1 +
>>>>  2 files changed, 57 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
>>>> new file mode 100644
>>>> index 000000000000..fe222f6db81d
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
>>>> @@ -0,0 +1,56 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: "http://devicetree.org/schemas/usb/microchip,usb5744.yaml#"
>>>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>>>> +
>>>> +title: Bindings for the Microchip USB5744 4-port Hub Controller
>>>> +
>>>> +description:
>>>> +  Microchip’s USB5744 SmartHub™ IC is a 4 port, SuperSpeed (SS)/Hi-Speed (HS),
>>>> +  low power, low pin count configurable and fully compliant with the USB 3.1
>>>> +  Gen 1 specification. The USB5744 also supports Full Speed (FS) and Low Speed
>>>> +  (LS) USB signaling, offering complete coverage of all defined USB operating
>>>> +  speeds. The new SuperSpeed hubs operate in parallel with the USB 2.0
>>>> +  controller, so 5 Gbps SuperSpeed data transfers are not affected by slower
>>>> +  USB 2.0 traffic.
>>>> +
>>>> +maintainers:
>>>> +  - Piyush Mehta <piyush.mehta@xilinx.com>
>>>> +  - Michal Simek <michal.simek@xilinx.com>
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: microchip,usb5744
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +    description: |
>>>> +      Specifies the i2c slave address, it is required and should be 0x2d
>>>> +      if I2C is used.
>>>
>>> If I2C is not used, then this should be underneath the USB host as a USB
>>> device. That also implies a different compatible string. I'd suggest you
>>> just say I2C is required if that's your use.
>>
>> We can't say that i2c is required because we have both cases. One is
>> really usb hub connected over i2c which at least requires to send one
>> smbus command to start operate. But it can be extended to add more
>> features - limit speeds, disable ports, etc.
>>
>> And the second is really the same usb hub without i2c connected which
>> runs in default mode. But reset is required to ensure proper reset
>> sequence.
>> Hub also have external clock chip which is not handled now because it is
>> just crystal on the board but if you want I can also model it via fixed
>> clock and call clock enable for it.
>>
>> It is the same use case as is with
>> Documentation/devicetree/bindings/usb/usb3503.txt
> 
> Yes, there are examples of how we don't want to do it.

ok.

> 
>> Can you please elaborate why different compatible string should be used?
>> It is still the same device and not quite sure why different compatible
>> string should be used.
>>
>> Do you also want to example where this node is the part of usb node?
> 
> See usb/usb-device.txt. And there is this[1] under review.
> 
> For these cases with I2C, I'd really rather see the hub always under
> the USB bus with a link to the I2C bus when connected.

I read that thread and also looked at his device and it is very similar
to this one. Binding should also have information about i2c or spi. It
is the same case here that you can use this hub without any bus
connected which works in default mode. Or when i2c/smbus is connected
and the hub is waiting for initialization sequence. And I expect spi
behaves very similarly but don't have this setup here.

Do we have any binding doc which is using suggested bus link?

Thanks,
Michal


