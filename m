Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA50318740
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 10:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhBKJlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 04:41:21 -0500
Received: from mail-co1nam11on2063.outbound.protection.outlook.com ([40.107.220.63]:49973
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230107AbhBKJgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 04:36:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MryZT4oGS4lI0R6+iv5HCvskulfZMedWnl75m1r5K/8IBb+VQZTRJRABS5o56nZGore6kZ36WeGqyCJCs5t2E6eC/XFS9lvcXr7MteNupsMhM7cIWEywLtP/7Uy9vah0saTzCkbciMIVt35Kwn20M1NNab9btX73dsrdiNy7VyXLts073QHrnh3E3oDqFVWmQG7QIMwxvi9SXbYbL7ZHvmoq+zL9ReQFdh0d3mR9Y9qGc0fqoiPwz64Vlv6kqs+B7g2s/Jl7kH45o3WoWuyRz/varl2S1oI4DAoiweNjgESUQ8w8hVNLSSSm9l6vquVPshaw7kCGQ0CSGhbIMkqrqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1r+jM2FE1fpl/Af6Gg0W6TeIMckZ5z0YAY8gpYSiPJQ=;
 b=HUR0dBORUnr4hqJRo5OIVL48nl/G/2y3dBW9N5TT4JNyLQxz0UrhsQtCCuWksrwd7R/wmSPpDS49oddVwI96rPuOhKBIs+bSB87+e3548AV6D3MXFl3Qo+vd3vqtvPUXGCP11qu2zbawXqV18jJ9PryT6zmQLeEBVl6trWq6oOu2TXEIiB8nc4SDEUfcS9Ifs+fIF+eI3+ssXYm5u58wLpXyEmTFTBmcHxSM4KkbGsnHI4PC2bFFWqU+8tNo81AjaGcQctgv4Ik8oi2RVRqJcGRoTUPLv/pJYI33TJ5uQC0OpbQUq1CjFaiJsL4g9Sll21pTTiV8KGX0rqeXK2TxbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1r+jM2FE1fpl/Af6Gg0W6TeIMckZ5z0YAY8gpYSiPJQ=;
 b=sWrJPUgUJDQZwmjpDuDlVfyHmSnAPSzXq2r8BzDleLw8cGYlIqbUAZYj7il0sopHX2OiKWxOC2cPEtJlQmwT1eTITowJR3Ihx+cZYfsh+Ki1J+z6adL+05IyPTEgyHJjwKdGEvyK1FeZalRSs4faNzQc4XU4qFGwRDJv+NoZiZI=
Received: from SN1PR12CA0097.namprd12.prod.outlook.com (2603:10b6:802:21::32)
 by BN6PR02MB2578.namprd02.prod.outlook.com (2603:10b6:404:5e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Thu, 11 Feb
 2021 09:35:43 +0000
Received: from SN1NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2603:10b6:802:21:cafe::ca) by SN1PR12CA0097.outlook.office365.com
 (2603:10b6:802:21::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend
 Transport; Thu, 11 Feb 2021 09:35:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT016.mail.protection.outlook.com (10.152.72.113) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3846.25 via Frontend Transport; Thu, 11 Feb 2021 09:35:42 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 11 Feb 2021 01:35:24 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Thu, 11 Feb 2021 01:35:24 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 gregkh@linuxfoundation.org,
 monstr@monstr.eu,
 linux-kernel@vger.kernel.org,
 robh@kernel.org
Received: from [172.30.17.109] (port=60730)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lA8Nf-0003Jy-OY; Thu, 11 Feb 2021 01:35:23 -0800
To:     Rob Herring <robh@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <git@xilinx.com>, Piyush Mehta <piyush.mehta@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-usb@vger.kernel.org>
References: <cover.1612867682.git.michal.simek@xilinx.com>
 <076994fc051e9230a3fef9e3eb5ec932104ef16a.1612867682.git.michal.simek@xilinx.com>
 <20210210222241.GA2901449@robh.at.kernel.org>
From:   Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: misc: Add binding for Microchip
 usb5744 hub
Message-ID: <584bfee2-17a6-5935-b61c-b49824bcf857@xilinx.com>
Date:   Thu, 11 Feb 2021 10:35:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210210222241.GA2901449@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bedae879-77f8-4285-35ba-08d8ce7066c8
X-MS-TrafficTypeDiagnostic: BN6PR02MB2578:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR02MB2578D7E821382BBF92CC858AC68C9@BN6PR02MB2578.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9r5yNa4I/xy+fSZMQIL1pDFT2SrOXo2Ggoy6FGITqGqCYS7MT9xiwL9SsIRzQg0zvsozO571SaJ+2JdEbdllqkRD+KaZ1FYQ2rXN8li8k9gL8c2tk3exnkvSRuUf6nuFyzpXx4LN2CLNrg1az9a37OACm+03lR2v32k4yqhwG+aJP21+7qxJtLOby0r2K66CPHBSeYyUnjWqhL3qbff0vTdkPjbrrpdNg0te6RNBOpw/zNGalKqlvwHKbL9BhVdUO48guf/YYiayxyAx7UU1iI23x7B8b7xZnz7A6ZD3rwnKm+WRzxloXeR+3sR3hy1VLNmHIaUxPwM97pQ5Eo/YpZhMRplk+O7FXu6N/JQWmfEE5QV6ZiTt+IOyr6RpuhbmmIu0pjk+l+euJrt0POGP/z+mVFUSyT5KTJ+9pmb0u5QO3TXWUwS3ZXPIpkeTMTijCpIli/tXveTDKj/ApaqqA9xoqre0QWMMFWXsA8KmKWS/7E2NlBGiAzNUyk+hKcDSOguIOZ8Y7Ov+MU96z0FWgTXzG3EE7xqiSRYtlT6tJPWAqhzz6QNadD8fgD6qLKLFTUdPlBcVYNO/MWDTpyW7OHH2T8uPLo1iSnKmPEZgurU2R4Q7LVJMWy1ktFqI7VrkTwhMvNW7bfyBxpN7BzFq8tyWvzapDiG8EFr1K3wH5/nOkfxMXqxJxWTItmLzWqVgVWh8EXHsZr52/55fMdmgvy3EWeAHKruZ6wYIgKXOEXUGbDKfCTEMUZjZOA1vAO4FPDzK9Ct5FdZ1yimjtWCUwpNRqtZOnOweO/h+0kwWcYs=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(36840700001)(46966006)(8676002)(36860700001)(2906002)(7636003)(426003)(336012)(82740400003)(47076005)(4326008)(31696002)(83380400001)(70586007)(5660300002)(186003)(8936002)(54906003)(110136005)(2616005)(44832011)(26005)(9786002)(53546011)(36756003)(356005)(478600001)(31686004)(70206006)(316002)(6666004)(36906005)(82310400003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 09:35:42.8167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bedae879-77f8-4285-35ba-08d8ce7066c8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT016.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2578
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2/10/21 11:22 PM, Rob Herring wrote:
> On Tue, Feb 09, 2021 at 11:48:09AM +0100, Michal Simek wrote:
>> From: Piyush Mehta <piyush.mehta@xilinx.com>
>>
>> Added dt binding for usb5744 driver.
>>
>> Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>> Changes in v2: None
>>
>>  .../bindings/usb/microchip,usb5744.yaml       | 56 +++++++++++++++++++
>>  MAINTAINERS                                   |  1 +
>>  2 files changed, 57 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
>> new file mode 100644
>> index 000000000000..fe222f6db81d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
>> @@ -0,0 +1,56 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/usb/microchip,usb5744.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: Bindings for the Microchip USB5744 4-port Hub Controller
>> +
>> +description:
>> +  Microchip’s USB5744 SmartHub™ IC is a 4 port, SuperSpeed (SS)/Hi-Speed (HS),
>> +  low power, low pin count configurable and fully compliant with the USB 3.1
>> +  Gen 1 specification. The USB5744 also supports Full Speed (FS) and Low Speed
>> +  (LS) USB signaling, offering complete coverage of all defined USB operating
>> +  speeds. The new SuperSpeed hubs operate in parallel with the USB 2.0
>> +  controller, so 5 Gbps SuperSpeed data transfers are not affected by slower
>> +  USB 2.0 traffic.
>> +
>> +maintainers:
>> +  - Piyush Mehta <piyush.mehta@xilinx.com>
>> +  - Michal Simek <michal.simek@xilinx.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: microchip,usb5744
>> +
>> +  reg:
>> +    maxItems: 1
>> +    description: |
>> +      Specifies the i2c slave address, it is required and should be 0x2d
>> +      if I2C is used.
> 
> If I2C is not used, then this should be underneath the USB host as a USB 
> device. That also implies a different compatible string. I'd suggest you 
> just say I2C is required if that's your use.

We can't say that i2c is required because we have both cases. One is
really usb hub connected over i2c which at least requires to send one
smbus command to start operate. But it can be extended to add more
features - limit speeds, disable ports, etc.

And the second is really the same usb hub without i2c connected which
runs in default mode. But reset is required to ensure proper reset
sequence.
Hub also have external clock chip which is not handled now because it is
just crystal on the board but if you want I can also model it via fixed
clock and call clock enable for it.

It is the same use case as is with
Documentation/devicetree/bindings/usb/usb3503.txt

Can you please elaborate why different compatible string should be used?
It is still the same device and not quite sure why different compatible
string should be used.

Do you also want to example where this node is the part of usb node?

> 
> 'const: 0x2d' instead of maxItems is the schema to express the address 
> if fixed.

Will fix.

Thanks,
Michal
