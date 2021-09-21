Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF7D413A7A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 21:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbhIUTFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 15:05:47 -0400
Received: from mga04.intel.com ([192.55.52.120]:11850 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232993AbhIUTFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 15:05:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="221560127"
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="221560127"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 12:04:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="512437210"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga008.fm.intel.com with ESMTP; 21 Sep 2021 12:04:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 21 Sep 2021 12:04:06 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 21 Sep 2021 12:04:06 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 21 Sep 2021 12:04:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErhRMCeyTfZUjPitmA+XS083mFrv6qXEKhXFHMDjmYe7ypZ+L7/k+ygC1zuV6LQcU1XtF2uhutDh7/PNvt6g126Y1afab3H+B8W4D8qRQRwbLG+BJUlkyWf5zmnS48FiuGLKItFSmt0sLYDklDM9E7Fxlms+qKzbf5BuJQThLozMNZmh3m/WEEp4fx+QO6WaLYbCZ49t5Q/KPfhST3u0aar0qzGlf3WP27yAacPuCHWLvzyA+c+9pbEw2XfOCpfVk9cdpmGSEJ0XXRERjKggkO/PqWKd+qDZ3ntBkqj6h8gXGM/5aJJn67p3Af8kltKV9w7j0I+8oPKcRGCFk6qFTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=lhNnzmANeLFQ2LxGIV03Mg/V9YTu4YSjdxqNcZPd7rM=;
 b=FsziE16IV8AWR9+JN9cJce74Pqh5Y3WvZOjtNiJA7QC6HVyBunulCGuPoanLKFhKz86B0fasN5GsFyWbfs/eddqgxx1pWhOiMbpCPCwnbmS7Oxsy7DmSBNAUBJBp++4P3BQlmihYRI5lnmOoJN6+5YDCeJELqYPepHf1VFF68AMh/cdEhWQ+S9/XIFhgQaxODi/jH+dimLKm4Mmz2LsoifjKJEwKjQOfLifSmePkkNP+MCjSe84oyICuFZhcQ3Is0p23aenYn5LP6UowYNFf3KEmo1hhoOjVoyMaZmCv6plprVsv1JzdXh6WSVHKzBC1lcjv0KrH+bPCJDOe3BawXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhNnzmANeLFQ2LxGIV03Mg/V9YTu4YSjdxqNcZPd7rM=;
 b=LPj6ldLxdLxPAyczQoUa8LvIvv14hj5RamqPCMA543KgdhR81gSoAPh75s42xk8vouohL4V6enCIhZDtS8Nvn+Dn7MZerwtj43dVNF9fIUp+/RAL1TglUmYZecmxsjAjMCanVOZ/sHYFSj9/r4guBymLluABy8mJkex6RyOrx+k=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1586.namprd11.prod.outlook.com (2603:10b6:405:f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 21 Sep
 2021 19:04:03 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a%3]) with mapi id 15.20.4544.013; Tue, 21 Sep 2021
 19:04:03 +0000
Subject: Re: [PATCH] x86/resctrl: Free the ctrlval arrays when
 domain_setup_mon_state() fails
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
 <20210917165958.28313-1-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <89f5465f-ce78-9106-4301-bf092a135069@intel.com>
Date:   Tue, 21 Sep 2021 12:03:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <20210917165958.28313-1-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0254.namprd04.prod.outlook.com
 (2603:10b6:303:88::19) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MW4PR04CA0254.namprd04.prod.outlook.com (2603:10b6:303:88::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 19:04:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92367e30-756c-4d29-a8c8-08d97d3293a7
X-MS-TrafficTypeDiagnostic: BN6PR11MB1586:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR11MB1586044992A748397C12A77FF8A19@BN6PR11MB1586.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wlKXGSCjYeyobOntMQuT1ngtNC+kps4uWwateze/r9rhStJEkOV1SOGXXknrniXGsZaJYLw1tl3+8X5A+mjhO70qffRoKXuXCvJ8jOfbM1LHsYvlNXeEwkfS3engdf2uZRJP5LovXVf8A9RuRiVpNaaxeHsenE6NGRQuRDh0HnL26BNBHK5Y2sRCBSUGjwdkuFK3ZbpF5O5C5Y1TlRWKYWilmZx9he3Lf/h226i1lAiuW6UsmRmb7PySM7oz4IgGkAz7GqKCPKyJ4iU/trxqjmXLNyAkHWVq3mDrntdkMQRoF9bJPtKIlkmGQ2AbHEMI8YvyPVgo5Fl5H5OMkbHS54BxOFxbEM86LrKUHMP1GyS/kOEkuSA98Y2TNZPTi2mC8fPnQAeBR1N53bU2QDOLtdgck7PyXruZp8iOCmk20zoANvChFOEHIzpLLn3EOiEETf9MdybnkHC6k2Cr1OJIGN4Ls0ldb9ZnIKS3GfG0MQmT207xqu9wEhiREAHaelt4wQ+y9UMz5UOyM9bEWgGz5/LVklLvS8eUnfP8ya8cYTK9endNbZrNgcuSu6Z6YOzWQSgtl4S7Q1WKsouGd3HxJvmtzw18x94VLDv3lZVXV8c/X7zAYEAwhpqDVJpYpzQuIOCK3/Dvde6fvi7L0FLd8sX9IRComgDUoqPflY/dYMGkYvJ9p8NQj60TcweLvvGswsdDD/e3ipFfa1zFjI1rVjfeZL1MlStDvAz+j1UEkMJKrvv0lEaxDpSXutFPvUTd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(6666004)(83380400001)(54906003)(36756003)(86362001)(5660300002)(38100700002)(16576012)(66556008)(44832011)(8936002)(66476007)(316002)(31686004)(8676002)(7416002)(6486002)(4326008)(53546011)(956004)(31696002)(2616005)(508600001)(26005)(186003)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NE85R3ljTTYrRXhjeUpRSGNoNVdraWM1TXZiZVVNaElWM1ZkWldZQlhlQUJK?=
 =?utf-8?B?Nll4UkxRMjZUdWxwaVpLc2R6QzhoMmwraHhlOUIrZXR5aUNMdFNZUDQwcDg2?=
 =?utf-8?B?R2ZWWXhSMTlsVFNNS0FCZDRmRTNGZ2txdVc2TWZ4MlcyYWpSUUNnbEJVdzFk?=
 =?utf-8?B?VHpuUjhCaVVxVE1zVndnZ213bktHNjFPQ1ZLUUt5QkV3MFQ4bW5JeENCcVRE?=
 =?utf-8?B?eFNTVDFodVAwSDIxeldVWnlrSGxZakRvV2tRckZvOHhmRkY0QjNDcDdqbXdD?=
 =?utf-8?B?aGpKeGE0akY4VFk4VWt2UDBSV0UwOWY4YXBPYWlBTEI0ZllQMkJrSFNQaUtF?=
 =?utf-8?B?TDlqbmdOdzZWTGhteVg4bU9qOGU1Y05iaFZRQWtDZXl3Mlg1OThoWUhnNWVa?=
 =?utf-8?B?MGZvcUttVEd1N3JsVmcyd2greFFTTHdDRE00Ynk1UVJyaDE0UHlGc29hamVi?=
 =?utf-8?B?NkFWQnJ4VytaOUZkTzBlMTZlSi9ORkxncFZQUXJselc0VFZ6UW1ZYU1OVkJo?=
 =?utf-8?B?aWN0Z2k4dGRUby9zbVBkWE5xYXQrdldwZEs3OG5XWGl1eEhEaVVJMEYrb25v?=
 =?utf-8?B?dUs5ZlNvWHdCMjNpaFlQMnpjNXpzQmxOVkNncTE3bkVkV2E4cUo5VG9YTXdy?=
 =?utf-8?B?QkRjcHh0Tkw1eEtvVVJMYWt4Vk9mbnFUMkpQMmpRTXIvN0pjRDY5WXkwSE8w?=
 =?utf-8?B?R21UQkNhVThSMmxpVk1aNlArRWxPaWNSVkM2VXZRaWtKVElNZFBPKzMxTSsr?=
 =?utf-8?B?a2tmYUhLYVh5dlVIYkhIS3A5TlBZWUR5dHdsV2VGRlJUVGpJbmpKbUtZTXdU?=
 =?utf-8?B?TUNZRlM5dmYxMzF5SEt2M2YzWCtuZmRYUHFKaG1NMnZ3Nnc3enZNU2VVQmx4?=
 =?utf-8?B?UzVkSTJieTVoK1p3UkRDTVlURGd0aXVvQVA2NHlpbWJvM0tKYjhIc1FoeUxF?=
 =?utf-8?B?Z3R1UUJzOGt3ME1DT0wzYVNDRzNjeTlHeTI4S1U2M2ZzWGxaSUNTb25FTG1u?=
 =?utf-8?B?L1YzS21ON2Jyalp4cE8wL1ZPZzhiSVBQdDZXbDRwNjJZWFZCTnkwRDIrdnpU?=
 =?utf-8?B?R1daZDlad1JUeG1QYlJEQk1qUE1ZQndjY05JdE01TlR5a1dkT2svbHZEMnpi?=
 =?utf-8?B?QlhiQ2trMitMbDM5Z004ZXNpNW1MNGdmT0VyRUdobE5DQ3h5YnFsQTZrdGN2?=
 =?utf-8?B?ZnhaN09XVUhOcDZkQ1Nha3liTDlTWHFVWHF4WXd1MDU2L0Z6VDFPQlRVK0VW?=
 =?utf-8?B?NS9VSi9ycnlaL0V0bDcyWE00eHFnSnRRTThERmZscnU3K2tzaHQrSnFUb2g2?=
 =?utf-8?B?a1dLMlVYd1FKd3NVTjlJeDR2Z3FEd1kvbXUzUGovekdXYzlzeDFjaXRnV0N3?=
 =?utf-8?B?bGNEWmNXZG5hNWxPbStEM0l1eDcvQ01hdkJRR1NmL2ZDR2JHNWRqaHh1NVpG?=
 =?utf-8?B?c2NBWmJSVFRWb1RRUzhiZXYvM29wNzhwVDZ1ZnBXZnkzS0VVekJhVExOYW9W?=
 =?utf-8?B?aUwvdmlqVVgyWlp3TUJ1Rk9KQXgwaHd1ZHlXdUM5V1F6anpkVWthSnFJeFdF?=
 =?utf-8?B?bkw5M0NpSVZBYnBPQS96c3lMaUcxZUs4bkVNbGZDWXgzeGl6NmI5RmdTVWRY?=
 =?utf-8?B?UWJUYURJMkJyMGJ4RGNKSzFzZm9qcXdmc3psdFI4K0JYSW1uMjVHWUdSU2RF?=
 =?utf-8?B?TXRlTUF3My9CSjdRKy90VitnUUExdVBTL09Gb0RkOFJyb29SdGoxay9RTk9O?=
 =?utf-8?Q?cYnZqV3zvAR0xblwJH2WG4EZAW8wswRIuJS/3FE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92367e30-756c-4d29-a8c8-08d97d3293a7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 19:04:03.0592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+VCW/FQQqrexsfRtTo2SLLsIizYkRr1fsUMYjh/E6JQjz0W98pV9lwGV653rCpRfdQw0jizQLFt5NIyIo/mwYXh4xZkeLG8giSDFdg8JEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1586
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 9/17/2021 9:59 AM, James Morse wrote:
> domain_add_cpu() is called whenever a CPU is brought online. The
> earlier call to domain_setup_ctrlval() allocates the control value
> arrays.
> 
> If domain_setup_mon_state() fails, the control value arrays are not
> freed.
> 
> Add the missing kfree() calls.
> 
> Fixes: 1bd2a63b4f0de ("x86/intel_rdt/mba_sc: Add initialization support")
> Fixes: edf6fa1c4a951 ("x86/intel_rdt/cqm: Add RMID (Resource monitoring ID) management")
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> This will not apply prior to v5.15-rc1, I'll provide a backport.
> ~s/hw_dom/d/;
> ---
>   arch/x86/kernel/cpu/resctrl/core.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 4b8813bafffd..b5de5a6c115c 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -532,6 +532,8 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>   	}
>   
>   	if (r->mon_capable && domain_setup_mon_state(r, d)) {
> +		kfree(hw_dom->ctrl_val);
> +		kfree(hw_dom->mbps_val);
>   		kfree(d);
>   		return;
>   	}
> 

Thank you very much for catching and fixing this.

Acked-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
