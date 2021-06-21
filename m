Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD6A3AE7D2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 13:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhFULDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 07:03:05 -0400
Received: from mail-bn7nam10on2059.outbound.protection.outlook.com ([40.107.92.59]:39809
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229651AbhFULDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 07:03:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeqhlItdJ4FD4S8ULuktmEKDroJLh8rMGmlVSiS+8D1wrjCpgD+ChLyDafNgJ2VL2eed8J6QnUoyB9tmfuL4BnQwaqxNublLvmD9E3pGL8MliLfe3lwcZr1WY7+GnYomxsI/7YsGNa1yc6kS3shXI33CfYNNoh6s/qf8nrzbvt35DkJfCjbvbHRty63GAg87zrN0Om7PJGGJUnUTOYolZwVORVxVWLC/0pK/WjSfYK249qhB2phgiGsqRLSxON9AgkYepxG+C259wQgHo9Eb7l/8pG+SJaaCYkySQ2ZDl++YXG66lQp+47lexGPu80DRRlXJXCUyt8gRxu/RmYrAlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWgzBPoO0VEBMZZcZZZNzJSB6SNd368MUG1O+/jsDBY=;
 b=OgizJGvvCINBxIlXUJ5N37MDbew1yGzGBH4upfTHU43QIWHFAVOdhEflkVRdzEgo4+pkXHEEIBOrFdKAy4hQy0TQV0iv/YdrryfNFYqKN9DdEYXwpy2gIiTBMAX9+HplnsBixzVgG9nrF6djjJDCW8MdKkqqHJN1IRMY4zauAKyi3ZW8VHH8qh8tLshfvxg2R4/SX90fHvUOrYPOpJ2bn2rfMBEUDSYSKIBPLLocuConsJByHTtRN5N9pvOPIWrZIzy4LDBv9W2uSWCi7FrA0q1SrNH5hdROAvqaexwslmi9rjOacQAFJbi63rEgRb5PCawMFjo4zBuL2LCNezOLLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=arndb.de smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWgzBPoO0VEBMZZcZZZNzJSB6SNd368MUG1O+/jsDBY=;
 b=KHsmKRs+Y8A8AoPiSnsj5ByCALitWd+/yQ8idOdiIM3cIakh19TL/WLJqxyk1gJKCtpQrY0+kawZFLpe7KdpyhBjXs9dwuwsdtY4ITKk67enm3IuH4AyXu3ToVJGdCSEhvwFlV4+tI81HBdgyc/hah6MJW+L/rfZm8xH3PJoWfo=
Received: from SN4PR0201CA0070.namprd02.prod.outlook.com
 (2603:10b6:803:20::32) by SA0PR02MB7179.namprd02.prod.outlook.com
 (2603:10b6:806:e6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 11:00:47 +0000
Received: from SN1NAM02FT0030.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:20:cafe::84) by SN4PR0201CA0070.outlook.office365.com
 (2603:10b6:803:20::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21 via Frontend
 Transport; Mon, 21 Jun 2021 11:00:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0030.mail.protection.outlook.com (10.97.5.194) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 11:00:47 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 21 Jun 2021 04:00:46 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 21 Jun 2021 04:00:46 -0700
Envelope-to: arnd@arndb.de,
 linux@armlinux.org.uk,
 robh+dt@kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 michael@walle.cc
Received: from [172.30.17.109] (port=45816)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lvHfa-0006R2-4q; Mon, 21 Jun 2021 04:00:46 -0700
Subject: Re: [PATCH 0/3] ARM: add NAND support to Ebang EBAZ4205 board
To:     Michael Walle <michael@walle.cc>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
References: <20210616155437.27378-1-michael@walle.cc>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <407a3259-6526-4c7d-6bec-bce1fd91ea01@xilinx.com>
Date:   Mon, 21 Jun 2021 13:00:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210616155437.27378-1-michael@walle.cc>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1018ae16-6607-4d29-5ba6-08d934a3d2fb
X-MS-TrafficTypeDiagnostic: SA0PR02MB7179:
X-Microsoft-Antispam-PRVS: <SA0PR02MB71798951979468DB542C4565C60A9@SA0PR02MB7179.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: myJ6uEt7vuBaI0s10qG6WU5zIKzNE2fxqJHLYCI9+8Xh8bvGriABwAdVhqbaaYeAUBTSaojXwRGyWpRFbc/lSkAOd87p7SXH6kHCWMR009Tmo5MT6KGFZmu0+GzkKkEOJgS0yN77ZklBmq4ibRBsKbPiO5ytQzdMM2MfEqdCfhUMMWf2MkmFqmlcqd6YzjCrfsI3oW1RqS1mLRMhiXMw/kdlQSL+NcnIsvyt4IJkoIN3bZci1KOlTuVyscbGt+qw5yJwBU2KFbkdXWZwcSAPXmzumMonYiwNK9s819K20Of9sj93+IWirOOPJGxjG3p3/19L1wbL6KI6qL7nR+3ke1UgjjtW1kDLA3awOaucViJ/FyT4JkbWbQXmpPIrQwrcN0hDJE3SOxgBSfZReZje4GnCdiYLV72Ey9Yuzzco8xm+gL3dF5r/7ljd/8n3kA1QNCcAplONmlEAKKfYCh1Z5l+twTrAUDp2eRm8k5jBPvIQlw8r31BP/GxaJyLOvGP1XRB/1TEnM69U1CKQI3pLk7un3i0nX1vMuM2sbTtIcFidQTIaaW5FExPXnqBcLvl6c7ToJZBuO3XgiFjsRG7Hj11VZpM0s88KwBvs4TrSIbDpXMi/Az7BqSzKU/XUofsXdBvjvbokh0jKdThvL24Ivoa08GfyitKOfxrGFTQ+gtHWXZzn6SftUV7JVlWljfF3glsSph9FKcWitw34ch7DcOuikj1OhTqtqWixoNuGxw4=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(376002)(39850400004)(36840700001)(46966006)(36860700001)(36756003)(26005)(4744005)(82310400003)(316002)(47076005)(6666004)(8676002)(2906002)(5660300002)(54906003)(4326008)(8936002)(31686004)(336012)(53546011)(70206006)(70586007)(356005)(478600001)(36906005)(31696002)(82740400003)(110136005)(7636003)(186003)(44832011)(426003)(9786002)(2616005)(50156003)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 11:00:47.2798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1018ae16-6607-4d29-5ba6-08d934a3d2fb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0030.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7179
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/16/21 5:54 PM, Michael Walle wrote:
> Thanks to Miguel, there is finally a NAND driver for this SoC and we can
> now support the NAND device on the EBAZ4205.
> 
> Btw. I'm not sure how often the PL35x NAND controller is used in SoC and
> if it qualifies to add it to the multi_v7 defconfig.
> 
> Michael Walle (3):
>   ARM: configs: multi_v7: enable PL35x NAND controller
>   ARM: dts: zynq: add NAND flash controller node
>   ARM: dts: ebaz4205: enable NAND support
> 
>  arch/arm/boot/dts/zynq-7000.dtsi    | 21 +++++++++++++++++++++
>  arch/arm/boot/dts/zynq-ebaz4205.dts | 12 ++++++++++++
>  arch/arm/configs/multi_v7_defconfig |  1 +
>  3 files changed, 34 insertions(+)
> 

Queue.

Thanks,
Michal
