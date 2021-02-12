Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57B8319F8F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 14:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbhBLNLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 08:11:34 -0500
Received: from mail-eopbgr770079.outbound.protection.outlook.com ([40.107.77.79]:64810
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231917AbhBLMx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 07:53:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xdm11ZYZPxZTHdOFtw/nJypeqos7nO5KbepjyTIrMfth2JXC66V8DJX5gnn/7/T8j5vqxRvup5rsHmmGyI6UqHvQSQ+RKvbqGBwNfXg7cvkPcPSiB08l8Ekdp3DkueIyWpKZODd8I+sTFlpa8+au844vz2/m8HOPZb2IVdxvM9xHCpwqOyul52ArGTf/f+mDSlb21EUgZ2h3ywsHmt7jcucijJQFnLBzHEQ+VC0xNWmYHBWeRLajt6lAm4BZ/c3bQHMUmvocX4cEcLuGBCiJpdZa1RnfkKV8QW8q1YVZiP6Eh4MfRthpA/8M9qoWi+kLS/VUVDNIM5vIvlsgC9CBig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ed2XxWgDc4LHqBHs/3y3ZNSMgL9DiwlZt0PXkK6tPSM=;
 b=Jn/OA6uYIwTIuCtnQ9i8zmfSXcXB6RUavK1Pew/qUN0gD9lQnfo8U0nIOPobJAndUHxpi7GFR8TILTM6u5aUaa3IflIUtMpfp1n45t+g/Ra1UepTF7QKRt3kIBURw0OcN4CBFf2s+283kzCc5WAkfkjbMRJjGgjvBJTOXvBXtDMp4nQMMgLOIiiVKGq4PBkMwjsdbEeNNIJIo9LXV7lmQPIUO2L7ohVhDMHjbCB2TdwlBDYKmb/b+CEQ5YN0GkuPnWkClN8owXiP2fdsdSwhczN48Q75Y4J/xu/a4jmzi/qtoc/P2LdafSpe6nhi9JeBAoS2+sTObN0WOj0NCcU4Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ed2XxWgDc4LHqBHs/3y3ZNSMgL9DiwlZt0PXkK6tPSM=;
 b=qNB3e7lJv6RjdckHWneQjvM/xdJBAqoWnTuemr3Um9si6hBsZOw7t55DlqYqt9wgTnfxxSRxPJdxBtGn0Gdc7pGBGPGL5XXQaNRqQ2XW+f2neH2q4fi3QnGb1ok5Vm33nhvK25BGtuzhaCd2/o+CyZh+iOK1vUI013uo7A5pX/8=
Received: from SA9PR03CA0004.namprd03.prod.outlook.com (2603:10b6:806:20::9)
 by SA2PR02MB7644.namprd02.prod.outlook.com (2603:10b6:806:144::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Fri, 12 Feb
 2021 12:53:05 +0000
Received: from SN1NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:20:cafe::4c) by SA9PR03CA0004.outlook.office365.com
 (2603:10b6:806:20::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend
 Transport; Fri, 12 Feb 2021 12:53:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT037.mail.protection.outlook.com (10.152.72.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3846.25 via Frontend Transport; Fri, 12 Feb 2021 12:53:05 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 12 Feb 2021 04:53:03 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Fri, 12 Feb 2021 04:53:03 -0800
Envelope-to: michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 iwamatsu@nigauri.org
Received: from [172.30.17.109] (port=39654)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lAXwU-0003wr-VW; Fri, 12 Feb 2021 04:53:03 -0800
Subject: Re: [PATCH v2] firmware: xilinx: Remove zynqmp_pm_get_eemi_ops() in
 IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE)
To:     Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, <michal.simek@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210211232312.2082334-1-iwamatsu@nigauri.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <81880da7-3a9d-cb6b-1391-b8f59fcd1a37@xilinx.com>
Date:   Fri, 12 Feb 2021 13:53:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210211232312.2082334-1-iwamatsu@nigauri.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2bf93a9-cd0b-481d-5751-08d8cf5523eb
X-MS-TrafficTypeDiagnostic: SA2PR02MB7644:
X-Microsoft-Antispam-PRVS: <SA2PR02MB7644D2A02F6E6B4295BBBC4BC68B9@SA2PR02MB7644.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Oj9pQ4TycTeKPLstvG08zkvUHdnPeuroxZRPAJOLFxcJCGhaAsrxn5xBeCzpPj67h2HHvmeG3xF21jYHwPWd3lH7GQakREsOWJhQu7WLLcP81hVL+TyfbRO9wxEAmV/A9gUAi9dm25MCl0aNNZz6NhkOBF8Fem5OSRNQSxR6eDxPhL8ehNrBBe68pVPKI2wslkpVWisJGrmhjtB7pCwlaOHgzZ9telIJ2ogDAlncvMRuL0RaUHEXdzpstLU1gIzifii5KaHs8/+a10ubUZwxcFEDehnwu94GRYxg4K6llviCS0a/kCgqjCeVDR80eOXD4/EDjZeOpf6bQlUfbNmH0eLvU6yuBtxwXd5+Z5yngip0HlKV0rjRHPT5u3pr/Ejt3hcjAr1BsHSGNMQt/jtiQFqKVgyCh8jAdI3sWZKeEqtHS4xZNjiOYngbSAXcg7Ic4TJgTeqR+FKmCBT9MgiU0SlyiesNEUYiSob/fMQG4f4RQGkSCTJZeRkZQKNUMKIbGKKXvviLBXCBGW2tssgKu9jaQ5aW9X3Ojqk8yzHmov9Og3mnHPOvJ/ibKu3zKaFLhFFSA4qXfhDAx4RJnDfTp8v33vRed4fBjRrx5W4IfpiJirlO4g/paVPR6kdM8OtgmNzOQWcJ6BULgsBXYXsBzbfuQ4gZq5eashzEAceszuxjmQjSGoL5FHM6F8ggUWV/jI8E2jVFrGM6NnzSjR/hQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(36840700001)(46966006)(53546011)(8676002)(2906002)(70206006)(47076005)(4326008)(31686004)(54906003)(44832011)(82740400003)(82310400003)(9786002)(7636003)(2616005)(110136005)(336012)(478600001)(36860700001)(186003)(356005)(5660300002)(426003)(70586007)(316002)(83380400001)(36906005)(8936002)(26005)(36756003)(31696002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2021 12:53:05.3901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2bf93a9-cd0b-481d-5751-08d8cf5523eb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT037.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7644
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/12/21 12:23 AM, Nobuhiro Iwamatsu wrote:
> zynqmp_pm_get_eemi_ops() was removed in commit 4db8180ffe7c: "Firmware: xilinx:
> Remove eemi ops for fpga related APIs", but not in IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE).
> Any driver who want to communicate with PMC using EEMI APIs use the functions provided
> for each function.
> This removed zynqmp_pm_get_eemi_ops() in IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE), and also
> modify the documentation for this driver.
> 
> Fixes: 4db8180ffe7c ("firmware: xilinx: Remove eemi ops for fpga related APIs")
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
>  v2: Added the comment pointed out by Michal. 
> 
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
> -can call zynqmp_pm_get_eemi_ops().
> -
> -Example of EEMI ops::
> -
> -	/* zynqmp-firmware driver maintain all EEMI APIs */
> -	struct zynqmp_eemi_ops {
> -		int (*get_api_version)(u32 *version);
> -		int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
> -	};
> -
> -	static const struct zynqmp_eemi_ops eemi_ops = {
> -		.get_api_version = zynqmp_pm_get_api_version,
> -		.query_data = zynqmp_pm_query_data,
> -	};
> -
> -Example of EEMI ops usage::
> -
> -	static const struct zynqmp_eemi_ops *eemi_ops;
> -	u32 ret_payload[PAYLOAD_ARG_CNT];
> -	int ret;
> -
> -	eemi_ops = zynqmp_pm_get_eemi_ops();
> -	if (IS_ERR(eemi_ops))
> -		return PTR_ERR(eemi_ops);
> -
> -	ret = eemi_ops->query_data(qdata, ret_payload);
> +use the functions provided for each function.
>  
>  IOCTL
>  ------
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index 2a0da841c942f6..4ef77deaf7918c 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -355,11 +355,6 @@ int zynqmp_pm_read_pggs(u32 index, u32 *value);
>  int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype);
>  int zynqmp_pm_set_boot_health_status(u32 value);
>  #else
> -static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
> -{
> -	return ERR_PTR(-ENODEV);
> -}
> -
>  static inline int zynqmp_pm_get_api_version(u32 *version)
>  {
>  	return -ENODEV;
> 

I can't see any difference compare to v1. Don't you forget to commit
your changes?

Thanks,
Michal
