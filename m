Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2313F423A0E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 10:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237802AbhJFIzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 04:55:53 -0400
Received: from mail-mw2nam10on2088.outbound.protection.outlook.com ([40.107.94.88]:34912
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237593AbhJFIzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 04:55:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNf1XMiJaLA2DwWM7ZW5yJAcyqoXsfMPgllUOZiD9r5tNNlwC6YQHKAb9GaAGq4pxclCZ2DhMShQdqRy3MwFw1WsluOEhLvluOus+5XYb9aCkP8Uk1RPm1dIJs+TBbkiFXjvZFtjRaLQ1bA+MgX04lKs3Q6vRuwSGyLmF05tgQ5G9GDeCzGz1FutoHlW/HzohfxKvlB3z4KefDHG80rRo0Ir7urkZEiiK+KB/klKcZx3ZPaWdSWiN2Fh8YJuS1egLeXhMG6kns+7dky+PNsivxYmnTGptXWb8utAFM+pQ3poB8OwQv9ovmkapUAY1Livws+Lje5dkbAtQ7BUhgco9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=km4pF6TbwAYk8ofGldXkiRdMHob9F5EXPl0nLS4KbBI=;
 b=JrL/PzHkn/kgW8cLq4MPAavdeK8xfnGtXoOUNJmH1Cpe6CeNACdnukeZ9hmMzH9QuZoTdFNTc/Fi5lI7GOXfdLQ8tSLuGsDU+0Xkl9f+XFAwXvTsm9c+DByVf/+c75w1qG1lieD9L38+K0Q5HiWHR1FzCCdf+w+BwbvfhMPDHOV/W8bQv0E3X0MN8ZrLDOf+JTZyUrO7p4zLngsm5r/ts7c6uxt0yWuZ0lBsbNd+hF2jvb/LsR0lW0OxRVC6XkF99/PHVXIkAhzYA8c7FdpqYva6szBwyBE2VoiQhAz7OzZmxnsKhahTRq++5olPHmuKmErNDt6YYjXqKV09v6kysg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=km4pF6TbwAYk8ofGldXkiRdMHob9F5EXPl0nLS4KbBI=;
 b=ndqRPbU1uiMs+ztbjLNwHP9xM2mL/yYqmwQQtrUdZD3lMiKzDVkyDNXfuIU6thHntL6SDa7A0nBxUyqKjH0fxjItCRJVFjQrAUni28IyBRmYHkvkgXiGc+FS3N740DUdAzmz7tu128/Mvx7c6xfJThh8mc5EPcaso5fP7aJop58=
Received: from BN9PR03CA0861.namprd03.prod.outlook.com (2603:10b6:408:13d::26)
 by BN6PR02MB2532.namprd02.prod.outlook.com (2603:10b6:404:56::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Wed, 6 Oct
 2021 08:53:58 +0000
Received: from BN1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::b3) by BN9PR03CA0861.outlook.office365.com
 (2603:10b6:408:13d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19 via Frontend
 Transport; Wed, 6 Oct 2021 08:53:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT027.mail.protection.outlook.com (10.13.2.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Wed, 6 Oct 2021 08:53:57 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 6 Oct 2021 01:53:57 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 6 Oct 2021 01:53:57 -0700
Envelope-to: linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 arnd@arndb.de,
 gregkh@linuxfoundation.org
Received: from [10.254.241.49] (port=37992)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mY2gW-0005Hz-VC; Wed, 06 Oct 2021 01:53:57 -0700
Subject: Re: [PATCH] firmware: xilinx: check return value of
 zynqmp_pm_get_api_version()
To:     Rajan Vaja <rajan.vaja@xilinx.com>, <michal.simek@xilinx.com>,
        <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
        <manish.narani@xilinx.com>, <nava.manne@xilinx.com>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1633509835-31949-1-git-send-email-rajan.vaja@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <fc238137-b78c-d137-df43-c9465315a12e@xilinx.com>
Date:   Wed, 6 Oct 2021 10:53:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1633509835-31949-1-git-send-email-rajan.vaja@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 670463e4-4580-4309-0d1e-08d988a6d5b8
X-MS-TrafficTypeDiagnostic: BN6PR02MB2532:
X-Microsoft-Antispam-PRVS: <BN6PR02MB2532F9825FBB281A95592759C6B09@BN6PR02MB2532.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oGoC4rOb6S9BnQNcParLoPuC75HCf+S4l/g/aIVogOtjWjIPXi1hvQkMiXDuVrewQFoIDIJwwEDnSXxTxNkDu8A20+FiuR13HjTMHS6pTNwz/RTAtYmcdYdqohjcj+yS4iyP2VPfnzpkLuFhA4IzahawNK+km8h0xbtfkohMJNbBTRlQ2ej0x8Bk+enuO6kp0FbSwSZ5W52ksRKZJ6wmG5E7yU4sEiDefI37gtx7ZiHFnmFmSUh2xxf1VU6oZOafnIJHLjLecUJhk7+fiHOR8ehMXw6Z5GbipKYiH4hZY/RqbOqdPfueda+zpRHwLblcOLRSJgPT3d9V8jCYyD5Aug3un1ArUUzpoUu4y4e48jwkNZH/ZnBV2zLzvCTD4eo9rbabQg2YPgQAzhXWv50UeEyaya1+kUgLz1sbcISwAQRC/tRUn7e+rwoh1644P54Z9L4s5mZYlnEmHwIM2IbOHHcBRoHjP2relDuGlciXA3KVe32rer0oe1v/Z+GuylgtL7kjHToIKBqSNRu5yeHhX8DAXzf2MtO1qQAIsY/8PpZ7OmeHFT5qAOAnqBrma6EtZqAGk+mT+dLK4CcSioOwWA1hdSrAmw/YYAPZK+m1nrrngCT4FjFYId5W8szA6NYNSm0M/79e6tfnOec80CAoiYT9fadOdSfMD5lvXSKo12hH80NjwdulUs7Pd+fd3lW1UEQjfTX9MpP+J3vHyHq2YPVIN11JpooTOt3St7K9AtgH9ZdONJEMTAF7qMR5Vg9Tp9vjzFj+ehPRkavLdMwTcg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(9786002)(36756003)(508600001)(31686004)(44832011)(26005)(5660300002)(53546011)(2906002)(8936002)(70206006)(83380400001)(186003)(6636002)(70586007)(8676002)(82310400003)(31696002)(110136005)(36860700001)(316002)(426003)(2616005)(47076005)(36906005)(4326008)(336012)(7636003)(356005)(54906003)(6666004)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 08:53:57.9784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 670463e4-4580-4309-0d1e-08d988a6d5b8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT027.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2532
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/6/21 10:43 AM, Rajan Vaja wrote:
> Currently return value of zynqmp_pm_get_api_version() is ignored.
> Because of that, API version is checked in case of error also.
> So add check for return value of zynqmp_pm_get_api_version().
> 
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> ---
>  drivers/firmware/xilinx/zynqmp.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index a3cadba..070197e 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -1371,7 +1371,10 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	/* Check PM API version number */
> -	zynqmp_pm_get_api_version(&pm_api_version);
> +	ret = zynqmp_pm_get_api_version(&pm_api_version);
> +	if (ret)
> +		return ret;
> +
>  	if (pm_api_version < ZYNQMP_PM_VERSION) {
>  		panic("%s Platform Management API version error. Expected: v%d.%d - Found: v%d.%d\n",
>  		      __func__,
> 

Reviewed-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
