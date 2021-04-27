Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984F036C7A8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238360AbhD0OU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:20:28 -0400
Received: from mail-bn8nam11on2058.outbound.protection.outlook.com ([40.107.236.58]:45024
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236173AbhD0OU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:20:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2RuH+6pqtBZXFt1uX/2KgPhzQiz6ujpMI7mdGJ0UAs2kPPPfFxr7Pku6jmrW0KF4z3DYA/fONUIfW8m4OwaGK3FYU2F67xed8VmYVkZRRNVzJ52dZ6i3VsAgbqIdceVd9kXw4UTX/QBbqtgfNqkpddq0YtBqcIflOMGo8V8CaxKBikvyTBoV44Cy0uxTuAIIN1rd8IUi4RNH4avJGZx6p1kc7DNRgv8ewyuwniQT+Prs6r8K61o4qjNXT4LdrMNKBTBAlqUc+hvy0z3lNwKCL3gbbEB9BITQ0OCUMGScwz5ENjz5LU+7ZfrMpN2jG0YJY+3QirkFXqUhZoZ/5/Wcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tn0FVY6RL/s71mBwIwUWYZguy5KY37Nc5MxgJgt9fpQ=;
 b=gDS1SjyS5Mm8UPFGZYhjFO2otdQ2txegNgnS/4MJlZuiLqXm4LsuHdBkj/hx8c/AKnYioN1IacbSB7+WoCI2nIKvrZCILjtZhowplKnvxs61acveM8QzMSwHnlcUhLdTVt5zzXfxQbq6il3zW/rhmnYsF2vlL0qAKPMjNMW7YShDbmSY+8rq8wFFoprDAHupc3WpFue4SJTVuIO9YzrXMAnTuy6RT2NXxLUqvLFVxdj/+cTxe79YRRzuuqlHhTsT01QiBW5AEKzH1tCmXfBdoQaRnI81XjtAIDhNnEhtMedOcUF3G+ae9+u+OiZHAlNRcoyngFfp7T8EcSjOoC5qpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tn0FVY6RL/s71mBwIwUWYZguy5KY37Nc5MxgJgt9fpQ=;
 b=q5sFdzJIPPKBO4m05XviG/nH4ZAGcV/n7+N0VyMqccLzL4LO5FFiUNfZnzcJjVDL6nf71f/2TO6aukOPIgH1/IecWcsg/FAYPREF8zwNqXBoi/6iKroUPqadNPmdUThvPEzU9wwNACcqi5Y9nQeyGlRyVm5o7BYIQM6OWNmhIJw=
Received: from DM6PR06CA0021.namprd06.prod.outlook.com (2603:10b6:5:120::34)
 by DM6PR02MB4170.namprd02.prod.outlook.com (2603:10b6:5:a4::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Tue, 27 Apr
 2021 14:19:41 +0000
Received: from CY1NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::cb) by DM6PR06CA0021.outlook.office365.com
 (2603:10b6:5:120::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22 via Frontend
 Transport; Tue, 27 Apr 2021 14:19:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT016.mail.protection.outlook.com (10.152.75.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Tue, 27 Apr 2021 14:19:40 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Apr 2021 07:19:24 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 27 Apr 2021 07:19:24 -0700
Envelope-to: linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 patrice.chotard@st.com,
 daniel.lezcano@linaro.org,
 tglx@linutronix.de,
 andrea.merello@gmail.com
Received: from [172.30.17.109] (port=50338)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lbOYd-0004pS-PD; Tue, 27 Apr 2021 07:19:24 -0700
Subject: Re: [PATCH v2 0/2] Fix missing entropy on Zynq arch due to
 get_cycles() not supported
To:     Andrea Merello <andrea.merello@gmail.com>, <tglx@linutronix.de>,
        <daniel.lezcano@linaro.org>
CC:     Patrice Chotard <patrice.chotard@st.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Michal Simek <michal.simek@xilinx.com>,
        =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>
References: <20210406130045.15491-1-andrea.merello@gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <f20bbd62-db3d-d0e0-aa28-888bdbbd4f9a@xilinx.com>
Date:   Tue, 27 Apr 2021 16:19:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210406130045.15491-1-andrea.merello@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abdb8647-eb48-4b63-4a21-08d909877f33
X-MS-TrafficTypeDiagnostic: DM6PR02MB4170:
X-Microsoft-Antispam-PRVS: <DM6PR02MB4170532AF971CB86FCD40485C6419@DM6PR02MB4170.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6yNnXt3fhP1yh30FkMv53EGxu3Y4nHv5auywWAXmwAMJjXPsuoz2bpFbrrNA4ADS446p5iscaAii4ecMbs+PoD1EPjdwqO6/NSFXdkrTeYbWz1+zjXy1oZm1hn9UYiv3XuKedDHB1Utw/dIpZBaqyv7Wc5uIdOWQKQGRxtX/i9OzaTY0w+7zxIJEGQpy0r+GOmkiODsArx+Ogi7hnGYSvaiLoRo/z7iF0uc0QDTFLbQfv/0uSSXcPB0OKscu3as9RfS9GVgG8r7XI6dLHYB3ufQYqm402bgA68ccO3ZvbF/TAAhPhHs+tl5pMttxAVNijzdzWIpFq6MUfkbMuOuIHJOonQd017eH7z4ZRK0rgGa6OqRFOoIdHtXzCIN9VZ0Y+WdulLFXApZirC/ph1DsrRG/ML1Lknedd2Bn5u3ZqYeEeRaXKOZUIU7ZPHz6QuCfDBhikMjvkc2kThFMDiTn2GeSaju0H+f31cGA7ZjeeiQ4sgACvV8ePn/fHAvhFLAzyor4mmG51W/n29LY+EseVnoXyYc8Kbs31jwSEaqXNY9QjxdiH6mslLgbCxDl39/3xm67wceFOYm/fLGdgrdXv+8Md6IIv7MQIzreuuiLZRukO3gEUvpmAq2tLu71zVAd+AnKrG9XPV6wBUOt3TKxlS0kJEnwfy9xtyItYa/d8r3lXSoPrBc4HG6+6wFP4P7fjY0hPeILwdre5p1DNFmBiw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(46966006)(36840700001)(31686004)(8936002)(8676002)(53546011)(478600001)(426003)(2616005)(82310400003)(5660300002)(316002)(4326008)(186003)(54906003)(36906005)(9786002)(44832011)(336012)(26005)(6666004)(356005)(47076005)(110136005)(36756003)(82740400003)(7636003)(31696002)(36860700001)(2906002)(66574015)(107886003)(70586007)(70206006)(83380400001)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 14:19:40.8214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abdb8647-eb48-4b63-4a21-08d909877f33
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT016.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4170
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/6/21 3:00 PM, Andrea Merello wrote:
> Changes wrt v1:
>  - rebased on latest kernel tree
>  - fix cover letter: does -> doesn't
> 
> A real-world problem has been seen with a Zynq-based board running
> Debian 10, where ssh daemon takes a really long time to come up at boot.
> This is due to lack of random numbers.
> 
> Since commit 50ee7529ec450 ("random: try to actively add entropy rather
> than passively wait for it") we try to generate entropy whenever we are
> in short of random numbers and someone needs them.
> 
> This trick works only when CPU cycle counter is available. On ARM this
> means that get_cycles() works and in turn read_current_timer() works.
> 
> Zynq HW includes two "cadence TTC" timers and the "ARM global timer".
> All these pieces of HW are fed by the CPU clock, which dynamically
> changes whenever CPU frequency scaling is enabled.
> 
> In timer-cadence-ttc driver this scenario is handled by looking at parent
> clock changes and adjusting things when required. This is the only usable
> clocksource when CPU frequency scaling is in use. arm_global_timer driver
> is disabled in Kconfig when CPU_FREQ is enabled for Zynq arch.
> 
> Unfortunately timer-cadence-ttc driver doesn't register itself via
> register_current_timer_delay() and that ultimately ends up in get_cycles()
> to always return zero, causing the aforementioned lack of entropy problem.
> I believe that the reason for this is because Cadence TTC counter on Zynq
> silicon is only 16-bit wide.
> 
> This patchset works around this by implementing in ARM global timer driver
> a mechanism to compensate for parent clock variations, similarly to what
> it's done in Cadence TTC timer driver, so that it can be used together
> with CPU frequency scaling on Zynq arch.
> 
> This proved to finally fix the problem on my Zynq-based Z-turn board.
> 
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Sören Brinkmann <soren.brinkmann@xilinx.com>
> 
> Andrea Merello (2):
>   clocksource: arm_global_timer: implement rate compensation whenever
>     source clock changes
>   arm: zynq: don't disable CONFIG_ARM_GLOBAL_TIMER due to
>     CONFIG_CPU_FREQ anymore
> 
>  arch/arm/mach-zynq/Kconfig             |   2 +-
>  drivers/clocksource/Kconfig            |  14 +++
>  drivers/clocksource/arm_global_timer.c | 122 +++++++++++++++++++++++--
>  3 files changed, 127 insertions(+), 11 deletions(-)
> 
> --
> 2.17.1
> 

I have no problem with these patches. I have tested it on zc706 board
and I see performance improvement when I generate random numbers.

Only question what I have is if ARM_GT_INITIAL_PRESCALER_VAL=2 make
sense also for others SoC with multi_v7_defconfig.

Other than this feel free to add my
Acked-by: Michal Simek <michal.simek@xilinx.com>
Tested-by: Michal Simek <michal.simek@xilinx.com> (on Zynq)

Daniel: Can you please take a look at this series?

Thanks,
Michal

