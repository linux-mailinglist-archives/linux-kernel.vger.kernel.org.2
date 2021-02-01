Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09FCC30A515
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbhBAKKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:10:55 -0500
Received: from mail-eopbgr700086.outbound.protection.outlook.com ([40.107.70.86]:9728
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233104AbhBAKJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:09:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqUAOP1AuIrgj8hiC9ZIqktVAiGdUEiFjqfofSQ1VAxV9Kxvve589oQ+AFB1i4W4T4+ADqXFcuS+ztIM2fOcyVnf4wbKPWf38iBSdu5dTo7LrFwL1Zu6VqDsx3T9vObum9VrgB1YG3d/Ww6NFhwCK4rytKQoaf4di5KYNWahSK8N0yHgTJUV459pWzF4zq33o/0Eqxk6oBt5MU7DIZ2WsVWglruMEymfJSmSOKc/pd5aLIzzutGKaaVT0AL6LtsxiPWiHfL5fOE8JMhPWPLsxKPrCymXfkq2gLwuhS1EISPXHPv8Efuc5l63CrCbpexlGsHpO+HrvhuQM7jh8Rc0nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Sntz/3ChtVnOHIj23voVIRyD2/ROvRzss5qjXQ0PCM=;
 b=B60gem3QkeGWvhKHAVeiUmIoB9nr9tOnLwlpFgD4Z2FLm6GhQNafuTDWCS+tHm8koKpUd69FwaRZLVfrO5vJ7HWdRalEgGXwPZH8k4UBOnU4pDHoXkp3K2N+TxdB9mxyzFawwk7Z8jIZLJ41ISka0yTDfIuyYHHICE6xpEUxUbuIw8K1jvmqepF8rcLqOntmhBGoU+PDjKwfCpHHSVlsb58f+T5kLUIH8SK6N0pMwKuy5zUj/5yMNbqUyqaspEmJ7RZQ1Gv5oIi/9kimVQkCJeYhMcA/3oHtfjdnpI+qUz+hcAmxlOIH9VLlVD5YA1UVtv+GW8IzXabxsfr2Fe8zqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Sntz/3ChtVnOHIj23voVIRyD2/ROvRzss5qjXQ0PCM=;
 b=aoCOiuzxsytMnMEskrYAWsFE2mI3pTKu258mz2OUcUzMyoTMtKuKVA3ZfN2uvW2+owYU1gEvSYUaj7gKFPpaa8snKyPiBQLbzjLPaLDgmXcdiS89RpF7HMDc63CIO7XSZT3HmE6AxQskFdog/F7vufNGoQ0hvC+Lc8USoqX6nr8=
Received: from DM5PR13CA0029.namprd13.prod.outlook.com (2603:10b6:3:7b::15) by
 MWHPR02MB3264.namprd02.prod.outlook.com (2603:10b6:301:65::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.21; Mon, 1 Feb 2021 10:08:19 +0000
Received: from CY1NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::a8) by DM5PR13CA0029.outlook.office365.com
 (2603:10b6:3:7b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.13 via Frontend
 Transport; Mon, 1 Feb 2021 10:08:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT009.mail.protection.outlook.com (10.152.75.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Mon, 1 Feb 2021 10:08:18 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 1 Feb 2021 02:08:17 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Mon, 1 Feb 2021 02:08:17 -0800
Envelope-to: michal.simek@xilinx.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 iwamatsu@nigauri.org
Received: from [172.30.17.109] (port=36608)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1l6W81-0002uz-GY; Mon, 01 Feb 2021 02:08:17 -0800
Subject: Re: [PATCH] firmware: xilinx: Remove zynqmp_pm_get_eemi_ops() in
 IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE)
To:     Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, <michal.simek@xilinx.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210131143033.7441-1-iwamatsu@nigauri.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <dc9f110a-d998-2f79-aeaa-317ec6032891@xilinx.com>
Date:   Mon, 1 Feb 2021 11:08:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210131143033.7441-1-iwamatsu@nigauri.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 427176ac-0a6f-4da9-11a9-08d8c6994c92
X-MS-TrafficTypeDiagnostic: MWHPR02MB3264:
X-Microsoft-Antispam-PRVS: <MWHPR02MB3264A49F917C5958EC588901C6B69@MWHPR02MB3264.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e+7WTUe1gp/RGhJECFhOYQotEaH9nY/ZKfS+qShEcVyWN/nq4G3hm4MYujE0jJJV7/QIzA9aMDeI7qXG8RHYfQ2g6eRwec+CaIjoqzrE5BA4bmm0jdrPWS9KCxDVkByOEv8dY9vMbvtEph/dxoM5eHH40CAQu9kUIka+yW9uR5RLlLFYlUcMNR+imJcR1v/8xVYkJPue19ikSFKzhmEdDp+Ot6jbro7RNWkk5CzD0/Cqb2Iz+tlfvmMXh9KHo27rM/IDIQWcGOFKle+/jOD4ofmLKqFh4x3IHPTS7CCMhG/0Ij2MWz39R3de8uS3W2TMOMkhnMzxkZ7cQ3KkQXykUXnDbt6kndm9j1xPk+Xd3vqGTrsKkPwK7xUvLFc9wIjttICW9wR1J2KeZVK/277lUDDTf7PfXzqtcCJEV9DWVHSo+0A+iDOUYIa2oKWLBdScolnpHG6iUgC0RGPkj8EsiUQENvvMGcFSButbHrdR6xmwIfTW0DcoWFpQIwUvx+tQNj9il4GHgwMHmewXtDw2sKA283EtBoEKBh9odgCfHsPh4mmdRE+JMJNUHocxSOvszaU6toyt6ko95MOifPIc/S0zJiRy84MwtJ+DPVVqqj3DFoHwUdUC5msW3GlQvu2jUay93GI7H7Q3sZaaqbFJpg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39850400004)(376002)(346002)(396003)(136003)(46966006)(186003)(4326008)(47076005)(44832011)(2906002)(26005)(53546011)(70206006)(70586007)(31696002)(82310400003)(8936002)(82740400003)(83380400001)(478600001)(426003)(54906003)(31686004)(316002)(36756003)(9786002)(36906005)(110136005)(2616005)(356005)(5660300002)(336012)(7636003)(8676002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 10:08:18.9222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 427176ac-0a6f-4da9-11a9-08d8c6994c92
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT009.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3264
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/31/21 3:30 PM, Nobuhiro Iwamatsu wrote:
> zynqmp_pm_get_eemi_ops() was removed in commit 4db8180ffe7c: "Firmware: xilinx:
> Remove eemi ops for fpga related APIs", but not in IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE).
> This removed zynqmp_pm_get_eemi_ops() in IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE), and also
> modify the documentation for this driver.
> 
> Fixes: 4db8180ffe7c ("firmware: xilinx: Remove eemi ops for fpga related APIs")
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
>  Documentation/driver-api/xilinx/eemi.rst | 27 +-----------------------
>  include/linux/firmware/xlnx-zynqmp.h     |  5 -----
>  2 files changed, 1 insertion(+), 31 deletions(-)
> 
> diff --git a/Documentation/driver-api/xilinx/eemi.rst b/Documentation/driver-api/xilinx/eemi.rst
> index 9dcbc6f18d75df..53416d25d309a8 100644
> --- a/Documentation/driver-api/xilinx/eemi.rst
> +++ b/Documentation/driver-api/xilinx/eemi.rst
> @@ -19,32 +19,7 @@ device to issue or respond to power management requests.
>  EEMI ops is a structure containing all eemi APIs supported by Zynq MPSoC.
>  The zynqmp-firmware driver maintain all EEMI APIs in zynqmp_eemi_ops
>  structure. Any driver who want to communicate with PMC using EEMI APIs

The whole paragraph should be tuned. I would leave here just

"Any driver who want to communicate with PMC using EEMI APIs
use the functions provided for each function."

Because there is no reference to any eemi ops structure.

The rest looks good to me.

Thanks,
Michal
