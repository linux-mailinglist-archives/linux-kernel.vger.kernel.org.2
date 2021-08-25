Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D523F704C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 09:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238793AbhHYHYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 03:24:46 -0400
Received: from mail-mw2nam12on2052.outbound.protection.outlook.com ([40.107.244.52]:15137
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238581AbhHYHYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 03:24:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNBSa0O/lELdMngRrOCyWDWbmTSsNKBE4apVQWf76fkTb7wJgsqj8MncR6NRZJcJj/rAYJfd9fqqMAK4Vy274nrJPsv73Ce7RcUrkurzII49RCq52I0dHGaMA2g41dt85nisOpLjInrD4sFdQv3SrkLoQA9NF2vZB/EGNAX6vQNq3VHIMjfjHmFiz4Tux/jCnBtuTL9AYv9uXYNSh+F2NoLQYz4IbeGyshoDt5XAyqMmVCHQNJXvr8xsAw6suftolONrIYM2ziWKynVQIp+tA9R6twETpV/rYeHdHbxcP8dvyAe7of1bSkaOfiq1+93w1/v/aHjLaGUJP+mQh39l0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VAznNsCfSAfM9NJxYEi51m28FabJHhnLHA3+qjrR34=;
 b=fs3QYaIz7yGL26JiKO7YUi6/P38OBRILboSQrJbzxKFKEo4pXWqfDaV2eoUHR0n85ObJUQf9mb5Sdi+L5MhyxwxlOFCn7c55OJih2fQ8044QrYKDe60EfaMVBeKtsaiTZMF9tnTL/++JBfJyfsw84OSwshw0uM3MTDEzU57DXIPjn1lo4h1WPPW5W1omEIVsmARuf8DcSUKKAi2QqGRDXaEBKZwiFRmGUye/Yjr2k3tZSSp8/C4fL4K0nL/n9Ll7bmvKq7iR8EC8R1Il2KbqwXhQDRB/Brj1MHJ3ztrXPBrVQt+oNtV//rzwKGn33j/XZ1I/fJDr0mJJxp6DXJh78g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VAznNsCfSAfM9NJxYEi51m28FabJHhnLHA3+qjrR34=;
 b=i0AIWkcu+k+Ikb3/9p+E9y9MQCsq91QfYwPEaQ8UPoJq+mN2T4bWx1ENSyw9XNyJBPOu0u0oAZ897GQtqDdDt3jzuaCM9R68sOkD9NcRJSiZdgxmN3GtgyIohC+dVnXiLLPbNwPMVrZ5VQ6SVm27RPy4GEkJK/98DOoTl+daldY=
Received: from SN2PR01CA0063.prod.exchangelabs.com (2603:10b6:800::31) by
 BL0PR02MB4722.namprd02.prod.outlook.com (2603:10b6:208:55::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.22; Wed, 25 Aug 2021 07:23:57 +0000
Received: from SN1NAM02FT0052.eop-nam02.prod.protection.outlook.com
 (2603:10b6:800:0:cafe::d6) by SN2PR01CA0063.outlook.office365.com
 (2603:10b6:800::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Wed, 25 Aug 2021 07:23:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0052.mail.protection.outlook.com (10.97.5.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Wed, 25 Aug 2021 07:23:56 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 25 Aug 2021 00:23:55 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 25 Aug 2021 00:23:55 -0700
Envelope-to: linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 zou_wei@huawei.com
Received: from [172.30.17.109] (port=48296)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mInGN-0008Qu-LZ; Wed, 25 Aug 2021 00:23:55 -0700
Subject: Re: [PATCH v3 0/6] Add Xilinx Event Management Driver
To:     Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>,
        <michal.simek@xilinx.com>
CC:     <rajan.vaja@xilinx.com>, <manish.narani@xilinx.com>,
        <zou_wei@huawei.com>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <wendy.liang@xilinx.com>, <jliang@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210702105144.28457-1-abhyuday.godhasara@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <438b398c-a901-7568-11e0-cd9bf302343f@xilinx.com>
Date:   Wed, 25 Aug 2021 09:23:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210702105144.28457-1-abhyuday.godhasara@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 171514df-5371-4b90-6b2f-08d967994cc5
X-MS-TrafficTypeDiagnostic: BL0PR02MB4722:
X-Microsoft-Antispam-PRVS: <BL0PR02MB47227936FA148A8B4573CA68C6C69@BL0PR02MB4722.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g1okI9f73vLymSfWWQWCC8Hsq2fLGpAAWUDfNFbaSbVX6Kdvx3e0+xJEeabOd2EggbaMk3SlG8Ay8PxTuEliAt8tXCYbjebRAVYtDhXZztDB+4na+eN14HoSM+RrB7e65r/g6cMmFDFbNOg92rOKwavJOTed6i83kteZstftkoh5Wln3oVoZLFEzFFIGv7ob6p+jkm4NMtuJkYSX6GZdoxkd3JY8UPpYc9mzz8JMRdmKxY77EHs/4ycwse9JEUtmrhzPNQUIEW7NI7xuU6KWgyItAkx9gp1dFKRfAOCmQeL1Vp5Ij1uU93qpqekxW+ZjtE9GyMNHV9So825R7jBOvu3P7m6n0gsMsDJn6AqfIc2eNZ2OwZjrtmbPHryix5fUUc64zoTIaYdTd2m7pdVcZixoEEFbGNh1PN0Q2N5tB3UX2cw663/NXXReyk2gXZa5PSpKKQ0Pm5ZTLmZqwOWa/FV+aAjON8ONzFnquvlf93hgeXQrS1BN76BZV08sGEi1YtoRXJT6nOfLasSz+KRo/QQoWQ0IsAY1Az2IV0bmBTB3Uz8nL1VlEFot/9yy2mMluzk8Ic50YuvmxdP7BdAKMt+w/B3nPZ7F09DYrBic7wHosR/GeWyQHI9EUtdSIN3KUnnVF/0JHD/k+07Xlyhpr2NedZN86npt7adpuW+LBKEWmcFOJdKDWJU5tg0tDIbAeVlyss4RoGlFhoQYfOvsBdroAfFDej6PJCAMxARWMD8/fe9Z16jXrylx0TM+CMWeVghcXjcc08ydIgA3pehQEw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(46966006)(36840700001)(7636003)(26005)(82740400003)(36906005)(336012)(8676002)(53546011)(70206006)(70586007)(31686004)(5660300002)(356005)(9786002)(2906002)(31696002)(83380400001)(36756003)(2616005)(54906003)(44832011)(36860700001)(47076005)(82310400003)(6666004)(316002)(4326008)(186003)(110136005)(478600001)(426003)(8936002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 07:23:56.4489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 171514df-5371-4b90-6b2f-08d967994cc5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0052.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4722
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/2/21 12:51 PM, Abhyuday Godhasara wrote:
> This Linux driver provides support to subscribe error/event notification
> and receive notification from firmware for error/event and forward event
> notification to subscribed driver via registered callback.
> 
> All types of events like power and error will be handled from single place
> as part of event management driver.
> 
> Changes in v3:
> - Update the commit message.
> 
> Changes in v2:
> - Removed updated copyright year from unchanged files.
> - make sgi_num as module parameter for event management driver.
> - Use same object for error detection and printing.
> 
> Abhyuday Godhasara (5):
>   firmware: xilinx: add register notifier in zynqmp firmware
>   firmware: xilinx: add macros of node ids for error event
>   drivers: soc: xilinx: add xilinx event management driver
>   firmware: xilinx: instantiate xilinx event manager driver
>   driver: soc: xilinx: register for power events in zynqmp power driver
> 
> Rajan Vaja (1):
>   firmware: xilinx: export the feature check of zynqmp firmware
> 
>  MAINTAINERS                                 |   6 +
>  drivers/firmware/xilinx/zynqmp.c            |  40 +-
>  drivers/soc/xilinx/Kconfig                  |  10 +
>  drivers/soc/xilinx/Makefile                 |   1 +
>  drivers/soc/xilinx/xlnx_event_manager.c     | 600 ++++++++++++++++++++
>  drivers/soc/xilinx/zynqmp_power.c           |  54 +-
>  include/linux/firmware/xlnx-event-manager.h |  36 ++
>  include/linux/firmware/xlnx-zynqmp.h        |  33 +-
>  8 files changed, 771 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/soc/xilinx/xlnx_event_manager.c
>  create mode 100644 include/linux/firmware/xlnx-event-manager.h
> 

This patch is in conflict with 2b9fc773c31b ("drivers: firmware: Add PDI
load API support") which is in Greg tree.
Can you please rebase it on the top of it and CC Greg on that version?
Would be the best if this will go via his tree because it depends on
that patch.

For the whole series
Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
