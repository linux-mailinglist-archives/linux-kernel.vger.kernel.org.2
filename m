Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C645A449B9E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 19:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbhKHS1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 13:27:40 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.1]:38311 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235525AbhKHS1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 13:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1636395888; i=@lenovo.com;
        bh=Q3cszk1K360DO1ttutnqVpU95gWzN68rst0qjfV1Ekw=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=YOlPixGN0tPAxyBdrfDLHVztJn24M7bSlqnerjZvfortlmIcBKoYmaKdlxqdfbB8w
         TL1sAn47tRh5hduQiC/kgYPkrwW4wfkmiFpA0cKcialLQzlr04PHwIHTaB9S2nTEvO
         Hyl4u5wLSiAgHvRJOQcuggwyOXMkOOfPdllycdXn6PFyXUq64+W3RADqBxDn183/gc
         P43GsFL8S301aauDN1LDXnnmfoJXUkCCm0k+NYmT4E62JobsZg0Gc2W+b96NrtZJTl
         /oiW923edOSvQEaTDDo5vltcyL7zd45Q+lsbwg/XRUoZFpXSgKK0tzjLMmmywc4JK7
         O4dqWzRz21hPQ==
Received: from [100.112.131.15] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.us-west-2.aws.symcld.net id EC/C4-26774-07B69816; Mon, 08 Nov 2021 18:24:48 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCJsWRWlGSWpSXmKPExsWSoV9jpFuQ3Zl
  ocPgcj8W3/z1sFm+OT2eyuLxrDpvFganTmC1W73nB7MDqsWlVJ5vH+31X2Tw+b5ILYI5izcxL
  yq9IYM1Ydu0ca8FFiYrjR/6wNTD+Ee5i5OJgFFjKLLHk2BVWCGcRq0TzpD9QTieTxKLumWwgj
  pDAIiaJE2tusEA4h5gkmjc2A2U4OSQEjjNKdK9yh0h0Mkrs3voDqmUiUP+OLewgVUICjxklGn
  prIBIPGSWunt/KApLgFbCVaP31C6yIRUBF4lNvKyNEXFDi5MwnQDUcHKIC4RINd4pBwsICERL
  3P90E28wsIC5x68l8JpASEYEEiWlNESAms4CnxMulORBbnSQ+32sEW8QmoC2xZcsvsE5OAWeJ
  7eefs0BMsZBY/OYgO4QtL7H97RxmiF5liV/955khflSQ2LD+LzuEnSDR8+8R1O+SEtduXoCKy
  0ocPTuHBcL2lVjXtowV5BwJAS2Jf390IMI5EvcmT2SFsNUklv6+xzSBUW8WkndnIflrFpLrZi
  G5bgEjyypG86SizPSMktzEzBxdQwMDXUNDI11DI0tdY2O9xCrdRL3SYt3y1OISXSO9xPJiveL
  K3OScFL281JJNjMCklFLQqLiD8cLrD3qHGCU5mJREebXsOhOF+JLyUyozEosz4otKc1KLDzHK
  cHAoSfBmZgHlBItS01Mr0jJzgAkSJi3BwaMkwrs8HSjNW1yQmFucmQ6ROsVozDHh5dxFzBwnV
  y1ZxCzEkpeflyolzpsFMkkApDSjNA9uECxxX2KUlRLmZWRgYBDiKUgtys0sQZV/xSjOwagkzD
  s3A2gKT2ZeCdy+V0CnMAGdcvBLO8gpJYkIKakGpu6NQUv5H9/gs9O2zZDiep1Ro3leZ4NUSfq
  2lj2GWbeXX51uGvR8T0NWiFPa15QjTbMuTTzgsyts0/TlYhPfap72r/YLma2UPnXTFb14hfWJ
  lxovF6vrMmxtslw0pyFfsG6xw4U983+u0j7e5HX0p/yNr2w+5zSObeupnJ76wLZTNpqH2WzzK
  8GEx8fe+BlWb7/9Oe/e073Td73zbZj4syXj246Gd558DCo+Yo06Tiwqhv27nkcGXdqW3GI7rf
  VN53a71qoHG54dKcmPf+jfcrnye8GXt28Yp/hkF3pvm/vph9aldZue5z5w/LyArWVlelJBxE8
  BEX65pfHhd4L/fQi8vrku+xyzoOKNG9Xhn5VYijMSDbWYi4oTAZ3r7i5XBAAA
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-19.tower-326.messagelabs.com!1636395886!35865!1
X-Originating-IP: [104.47.124.50]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 7584 invoked from network); 8 Nov 2021 18:24:48 -0000
Received: from mail-hk2apc01lp2050.outbound.protection.outlook.com (HELO APC01-HK2-obe.outbound.protection.outlook.com) (104.47.124.50)
  by server-19.tower-326.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 8 Nov 2021 18:24:48 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4Ebak7GEdhFcZKanxmF9fnGp31IJU5DSrZfpNCRQm/fJKbusveEB47GPdMiGp+Z6e0crEXCntTcWp+LM6uOmSx54400sZtEOK0CkXK9oyPa8jY1hwIsO9JsUPYJUgwwE+8Wd0KZ2bC1k205Ca2YuTEzlyBFAUOA8rNKh5aXZ2cDclJVUKYl2r7IAh9tFP1F3QLr6xqPHsfN+aIl+0U1h13g9paD/sZKVClEtP40Vb/zNyUuz625SsQwp8QsqjhllHc2g0WpjtILKuJBcACWiJU6j59QwCq1i/wroKBfD6wE4+svf3PPbgmIVyc+O0GH0fsLRdFSgx6QTRiC2UwIqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3cszk1K360DO1ttutnqVpU95gWzN68rst0qjfV1Ekw=;
 b=RfX0+rB8HUpRFUKOGipfhozNQ/89nOwfdEtXuSBIsHY372nvHWMqVYlFa+yLM0R0s18IenPDNGJI600jFeNBcAH1h8RJqIN2eZx+zVuxRbf4lWekZjtBOE5A7vUVu+4AnFLRo1oVdGn1pj+PlZt6Lr9jQympinKrlAGiJc1R6bycZBHl9hbAME5eWefXAgiPGfThcbibkFEfB0jFA9SY0UTiYsYx/fdoa81uHSX8pkGvBX/1GAU43C8aO/4gKkVCa8nMwE1zZnlSslXFU1oDFLQXyRToEyfhRMC8kRQdgo7pKFqxNKImCZ1EP31pmcgaOrCGQ1H68Vain8ngdj+/8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 104.232.225.6) smtp.rcpttodomain=redhat.com smtp.mailfrom=lenovo.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=lenovo.com;
 dkim=none (message not signed); arc=none
Received: from SL2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:100:41::28) by PU1PR03MB2972.apcprd03.prod.outlook.com
 (2603:1096:803:25::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.9; Mon, 8 Nov
 2021 18:24:45 +0000
Received: from PU1APC01FT111.eop-APC01.prod.protection.outlook.com
 (2603:1096:100:41:cafe::c5) by SL2PR01CA0016.outlook.office365.com
 (2603:1096:100:41::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Mon, 8 Nov 2021 18:24:45 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 104.232.225.6) smtp.mailfrom=lenovo.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=lenovo.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 lenovo.com discourages use of 104.232.225.6 as permitted sender)
Received: from mail.lenovo.com (104.232.225.6) by
 PU1APC01FT111.mail.protection.outlook.com (10.152.252.236) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.10 via Frontend Transport; Mon, 8 Nov 2021 18:24:44 +0000
Received: from reswpmail01.lenovo.com (10.62.32.20) by mail.lenovo.com
 (10.62.123.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2242.12; Mon, 8 Nov
 2021 13:24:41 -0500
Received: from [10.38.62.237] (10.38.62.237) by reswpmail01.lenovo.com
 (10.62.32.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2242.12; Mon, 8 Nov
 2021 13:24:40 -0500
Message-ID: <ec4bfa3d-ddd7-9826-f3eb-16878c0bdb8e@lenovo.com>
Date:   Mon, 8 Nov 2021 13:24:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [External] [PATCH] platform/x86: think-lmi: Abort probe on
 analyze failure
Content-Language: en-US
To:     Alex Williamson <alex.williamson@redhat.com>,
        <hdegoede@redhat.com>, <markgross@kernel.org>
CC:     <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <163639463588.1330483.15850167112490200219.stgit@omen>
From:   Mark Pearson <markpearson@lenovo.com>
In-Reply-To: <163639463588.1330483.15850167112490200219.stgit@omen>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.38.62.237]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail01.lenovo.com (10.62.32.20)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b241edf-ebe4-4adf-bdee-08d9a2e50a15
X-MS-TrafficTypeDiagnostic: PU1PR03MB2972:
X-Microsoft-Antispam-PRVS: <PU1PR03MB2972E4D8315C0BA529123F7FC5919@PU1PR03MB2972.apcprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vqYzfx0IOJ4sUWAXCOhhjGKMM1CMI6XEYUJWbiJcjnt1hzHrEIYUhKG63bMradtvEsGrWgASUTdqk5MTBML1441wbj9/1U6+QemCE+iZFEC5c+h36/u5TsHXuqej/PtQFpf+MaF7tCUA3iTX683WN3Mm8MJ18uBzrrQwuwEKk1htaEbcCgattAgC28upDS/3aAMgNZzzpOB19R3Nkkd1MJDw5DnGSYlXcYPT2xRrecn5RK/kx+6S9ZtrDk8qOXgV6pZTwvfVjqI+0+uvQs2FeWkm+xUC6ehjRVBjXxfI05q2QY31Bz5+afh9StezRfli8vWgV3r+yiUT/evEIT86F+G0JtnFnurBEXj3+NIUKfPs6pftsk+DLIUKRhVtrIckIM6qs0s5v6VAoVb2MMUlW+UcFLCG+mZBM4X5mGysxVsYTrXg2+4+/uM4d52mIB7c381MOtMEOD6J+BpX4YV7ZQo2ZIuamRaKraFj/ABxDW0RWQpVQE50XSASsIsq37NllSHEEIooeirjSJHkV9q5WBi55QpitPIvLLa4h8PnrBUfen8YvXRyMxHt0F9ILRQq6RRzurJdO5bfUGGSzGTm3nC9A2QOxqQ4AW8iPDU3bX63YorBhgjCBF44g4fuXblkCPz8FMuRiBHTSd6TVNtD0CdRGKTQXoefDsDgJwBGSdSCOpOacLYvO1BnSzPnnhYxkSyEKcofM9o3FK3kG88cvc9xJFVCxvmhXm++N7okEP72koPINAWN8AOHLW8q/Nfz6E9Idu8svXkeN2OFWUHVK9HKrjJC+0rUcyJfydMTh4U=
X-Forefront-Antispam-Report: CIP:104.232.225.6;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.lenovo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(356005)(31686004)(53546011)(5660300002)(2616005)(36756003)(70206006)(31696002)(81166007)(8676002)(86362001)(83380400001)(316002)(36860700001)(508600001)(2906002)(70586007)(54906003)(8936002)(26005)(36906005)(16526019)(82960400001)(82310400003)(4326008)(426003)(110136005)(47076005)(186003)(16576012)(336012)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 18:24:44.5485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b241edf-ebe4-4adf-bdee-08d9a2e50a15
X-MS-Exchange-CrossTenant-Id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5c7d0b28-bdf8-410c-aa93-4df372b16203;Ip=[104.232.225.6];Helo=[mail.lenovo.com]
X-MS-Exchange-CrossTenant-AuthSource: PU1APC01FT111.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1PR03MB2972
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks Alex

On 2021-11-08 13:03, Alex Williamson wrote:
> A Lenovo ThinkStation S20 (4157CTO BIOS 60KT41AUS) fails to boot on
> recent kernels including the think-lmi driver, due to the fact that
> errors returned by the tlmi_analyze() function are ignored by
> tlmi_probe(), where  tlmi_sysfs_init() is called unconditionally.
> This results in making use of an array of already freed, non-null
> pointers and other uninitialized globals, causing all sorts of nasty
> kobject and memory faults.
> 
> Make use of the analyze function return value, free a couple leaked
> allocations, and remove the settings_count field, which is incremented
> but never consumed.
> 
> Fixes: a40cd7ef22fb ("platform/x86: think-lmi: Add WMI interface support on Lenovo platforms")
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>   drivers/platform/x86/think-lmi.c |   13 ++++++++++---
>   drivers/platform/x86/think-lmi.h |    1 -
>   2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index 9472aae72df2..c4d9c45350f7 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -888,8 +888,10 @@ static int tlmi_analyze(void)
>   			break;
>   		if (!item)
>   			break;
> -		if (!*item)
> +		if (!*item) {
> +			kfree(item);
>   			continue;
> +		}
I feel bad that I missed this in my original commit.
I've (obviously) not seen it on any platforms I've tested. I'll see if
we can get the FW team to address the origins of this too - I'm guessing
the root cause is in the FW

>   
>   		/* It is not allowed to have '/' for file name. Convert it into '\'. */
>   		strreplace(item, '/', '\\');
> @@ -902,6 +904,7 @@ static int tlmi_analyze(void)
>   		setting = kzalloc(sizeof(*setting), GFP_KERNEL);
>   		if (!setting) {
>   			ret = -ENOMEM;
> +			kfree(item);
>   			goto fail_clear_attr;
>   		}
>   		setting->index = i;
> @@ -916,7 +919,6 @@ static int tlmi_analyze(void)
>   		}
>   		kobject_init(&setting->kobj, &tlmi_attr_setting_ktype);
>   		tlmi_priv.setting[i] = setting;
> -		tlmi_priv.settings_count++;
>   		kfree(item);
>   	}
>   
> @@ -983,7 +985,12 @@ static void tlmi_remove(struct wmi_device *wdev)
>   
>   static int tlmi_probe(struct wmi_device *wdev, const void *context)
>   {
> -	tlmi_analyze();
> +	int ret;
> +
> +	ret = tlmi_analyze();
> +	if (ret)
> +		return ret;
> +
>   	return tlmi_sysfs_init();
>   }
Looks good

>   
> diff --git a/drivers/platform/x86/think-lmi.h b/drivers/platform/x86/think-lmi.h
> index f8e26823075f..2ce5086a5af2 100644
> --- a/drivers/platform/x86/think-lmi.h
> +++ b/drivers/platform/x86/think-lmi.h
> @@ -55,7 +55,6 @@ struct tlmi_attr_setting {
>   struct think_lmi {
>   	struct wmi_device *wmi_device;
>   
> -	int settings_count;
>   	bool can_set_bios_settings;
>   	bool can_get_bios_selections;
>   	bool can_set_bios_password;
> 
Originally the settings_count was used in the ioctl based driver we 
have, but I have no issue with it being removed as it serves no use. 
Thanks for the clean up.

Reviewed-by: Mark Pearson <markpearson@lenovo.com>

Mark
