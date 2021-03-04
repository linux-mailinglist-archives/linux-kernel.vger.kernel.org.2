Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAA332D75A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 17:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236536AbhCDQEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 11:04:37 -0500
Received: from mail-bn8nam12on2058.outbound.protection.outlook.com ([40.107.237.58]:14934
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236484AbhCDQEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 11:04:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MY/GoxLKpv88r8kkxgPk8npgyScODVf0WIJ3Is3S4U3W1u20BYsbd8L2mfZZmSTIW09/S9XZRBL+ZxG0+v4XdKzFLwr5GJGVtHh9rQgLdcTFSLyGAlvryBczNVoUXDbaZSHt64VEFo0et4VdgmnDb+4sxACefXugma6AxokX9DECrA3GwNLcL4ZXU9ekVeaVz2RsQLaA/10fA/pcXXDpBjkY6wWsmjrEeUvpxP1T/v1yjak5dzHFFFP0sFrslYnKaOtYqK3jqajUQXzlE44sRWND/5FnNI76HE+x26gILjahdx/FYB6+Or3fB7CIq/eJ7EdkkEu+IDzGhhcZ5QDk7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHHWHrbP2wFdaPb/NWo/ukQdZ6B2W2YxNL0CW5tHxt8=;
 b=OGsmtV3wxGsu4YtcsyPoWz4xipsbH+su0NAb8IuIIy1Ir85msHnQAMlX9KrS2MpPHIcjhA5bBtE/9Woi6ATRpnMTc5WQxX7eXIoLfv5kzDVLch1zNJQn6ve8URQrZs5BquQ8JIKoLKdO8UbBPNEFb+vh5lidKX069pbtMWbcCvR6GB8OoBEQB9//33o2/ceg3KGeLbKoE8XUjb0P/ZhbV8bZQGZfIGv+tPHLapJ1WjUgPfKhf8UXWlIEoPSqzaMDvvOT/H6SfZsPWDdXvS5I4kd6bB8oLy5VhukZPQ3S07NxS/harZbL6Foyt34UgQX9soVvAgQ3i1FaSscKFsaczA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHHWHrbP2wFdaPb/NWo/ukQdZ6B2W2YxNL0CW5tHxt8=;
 b=LuBHqMAI1W7JtBjfjqVfBQIEznH/oflXnorTALpEjo99yireMtpled+QLFyoufXUqOIs+m3TO5FuJCN6UV9xdTagUFdpIQdwYz+sBqNEMxHrR5Mo/FbRyAU1rQ0vqeMHo96LHOG2udoupmhnu3w16BILPTaKYTTDefug2ip4xIc=
Received: from DM5PR21CA0027.namprd21.prod.outlook.com (2603:10b6:3:ed::13) by
 SA2PR02MB7531.namprd02.prod.outlook.com (2603:10b6:806:14c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 4 Mar
 2021 16:03:29 +0000
Received: from DM3NAM02FT042.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:ed:cafe::aa) by DM5PR21CA0027.outlook.office365.com
 (2603:10b6:3:ed::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.10 via Frontend
 Transport; Thu, 4 Mar 2021 16:03:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT042.mail.protection.outlook.com (10.13.4.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3890.19 via Frontend Transport; Thu, 4 Mar 2021 16:03:29 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 4 Mar 2021 08:03:22 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Thu, 4 Mar 2021 08:03:22 -0800
Envelope-to: michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 p.zabel@pengutronix.de
Received: from [172.30.17.109] (port=50718)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lHqRe-0005wY-0h; Thu, 04 Mar 2021 08:03:22 -0800
Subject: Re: [PATCH] reset: zynqmp: replace spaces with tabs
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-kernel@vger.kernel.org>
CC:     Michal Simek <michal.simek@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210304160042.15316-1-p.zabel@pengutronix.de>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <b5310ccf-2004-b047-c545-cceca3b1ee64@xilinx.com>
Date:   Thu, 4 Mar 2021 17:03:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210304160042.15316-1-p.zabel@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4af6d212-dd5e-4f20-bef2-08d8df270d48
X-MS-TrafficTypeDiagnostic: SA2PR02MB7531:
X-Microsoft-Antispam-PRVS: <SA2PR02MB7531B7EF5A216D1D6DC97048C6979@SA2PR02MB7531.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sNa5PI8tcPJRXOPz8AEyhha8mkyhLuEQYxWZVHZC29hqCO7zRpb1qsldwlF16m+R+LHpad35pHi7vhatYeEMuv9a2AGXToIbkvEgdsGO0wIoDUvd5lQfaKhjIr+11buCDBM1U9LyHlrRZmCQszT7H/VhGzFCVWFp7nvBG2Q3RpUZzoqFFEVlxSEquYRszzOJntvIXx0hGZWedILaHAuaHdshJXAC+37+VExNWdO+N7ZNo2Ls5N25rdYQtJqkMt/1ceDvsCkJksxG/4b0zFYg1nWbiH4A0ColP2WDLzkU5oxyrEHD44D/cdpQn7UN9F6RGe74rGfSI1ZPvqNN+YNUB1oVxn0kYhYxVU4QENLGYy7peJIssOwsbvi4U+5l3rsbE5AlQOABaPog5+H14B1uRB+A+I4xeaYevpVvwnEhs7CVpBoECqv8OCfhMJjb8Ny6Tw6njJ+xxDHq4T2NVAivqQ+PYgoJcd9IDI5gXZkxKtCZFTBoHpT+caxWdw4uy/DoC3Wr/7fSPJNmX/AwjWZNIR/hxJo7n6X8O4wB5jVsfsZXM6hBCclfkT8oT2WSA8PWmtFvVP6OPaE6qsMbkhaijyI/ICQ45vKZTV/1YezY5qwb3Sms3eQpOT3Pjl1iGB1uZB0CyW+Ab5fIhBv7j8z8ca5wegnE7184JNbTJtLfFNT/qmbqg1/KSiGOJ7Z2rE4l1y9tKiyHRD1TtdMmZRdUsg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(36840700001)(46966006)(186003)(336012)(4326008)(82310400003)(36906005)(31686004)(316002)(5660300002)(9786002)(83380400001)(2616005)(8936002)(36756003)(478600001)(8676002)(2906002)(70586007)(54906003)(70206006)(426003)(44832011)(7636003)(356005)(53546011)(82740400003)(26005)(31696002)(47076005)(36860700001)(110136005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 16:03:29.1625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af6d212-dd5e-4f20-bef2-08d8df270d48
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT042.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7531
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/4/21 5:00 PM, Philipp Zabel wrote:
> Fixes checkpatch issues:
> 
>   ERROR: code indent should use tabs where possible
>   #86: FILE: drivers/reset/reset-zynqmp.c:86:
>   +        .reset_id = 0,$
> 
>   WARNING: please, no spaces at the start of a line
>   #86: FILE: drivers/reset/reset-zynqmp.c:86:
>   +        .reset_id = 0,$
> 
>   ERROR: code indent should use tabs where possible
>   #87: FILE: drivers/reset/reset-zynqmp.c:87:
>   +        .num_resets = VERSAL_NR_RESETS,$
> 
>   WARNING: please, no spaces at the start of a line
>   #87: FILE: drivers/reset/reset-zynqmp.c:87:
>   +        .num_resets = VERSAL_NR_RESETS,$
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/reset/reset-zynqmp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/reset/reset-zynqmp.c b/drivers/reset/reset-zynqmp.c
> index ebd433fa09dd..daa425e74c96 100644
> --- a/drivers/reset/reset-zynqmp.c
> +++ b/drivers/reset/reset-zynqmp.c
> @@ -83,8 +83,8 @@ static const struct zynqmp_reset_soc_data zynqmp_reset_data = {
>  };
>  
>  static const struct zynqmp_reset_soc_data versal_reset_data = {
> -        .reset_id = 0,
> -        .num_resets = VERSAL_NR_RESETS,
> +	.reset_id = 0,
> +	.num_resets = VERSAL_NR_RESETS,
>  };
>  
>  static const struct reset_control_ops zynqmp_reset_ops = {
> 

Reviewed-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
