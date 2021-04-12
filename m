Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67EFB35BB93
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 10:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237124AbhDLICj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 04:02:39 -0400
Received: from mail-dm6nam11on2057.outbound.protection.outlook.com ([40.107.223.57]:22425
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237097AbhDLICa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 04:02:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmpNQwUxzjjbp8hNBlDXcpehIDcjT9vX/9HI97BXMWhMvsddmClHFmupt4SKC7bn8hdFB3ju+BrPdbLESTOtQE++xKCfK1w6gm4cAXLlM+Pn4/Dorh90XMu6VMnAc71/cHHVf/nL0jARVpaX49YJOZBeI5afmbvNlVKJUQSS6gXhTPVfhnwAaoILT4RPvSN9b5Zd8CUIuj1g01AkRJfrYT2t5iRPBusvdBqjQ+ywl2dFPKu5qoCIHnmReGSxQ7xnT9R+H6fU9nkrZREpPtdw7qYhRbJzrQ9Ja4XFldjIXcVZ40GlgHJc070b6e8E5hdubdSIiBarCOe56+cd33kzUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dngczhnu3aRn/DwI4m8c5n/HnnCT4FBEVYDTl5i/Pg=;
 b=Q0mSAFSg4of4jnyRyW63xjw0dhgPw2oAd4PSla5GlpYiXLtLqNM7J/tKttdlkkVaZJU0Z9xSQ8LBJ+hkf2I/DOdr6TNBjTNjcuMo8ViSH3xBlYeDTPq7Jank9TOb7G/hoG0Z4EhY8QPHMxGcqzaaPxn7XzwFHt3HNe16wo24WlG0SVq/7cS2SPYPWCYKSdYNxet/l0DY7FNvNWHfq1fwzAkUF77EaGx2Hsob/z6YEVgbTeZi/xfla+nLMX/4V5LXaDdetOGhnNL1ZKCuWzoiOhJ3fMDSvP1LbvbirKCnGGbAOxQBaOa0YqMVClomgB97DAUbz5O9XidJMxik8zjnDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dngczhnu3aRn/DwI4m8c5n/HnnCT4FBEVYDTl5i/Pg=;
 b=WqfnuBnOt4+kicq3Z5noreSbGsMnqUnLmoWmM5yMe5k9gndvCTsNGe0o4ya2MYRNglZs4MG5mW0dsYQd0zPj6WrVM8TzdsjhSJdO/6bJpwgzHMeWmi1uwqh3x1luql/aLEvnmeZyLQvB9imjHcOb7Pvz/czcqLXjoSo233ir3v8=
Received: from DM5PR21CA0026.namprd21.prod.outlook.com (2603:10b6:3:ed::12) by
 DM5PR02MB3244.namprd02.prod.outlook.com (2603:10b6:4:65::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.17; Mon, 12 Apr 2021 08:02:11 +0000
Received: from DM3NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:ed:cafe::be) by DM5PR21CA0026.outlook.office365.com
 (2603:10b6:3:ed::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.4 via Frontend
 Transport; Mon, 12 Apr 2021 08:02:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT004.mail.protection.outlook.com (10.13.5.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Mon, 12 Apr 2021 08:02:10 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 12 Apr 2021 01:01:56 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Mon, 12 Apr 2021 01:01:56 -0700
Envelope-to: git@xilinx.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 linux-usb@vger.kernel.org,
 p.zabel@pengutronix.de,
 balbi@kernel.org,
 robh+dt@kernel.org,
 gregkh@linuxfoundation.org,
 linux@roeck-us.net
Received: from [172.30.17.109] (port=49698)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lVrW7-0004FT-Ab; Mon, 12 Apr 2021 01:01:55 -0700
To:     Guenter Roeck <linux@roeck-us.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>
CC:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <balbi@kernel.org>, <p.zabel@pengutronix.de>, <git@xilinx.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1615963949-75320-1-git-send-email-manish.narani@xilinx.com>
 <1615963949-75320-3-git-send-email-manish.narani@xilinx.com>
 <20210407214811.GA260719@roeck-us.net>
 <ee280235-736d-1689-d324-b090c21106c9@xilinx.com>
 <82dc676c-10c7-2a45-7ab3-ecad46eab0a3@roeck-us.net>
From:   Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v4 2/2] usb: dwc3: Add driver for Xilinx platforms
Message-ID: <966e3077-ace0-0c38-90ad-e5b833cbbde6@xilinx.com>
Date:   Mon, 12 Apr 2021 10:01:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <82dc676c-10c7-2a45-7ab3-ecad46eab0a3@roeck-us.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d33e0350-03cc-4ce2-9766-08d8fd8946a2
X-MS-TrafficTypeDiagnostic: DM5PR02MB3244:
X-Microsoft-Antispam-PRVS: <DM5PR02MB3244934C68BC749DFF1B1EE4C6709@DM5PR02MB3244.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fUnyXHb9kJVEuMm8NMgluhv2WnaNgfPkMKopiZ6ErNBAXjPyXBgtGveT5Yk/2UT2yYa+PR7Fw+bQpE5ii+vg1hWoGUeqMqpIkirsCEV0brzk80KHtTzd62SMaw8V2Yh1fnRDXXhz94G9gysprRyFcO4yu/v+VzGxsYd8uDVOc8RlaTwIwOqQZrM/ddfxBpkplKHTJOq7eEutSg7yAWlj+Wz4rBgeP3S8Cs8QYQDkfV8C43QxlCAdPwuwKyD5uJ/1mjTtj/QANHWXHCahZaU5xdd2lZTePXgRly4x0usrNkUyzbRz7jIPKhYQTn1Y7kBVTVLK56kZf/28TpOhoHsesjAMJ8HhmTyZD65OvSfOfmyrb5sL23S2Qv0LAl1F/FlrGDMUUJMeJjQ7jhAa48BI7F+1cijfQF1ZFlwwCfBS1PdorHd9ss8M7vK+xHs7pdEuPSim4DbEqNZRy90mcw4+lIkC3nSzFvkh90p1yiAUvnoeSX3mzp+tHfoJk0ibwm/oP9iRC40PpNkiKXn0/PJ7mUa7FYiPapI0l+xbWDkQyrBKflnW4zYk9uMfWgdd/sFsc03Kb02SPNffJr4JT70m6Dx8YcfkWkUC3M9kbyV8Vds/Lq7xoEJRHsitGLtqsQWKuRQJQMowtAyBpWiw7C2hdq3UohQpUmSnkV5qrU/fqZUG1k0r/OYREFMPxo6n2WdxX0AGitZesik6pzDP72R6Trh/iQqvlwTr3Pmbc4aKjaFOGcwCzWiODumrZ0tvuzgbtNZleEox8WAOiyfWmpSYmKVBu82+koxz1y7sHEREcGc=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(39850400004)(36840700001)(46966006)(8676002)(53546011)(9786002)(82310400003)(110136005)(36860700001)(2616005)(8936002)(426003)(6636002)(316002)(336012)(5660300002)(54906003)(4326008)(36906005)(44832011)(31696002)(31686004)(2906002)(70586007)(7636003)(36756003)(356005)(186003)(82740400003)(26005)(4744005)(83380400001)(47076005)(70206006)(6666004)(478600001)(966005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 08:02:10.9413
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d33e0350-03cc-4ce2-9766-08d8fd8946a2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT004.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3244
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On 4/11/21 4:02 PM, Guenter Roeck wrote:
> Michal,
> 
> On 4/7/21 11:08 PM, Michal Simek wrote:
> ...
>> It looks like that you directly created the patch. Isn't it better to
>> send it yourself? Or do you want Manish to create it based on guidance
>> above?
>>
> -next is substantially broken all over the place. I already spend way too much
> time bisecting and analyzing the failures, and making sure that the problems
> are not caused by qemu (which is why I tracked down this problem in such detail).
> I don't really have time to write patches and guide them through the process,
> sorry.

I definitely appreciate your help on this.

Manish has sent a patch for it already.
http://lore.kernel.org/r/1617904448-74611-3-git-send-email-manish.narani@xilinx.com

Not sure why he hasn't added you to CC but at least Reported-by: tag
with your name should be added.

Thanks,
Michal
