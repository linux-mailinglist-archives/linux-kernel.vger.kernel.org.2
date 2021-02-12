Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAD431A063
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 15:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbhBLONJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 09:13:09 -0500
Received: from mail-bn8nam11on2045.outbound.protection.outlook.com ([40.107.236.45]:46336
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230194AbhBLONA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 09:13:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTERjSuCzpf/182jSFMw70aXYgMAWQtYVte5VuTlPMd+46KOMi3ZUkI2HCZ1SZe2o5Q14RII1HVtSyZC1uQLW1ahvFo7JS7rxAtMTtGErxuBiVAClOlEIgmHecyPYUBkh49bGOXzgO8rwPngnbrSL9IUMmRDOzS6odPaRgDxcNnTgzrmqP7KZlNjkLAKoNceEoTLUkCKIhvEgzHrtL2xw+8lJmHE/3acyPbSCKiT1j9GzH5epPhcykQefhyBwB5bDO3oD1ccvCmRVucjUy4/ioxIxtF7Ixo/s3dhqz3qwc/N+PU8S2hN/8y7lhRM778tTcshPkMqJXvSxE0aryad9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lZaxoMS4SB4e3JIiIa1ESF/9GdtfCglfWuWw2kCKbY=;
 b=PPBzi/+ihmHhk53N82NrVl3BtdJij46EWwl9HIsXRaPs6uP+AH3RGX5DYVpcs/yJKV4zhJ3wHNMRpv4tulw8ZC4XTMYXT8QoOtaA5oMJofPWOlT9ed/WGNmixkaDGN3EBAbQDpxoaH6EhnVokTefQh0pv9fCtmxlnuORGj2AsS3FouhayiCUAAq1lJ39FGEOlsxIMG+hF1u2sWJvOpVqI54LlEzpLNWTPMzEjbPQGmxHoipHyoV8z9HD5Pk6sc9eRkw3pL4lj8xiHFzBsNjK4L7n8izdvTqbaABWDC5RjgiL/OSXAIDe0Z7hOZbDCikISOad/wjfAbge/rDnsPWGag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lZaxoMS4SB4e3JIiIa1ESF/9GdtfCglfWuWw2kCKbY=;
 b=gCNHKWcrqFleFbURcWiHoHu5mkqOyNT/Dw4PVRsLbFtcfx1B6jhkAnKQS8ziiuC89di+aA4jTef9gncq1EjzWyzC5u42+bLawQnbTTVdgycB0bbtOs6HKt+HG1HuUIhMOoe+UuEZ2np6YdYdmcG2s1zZ+GiY3fl6FdpVAfz9Ch4=
Received: from SA9PR13CA0085.namprd13.prod.outlook.com (2603:10b6:806:23::30)
 by DM6PR02MB4361.namprd02.prod.outlook.com (2603:10b6:5:22::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19; Fri, 12 Feb
 2021 14:12:07 +0000
Received: from SN1NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:23:cafe::ca) by SA9PR13CA0085.outlook.office365.com
 (2603:10b6:806:23::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.12 via Frontend
 Transport; Fri, 12 Feb 2021 14:12:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT055.mail.protection.outlook.com (10.152.72.174) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3846.25 via Frontend Transport; Fri, 12 Feb 2021 14:12:06 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 12 Feb 2021 06:12:06 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Fri, 12 Feb 2021 06:12:06 -0800
Envelope-to: tejas.patel@xilinx.com,
 michal.simek@xilinx.com,
 amit.sunil.dhamne@xilinx.com,
 rajan.vaja@xilinx.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [172.30.17.109] (port=47872)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lAZB0-0004uh-Ca; Fri, 12 Feb 2021 06:12:06 -0800
Subject: Re: [PATCH] drivers: firmware: xilinx: Fix dereferencing freed memory
To:     Rajan Vaja <rajan.vaja@xilinx.com>, <amit.sunil.dhamne@xilinx.com>,
        <michal.simek@xilinx.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tejas Patel <tejas.patel@xilinx.com>
References: <1612765883-22018-1-git-send-email-rajan.vaja@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <7385a404-a627-2ab3-50b3-b4807bb3b387@xilinx.com>
Date:   Fri, 12 Feb 2021 15:12:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1612765883-22018-1-git-send-email-rajan.vaja@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86d34b35-66cb-440c-3a9c-08d8cf602e1d
X-MS-TrafficTypeDiagnostic: DM6PR02MB4361:
X-Microsoft-Antispam-PRVS: <DM6PR02MB4361B760BD72E08D33A6C769C68B9@DM6PR02MB4361.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:517;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NNjzmF/Zz1Pkd3MQrWef7t/5XzhF7qwSyBte0FBAmQX4TZHFSaGt4uk51KUEAjGNF7wOHxGMiQH/3cqfqRIZsBX68QW69nOAL6FTaY6oPwZc5+Ek9rdAkKLIBe73PHOEb1mr4crO7+FyYY4bp6nECx/lkZ3jR6TsBFkb7Hx2VUotw2IS5aJLOqeXN+tKjCEglX7vIG5qweqH0FC7DANmefilhzLP6Cqe/KtCtJAs2ulTNN8DdqAaEkQH1gOqx55tsB9ooKwgoCv5ffa/ttFci2/ffhwp/fAgGXDal4kEbka7sTojS5QUGim1GRPbFU7tkdKcCXSQ+Q9xdu20+ymhScTLCGZoJlyKqvXMEenaTh/hsw4Fb+z3Hr3tN8jlamaKiHEFUisCKGB0awOuhapQ9jMx2fBDkImS6IGfTVg9yRE/Er6EC5hZ11UBL3REU12Kb4yUIFSVPt/eKuaEwPO1tanzKdW7I4VQQZjd+EbaT/JL5Y0qi9DcLU46/R5iWbhEsDEvlCW0zaftaT5V9gu+WINkE7bt16J/Hi/et24VelnOb8uJY7YSEmn+6hOo7Iaxs9ByZu+runFh10NFkjOtH2MKQ7KiDdVcWZYbsURoRDOZZ5pXYz2vgz7/r1Uz1N0Lj8AVFpPCdksWC8xpC0txT+wVXKVuLTCsnWvrpallqUrlqWahBk9+1AcYZ4dN6Rp2cj4xby92YyWBAYiqSFYHiQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(46966006)(36840700001)(44832011)(7636003)(316002)(2906002)(36860700001)(9786002)(83380400001)(107886003)(110136005)(478600001)(82740400003)(5660300002)(8676002)(356005)(54906003)(8936002)(53546011)(31696002)(82310400003)(186003)(26005)(47076005)(36756003)(70206006)(70586007)(426003)(2616005)(336012)(36906005)(4326008)(31686004)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2021 14:12:06.9603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d34b35-66cb-440c-3a9c-08d8cf602e1d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT055.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4361
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/8/21 7:31 AM, Rajan Vaja wrote:
> From: Tejas Patel <tejas.patel@xilinx.com>
> 
> Fix smatch warning:
> drivers/firmware/xilinx/zynqmp.c:1288 zynqmp_firmware_remove()
> error: dereferencing freed memory 'feature_data'
> 
> Use hash_for_each_safe for safe removal of hash entry.
> 
> Fixes: acfdd18591ea ("firmware: xilinx: Use hash-table for api feature check")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> ---
>  drivers/firmware/xilinx/zynqmp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 7eb9958..83082e2 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -2,7 +2,7 @@
>  /*
>   * Xilinx Zynq MPSoC Firmware layer
>   *
> - *  Copyright (C) 2014-2020 Xilinx, Inc.
> + *  Copyright (C) 2014-2021 Xilinx, Inc.
>   *
>   *  Michal Simek <michal.simek@xilinx.com>
>   *  Davorin Mista <davorin.mista@aggios.com>
> @@ -1280,12 +1280,13 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
>  static int zynqmp_firmware_remove(struct platform_device *pdev)
>  {
>  	struct pm_api_feature_data *feature_data;
> +	struct hlist_node *tmp;
>  	int i;
>  
>  	mfd_remove_devices(&pdev->dev);
>  	zynqmp_pm_api_debugfs_exit();
>  
> -	hash_for_each(pm_api_features_map, i, feature_data, hentry) {
> +	hash_for_each_safe(pm_api_features_map, i, tmp, feature_data, hentry) {
>  		hash_del(&feature_data->hentry);
>  		kfree(feature_data);
>  	}
> 

Applied.

Thanks,
Michal

