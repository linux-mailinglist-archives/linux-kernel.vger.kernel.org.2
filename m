Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5925043115A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 09:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhJRH0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 03:26:09 -0400
Received: from mail-dm6nam11on2051.outbound.protection.outlook.com ([40.107.223.51]:3553
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229847AbhJRH0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 03:26:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qq/Q+yoVDcr+KNKf3jHEyQrdJqX55S8Hqx1N7Xzu0KUYxz0K9qejUsfUEFSbqmUvJeMxAQD151yyJs3qTaN5BsKy0aBicP7DNO5lLM5jR1o4Jygg8G+TK44Jm85UfRyEV4h2O87EqF8Q2gXxmQAYjDpfo+Uty7o5RXLOcuEXWU4Egopf/Ls4F5wx0SehHLzoxVDCb9iMJCrMO/p7f5z4D1L/dWZdmWEMNUssu1CMHq6RXWRS3vSyBx20Ig8RFkkRE9tJLLKzYCW7wS4tENnZhItMW5jODcecvVtJCmYtARk0IYcOKOzspaqCu5WXhGjbqJ+UnQuCb+xHoFKv9IPpmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpscEyTiCBVTvdLpc16SDxDeeAOZK0fs88A1wSyXf3Q=;
 b=B83JxxCdsLinlUbL1Lj8mVK0es16PHlr3Z4GYWB/ScHACGegD+DX5K1d48DQIGWq6pzJTUbLsbuI+aJwMMEZSXBp2sV4zlsGyJ8iOqzJ09EzZG/3tuuLH6Rn4TKIQ28U+uB1Kr9Td2j9N0pY8xq5x6BWx5dWdXlq2VvxZYxWDbWaEm4xrhvrBsBnwUbbLRXcwoS791ozeEINygi43tGgjEbOxyHYEFgzqukVJe/5zmDSnXg+nIuF2qtrD3KgoqTK8dzPW1OzlR2X92RIdh/AJUYCuqkRBwXUTEgIyuc6BkFwrgu+dpvUXyyvVv6cfEswnvlC1cgxegf30gRh5qnunQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vivo.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpscEyTiCBVTvdLpc16SDxDeeAOZK0fs88A1wSyXf3Q=;
 b=Kzip970AtB9rUkE4kyoLz86aNXb+k36pjerfnWbzTNv4/ntPWbhBrfP/CiXP+VrGiLHYzsI2t2gnmnjcTylk7Mze4jI/ol2ABJYVt4rv72CEMMvPOLgAZ+JZKKr4/Qu+NqS28AerKbHjqN8JNmP1x+QUes8aKICYaH3VVlMsD5E=
Received: from DM6PR02CA0163.namprd02.prod.outlook.com (2603:10b6:5:332::30)
 by SA2PR02MB7644.namprd02.prod.outlook.com (2603:10b6:806:144::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Mon, 18 Oct
 2021 07:23:53 +0000
Received: from DM3NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::3c) by DM6PR02CA0163.outlook.office365.com
 (2603:10b6:5:332::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Mon, 18 Oct 2021 07:23:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vivo.com; dkim=none (message not signed)
 header.d=none;vivo.com; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT004.mail.protection.outlook.com (10.13.5.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 07:23:52 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 18 Oct 2021 00:23:52 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 18 Oct 2021 00:23:52 -0700
Envelope-to: wanjiabing@vivo.com,
 jassisinghbrar@gmail.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 kael_w@yeah.net
Received: from [10.254.241.49] (port=54980)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mcMzw-000Gxz-6V; Mon, 18 Oct 2021 00:23:52 -0700
Message-ID: <53c559a8-9bea-c4f9-3650-88e033a2a3f4@xilinx.com>
Date:   Mon, 18 Oct 2021 09:23:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] mailbox: zynqmp-ipi: Add of_node_put() before goto
Content-Language: en-US
To:     Wan Jiabing <wanjiabing@vivo.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Wendy Liang <wendy.liang@xilinx.com>
CC:     <kael_w@yeah.net>
References: <20211018013427.5476-1-wanjiabing@vivo.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20211018013427.5476-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 807d3f6f-0780-4782-54d5-08d992083cf8
X-MS-TrafficTypeDiagnostic: SA2PR02MB7644:
X-Microsoft-Antispam-PRVS: <SA2PR02MB7644596824CA5406C6B35C0AC6BC9@SA2PR02MB7644.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sMaZeMqzyMjvAPYgGkZ2FHKYGZouTtbtyzux2MqTFITWdtxVjDTcfAltSybR5lIA31Ht1ZjMT11LhNCdqxwJigmPu6FrmHyB88Qf8kRMODTy/Sihz+XCYD9+qyBlrSuFUczTUndX8t9BU9z0Ax3qL/1//1UMEfkMPoUri862gHFhwXMvxjLIhUAAO/PWdb3iTG5ynbYp9YyTZ3WAtHknl3Dn6DbK7y02ByzN9lDbwv1KISvvLe5/seAgxCLrA7eall/AlfYCREZiYsXM9fvr/NZPobYR7xfgNlZW4y2+LoisgX+4gvwKa0jqBri/dnyAJyBZ7e92jZamHPquq9ubG1MOuO2OaFQilTFB+ZQYT/P/m9Ge9F8p9Apvm6xA805sbjjgKAvZIuRe5TWuZBCI77lXtJekZJVFL/AihSWdfIqbJavEaXLYIgQaQePQy6QR0oP7m78Syd2gxNTyBmb2NbdFAFcRIwiVO1CBd89bUPc7v5CdyKilUQ1+BkBdFa4D22TMd2qcAIJhdOGUgRBfelB9RcgP/m1ztZRIE8IYhgTx9Z9U3aYLNk1ZT+XHaZp94kXwrwH1gMSA3xX2epZ/AERxP7T0ulY8iOlkRGndv/WSc3ZDLgrGEl24FHDL8+dDetIS1wgxheloior7CjmAOIo74PW0zUIi3KAsMtgfCyBRLxjvAPrQwBduIK27rNyYaw7jV8I2ym3UhOryEkug6tqYnRec5/4jIOEA1LbDa41VSfgQeJljisxoXKHR7Oziw24s8kIeRvVpFrCWYU4/A4gAb94fsu79hbvX44ZTjSw=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(31686004)(110136005)(316002)(36906005)(82310400003)(4326008)(36756003)(70206006)(31696002)(8936002)(15650500001)(336012)(8676002)(53546011)(83380400001)(5660300002)(26005)(6666004)(2906002)(36860700001)(508600001)(44832011)(426003)(2616005)(4744005)(70586007)(47076005)(186003)(9786002)(356005)(6636002)(7636003)(50156003)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 07:23:52.9037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 807d3f6f-0780-4782-54d5-08d992083cf8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT004.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7644
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Wendy: Please check.

M

On 10/18/21 03:34, Wan Jiabing wrote:
> Fix following coccicheck warning:
> ./drivers/mailbox/zynqmp-ipi-mailbox.c:654:1-33: WARNING: Function
> for_each_available_child_of_node should have of_node_put() before goto
> 
> Early exits from for_each_available_child_of_node should decrement the
> node reference counter.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>   drivers/mailbox/zynqmp-ipi-mailbox.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
> index f44079d62b1a..67d4203fb4f5 100644
> --- a/drivers/mailbox/zynqmp-ipi-mailbox.c
> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
> @@ -657,6 +657,7 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
>   		if (ret) {
>   			dev_err(dev, "failed to probe subdev.\n");
>   			ret = -EINVAL;
> +			of_node_put(nc);
>   			goto free_mbox_dev;
>   		}
>   		mbox++;
> 
