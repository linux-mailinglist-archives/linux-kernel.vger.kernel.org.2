Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C828347245
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 08:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbhCXHRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 03:17:53 -0400
Received: from mail-dm6nam08on2057.outbound.protection.outlook.com ([40.107.102.57]:10145
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235818AbhCXHRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 03:17:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVODtPUAJ8qJ7+wQSeu0CLZrReUL3rOk4ZeNNes3gRmq+CwrKZjx2pVIm6QDQFViHvrFhbnIfncSmyH8xRFNRiopKkNZSYpsy0dM9nc0RIOnV7VSKb3K+MkxjikYPlBWwsy/YldZmOYJE0vyLkckWLhJEO4RWRKXUGjhbNtwPByOF5ZUAzdI8KdB5uqscKo1GcNedKVZnVwAToroVkzVOaHIO98xcIxCXe+sDUOgM6rZAT8ncVYstTaH4Wk1MlqRUotr7oVM9NQSBuD82Qp5KKQq2a2IjSZRO+O+BWwTBp7GEmoorqUSUnpF4zR8URVopa2ZI1PUHKy7UrEVtQR00w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRO8Dsv9yRKq/dE5Qu8Bxd8pvJ1A1X/SVAowR40pnMs=;
 b=MSRBfpkgs8kEYBScyOH9fr/t7dAOpKqwOvDIDe8p10DMLF39znZ19wM0qrH2PvRgaKQUU5T/Tfm2N/p/FZkJWE14nd4sf85KXHEfPaRfhVI4v1CpBWe2pv4zkhBBKsB12gOB3k7O0ysvEdQA6Ha/SRPR1UzoCx8cwj5QvDGjAwfZmcDSaZMu9KA+XmbbzlkucdUAHFwLp1A7T72sudeWl9bfDltKhwI+vYFo/tNrCCi64/1OP8GEwPE83PrHap20zmjNfBxT8eMRh/gv/yja+vfxMUQa9D+IhWqY3q6lIJEJj60szQdCO4iEmqoyvtdx0nDwt9RqFQrmU7t3IPwkyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRO8Dsv9yRKq/dE5Qu8Bxd8pvJ1A1X/SVAowR40pnMs=;
 b=d40ukcrRKRHVfyGNmeP2yoQffDmNRNpP63pG2zJe+nT94mhQ4INjJdPIx5piVq8ahZvNYXl3OXU+ZfjnMyKgVjCGAdIQdycAajKWpVNehLzOy8oJmQfT9We/efAArBvUDZSGVfqsOIF8tEQk70dTPBYaqdnkykNCx4Xx4wU6Pm0=
Received: from DM6PR06CA0056.namprd06.prod.outlook.com (2603:10b6:5:54::33) by
 MWHPR0201MB3401.namprd02.prod.outlook.com (2603:10b6:301:76::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.23; Wed, 24 Mar
 2021 07:17:33 +0000
Received: from DM3NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::c) by DM6PR06CA0056.outlook.office365.com
 (2603:10b6:5:54::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Wed, 24 Mar 2021 07:17:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT027.mail.protection.outlook.com (10.13.5.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3977.25 via Frontend Transport; Wed, 24 Mar 2021 07:17:32 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 24 Mar 2021 00:17:25 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Wed, 24 Mar 2021 00:17:25 -0700
Envelope-to: git@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 vkoul@kernel.org,
 kishon@ti.com,
 laurent.pinchart@ideasonboard.com
Received: from [172.30.17.109] (port=58898)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lOxlc-0008Az-Gy; Wed, 24 Mar 2021 00:17:24 -0700
Subject: Re: [PATCH v3] phy: zynqmp: Handle the clock enable/disable properly
To:     Manish Narani <manish.narani@xilinx.com>,
        <laurent.pinchart@ideasonboard.com>, <kishon@ti.com>,
        <vkoul@kernel.org>, <michal.simek@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
References: <1616509187-8209-1-git-send-email-manish.narani@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <75defbfb-57f1-71bf-68b4-3abc52a8f39a@xilinx.com>
Date:   Wed, 24 Mar 2021 08:17:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1616509187-8209-1-git-send-email-manish.narani@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39a8cbd1-269e-4edc-da11-08d8ee94e494
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3401:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB34014B656A6AD7A56ACBEED1C6639@MWHPR0201MB3401.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H07NLfzbGxk2vOllkfY8sv24GfXqMpg8fPAx3bE8U1CzFN5divBQUCrgH6NuaMHuZHWIQd9PFNwBb3WkoYDp0Hy0UiZeLhbZOb3fSlnKF/F0BUnSknixWjsGKSLO5Lz1vGEOJ4boLJ01jdv7tFBorRzZEr4ftGkK7X7NVLI2yL8btwed0lFSCJo1wM1dbjjVee5FAPhh/Xc1+wpV9AEQ7OsOqlymhb+KcVssIU6i2LMNcAUyw/kxHQdF2FLSWb5nt/sTWhRBRyVX91MmwUn+b2N2CStc62MAe5SVYYbEn7oZJZxc5HJ6Oy0Jw923HRLv8DOnFcp/JzpPveZ+hgxpYryhIKotrigMNSNF1mekUctvbDO1f7AcNxjE9gMsgDsR4cy9De0VGyfofe2wxfNVBbQtZt9fWKYG1dmu/p3RCNfXzjuLnvkkZ02sJtAoY+qhA8Oj2zvLt9QVkVLGPvwA2dDi3dZzXWWm3R8tn9V/ujtX2XlLx6vaDu+B/pHq1k3HvZIum6Mhy9Q5yu8QzKrGD3JXfNhAi/k+ilt0bF1y+aaCHRJqvu24rGfBKloyIJVMOZYqZJOyoX1YzZD4tQS1vp0oQ2B+toyzHYrJKCHxFFEkUR5bw7Udtf31YCWWwpKaWIX7jfLgOF/PRonAUwVGi4dhxAONYkeKLE8DROt61ZOJMMollmaJii9B3IKwrzjyqDtAr7F+IIkTy5YIG3/Vaw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(36840700001)(46966006)(44832011)(82740400003)(6666004)(54906003)(110136005)(478600001)(5660300002)(9786002)(70206006)(107886003)(70586007)(83380400001)(8676002)(186003)(26005)(4326008)(316002)(31686004)(36906005)(356005)(336012)(426003)(2906002)(2616005)(53546011)(36756003)(8936002)(82310400003)(36860700001)(31696002)(7636003)(47076005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 07:17:32.9546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a8cbd1-269e-4edc-da11-08d8ee94e494
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT027.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3401
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/23/21 3:19 PM, Manish Narani wrote:
> The current driver is not handling the clock enable/disable operations
> properly. The clocks need to be handled correctly by enabling or
> disabling at appropriate places. This patch adds code to handle the
> same.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/phy/xilinx/phy-zynqmp.c | 57 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 50 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
> index 2b65f84..69492a5 100644
> --- a/drivers/phy/xilinx/phy-zynqmp.c
> +++ b/drivers/phy/xilinx/phy-zynqmp.c
> @@ -219,6 +219,7 @@ struct xpsgtr_dev {
>  	struct mutex gtr_mutex; /* mutex for locking */
>  	struct xpsgtr_phy phys[NUM_LANES];
>  	const struct xpsgtr_ssc *refclk_sscs[NUM_LANES];
> +	struct clk *clk[NUM_LANES];

Please also document this property.

./scripts/kernel-doc -man -v  drivers/phy/xilinx/phy-zynqmp.c >/dev/null
drivers/phy/xilinx/phy-zynqmp.c:170: info: Scanning doc for struct
xpsgtr_ssc
drivers/phy/xilinx/phy-zynqmp.c:184: info: Scanning doc for struct
xpsgtr_phy
drivers/phy/xilinx/phy-zynqmp.c:204: info: Scanning doc for struct
xpsgtr_dev
drivers/phy/xilinx/phy-zynqmp.c:226: warning: Function parameter or
member 'clk' not described in 'xpsgtr_dev'
1 warnings


Thanks,
Michal
