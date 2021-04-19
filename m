Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC52364064
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 13:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238397AbhDSLXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 07:23:53 -0400
Received: from mail-eopbgr750074.outbound.protection.outlook.com ([40.107.75.74]:33669
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233132AbhDSLXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 07:23:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOCt4sQfuChV3v05E/JdnAOwZEUJyAv7QQE3I7f1qnxgXDZ1ushWUB6SM6C46DBQKt5A4P4uxWSj36FlGhibT5PiMNe0vlsKSOCDj23qsV8pZTVW2oqWVr4bTZ9xDBNDpSmLg2/Xi3jnWbJT+3kREngPFc4ocJMfiRSWQodByZu9Q+iG1uWm0/9HWqXJa9HVr4daOMLQNXOQskJjDj2ekadzBv3bu4+KCou/pl98sR1JuO7UeGjlhKkCU2KDfO8SxnQUOmPesCWwJpabPyWuexLil/2nw219Oj24KBCVTZ7WU5WZ2pg1l6Pzod1onIR0V9/rJuxjmQfjLIqjvni6Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2v6ZL0gVK6XXeeMPSg3QbxRP16b2zIhS3Dll/Mh+8g=;
 b=OloHO/fxYhFQtwE+ZqIIhgYmuXRI+954aZeWbT7G4J52rmLHKsvKweF7CIATpAmQgGq2grHQ+rJobD7MTaq43yHh1H++b4CL+8Xy7x4niff445i0ksVgNdhSZ2ZJ5vI/f1FWEXusWd5NNtcyj5uEdgRY564apeXF+VBVFA6ope4Mf6ZSUrT7XHbyU7iBGp/aQLBvfojNUpmNHlsj8lEj0n8C9mINLmATC5t3lmDZjkxYoOtvlDG/G1UUMydOwaE56zfzR9zj2wSGcWHxpTqu2JLNszNvEJE/E8WU5mRby7nkpzczSDdgiJdvvuO9TvIX5iuhBs5pxd7C2j1NHLHz/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2v6ZL0gVK6XXeeMPSg3QbxRP16b2zIhS3Dll/Mh+8g=;
 b=IcKIzDLiQ/J/yboIwanLnVCQJl45GienSYqV3d9bFVbHku/nrR4u1ocvEks8DTf083GsfnEKAIU5tZ/AhpBx1MC9uc2pc2W4KnybEu77BVsSIzxnTHNi8frY4PKk/nxuUxZ3C0sat/JUfAo2gIm9RGdNe7V4Ugvf+ot6S+LYnfk=
Received: from MN2PR15CA0032.namprd15.prod.outlook.com (2603:10b6:208:1b4::45)
 by MWHPR02MB3198.namprd02.prod.outlook.com (2603:10b6:301:62::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.23; Mon, 19 Apr
 2021 11:23:14 +0000
Received: from BL2NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:1b4:cafe::c2) by MN2PR15CA0032.outlook.office365.com
 (2603:10b6:208:1b4::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Mon, 19 Apr 2021 11:23:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT029.mail.protection.outlook.com (10.152.77.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.19 via Frontend Transport; Mon, 19 Apr 2021 11:23:13 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 19 Apr 2021 04:23:09 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Mon, 19 Apr 2021 04:23:09 -0700
Envelope-to: linux-kernel@vger.kernel.org,
 tglx@linutronix.de,
 maz@kernel.org,
 robert.hancock@calian.com
Received: from [172.30.17.109] (port=52716)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lYRzh-0001tS-1S; Mon, 19 Apr 2021 04:23:09 -0700
To:     Robert Hancock <robert.hancock@calian.com>,
        "maz@kernel.org" <maz@kernel.org>,
        Anirudha Sarangi <anirudh@xilinx.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>
References: <20210415233250.4071772-1-robert.hancock@calian.com>
 <87zgxys5xn.wl-maz@kernel.org>
 <2834595e6552c81441592a57dc41146d46484143.camel@calian.com>
 <877dl22k0y.wl-maz@kernel.org>
 <87916c069789a91a5bb0856c6ff9d72c36a59dd5.camel@calian.com>
From:   Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] irqchip/xilinx: Expose Kconfig option
Message-ID: <c3cdcb8a-9d32-3bf1-b69e-86e4942861cc@xilinx.com>
Date:   Mon, 19 Apr 2021 13:23:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <87916c069789a91a5bb0856c6ff9d72c36a59dd5.camel@calian.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dc202c2-ef00-416f-e274-08d903258586
X-MS-TrafficTypeDiagnostic: MWHPR02MB3198:
X-Microsoft-Antispam-PRVS: <MWHPR02MB319803F7B580C85846D31564C6499@MWHPR02MB3198.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: je2ChiJ66Fc49rm8BFMKQTzQZj0y2/UTzt1A0uUsGuzH8/ODkQfAX12UcMSQxcZGZxF5e8d/ecj4p/llQ9okhvJqX4YcTQ0Dbbc3l3iRGWmr3VRev/3Frv5ABVhuHKjHKyBTRtVgXOzEHWWsXj8p0A+h2Zibc0aFlLfwyjCWpepEksnBZjGqOOzJsuRuK7JliHatC/wddWe806OozIq1V4jfP14X614sIsY/EF3zVjyl3OIP8m1bHnJ3m29nR94+9Ziy1hfvLdcoBpp4WOhltOkLJNcR0rcB9DGBJQGQ6j+7L1iuJXBHOkx3GQYpOC1/3qFDWW4KRwdt4k+U8zmF3KCnN5ODtLbHV+ic1VTaekSJgccU0vKaJm+5L9egmVf5EVT+hg+mRqVe4hPzT/TTsl4gyYp9ugJ43YooKKAYmAe1WCkn+galIH6/dfh1/ahNtBPmIy/SsbyDJjV2vxGJG58P/5D4zPl1LQedwHGOyKoqL0WVrQLF80dueJ/SFEJDlAjTLmc+t+vfvMOJ+DziqSWr22/GuOnwA+Q4gsvDsdeMfoKoFkyxLvF0k91J7iIFLl2UrbgWAreWfLcKRtcUrG0A824YjovuyrG2KNjBYlq4HlxOJ5rEmMcUjTpxJmL4KZ5DloV5je4vTrmF73MKUynbQI6Ij6hYAIRVhy24GF/KlARaKZS/O459QCyycJr/BZWUAxBNTb10wCVanhKghg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(36840700001)(46966006)(82310400003)(4326008)(336012)(6636002)(9786002)(356005)(8936002)(44832011)(53546011)(6666004)(47076005)(36756003)(26005)(36860700001)(110136005)(186003)(426003)(316002)(54906003)(31686004)(70586007)(70206006)(5660300002)(2616005)(478600001)(83380400001)(7636003)(107886003)(8676002)(2906002)(82740400003)(36906005)(31696002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 11:23:13.7049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc202c2-ef00-416f-e274-08d903258586
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT029.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3198
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc and Robert, +Anirudha

On 4/16/21 8:14 PM, Robert Hancock wrote:
> On Fri, 2021-04-16 at 18:53 +0100, Marc Zyngier wrote:
>> On Fri, 16 Apr 2021 17:05:49 +0100,
>> Robert Hancock <robert.hancock@calian.com> wrote:
>>> On Fri, 2021-04-16 at 14:41 +0100, Marc Zyngier wrote:
>>>> On Fri, 16 Apr 2021 00:32:50 +0100,
>>>> Robert Hancock <robert.hancock@calian.com> wrote:
>>>>> Previously the XILINX_INTC config option was hidden and only
>>>>> auto-selected on the MicroBlaze platform. However, this IP can also be
>>>>> used on other platforms. Allow this option to be user-enabled.
>>>>>
>>>>> Signed-off-by: Robert Hancock <robert.hancock@calian.com>
>>>>
>>>> I don't think this is a good idea. In general, people have no idea
>>>> which interrupt controller they need to select. So you either end-up
>>>> with a missing interrupt controller, or a bunch you really don't need.
>>>>
>>>> This is essentially a platform constraint, and this should directly be
>>>> selected by the platform if you have this IP in your system.
>>>>
>>>> Thanks,
>>>>
>>>> 	M.
>>>
>>> The problem is essentially that at the platform level, we don't know, other
>>> than in the MicroBlaze case where we know it will be used as the platform's
>>> primary interrupt controller. In our case, we are using this IP core on the
>>> ZynqMP platform as a secondary cascaded interrupt controller in the FPGA
>>> portion of the device.
>>> But many ZynqMP configurations wouldn't have this device present, it
>>> depends on what the user instantiates in the programmable logic.
>>> Also, this core could just as easily be instantiated in standalone
>>> Xilinx FPGAs which could be connected to many different platforms
>>> over a PCIe, AXI, etc.  bus.
>>
>> Not compiling it for some users is great if you happen to *know* what
>> you have to select, which is probably a single digit percentage of the
>> people that build their own kernel. At least having it to depend on
>> ZYNQMP (or some other FPGA platform) would narrow it down.
>>
>> And if you have some other HW in your FPGA, you can make the config
>> fragment for this HW select the right interrupt controller. But I'm
>> definitely not keen on making this a universally user-selectable
>> driver.
> 
> In general there is no specific or unique config option for what is
> instantiated in an FPGA, it is completely up to the whims of whoever set it up.
> You can instantiate whatever logic cores you want and there is no guarantee
> whether they will or won't end up using this interrupt controller in the path
> somewhere, so having a dependency there doesn't make much sense. For FPGA logic
> it's ultimately up to the user to ensure the kernel config they are using has
> the right drivers enabled for the cores they are using. Kconfig doesn't and
> can't really help in this regard.
> 
> There's some precedent on this issue with drivers for various other FPGA-based
> IP cores for SPI, I2C, Ethernet etc. Often they started out with an
> architecture constraint which limited them to the platform they were originally
> developed with, but which was later removed because the ability to use them in
> standalone FPGAs means that the platforms they could potentially be used with
> are basically unconstrained.
> 
>>
>>> So I don't think having this as a platform constraint makes sense.
>>
>> I don't think imposing this on *everyone*, across all supported
>> architectures and platforms makes any sense. Surely, people who build
>> their own HW (because that's what we are talking about here) can be
>> bothered to add the small Kconfig fragment that is required to their
>> kernel build.
> 

The same interrupt controller was used by ppc405 and ppc440 xilinx
platform in past. Unfortunately it was separate copy of this microblaze
one and ppc copy should be already removed by removing support for these
platforms.

The first(default) configuration which was mentioned above is primary
interrupt controller for Microblaze.

That being said this controller can be used and actually is used by
Xilinx Zynq(arm32) ZynqMP(arm64) and Versal(arm64) SOCs as a cascate
intc controller. I have also seen couple of different cpus in PL which
can use (and actually use it) this soft IP. But limiting it for
Zynq/ZynqMP should be fine.

Recently my colleague (Anirudha) did some experiments with binding and
unbinding this driver for cases where you are using it as cascade
interrupt controller in a programmable logic(PL) (primary controller is
GIC) and then you want to exchange the whole PL by different
configuration that you need to have option to remove this chip.

Thanks,
Michal
