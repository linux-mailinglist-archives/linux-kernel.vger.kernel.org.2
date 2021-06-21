Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7793AE8B9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhFUMHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:07:32 -0400
Received: from mail-co1nam11on2085.outbound.protection.outlook.com ([40.107.220.85]:62101
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229710AbhFUMH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:07:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMbjb1rDFMjG5s845uD/jbZweSY8SHgwyOY4+2MdGxYr+jPmlwm4QFFapaIP3fdD2wLhW7FO9vtjyWD3eBiZCaBOLDIzblIBTF73HrATSzpBxUV+wuzpP43tM+FYmh4+0Fpg176PreDusv1P1UW6AG+lIwX+ThpKsMnRHDOKsGch4HHKxG8mJAnE1XrFeW7M/PV2aMG0CzNNWEp2cyKPvlCe5GcVRGqbanEQ0eT0AzBTODBNxirEbFMaPUtzzQq1F8TnNewxfVXiSo+PDtNxrclLLx9wvmJTQzdRPT5m9U3IAiSH7MQV9yCH23aJsP4lDfL4wtlTzfg/eHwpzBMsaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnV0ZHlVBGPc6TlbRPbVUDuEpaLVRSqa7O5ZieSx3EA=;
 b=jgXkAYxMd7DoI1MiJTXmr3/36lK8lcJ6AWvpRbwCrVb0vpAt2xsX3vWNrvKyAYTIzVBf4s7z/PqW+vw+UhYObwTQhWyCMVIgrFmPndZOVFUqvvapFXAzhevd+Rpjq8LleK66YuW2Lb8XMwADKoXmo4JETONVqGAluXrMeU0H4KBo+Dxt0ROqpH8722Z1o/E66sU9yKeJB6saA6QvAHDyY0aTmSZllyFj2tlCagrMVQt7dewuzfVu3AoTispPH48IhgglRNEvKszqyweE8ZqRQncfipWkaaHMUDH35O8o8oQk7VL2W7l0Upjjmvd1/X3Vb+v8PcXAw2jAzdKY11/fSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnV0ZHlVBGPc6TlbRPbVUDuEpaLVRSqa7O5ZieSx3EA=;
 b=kAGIqWDwY1z1egGJ+ocbt2evx6nYgu9Hsx7g2PUfcrcqvrWPMRLWEu69Byk6JFTTu7LqpIxtlz1CctEn/yIv+YVgLUbRy+2aJa0vM6eOildV67nmd5+uRtsgjkEiPRMHbrAhrSC/TFJab39PBiG7AN/W+PHfblSKFD7kOz8y0kY=
Received: from SA0PR11CA0097.namprd11.prod.outlook.com (2603:10b6:806:d1::12)
 by BN6PR02MB2818.namprd02.prod.outlook.com (2603:10b6:404:fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 12:05:12 +0000
Received: from SN1NAM02FT0061.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:d1:cafe::23) by SA0PR11CA0097.outlook.office365.com
 (2603:10b6:806:d1::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21 via Frontend
 Transport; Mon, 21 Jun 2021 12:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0061.mail.protection.outlook.com (10.97.4.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 12:05:11 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 21 Jun 2021 05:05:06 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 21 Jun 2021 05:05:06 -0700
Envelope-to: linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 zou_wei@huawei.com
Received: from [172.30.17.109] (port=50770)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lvIbO-0004pa-9S; Mon, 21 Jun 2021 05:00:30 -0700
Subject: Re: [PATCH 6/6] driver: soc: xilinx: register for power events in
 zynqmp power driver
To:     Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>,
        <michal.simek@xilinx.com>
CC:     <rajan.vaja@xilinx.com>, <manish.narani@xilinx.com>,
        <zou_wei@huawei.com>, <amit.sunil.dhamne@xilinx.com>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <wendy.liang@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1622217566-1856-1-git-send-email-abhyuday.godhasara@xilinx.com>
 <1622217566-1856-7-git-send-email-abhyuday.godhasara@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <a1f6c4b7-34a0-ac16-3091-854394c5ad24@xilinx.com>
Date:   Mon, 21 Jun 2021 14:00:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1622217566-1856-7-git-send-email-abhyuday.godhasara@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b23cb631-3275-4af3-acd7-08d934acd274
X-MS-TrafficTypeDiagnostic: BN6PR02MB2818:
X-Microsoft-Antispam-PRVS: <BN6PR02MB2818725220C0CA1064E39E07C60A9@BN6PR02MB2818.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Loaqpm+xhR85WO78WD3YN8TIVZAOCzOQ9scZ9ytpRosewItea1I3wOoTemjjKhpugOADwRNILe+giIjEpikEiURRZThKkuWhmjqCBk7b0bB8f82Kmo5BmTTgjYHUCRUfwipsqaG0AnxzVIAWwFNGon8x9kNc/F2DSzT945omphZIraRwxOrbDGhWJiRJhp2HQkhdPQrN55/F/wqePMGUv8v/Ma8zwj/+Eo3xHLV1VJE6Mj/WmhtsLzmIFRlbQHEFvqq5U8LngoavueR0Te5yNwUCCFD2OxphIxekv0AUaKvri7BZGi7BbWUHKuLP4IK4OkMzC6AGJXwwGCAuvKBkwbf2yE1sclqon1IzgV2qa/ec9ZyyVh0erz+yH6cJXGcP8nCD78BWyKZh3WkfvmYdIjsh3pxr0KFjdA/p34YhwvUaCrUup2mi0NjQYg2RCDgvKnD+6lPxrXThMbQvrEyjDC7TZy5ebXIT4jXWUOiCEdzpkuNv3/ilaUucusLO/K8rtEI2e1mwOvnHzn4E/rJTbKTwySMA1wurTaieBxFw05MP9bPxTaiBM7ORpBEc0suQx7VHlhabtnKMmbouiKadSxYdpzY55HElZINabu0MnvgMRmK6yI53Qk36Cg3xdseGzQ+RkWuSIqLUfYegGX/rHv3RwL7FTHYiB60phIxp1/zgJ8L0i5MoPDF39hzYJmNA/DUr+mPFYuuTnt7qtKXAiw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(136003)(39850400004)(376002)(346002)(46966006)(36840700001)(8936002)(36756003)(4326008)(83380400001)(31686004)(2616005)(336012)(8676002)(26005)(478600001)(70206006)(82740400003)(426003)(186003)(82310400003)(70586007)(47076005)(7636003)(316002)(5660300002)(36906005)(44832011)(9786002)(6666004)(53546011)(110136005)(36860700001)(2906002)(54906003)(356005)(31696002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 12:05:11.8617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b23cb631-3275-4af3-acd7-08d934acd274
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0061.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2818
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/21 5:59 PM, Abhyuday Godhasara wrote:
> With Xilinx Event Management driver, all types of events like power and
> error gets handled from single place as part of event management driver.
> 
> So power events(SUSPEND_POWER_REQUEST and SUSPEND_SYSTEM_SHUTDOWN)
> also gets handled by event management driver instead of zynqmp_power
> driver.
> 
> zynqmp-power driver use event management driver and provide callback
> function for Suspend and shutdown handler, which will be called by event
> management driver when respective event is arrived.
> 
> If event management driver is not available than use ipi-mailbox rx channel
> or IPI interrupt IRQ handler for power events (suspend/shutdown) same as
> current zynqmp-power driver.
> 
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
> ---
>  drivers/soc/xilinx/zynqmp_power.c | 48 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
> index 76478fe..fe7be17 100644
> --- a/drivers/soc/xilinx/zynqmp_power.c
> +++ b/drivers/soc/xilinx/zynqmp_power.c
> @@ -16,6 +16,7 @@
>  #include <linux/suspend.h>
>  
>  #include <linux/firmware/xlnx-zynqmp.h>
> +#include <linux/firmware/xlnx-event-manager.h>
>  #include <linux/mailbox/zynqmp-ipi-message.h>
>  
>  /**
> @@ -30,6 +31,7 @@ struct zynqmp_pm_work_struct {
>  
>  static struct zynqmp_pm_work_struct *zynqmp_pm_init_suspend_work;
>  static struct mbox_chan *rx_chan;
> +static bool event_registered;
>  
>  enum pm_suspend_mode {
>  	PM_SUSPEND_MODE_FIRST = 0,
> @@ -51,6 +53,19 @@ static void zynqmp_pm_get_callback_data(u32 *buf)
>  	zynqmp_pm_invoke_fn(GET_CALLBACK_DATA, 0, 0, 0, 0, buf);
>  }
>  
> +static void suspend_event_callback(const u32 *payload, void *data)
> +{
> +	/* First element is callback API ID, others are callback arguments */
> +	if (work_pending(&zynqmp_pm_init_suspend_work->callback_work))
> +		return;
> +
> +	/* Copy callback arguments into work's structure */
> +	memcpy(zynqmp_pm_init_suspend_work->args, &payload[1],
> +	       sizeof(zynqmp_pm_init_suspend_work->args));
> +
> +	queue_work(system_unbound_wq, &zynqmp_pm_init_suspend_work->callback_work);
> +}
> +
>  static irqreturn_t zynqmp_pm_isr(int irq, void *data)
>  {
>  	u32 payload[CB_PAYLOAD_SIZE];
> @@ -179,7 +194,32 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
>  	if (pm_api_version < ZYNQMP_PM_VERSION)
>  		return -ENODEV;
>  
> -	if (of_find_property(pdev->dev.of_node, "mboxes", NULL)) {
> +	/*
> +	 * First try to use Xilinx Event Manager by registering suspend_event_callback
> +	 * for suspend/shutdown event.
> +	 * If xlnx_register_event() returns -EACCES (Xilinx Event Manager
> +	 * is not available to use) or -ENODEV(Xilinx Event Manager not compiled),
> +	 * then use ipi-mailbox or interrupt method.
> +	 */
> +	ret = xlnx_register_event(PM_INIT_SUSPEND_CB, 0, 0, false,
> +				  suspend_event_callback, NULL);
> +	if (!ret) {
> +		zynqmp_pm_init_suspend_work = devm_kzalloc(&pdev->dev,
> +							   sizeof(struct zynqmp_pm_work_struct),
> +							   GFP_KERNEL);
> +		if (!zynqmp_pm_init_suspend_work) {
> +			xlnx_unregister_event(PM_INIT_SUSPEND_CB, 0, 0,
> +					      suspend_event_callback);
> +			return -ENOMEM;
> +		}
> +		event_registered = true;
> +
> +		INIT_WORK(&zynqmp_pm_init_suspend_work->callback_work,
> +			  zynqmp_pm_init_suspend_work_fn);
> +	} else if (ret != -EACCES && ret != -ENODEV) {
> +		dev_err(&pdev->dev, "Failed to Register with Xilinx Event manager %d\n", ret);
> +		return ret;
> +	} else if (of_find_property(pdev->dev.of_node, "mboxes", NULL)) {
>  		zynqmp_pm_init_suspend_work =
>  			devm_kzalloc(&pdev->dev,
>  				     sizeof(struct zynqmp_pm_work_struct),
> @@ -223,6 +263,10 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
>  
>  	ret = sysfs_create_file(&pdev->dev.kobj, &dev_attr_suspend_mode.attr);
>  	if (ret) {
> +		if (event_registered) {
> +			xlnx_unregister_event(PM_INIT_SUSPEND_CB, 0, 0, suspend_event_callback);
> +			event_registered = false;
> +		}
>  		dev_err(&pdev->dev, "unable to create sysfs interface\n");
>  		return ret;
>  	}
> @@ -233,6 +277,8 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
>  static int zynqmp_pm_remove(struct platform_device *pdev)
>  {
>  	sysfs_remove_file(&pdev->dev.kobj, &dev_attr_suspend_mode.attr);
> +	if (event_registered)
> +		xlnx_unregister_event(PM_INIT_SUSPEND_CB, 0, 0, suspend_event_callback);
>  
>  	if (!rx_chan)
>  		mbox_free_channel(rx_chan);
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
