Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E736131C6A0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 07:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhBPGtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 01:49:10 -0500
Received: from mail-mw2nam10on2077.outbound.protection.outlook.com ([40.107.94.77]:6752
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229790AbhBPGtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 01:49:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWsoIP4Ti37Q5nUiSkHEOYE0u4idMGlkKRZ58OyfSReE9Ax+c6DLIranplB/+gA+PuHBZ4iO8bdy2nEttxlbSzAq8g5HHZne0ppD524G0+/3/fB2/sluUT29djjvDMl4nsF9XOMc/q05nZlJTAiKqu5AQO/XassAbf1WBh/vHreVw125+yyqR61G9eiS4/vO43DV5mtppDzhRx92UGybcQ+RWatoHXWb6nh56DGtKwp4jNMiDIlKXz71AvuX0+t3To0lsCDgcYDJAjaOeAXUlkr3P6IrfpsLKF21jcp3crWlZCLXKMAgyirpBfdzEI8oM4hZTqOy8T0xN2dYgbEIkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlcqXVaFnWBvfwkuJxYmHW78/Yc8fJisXaMHJx+xwZ0=;
 b=VIC4oYHS7AGUDycFe+owCz1fzvSpIi5VY4wOFjERbJqZR+1b/9t5z2kcO9wxjWI2s+yXpTPTh0GWGhmxme5QkkCstlJqcGAn5kl29soRTwWPXVGzjRCWkyVHkFVAl9TyW3JP3CkDyKDZ8qRmuAyfuXGn1nFsHsghxhXGyFnmDdQKdHvP7OZbU8Eb1WB9ems2fvVcn7cpmpmitYhsml/ZjKfR588zV5zWsENDkV1I7J6OiTxLFxWmwa2nBe5x17ELOGcUfHIeJPx5qc+maf3Wyzk21yh1hYNm8jTjadgv8QPczofOtKELF3K0N6hTSrR/bD3UypBKSBLXYpEtZ6LOqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlcqXVaFnWBvfwkuJxYmHW78/Yc8fJisXaMHJx+xwZ0=;
 b=S//moBwEmURQp/ROcDo/kTGhrBEXfJLSecqN0Sgb0XkwkJs9Z6T3UeaXEPUZBgaNKi4XygCaxn611GIAWO9fdej2cgal/9DP9rhs6JpZeQVC5RUEUMGXteqeHDEi9Y8P96Wk2lOZrzbVGQp6u//JDF5NDs6sog8qXGzhLqFX4Y4=
Received: from BL0PR02CA0106.namprd02.prod.outlook.com (2603:10b6:208:51::47)
 by DM5PR0201MB3528.namprd02.prod.outlook.com (2603:10b6:4:7e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Tue, 16 Feb
 2021 06:48:12 +0000
Received: from BL2NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:51:cafe::23) by BL0PR02CA0106.outlook.office365.com
 (2603:10b6:208:51::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend
 Transport; Tue, 16 Feb 2021 06:48:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT025.mail.protection.outlook.com (10.152.77.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3846.25 via Frontend Transport; Tue, 16 Feb 2021 06:48:12 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 15 Feb 2021 22:48:11 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Mon, 15 Feb 2021 22:48:11 -0800
Envelope-to: michal.simek@xilinx.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 iwamatsu@nigauri.org
Received: from [172.30.17.109] (port=60682)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lBu9b-0004rf-3x; Mon, 15 Feb 2021 22:48:11 -0800
Subject: Re: [PATCH v3] firmware: xilinx: Remove zynqmp_pm_get_eemi_ops() in
 IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE)
To:     Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, <michal.simek@xilinx.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210215155849.2425846-1-iwamatsu@nigauri.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <a84e9ebe-0099-8841-fb26-54d123fb79fb@xilinx.com>
Date:   Tue, 16 Feb 2021 07:48:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210215155849.2425846-1-iwamatsu@nigauri.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf2fcb8f-1388-4824-4af5-08d8d246d470
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3528:
X-Microsoft-Antispam-PRVS: <DM5PR0201MB35287776E5ECD69C17BDBCFAC6879@DM5PR0201MB3528.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Albhd1v+QlZObORViNkcCTBrMzqU5QVYbf1o3IOB1+T2iKDQy8vwCifuZY5aW9CHgQ9+3T8okZjZ+YnvcsPS1WfxxzSK1SRLELEwgsIM2XugoXinNMeHJTVk6OFbFEBW2OrfLDMSOaID2nNMn+4PkhA6p2TYIjCEG1sybXhiQ+aHZQTQoGKy0Gj0IUSB/gYXo9TcJ3Bagfo3QYBkQPQV3PfGFWudLDDpq2tU1+G+IgjuhVkHF81EWd504DdLe/WSQyAcEXc+2rXo3uWFt2QEo8GJDwdPVm8j0VZaSsGwxubB8i/eAz3yh6R7lJPvQmfGDYuHd5A58IdTVXXelYoP84RSMSRboGyEr+MjfSMr3w/T4UnINskzl/Qongh8MeAiF/8CzLPA5N5dNQO6YiiZ7ZHP0W0+vp/3Wb4b5LtODwezAVCj5/RPtnvhDbWrrCqYMoK9PPMCNcRKdxqBbnE49pZeXEQV1erlJ03/vpx25FmnaOyRP4FO9wBMULTu+Ttq2f1j4QHTYtbLfpT2ondwFbB7h3i7809DIfFIRwFZgEMx9mOun4Ybv0g0u8DCFZV6xajBvzJlR00byKZoQio4XkKFa8eumDzhzfb9lWLtuh1pnXbEeDD2HZDWQnaUff8TjvRzj3m2XZEU7sYIWfESoItC8mxhJbE7Wea0lEgktQAX6tqBNSTDPyB3s1TAbLkOrUqYTe14gL357C/65QqfRg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(2906002)(44832011)(36756003)(2616005)(31696002)(70586007)(336012)(82310400003)(426003)(47076005)(83380400001)(7636003)(186003)(8936002)(356005)(498600001)(26005)(31686004)(36860700001)(9786002)(36906005)(70206006)(54906003)(8676002)(4326008)(53546011)(5660300002)(110136005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2021 06:48:12.5178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2fcb8f-1388-4824-4af5-08d8d246d470
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT025.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3528
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/15/21 4:58 PM, Nobuhiro Iwamatsu wrote:
> zynqmp_pm_get_eemi_ops() was removed in commit 4db8180ffe7c: "Firmware: xilinx:
> Remove eemi ops for fpga related APIs", but not in IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE).
> Any driver who want to communicate with PMC using EEMI APIs use the functions provided
> for each function
> This removed zynqmp_pm_get_eemi_ops() in IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE), and also
> modify the documentation for this driver.
> 
> Fixes: 4db8180ffe7c ("firmware: xilinx: Remove eemi ops for fpga related APIs")
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
>  v3: Update eemi.rst.
>  v2: Added the comment pointed out by Michal.  
> 
>  Documentation/driver-api/xilinx/eemi.rst | 31 ++----------------------
>  include/linux/firmware/xlnx-zynqmp.h     |  5 ----
>  2 files changed, 2 insertions(+), 34 deletions(-)
> 
> diff --git a/Documentation/driver-api/xilinx/eemi.rst b/Documentation/driver-api/xilinx/eemi.rst
> index 9dcbc6f18d75df..579cf9a407ac2f 100644
> --- a/Documentation/driver-api/xilinx/eemi.rst
> +++ b/Documentation/driver-api/xilinx/eemi.rst
> @@ -16,35 +16,8 @@ components running across different processing clusters on a chip or
>  device to communicate with a power management controller (PMC) on a
>  device to issue or respond to power management requests.
>  
> -EEMI ops is a structure containing all eemi APIs supported by Zynq MPSoC.
> -The zynqmp-firmware driver maintain all EEMI APIs in zynqmp_eemi_ops
> -structure. Any driver who want to communicate with PMC using EEMI APIs
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
> +Any driver who want to communicate with PMC using EEMI APIs use the

wants

> +functions provided for each function.
>  
>  IOCTL
>  ------
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index c8a18da6906e78..70e19ab34ff1ca 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -416,11 +416,6 @@ int zynqmp_pm_read_pggs(u32 index, u32 *value);
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

Queue for 5.13 with corrected sentence above.

Thanks,
Michal
