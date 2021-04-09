Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88CDA35A7A7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 22:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbhDIULw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 16:11:52 -0400
Received: from mail-db8eur05olkn2104.outbound.protection.outlook.com ([40.92.89.104]:61856
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229665AbhDIULr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 16:11:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8WTJy1WGrkhPLoo0iRIDRzofy9/0mgAs4r8t7ocQ40uvVaekp/iKhs3x+uQIIPIsjEv761b/DuL8uvZlQosY8/JrJfLlJGoBbPyBDrrf1zmhgpuBQG5e1rrjzabEKw2XjpGxnyU0kdx2K+sGTD9eHacsAkHQ/ohDcsmHGKPe+arIBCu2A/m2BXLjhNVVn2p/B3g+2DZX8JgHLCpxbpTGqrrzQPntLN0FHgKmVz7nuIrOxmtQXxiR7K/CJh21fM4OLoWI93SZf3NpQnbZlcuzefZokiIXPpUv1WwVUQIjBUItErb2/62Cmhir9whHYZb4JhrjrYBSvyKtkkHQn/a8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4otrfRr3dbYdW03So9+n2iHo9agTOxFXTKSUxte67Y=;
 b=h/K5Qf3x+VEDxzHE7gmumLYC4C1ySKbS+ribKhKXXWs0uvyDBv2M1Cq0TO3YishRR0ErVen4+qG7YGZwFVaW8mLPNqosG3aeSHvcepkzVCc4A6no9f0EvRnG8LalbHgEpIo/ILcUnp4z14h5djSkfx+AGvup5PENft+Xo5kA0Gv+wwp4jNmjCQ0aLx4JYcVLo1e9+bAzsGBZkkItGRlQY4RLrynrDdJLW1ZWZB1JueDFZAPzSE//PCspW4Qi+hZttvLslxgpWsgybe8sMiBj9Hyvz/CD8qJDVEficotrQiaBNDE3FeiKWVeF11f8bqmqXQVP9ksRwf2RdzuH+TD07w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB8EUR05FT052.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc0f::45) by
 DB8EUR05HT035.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc0f::334)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Fri, 9 Apr
 2021 20:11:32 +0000
Received: from VI1PR09MB2638.eurprd09.prod.outlook.com
 (2a01:111:e400:fc0f::45) by DB8EUR05FT052.mail.protection.outlook.com
 (2a01:111:e400:fc0f::222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Fri, 9 Apr 2021 20:11:32 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:B2C86E232131037083D68597407A8EDD5DFCD11A671C7F2E252D986C441AE66E;UpperCasedChecksum:13978A6395B6374685BC243B83E98E3A828459E881489A9298ED36C92190010E;SizeAsReceived:9040;Count:48
Received: from VI1PR09MB2638.eurprd09.prod.outlook.com
 ([fe80::948b:987c:566b:198e]) by VI1PR09MB2638.eurprd09.prod.outlook.com
 ([fe80::948b:987c:566b:198e%5]) with mapi id 15.20.4020.021; Fri, 9 Apr 2021
 20:11:32 +0000
From:   David Coe <david.coe@live.co.uk>
Subject: Re: [PATCH 2/2] iommu/amd: Remove performance counter
 pre-initialization test
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, will@kernel.org, jsnitsel@redhat.com,
        pmenzel@molgen.mpg.de, Jon.Grimm@amd.com,
        Tj <ml.linux@elloe.vision>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alexander Monakov <amonakov@ispras.ru>,
        Alex Hung <1917203@bugs.launchpad.net>
References: <20210409085848.3908-1-suravee.suthikulpanit@amd.com>
 <20210409085848.3908-3-suravee.suthikulpanit@amd.com>
Message-ID: <VI1PR09MB2638254CC3089BEA411AE90AC7739@VI1PR09MB2638.eurprd09.prod.outlook.com>
Date:   Fri, 9 Apr 2021 21:11:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210409085848.3908-3-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-TMN:  [eEHj7CAarsXoLaU0Ci2YFnhriPCHUTr6]
X-ClientProxiedBy: LO2P265CA0228.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::24) To VI1PR09MB2638.eurprd09.prod.outlook.com
 (2603:10a6:803:7b::27)
X-Microsoft-Original-Message-ID: <369d4db7-9cbd-7163-4152-47f1a0181cf0@live.co.uk>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.6] (90.246.218.100) by LO2P265CA0228.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:b::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Fri, 9 Apr 2021 20:11:31 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 1e00510d-4fa9-4e3c-a3c4-08d8fb93aafe
X-MS-TrafficTypeDiagnostic: DB8EUR05HT035:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2/PXx4AWYPTalGzJNT5wEat8nmOmYgPWNHCpljFTuVLsFt4bSb0xS3XQhp464rNK5BSy8c6h43Kl1lV6houA8VhQ61iKD+QVPI48s9K1ogqfVxUPlywV1G1tlwQ4ttZ/ZsRSFDBUGmCld6ebkAh0xKqIJXRchjQGBCd0cuBUyMGOWm2epVNMVDYX2SiwFffiW46oGAIsARIfiAZBoA5lSNwS1cLPzww3Pc8k0YPwec1QeS8iBjO5ms38BKAepKqNWGQKggjbdjdxXAqp5apO1nLo5uSyEHcDhw3XGPunVvUZhUi5tDzZ+YEVsjy+wjahC+9r0T+uPJ0MTMWDVb0pZAmiotYLnfZCHUb+0j4r0APIPyapGoSMkHa9jlUzUp4qNFQgvxLY8v0gf7qHhJGuzV5Kv7/btii4o0dListIYj53NMRiRLiMChN6qD/Iy7D2
X-MS-Exchange-AntiSpam-MessageData: abUJlayhi497u5jAKC5xvHfPs99AK1DvBSpSfZCalZkp9xJuA9E9fuKUpdZtVopWtkwD6vuEJiYzWhaKTv9TbXwOPt06W0dBjWxguLaqxKMF0jq8ZcQ1sM1rAOdAUgjwEF7JWLBh7tnCxEWDuE+xvw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e00510d-4fa9-4e3c-a3c4-08d8fb93aafe
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 20:11:32.6530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT052.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8EUR05HT035
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2021 09:58, Suravee Suthikulpanit wrote:
> In early AMD desktop/mobile platforms (during 2013), when the IOMMU
> Performance Counter (PMC) support was first introduced in
> commit 30861ddc9cca ("perf/x86/amd: Add IOMMU Performance Counter
> resource management"), there was a HW bug where the counters could not
> be accessed. The result was reading of the counter always return zero.
> 
> At the time, the suggested workaround was to add a test logic prior
> to initializing the PMC feature to check if the counters can be programmed
> and read back the same value. This has been working fine until the more
> recent desktop/mobile platforms start enabling power gating for the PMC,
> which prevents access to the counters. This results in the PMC support
> being disabled unnecesarily.
> 
> Unfortunatly, there is no documentation of since which generation
> of hardware the original PMC HW bug was fixed. Although, it was fixed
> soon after the first introduction of the PMC. Base on this, we assume
> that the buggy platforms are less likely to be in used, and it should
> be relatively safe to remove this legacy logic.

Thanks for explaining the 'context', Suravee.

> Link: https://lore.kernel.org/linux-iommu/alpine.LNX.3.20.13.2006030935570.3181@monopod.intra.ispras.ru/
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201753
> Cc: Tj (Elloe Linux) <ml.linux@elloe.vision>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Alexander Monakov <amonakov@ispras.ru>
> Cc: David Coe <david.coe@live.co.uk>
> Cc: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>   drivers/iommu/amd/init.c | 24 +-----------------------
>   1 file changed, 1 insertion(+), 23 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 648cdfd03074..247cdda5d683 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -1714,33 +1714,16 @@ static int __init init_iommu_all(struct acpi_table_header *table)
>   	return 0;
>   }
>   
> -static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
> -				u8 fxn, u64 *value, bool is_write);
> -
>   static void init_iommu_perf_ctr(struct amd_iommu *iommu)
>   {
> +	u64 val;
>   	struct pci_dev *pdev = iommu->dev;
> -	u64 val = 0xabcd, val2 = 0, save_reg = 0;
>   
>   	if (!iommu_feature(iommu, FEATURE_PC))
>   		return;
>   
>   	amd_iommu_pc_present = true;
>   
> -	/* save the value to restore, if writable */
> -	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, false))
> -		goto pc_false;
> -
> -	/* Check if the performance counters can be written to */
> -	if ((iommu_pc_get_set_reg(iommu, 0, 0, 0, &val, true)) ||
> -	    (iommu_pc_get_set_reg(iommu, 0, 0, 0, &val2, false)) ||
> -	    (val != val2))
> -		goto pc_false;
> -
> -	/* restore */
> -	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, true))
> -		goto pc_false;
> -
>   	pci_info(pdev, "IOMMU performance counters supported\n");
>   
>   	val = readl(iommu->mmio_base + MMIO_CNTR_CONF_OFFSET);
> @@ -1748,11 +1731,6 @@ static void init_iommu_perf_ctr(struct amd_iommu *iommu)
>   	iommu->max_counters = (u8) ((val >> 7) & 0xf);
>   
>   	return;
> -
> -pc_false:
> -	pci_err(pdev, "Unable to read/write to IOMMU perf counter.\n");
> -	amd_iommu_pc_present = false;
> -	return;
>   }
>   
>   static ssize_t amd_iommu_show_cap(struct device *dev,
> 

I'll test your revert + update IOMMU patch on my Ryzen 2400G and 4700U 
most likely over the weekend. Very interesting!

Please be aware that your original IOMMU patch has already reached the 
imminent release of Ubuntu 21.04 (Hirsute). I've taken the liberty of 
adding Alex Hung (lead kernel developer at Ubuntu) to the circulation list.
