Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7643AE853
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 13:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhFULse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 07:48:34 -0400
Received: from mail-dm6nam12on2064.outbound.protection.outlook.com ([40.107.243.64]:47553
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229576AbhFULsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 07:48:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4jWWEHzVL9cAB+jHQMij8tkLD7O4loPc32VREP66F/oIvwtiUFhbCH7vcOYBrcm0woV99ShV0v/EGgkFe6WhQgHFn5g8jPkrWwSGDM6u1p3Do/fdgUGcaIy81QJOuOFI2QruQAXN75W2AfXkDfe+pc38tii0sngLqXUko3LHDHEzSU+O34k41s+kPHmOkGi67LthqfLekw51H2ZXQRzA5cvz1cWsV9nxwjmDr5p+fOhh1VbeLKncsUt+0T9kCvL/1t0R/SoySKcLvdKIs8sttoeZtr8WdoK7sMoUQVNDl74/BHgrKGV4QNNtJoUL4ML6V2I21H35HLVGwPd9KyFbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfCaix4Rmr6isRzPYA8PJoD3nZQUIQ0eNsKXltEZDaE=;
 b=IX8/5bsEbyAN9qYSk7Rv1wHk1uR5NWgFztFJ9qH+MvLa1H3M7K233G7qR87I4RHXTOlaBFxumOicg0LijHdlwV8N03jFa2/P6jG9vxDnszRPyzUUu10PvsEek65rZBAAdCniPA4/z5GmtyoSmmXbrcD0BEMkG5fKWBDoMUlrsUDMb3cASyaOluT8+84zC7zSKMVMwlgJeP0I+DpI3mujoDCQmhVlcDwTTOGqHHTz8UO/UX7s9WGbyYyTrvgzWJ6+8zHfzBZe6J4nQQaBNWrEicRFtysNjO52O8fbCNcO4D71dBab4j803HDnMyGh1+OsNQPqbriqU53iUE4snzczoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfCaix4Rmr6isRzPYA8PJoD3nZQUIQ0eNsKXltEZDaE=;
 b=qrsm+ffSJl3fIicA3ClrhE0DkZv1UoZ3ougSbIFO5RE01yLdSYxiU4VEzdLmRt1KTsEFxSe7JVlk2Dr/eEIsAA30JgxypQ5/QAVOBKtcHhmM0F4buSV30Sa5Bd13179nA+0n4i+FYRIwaWHwGWlK1H2M9TM7U3noJG85f9BQwuA=
Received: from BN9PR03CA0939.namprd03.prod.outlook.com (2603:10b6:408:108::14)
 by MN2PR02MB6717.namprd02.prod.outlook.com (2603:10b6:208:1d1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.25; Mon, 21 Jun
 2021 11:46:18 +0000
Received: from BN1NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::fb) by BN9PR03CA0939.outlook.office365.com
 (2603:10b6:408:108::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend
 Transport; Mon, 21 Jun 2021 11:46:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT033.mail.protection.outlook.com (10.13.3.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 11:46:17 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 21 Jun 2021 04:46:16 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 21 Jun 2021 04:46:16 -0700
Envelope-to: linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 zou_wei@huawei.com
Received: from [172.30.17.109] (port=49584)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lvINc-00035M-Cy; Mon, 21 Jun 2021 04:46:16 -0700
Subject: Re: [PATCH 3/6] firmware: xilinx: export the feature check of zynqmp
 firmware
To:     Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>,
        <michal.simek@xilinx.com>
CC:     <rajan.vaja@xilinx.com>, <manish.narani@xilinx.com>,
        <zou_wei@huawei.com>, <amit.sunil.dhamne@xilinx.com>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <wendy.liang@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1622217566-1856-1-git-send-email-abhyuday.godhasara@xilinx.com>
 <1622217566-1856-4-git-send-email-abhyuday.godhasara@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <5cc24f36-c0cb-776f-fc9f-d9d3ccc791b2@xilinx.com>
Date:   Mon, 21 Jun 2021 13:46:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1622217566-1856-4-git-send-email-abhyuday.godhasara@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee971057-233a-4f00-8ff8-08d934aa2e9b
X-MS-TrafficTypeDiagnostic: MN2PR02MB6717:
X-Microsoft-Antispam-PRVS: <MN2PR02MB6717F6A5744315703CFF0C3DC60A9@MN2PR02MB6717.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jGDAJBQM9goeIaHc4H4r5EJG6RbIQF+Cm4kU5VLdQgx8Z3eGpXa4EqbvVQc64EeVrX7U93+hHEDUarv/BBSOiblPF0i3ssSpv/AYcXZacfVNem16je4qxutj1jdXglq3teOa5K6mT30Cx9wahGCfnLstk+Vctz6w5UDSd6cUdLymDbRqPv/wOeXRNC4b//vStX5Mte5hlT3NCynBZnAHzHN1vzf3w65fTE8/kDt9EB9F7ldGQSymSZ7oYOUTVnvQiz//mzg1FwwqmZQgUoyjIWldKgdSc2z3brVrLe6fbZchgGQnhR9sUu9HA/z1uuaBAf/mWgsn9uYwNgvU3JQHR7KlcD38nKCC1Xm+CbysgXMhzXBaVkQHQKIHyXHZ9f+aOPmjJ7TFvNqStH+69FAna3KwXIVsO5JGcfFPdsauqmwg//krYOj00AvHec8jBbL+2OAA5Bc0myPQsECUiRLJmtG5rN3nlIkp20bNSR00yHHrRdlPlqctZMFHo0V9ohOE7Do2afFS8queOeEwNkMCOcgtDmbE4euAqUPiHiWqFCSCt3b835NsWByEBAjkglYFtLerveofqo5xUfpIRIyTuF5ygLCAzPbfrdt34OPPKDdHdVNyCELrkcN3Vh3/rQqYMDvdaFY1vmk9c/uwgrVpUbwOe7vV89hyuyGwRVb9zgEvep06FRTidEMB4dK0KYGaR5YAII5U2NjEDg0dfWbHJA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(39850400004)(36840700001)(46966006)(26005)(4326008)(426003)(36756003)(31686004)(36860700001)(186003)(356005)(2616005)(82740400003)(478600001)(54906003)(5660300002)(2906002)(6666004)(83380400001)(316002)(9786002)(44832011)(36906005)(7636003)(8936002)(70586007)(31696002)(82310400003)(336012)(110136005)(70206006)(47076005)(8676002)(53546011)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 11:46:17.9247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee971057-233a-4f00-8ff8-08d934aa2e9b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT033.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6717
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/21 5:59 PM, Abhyuday Godhasara wrote:
> From: Rajan Vaja <rajan.vaja@xilinx.com>
> 
> Export the zynqmp_pm_feature(), so it can be use by other as to get API
> version available in firmware.
> 
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
> ---
>  drivers/firmware/xilinx/zynqmp.c     | 3 ++-
>  include/linux/firmware/xlnx-zynqmp.h | 6 ++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 33f190e..ce16a72 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -153,7 +153,7 @@ static noinline int do_fw_call_hvc(u64 arg0, u64 arg1, u64 arg2,
>   *
>   * Return: Returns status, either success or error+reason
>   */
> -static int zynqmp_pm_feature(u32 api_id)
> +int zynqmp_pm_feature(const u32 api_id)
>  {
>  	int ret;
>  	u32 ret_payload[PAYLOAD_ARG_CNT];
> @@ -190,6 +190,7 @@ static int zynqmp_pm_feature(u32 api_id)
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(zynqmp_pm_feature);
>  
>  /**
>   * zynqmp_pm_invoke_fn() - Invoke the system-level platform management layer
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index c715756..06ea5a4 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -427,6 +427,7 @@ int zynqmp_pm_pinctrl_set_config(const u32 pin, const u32 param,
>  				 u32 value);
>  int zynqmp_pm_register_notifier(const u32 node, const u32 event,
>  				const u32 wake, const u32 enable);
> +int zynqmp_pm_feature(const u32 api_id);
>  #else
>  static inline int zynqmp_pm_get_api_version(u32 *version)
>  {
> @@ -644,6 +645,11 @@ static inline int zynqmp_pm_register_notifier(const u32 node, const u32 event,
>  {
>  	return -ENODEV;
>  }
> +
> +static inline int zynqmp_pm_feature(const u32 api_id)
> +{
> +	return -ENODEV;
> +}
>  #endif
>  
>  #endif /* __FIRMWARE_ZYNQMP_H__ */
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
