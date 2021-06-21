Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD783AE85A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 13:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhFULuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 07:50:35 -0400
Received: from mail-bn8nam08on2045.outbound.protection.outlook.com ([40.107.100.45]:6977
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229487AbhFULue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 07:50:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVLoMGpbXwjzhsd341BOKRxafb1/dv2nV25KE+8P0yHnVZS0FueWK9yECn8CqNH7xwl6q4btbwBIyG/NviueBzbetcIhMLzfXDP1X6JXpFYUPTCg+M8hUR3gMCm9U44lUJcwPZQ1mnpZeXz1lEXISY07C4o0Ks9ec+oRnCoHEBWuz9Wn1m/iiof83bPpMwRj7MlmQc9JQX7V3eJtBTeWKWLJu3Q+723nH+Blv0qWPucYeAQKAocv27PoyECmiZ3boAkB0Bap1x5IecHSvfq+nWMMEWpenBkiD8hgNueljnmfUG4fDPTX+GL/FHbOiJ6++npa/CrGVHBUklNf5i47tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMSEyBvG/WPcRPl5CUtKs7mqYQ8hrWNa3NbtXOHo5fE=;
 b=mpDnC+E8nCpkYcDubddTpssdbYWdxaJ694tscxNvJRduUoA6iTPl1mtplmgx9vTHfLtzfGtbrrLOMXsTUOhWd94rYsghpa/iC2VQKipoqzkBDl4ukNys735zPJvrxtv4CH7Pcs/xWYjSEJtSjjPPnKAWuO2G7SN5JT810M7qhZzMJp0CL8onK2UFMJL90BagscCyYHZ7ykeR3kX5c5+wQDkX4STZsYREcOZ3fil+fLHCXnKWbPy8eGSse/MwsGdKsFLN450VX9ZUZvtGAgEmE+uD4l9Ib2m7KCPWBByEsxWa9fDqztEXgAOl4PaRUvy1+RNBipkojH9Yaq7Jqyj6fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMSEyBvG/WPcRPl5CUtKs7mqYQ8hrWNa3NbtXOHo5fE=;
 b=jBrSYZ78QGgrkt4k2Rl7fxMA9lV+9tlE7aBa6Y5U5NSpXhVHt544BHoLwlEgMqgBzZepzjgskGHa4cD6OA2NkEp87cPqRw5ialApvfMa8LqPjgZzZ0/dY8mRPf1uI6q/VlQhcxKNC9t6d4MC1T0HLS2w8w3ptvqpsL5n3QJKOX0=
Received: from BN6PR17CA0004.namprd17.prod.outlook.com (2603:10b6:404:65::14)
 by SN6PR02MB4270.namprd02.prod.outlook.com (2603:10b6:805:a3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 11:48:16 +0000
Received: from BN1NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:65:cafe::ea) by BN6PR17CA0004.outlook.office365.com
 (2603:10b6:404:65::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Mon, 21 Jun 2021 11:48:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT011.mail.protection.outlook.com (10.13.2.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 11:48:16 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 21 Jun 2021 04:48:14 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 21 Jun 2021 04:48:14 -0700
Envelope-to: linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 zou_wei@huawei.com
Received: from [172.30.17.109] (port=49752)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lvIPW-0003Cq-3f; Mon, 21 Jun 2021 04:48:14 -0700
Subject: Re: [PATCH 5/6] firmware: xilinx: instantiate xilinx event manager
 driver
To:     Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>,
        <michal.simek@xilinx.com>
CC:     <rajan.vaja@xilinx.com>, <manish.narani@xilinx.com>,
        <zou_wei@huawei.com>, <amit.sunil.dhamne@xilinx.com>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <wendy.liang@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1622217566-1856-1-git-send-email-abhyuday.godhasara@xilinx.com>
 <1622217566-1856-6-git-send-email-abhyuday.godhasara@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <1155e79d-7c66-d772-d5ce-7d346ee8d8a0@xilinx.com>
Date:   Mon, 21 Jun 2021 13:48:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1622217566-1856-6-git-send-email-abhyuday.godhasara@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b467dcca-bb9d-4a25-9b4b-08d934aa7551
X-MS-TrafficTypeDiagnostic: SN6PR02MB4270:
X-Microsoft-Antispam-PRVS: <SN6PR02MB4270157FF3E1D5E2E62F7F0DC60A9@SN6PR02MB4270.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: We1lqVvWUJsWM6DjK9Sb0hgG8aL1xUnx1lxeRQyZiWkUI8t/XEwWAPcviE6u2Lw/TXiFBV6I/N4WrqnRI4BD2ly2r2X3OG6C7YVv9v1spVMEqtFiqPAsIwxbgcqEWRIz+SRZ/vt3U2HoyFvA10Hqz0eGFAax2rGO+AwgYQCKFGd2BHM3P0L6ZXmHWWcWQVg95Vgmh6YZJ5TTskz3tr6PhGwoC55vUt2lHEJ95cwN6zqhSeEaNi0b5zzjyLbIiTnfEj7g/iVJDOWeyESKe8XCpCVaWY4pk1Bx6Qw5ihtnxXEBrJMKX3z/ZhMeh/wT6t2f1ORe+6wpWsamOliD2BCFcBqgopvaSTVnavpkbx0YvYOzBxXr0t85YTpiWrJMteYdd4j3gX3c/bLh1ghRa9cBBFsqDS48zI08n36EwRT6b/F5ga/aQuiv0KpTkVWuZoL1UCTqLhx+enb/qCHgYHg9WndZGpTurf+NYg9JE8teSW73zY4jQOdIkADyL6ml1H5lR83E/tyVwdiXWf34YCjOSLAfQf+OlYWSuNn0VYzM46eIRRXqODcBqTIXqs6sIi971i5y2SHY2b34D7x1KImShOi7K68giHHlkWK/SVs2Slsm4xTJHwPSzob+yOx2YCNrQ3UWZTdXgG2WScBcYqxnPwZ/l/8CKRFHYG3NESmAnkjsf0nH9dCntVewC1BMtXMjMMFKuWxZK95CBNO+QjQA1A==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(46966006)(36840700001)(36906005)(5660300002)(83380400001)(336012)(44832011)(6666004)(316002)(82310400003)(82740400003)(2616005)(7636003)(426003)(8936002)(478600001)(31686004)(31696002)(4326008)(356005)(8676002)(2906002)(36860700001)(9786002)(186003)(110136005)(70206006)(70586007)(53546011)(47076005)(54906003)(26005)(36756003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 11:48:16.5443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b467dcca-bb9d-4a25-9b4b-08d934aa7551
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT011.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4270
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/21 5:59 PM, Abhyuday Godhasara wrote:
> Register simple platform device to instantiate Xilinx event
> manager driver.
> 
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
> ---
>  drivers/firmware/xilinx/zynqmp.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index ce16a72..31f7857 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -23,6 +23,7 @@
>  #include <linux/hashtable.h>
>  
>  #include <linux/firmware/xlnx-zynqmp.h>
> +#include <linux/firmware/xlnx-event-manager.h>
>  #include "zynqmp-debug.h"
>  
>  /* Max HashMap Order for PM API feature check (1<<7 = 128) */
> @@ -31,6 +32,8 @@
>  static bool feature_check_enabled;
>  static DEFINE_HASHTABLE(pm_api_features_map, PM_API_FEATURE_CHECK_MAX_ORDER);
>  
> +static struct platform_device *em_dev;
> +
>  /**
>   * struct pm_api_feature_data - PM API Feature data
>   * @pm_api_id:		PM API Id, used as key to index into hashmap
> @@ -1412,6 +1415,15 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
>  
>  	zynqmp_pm_api_debugfs_init();
>  
> +	np = of_find_compatible_node(NULL, NULL, "xlnx,versal");
> +	if (np) {
> +		em_dev = platform_device_register_data(&pdev->dev, "xlnx_event_manager",
> +						       -1, NULL, 0);
> +		if (IS_ERR(em_dev))
> +			dev_err_probe(&pdev->dev, PTR_ERR(pdev), "EM register fail with error\n");
> +	}
> +	of_node_put(np);
> +
>  	return of_platform_populate(dev->of_node, NULL, NULL, dev);
>  }
>  
> @@ -1429,6 +1441,8 @@ static int zynqmp_firmware_remove(struct platform_device *pdev)
>  		kfree(feature_data);
>  	}
>  
> +	platform_device_unregister(em_dev);
> +
>  	return 0;
>  }
>  
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
