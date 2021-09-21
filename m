Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99189413A7C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 21:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbhIUTGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 15:06:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:5455 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234090AbhIUTF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 15:05:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="202940930"
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="202940930"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 12:04:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="557062661"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 21 Sep 2021 12:04:23 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 21 Sep 2021 12:04:23 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 21 Sep 2021 12:04:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 21 Sep 2021 12:04:23 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 21 Sep 2021 12:04:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQYGbzyQwrVfkbw2rFeJIrM1ZzfrjXPJ/+UUrI/CW5F+JokSXHXwLYl6WYK4QBNsIZAtJH5had4V+bFsWaOP0I05spIc1cuvaFUxReltbdBGlG/Wxlt1OjkZXinar3E0s3ymfxwGKEkq00TJq9U8GEpZMWitzu/4cy7HePyI+YKavq32Tm9Brk+y0pJDLuvziw0GkfAQm8gO7D5iHyEpYLerl8AlggPPTVVHQ0WvQA5vU6bO6ebM2rrlhLmhcogjPO/uN9/7FX3EsTaRa7wZ1D9uBTSjRj9vjopi0AA8Dx1yoxC8Shy3VpdoVIVN3gHPWY7ePE2KehT4c9d/32TeDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=oBtIRPJVBFj+35+GM+9lyxez8hTTmzUcgm8WhjvO5Tg=;
 b=cjOi//oerLWhbBe+1lC8UQ/3V9Y7ROrMxLjgVCydQjyDKeM66Xge/ZcBqrV+zeVAH48EM9eSuRsdjMzQAdkasXlr+QYsRA1aV65fzljZEmuND1MOnPrOJqOVxFIGv7lCPTVgevsjd2oC29qfq0W7GNIkfO+Zd0uoSv6d8vUi1Kti6iyKU6T9TgV8DtVAU9pw58boIKVCgBYQLown15nWFTo/Cy/jjfzW71Hwz1U1iI1CC79n2mUUWljE25NURzDGo7N+4amArGVC8B6N+qG1K5fcHmi5kb73zuq9Vgv1tNOyWsuYypYANhn5nY+ePtvDM9FyZXoeDAQ3CeZSUXpqIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBtIRPJVBFj+35+GM+9lyxez8hTTmzUcgm8WhjvO5Tg=;
 b=qCikb+w1l8ux9+Gh5MK9TzmvRBgJDPGQI7MifZCUJcgSmUerUi8GkYXD/SpkCiMafZJJjqkDHD23bdYTHvRP+zXevtQKZusOM6EiD/K+yxMNwg+pUNUTwgvFD2K5IUg35Gk5Aay703DxEIxSxl8c8NJv5hl7xY482h0qlDd/5H4=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1586.namprd11.prod.outlook.com (2603:10b6:405:f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 21 Sep
 2021 19:04:19 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a%3]) with mapi id 15.20.4544.013; Tue, 21 Sep 2021
 19:04:19 +0000
Subject: Re: [PATCH] x86/resctrl: Fix kfree() of the wrong type in
 domain_add_cpu()
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        Jamie Iles <jamie@nuviainc.com>,
        "D Scott Phillips OS" <scott@os.amperecomputing.com>,
        <lcherian@marvell.com>, <bobo.shaobowang@huawei.com>
References: <20210728170637.25610-1-james.morse@arm.com>
 <20210917165924.28254-1-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <a266736b-4d08-f5a0-887f-29ddfc8a3b72@intel.com>
Date:   Tue, 21 Sep 2021 12:04:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <20210917165924.28254-1-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0248.namprd04.prod.outlook.com
 (2603:10b6:303:88::13) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MW4PR04CA0248.namprd04.prod.outlook.com (2603:10b6:303:88::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 19:04:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa7943a7-f668-4702-67c4-08d97d329d62
X-MS-TrafficTypeDiagnostic: BN6PR11MB1586:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR11MB1586680141397DDE2494BE36F8A19@BN6PR11MB1586.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7CTuVc98OO24yGVrDY9LDDLqWMp6kPHBGJwV9G92+6MOm7UXjdwqz/TesMWr4YS6WTm5ebQ9XiQDse+ej8xACLVpXVcFfIAUwBqdCljFKZp4AsGdX/B1pL90icfe16Ube3xN8fffY8MFp68hNKwQXwIoJddjz3vug1QXINQTlRx2MpkfDnhbMaEPdnulgNQ6ZXQOY5sO8f/ZD9LStL++aiZVDchdeSm0jzhoeVe1aNE2y76yRdfiX2W+7DRklTWbRJMMGATa4zFUNtsdm0kwJJMGDmjOsamSA7WGY8PVo2axTFWfF58wQRQBEMmI6WGyaWrW33BRW1o7fLM7R/jfKfJ6Uu4/UO0ABd0DhNAY5Y11RJhZ5qhcfJh/Fd2OAuG4wKNy3dwfBi6TFzHK5U3yzGNIh4OWV0MZQLzGdTEJsttAbmGTNpk0+b43NvfAOIxJ6J4bqAbocK8ZGYKC6kya7woHPrX8z6x0NB8PXmbAETDiiRQ4Qu3f0t409MkCvcEjCLmORwncMgXajtM+/iY0x0/SrWbFUPnE3tiCuBdWyA0ipgBQdn4TKsR0B3eYr6jwB9sZVZe3CGyo7gariOS0ZgbiARJHeml/UC8cTl1d0laOg4kCQosuEqP7Mmggg4Ro35A94DKM+pQR0vGRatRG0bWNbed3/InIcCCdOmDDnCM1vvQLmEL0MhJjC3aqWf0d7yli+HOwZURoVKxAcKW1vtMb2qS93C1loEE70xXLNyc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(6666004)(83380400001)(54906003)(36756003)(86362001)(5660300002)(38100700002)(16576012)(66556008)(44832011)(8936002)(66476007)(316002)(31686004)(8676002)(7416002)(6486002)(4326008)(53546011)(956004)(31696002)(2616005)(508600001)(26005)(186003)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVlYR3ZuMmVDWE8wa1UzWW8zdEQ5ZXUwZUhyUWRQa2Y4MjlwNE1MNDk4UEtB?=
 =?utf-8?B?TEZBNm5ZdWtDN1ptTitXR3NoelhDTmVBYjVteFBJL3NveWJmVG5HTE9CdUMy?=
 =?utf-8?B?NGJaNHZFWkZuOWNTUkNDYk9wWlhKZlNWWHFMUzRsdzZpdWxMOW5ieVIvZEhI?=
 =?utf-8?B?UmJDQnpXbWkrcmhJWXhHdkJxeldCU3ZSaGhETFh2UTI0ZFp1a0lWNFlTSC9Z?=
 =?utf-8?B?N3FyWE5KRC9rcmVtNFlmZTYyZmI2RHNLYWErLzFDWEx2WS81VENUUFFkRE9F?=
 =?utf-8?B?MENrSUNqR1NUbVdQOGEwY3BVekhOMElsSlNqRXJCY0s3RWdkenhwNlRrSVQy?=
 =?utf-8?B?UktxUFViMFg5SEdhdDF2ME56TEFtZTM0YzVaRk4zM2V1cnBYZnp6RjQ0L05S?=
 =?utf-8?B?cmtHNWlUdk5OUXhzbWltVXZhaW83M0JkczlzdWp1UmMvYlAzSVFkS0FRb0hk?=
 =?utf-8?B?azdVWG1oamk2V0tQTi95R2tmSXNDQ0tVVkIzbzBrdWdVbWhlcnc2R2Z3cUt4?=
 =?utf-8?B?Q2VxcEZLb3d0a0RySDBSaUhFbGpiMkQ3a1VHeCtWdDErY29FQi85aExRaUI1?=
 =?utf-8?B?YzJhaW5YK3lXY2VnOUpCRy9HTXAySWhzU3hGbUd6SXEyT3dWdjRndFhyOE5x?=
 =?utf-8?B?S01RYTZHWCtZb3hGV0ZzaVlyVUR5cXAyblMrazROQkZVZXR2bTFxbFdMQmI4?=
 =?utf-8?B?bTYzbTlrUEtnWVUxVjdBeEorV0Evdjl6bmg5MDZoREZqbWtpL0VjbldaV2Ja?=
 =?utf-8?B?SGlYQ1lnVE9hUGJaWjVYUGQ0NkJZeXFweVRxQmVEaXZkYzh3VEl2N3ljTHl2?=
 =?utf-8?B?dDBYdVFnV2FUazJVblduT2FXOFo1TEh6L1lOVkl4U1l2SlNEb1dTMUh0dlFk?=
 =?utf-8?B?eGZQcUlvRUFIU0lHS2FzT3NrR2luZTFXazkyZmgyRmZVM2QvK1dYL1NhTnBC?=
 =?utf-8?B?VkU3SDNWR1BUbHRSNmlJanV2aFFSNWdobDM1czJxeHN3YTRBMkx2cGFFTU0v?=
 =?utf-8?B?K0xINU8vZFgxMldZcWxZR1dldjBLb3NOR1M5VURjQjZIeG9ZM1hRTzJNaUQ4?=
 =?utf-8?B?VElIMnFaamtUVTZrMEtYS1I5MWcyR0lSalo0VnIzSUZ2WXdBN2kwWGI0VFFq?=
 =?utf-8?B?TitCR0s0dVc2b1AvT3E1U3dFMnVHVjZVODlZWEtPMkFOWFluNlg1OUJodWxU?=
 =?utf-8?B?all6SStSb3M1L3FIRXFRdElrRHFCNGhVS1F0c0tYVHRaK1l5RUFCeHA3cnMy?=
 =?utf-8?B?clRBOURNaVVkMXNqSk0xc0VkNkE3OFR6d2U1WTJQcStTY253VFZZNDlOTW1T?=
 =?utf-8?B?LzRQcHVWYmIyZHJuWEg3cUpnQjJVeWw4QXVrVTl5M09aZEhuTHFuWGV1bHIy?=
 =?utf-8?B?NDFTeXQ2aVR4NzI0TkNBMzZzR1hzKytCWHNiNjJWZ2xrRkhhRFYzMjNDa0tm?=
 =?utf-8?B?dVlYT0dodXdXZDFlSHZOYlF6Wm8yc2pUYTJMa3haSjhWNGVTKy9rcEdFeEVW?=
 =?utf-8?B?SmczR2RQOHR5SDg2N0ZndjRIR01VaWNVVy8wMGl6QVhjOGVSWko4OTNneEw1?=
 =?utf-8?B?SXd3QXRRcW44TE1CL2xFdllqZVJtWXlvRHFJaHNIV21hdFhYeEpyS2JmVjJu?=
 =?utf-8?B?RldZZVRXQjQwZE5POUtTcENZdm03OVhyN01PTXZ2MEc3ejRjanYyT1lEZndR?=
 =?utf-8?B?QWtja2dzN0tuanBZTG1aT3pyckVlOUxjMUk1MVpFRnNMdFBTNnIyYm5aSWNl?=
 =?utf-8?Q?S3BUiFD9xN3PZdMBhjECYbFF1fP5MlFShA4nBRJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7943a7-f668-4702-67c4-08d97d329d62
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 19:04:19.2960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IEBb9XSKqvq8xngIo2Lpc8kFFRRa2VXMZ+j7fqHAFgzspQ9ejYg4gauXx1AbHz/JIupjwP451zKdXYu0VcGJzqMRl8ELshNrHnkfrpyl6EU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1586
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 9/17/2021 9:59 AM, James Morse wrote:
> Commit 792e0f6f789b ("x86/resctrl: Split struct rdt_domain") separated
> the architecture specific and filesystem parts of the resctrl domain
> structures.
> 
> This left the error paths in domain_add_cpu() kfree()ing the memory
> with the wrong type.
> 
> This will cause a problem if someone adds a new member to struct
> rdt_hw_domain meaining d_resctrl is no longer the first member.

meaining -> meaning

> 
> Fixes: 792e0f6f789b ("x86/resctrl: Split struct rdt_domain")
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   arch/x86/kernel/cpu/resctrl/core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index b5de5a6c115c..bb1c3f5f60c8 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -527,14 +527,14 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>   	rdt_domain_reconfigure_cdp(r);
>   
>   	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
> -		kfree(d);
> +		kfree(hw_dom);
>   		return;
>   	}
>   
>   	if (r->mon_capable && domain_setup_mon_state(r, d)) {
>   		kfree(hw_dom->ctrl_val);
>   		kfree(hw_dom->mbps_val);
> -		kfree(d);
> +		kfree(hw_dom);
>   		return;
>   	}
>   
> 

Thank you very much.

Acked-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
