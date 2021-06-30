Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5943B8186
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 13:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbhF3MAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 08:00:03 -0400
Received: from mail-co1nam11on2081.outbound.protection.outlook.com ([40.107.220.81]:40032
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234148AbhF3MAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 08:00:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/YzZkd8phNfDR7/wb/nwISNuXNfFHjQPzwDGC2adRiBw+bvUbS2yHvjEwhCkX7kCCv2oO8r83tFTXOK4Z8KEiphUWK6qFGxjEkc8mQq3X10AhKQ6Ep1xUh2p3/cfxf4icf6/QP4I/+mSt41MQ5rbw+vnnw/t250k791FKlMkC/UQt+khbf/YqM/TAXYpzPOYf/H5uduFhbW4l83UPdKOUG8XWf55sGjEajOwNpH6ALJ6QapK1mq5tzwkDo6DHO8E4uy5G6W8FjnXkbJlryQUJx3hrS3RPEaHFHjQudKt1TIEwjNpxlbDPEDtybpCdSMIg4tc+KLccC+92GDXmluvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwEmAI+wpSqXZU+nmMXTLKKQxLRKWFVO/Ipn2xFBkic=;
 b=mkDWV6jIoOZSdq/Xgx+oVaSllX+LVT/hB+ya+ppWzXwIYJq3Kkq0nKn9NjHXeLAIWn4z1yfMyE8CfKs6iRPFltRti5uwjGbZbBFlyyihOsL2VT3RkaOO2Crm0meyOjN9zOcvp8K59o2Ml0C/tuKSTj5XMUD5owBuf1EjIe4H8H7YaYrPDGbHZsTPQONUib6Tayzbziqbg8U5yIPXm1niyWY425/V26MGJApeJRcrmEyvdS3FgsmjlZKrKO13CdYJbBChKTv/V9oRrruHD+IMaf3YJOwF6w2j9crq/Q36ggcnFtPDE/WJmGQ5UOtG36lQRBhZu9h0GbS9OB3tfhNhNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwEmAI+wpSqXZU+nmMXTLKKQxLRKWFVO/Ipn2xFBkic=;
 b=aagC//iznMJfOAVpzHyU7SJPvp6R7L3ZRKkXM7zAiznAZNsGBpiO7lvPOYMfuilWgISAaMqUH0PHAeTdU7wdm8soh5Iwsf/xGsA4PWCujkmJgUbQVk+LhLCwkwglZrFw1DDHufnNBIEj8CdEX0yHlN7YGpGSLjWc4NyeGwM+2CA=
Received: from BN9PR03CA0752.namprd03.prod.outlook.com (2603:10b6:408:13a::7)
 by CH2PR02MB7015.namprd02.prod.outlook.com (2603:10b6:610:5f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Wed, 30 Jun
 2021 11:57:32 +0000
Received: from BN1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::35) by BN9PR03CA0752.outlook.office365.com
 (2603:10b6:408:13a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend
 Transport; Wed, 30 Jun 2021 11:57:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT027.mail.protection.outlook.com (10.13.2.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 11:57:31 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 30 Jun 2021 04:57:29 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 30 Jun 2021 04:57:29 -0700
Envelope-to: linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 zou_wei@huawei.com
Received: from [172.30.17.109] (port=56240)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lyYqP-0006O0-KZ; Wed, 30 Jun 2021 04:57:29 -0700
Subject: Re: [PATCH v2 2/6] firmware: xilinx: add macros of node ids for error
 event
To:     Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>,
        <michal.simek@xilinx.com>
CC:     <rajan.vaja@xilinx.com>, <manish.narani@xilinx.com>,
        <zou_wei@huawei.com>, <amit.sunil.dhamne@xilinx.com>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <wendy.liang@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <jliang@xilinx.com>
References: <20210625134937.10349-1-abhyuday.godhasara@xilinx.com>
 <20210625134937.10349-3-abhyuday.godhasara@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <a03d64b5-9da7-3a23-9b93-0ee119a7bd02@xilinx.com>
Date:   Wed, 30 Jun 2021 13:57:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210625134937.10349-3-abhyuday.godhasara@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26903a43-ef74-433b-6e6e-08d93bbe3dec
X-MS-TrafficTypeDiagnostic: CH2PR02MB7015:
X-Microsoft-Antispam-PRVS: <CH2PR02MB7015B9380FFA25549D16727DC6019@CH2PR02MB7015.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lfORVtQqI93bnKtu6cTII12RTxthS/JxsFGXXSJaVtcc3IQUwBnT9sGEMdrAJNWwt4EgGsZmpbr53SiOhiv6k6SGZhywZ12UGyjHEhf3brpaeP7KPebYTKKswLfSEJoJxF/wNNI2u1o4Ijf3N+jLh0HqKXgl//7lpATyExjX+zsykZJoM8n2RKaKlfHuc2i2apxXpFb8ZlSA3PSV1qbCCW3N1bfd/p1anSN1BINHRRGRia61GDUWyxCGToiEaH0anHvobReZbKmpg5KnAmDzlCDxxZ1DDEsQ38efwlw2gPl13XJb9h8LuwjUbYkBVtrnyIu4VdYj+WAUfjMSX62YPY4fjaOoOuqYBg9kNmfyKh0V/bzJOG3Zr79yB9wKY8xqPEA93ohBPi0JIBkqydFnQG6ts8pAAaOWBab7++TVmQ8Pz2GiFq13C6OTmmG8Ph/rSrFyAHfptsi9AuOMc2Z+o6ZZDeJQH7vZyj9i0grTVfnU+s8CCEMl5FqeoT3lUIfiKF2ow4B8MASQELwAqb5IonmrsVB16s1c2NbxTN7HmT0FJLuV98p3R4XleINuIuKw0UHPgQyLy/RKweQ0TJv0L8jrCDXvhRfJ5RpRASwFQlxNpsmThmApVTicBrDafUqF+LunXkbl+RcdGgWZnHXUVU9E2GbICNt2Xy9O2XLn+LvJK1QzHA8z9V38fbGoUw62o/GoHLfZUj9sOh55mTMrzWjMLY7O3GGn1f191WU1bt/KbVcdfoWqSX8d8aKuwGhorGl14Ib+fYZ7cLtbFHPEMQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(136003)(39850400004)(396003)(376002)(36840700001)(46966006)(478600001)(336012)(426003)(8676002)(44832011)(8936002)(4326008)(82310400003)(70586007)(6666004)(2616005)(54906003)(70206006)(110136005)(36756003)(316002)(107886003)(26005)(36906005)(9786002)(7636003)(47076005)(82740400003)(5660300002)(186003)(53546011)(31686004)(36860700001)(2906002)(83380400001)(356005)(31696002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 11:57:31.6836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26903a43-ef74-433b-6e6e-08d93bbe3dec
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT027.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB7015
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/25/21 3:49 PM, Abhyuday Godhasara wrote:
> Add macros for the Node-Id of Error events.
> 
> Move supported api callback ids from zynqmp-power to zynqmp-firmware.
> 
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
> ---
> Changes in v2:
> - As per review comment add PM_ACKNOWLEDGE_CB in pm_api_cb_id
> ---
>  drivers/soc/xilinx/zynqmp_power.c    |  6 ------
>  include/linux/firmware/xlnx-zynqmp.h | 14 ++++++++++++++
>  2 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
> index c556623dae02..76478fe2301f 100644
> --- a/drivers/soc/xilinx/zynqmp_power.c
> +++ b/drivers/soc/xilinx/zynqmp_power.c
> @@ -46,12 +46,6 @@ static const char *const suspend_modes[] = {
>  
>  static enum pm_suspend_mode suspend_mode = PM_SUSPEND_MODE_STD;
>  
> -enum pm_api_cb_id {
> -	PM_INIT_SUSPEND_CB = 30,
> -	PM_ACKNOWLEDGE_CB,
> -	PM_NOTIFY_CB,
> -};
> -
>  static void zynqmp_pm_get_callback_data(u32 *buf)
>  {
>  	zynqmp_pm_invoke_fn(GET_CALLBACK_DATA, 0, 0, 0, 0, buf);
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index 655783259415..be3414a6472a 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -60,6 +60,20 @@
>  #define XILINX_ZYNQMP_PM_FPGA_FULL	0x0U
>  #define XILINX_ZYNQMP_PM_FPGA_PARTIAL	BIT(0)
>  
> +/*
> + * Node IDs for the Error Events.
> + */
> +#define EVENT_ERROR_PMC_ERR1	(0x28100000U)
> +#define EVENT_ERROR_PMC_ERR2	(0x28104000U)
> +#define EVENT_ERROR_PSM_ERR1	(0x28108000U)
> +#define EVENT_ERROR_PSM_ERR2	(0x2810C000U)
> +
> +enum pm_api_cb_id {
> +	PM_INIT_SUSPEND_CB = 30,
> +	PM_ACKNOWLEDGE_CB = 31,
> +	PM_NOTIFY_CB = 32,
> +};
> +
>  enum pm_api_id {
>  	PM_GET_API_VERSION = 1,
>  	PM_REGISTER_NOTIFIER = 5,
> 


Acked-by: Michal Simek <michal.simek@xilinx.com>

M
