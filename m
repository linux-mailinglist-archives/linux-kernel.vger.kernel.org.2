Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC831431A7B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 15:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhJRNRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 09:17:06 -0400
Received: from mail-mw2nam12on2082.outbound.protection.outlook.com ([40.107.244.82]:53888
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229519AbhJRNRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 09:17:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lj++UyC8dpYqfD4/FAOVoJK8g5blEzvNW+ed4bGnGAuE0PIfwmtD/I5bFxdw2+MnP5l72y7m2Wvc+0rNeKnUHMIh6pAtFFCS4p69yCcnZBUG71vzqHnWI7d+vQoJilyG5PRxveEzPqu5vJzEOvEr8DQqa7VC9RBOq21FORcqUpBeDGtk69dIzjk7/qerP6po4uPX5TUuNdMAzCgHQ3ZTcEd2tYpsLHz5zt1gpGckU9C3lv1EA95OzqeD26iya7RNBWUOXRto9aSX6ioh1aLmKJWTMQk+bKvaoaNJ+BLEaFkjg6quEQurc5PjxHM6omQv7HbRqQwBH+wic7GKJLFQ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgxFbrA+pWPOWRPu16iezX9/XG3bG+1nz4zyYurl/4M=;
 b=fa4tVpR9PNMwcNt0A2NPKNehJbs6m9Z9AbZAE102WkMuC0gsc5wsKkhmDYZ0+wZ1g9/V97hcdKO4/u60kr+b1fDpkixssx/BRtkTKimkspgrs030LAu45XDkMmWx/+TEmA/zpqclWs8zXtAKZ+PnRif6SR/ooMY6Qxq5P/kUf+eGmhUM1mupbYP8CwrV8tkYJuWVqOr+6n/7r8POolV67gMAxw1R/pDqby479rgTa3x+Ux3SXME9BlGZZ6nPmZXyKkqWwjQridqtQlQ9HWgmHEyfJr5XUHY2xp3kkAQwW/5aITr3N5MXZ1mhr4IU7/Kw2ELA1lXwHMxPsEwAruWS/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgxFbrA+pWPOWRPu16iezX9/XG3bG+1nz4zyYurl/4M=;
 b=M8TeYJllyAc3/5/Ik3afTpUQi2wnCiCZfT2c4V69Z9ds/EBjqVI3B9JxEVnG4rvjyy5y+d+t+HHw0RO//O+7PzdvDvs+EqT2SvNJztkLxZznEkselycZbV3q6z16ZUV21+xUrq5nbHAue5yik5dg4XpXvzD3JLbnf/8lEFt62/A=
Received: from BN9P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::26)
 by DM6PR02MB6281.namprd02.prod.outlook.com (2603:10b6:5:1fa::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Mon, 18 Oct
 2021 13:14:50 +0000
Received: from BN1NAM02FT058.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::df) by BN9P222CA0021.outlook.office365.com
 (2603:10b6:408:10c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Mon, 18 Oct 2021 13:14:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT058.mail.protection.outlook.com (10.13.2.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 13:14:50 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 18 Oct 2021 06:14:47 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 18 Oct 2021 06:14:47 -0700
Envelope-to: gregkh@linuxfoundation.org,
 arnd@arndb.de,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [10.254.241.49] (port=57322)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mcSTX-00061q-F3; Mon, 18 Oct 2021 06:14:47 -0700
Message-ID: <4af277e4-4cab-1e61-8a68-f45df1b19016@xilinx.com>
Date:   Mon, 18 Oct 2021 15:14:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] firmware: xilinx: check return value of
 zynqmp_pm_get_api_version()
Content-Language: en-US
To:     Rajan Vaja <rajan.vaja@xilinx.com>, <michal.simek@xilinx.com>,
        <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
        <manish.narani@xilinx.com>, <nava.manne@xilinx.com>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1633509835-31949-1-git-send-email-rajan.vaja@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <1633509835-31949-1-git-send-email-rajan.vaja@xilinx.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 532eac64-b2b0-4f8d-405e-08d992394446
X-MS-TrafficTypeDiagnostic: DM6PR02MB6281:
X-Microsoft-Antispam-PRVS: <DM6PR02MB62814C9F8AA370E712A1D483C6BC9@DM6PR02MB6281.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JCtoSC0IS5s4tfwmtokVDg3Qbcdidu+uo3xGVdPFpUXaJ/Fpa2WY5Lpnio7lquX4L0e+Xn2d4ic0r+viU2DVYvo7F/iNtQ8jLbaT9HUOzUx6KlBwWyHCTBpmdNduVVbO/5Pv9o4bv3VsnJrh9PQrJ1EAjGv8ks/PfIO/rGoL+uMhITfs8iWlFxakI6aatrBHNFQHAnBErdl3fMOpue7Wp/G92jiSrvcSG36kCMEobyhskFfDaEZizJWDkfARgUDDF4RVzRdIX/rj7Ah1Up3M9agRTRN0K/YDNCJNSilau0kHKcH9s+9TkQHNY0U4Jv8rkS+Waienr1dt85q85o+/S4yIwdk52ywJr33M5LfrPC1FNnG1tEKaOHXrcepdskocePlop35KiY7anbAmSnHx+/QXh5HubNDQFzhkumOhzpxQHNkQ1XPdwbaE6IEd8O/XSw97LnAcAozlGIbCJsOEFpY5tet+wRRbw+70478bxUxK3G92h3wNos6aO8LSlamtCvUvgxs8EUcPz7g+wR51Pwmq69k069sqo9L6pDKptbfbrJWW3lgxdarBK0vUJDPL0c+tS1VjYEFh9a/SWraZEJ5FYvJftFADvjjEu4UT6O7G5gHwNF8n+BFMLNmlraT09x8fgsLJcr6O2Gw2+5BiNWGA9zy4rzeMUAgkv1rlJ5KuFQ+qkwcWpdhHjQHavIfieWT8m6XzHtxNDKaKlEfJtuulc+CXXc8sF0p1XtqFXHxQJee3CIU21Tzf0o9uJypqN4hYF+P5bTsnk/KdfXOOTw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(70206006)(82310400003)(110136005)(26005)(70586007)(9786002)(31696002)(356005)(336012)(54906003)(8936002)(36906005)(36860700001)(53546011)(47076005)(186003)(8676002)(2906002)(44832011)(508600001)(4326008)(316002)(83380400001)(426003)(2616005)(31686004)(36756003)(6636002)(5660300002)(7636003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 13:14:50.4472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 532eac64-b2b0-4f8d-405e-08d992394446
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT058.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6281
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/6/21 10:43, Rajan Vaja wrote:
> Currently return value of zynqmp_pm_get_api_version() is ignored.
> Because of that, API version is checked in case of error also.
> So add check for return value of zynqmp_pm_get_api_version().
> 
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> ---
>   drivers/firmware/xilinx/zynqmp.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index a3cadba..070197e 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -1371,7 +1371,10 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
>   		return ret;
>   
>   	/* Check PM API version number */
> -	zynqmp_pm_get_api_version(&pm_api_version);
> +	ret = zynqmp_pm_get_api_version(&pm_api_version);
> +	if (ret)
> +		return ret;
> +
>   	if (pm_api_version < ZYNQMP_PM_VERSION) {
>   		panic("%s Platform Management API version error. Expected: v%d.%d - Found: v%d.%d\n",
>   		      __func__,
> 

Applied.
M
