Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE0D3A8820
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhFORxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:53:47 -0400
Received: from mail-sn1anam02on2050.outbound.protection.outlook.com ([40.107.96.50]:24259
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229976AbhFORxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:53:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdtZUDdj8reHUnW/6CnM74RxfFDKqI0il6rVqBJSJHtM68MYzDVRoFviv63XAo0b7UUBZ+7UC4Ukw3Yci3R/UfbupWqEOXNbhL7hQRcGD7IOFaotLvckoaBg6BSlCk9qu8hVe7TWo2M3TP8QtslopHA5M9BS0yRRFwwZdGcAKEWUFCM2a7p7MVHCW1Vc7UfMJ+APn7S7ihZVNm30rKWHb4bPDV3y8bqJZ4JyaiQgh3P7tnWBRxZ2SBjiLTHrvCICWabsUTUM9vmA9dRtfVahrZYs861nv3jO64AmZZUwL6EYvTk2VRuYhLwV6KRD7PlkOt8yTpyJdcGZnZSP1GqsdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avmvXkSpwqK7mTwf7wWpZQ29pShy3NhAm0aJKhyT2nw=;
 b=hWIGh2jHLx3Mb5RTJyG2tQmKzCFjSkURw2uaS5hw0yBQMLDJR2aNO1wvXW96kMPsMuYpPcWT20fhVA2inoCdtnUpN09eF/zkMPqSX4G7+uzmvpdRmLTz/odlZnkPcEGmVGqJZjoTgCfedJTjxIQ8LMF2I07Te5zmA9yuYw2VOf00OalLrcI+a4sBPb7WG2Zv9R3JPC1ALFNtFzjKiIdLWI9/Yp1h+JFXwHnqoD4Mo5kChU2XQ6QKyXJFCfhC5m1pgY3sjggGfdvqWXUPvIqsF1zfrlcVtKDt/ou0ueiqyuAZvRKhrs4SpGdIWD2WcgimlHx+TBmWpf3+SkmpnGacUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avmvXkSpwqK7mTwf7wWpZQ29pShy3NhAm0aJKhyT2nw=;
 b=nv/qeNuEJzMD/6lwwkdW9Yt0q9D9jxbxeU4nYCRWSMJic7t9Eidym340lJAt9rXF6MBKucOopdA3nDbsylfuRgqNitEpV8Lcm4FDuWuMZuZLOZ4uTHwShwnIPFp8LgN6tx2rZ3rUYrOI0WEevht5RLq1b5RZwEN8H4q5nu1mH5I=
Authentication-Results: marvell.com; dkim=none (message not signed)
 header.d=none;marvell.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MWHPR1201MB0206.namprd12.prod.outlook.com (2603:10b6:301:55::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Tue, 15 Jun
 2021 17:51:36 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::bdeb:29f3:2bf1:bfa7]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::bdeb:29f3:2bf1:bfa7%8]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 17:51:36 +0000
Subject: Re: [PATCH v4 02/24] x86/resctrl: Split struct rdt_domain
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com
References: <20210614200941.12383-1-james.morse@arm.com>
 <20210614200941.12383-3-james.morse@arm.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <ac2a3f6e-ef49-5770-7886-c3f813659d06@amd.com>
Date:   Tue, 15 Jun 2021 12:51:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210614200941.12383-3-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SA9P223CA0027.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::32) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.136] (165.204.77.1) by SA9P223CA0027.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Tue, 15 Jun 2021 17:51:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5b79031-53d1-4400-70d5-08d930263824
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0206:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB020626B2EBB10EA8DF16A90295309@MWHPR1201MB0206.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: obihVeCIae5InHuJ/cabS7+AHRNzU0z/hqLv5F+UKGnEo5ps7Zob0uNLALz3KBg45O/R8ShEGTGVGFamnEXa415ZVP23P9TrfkV8wWzDjlwjgkSI1EGR0DOXdrBIsXkdwCgL5lF8ySpANvygmb+uIdNDo2eWJQiAJZ6TPcR0C/oG7yNWhkF8iPhKkPlGoDATACxAvKS++Z8/XU7J3KQM0lYh9N4T+T29fU3RVgRCp+0lZMEQTtcO6bko8BzoSnIG1ZTDSrXSNP2QWW+U3h19PtahdJxtdwCe9nn0PVHO9VngvKElODVrVASWb3pyWtqpcY6zxElIlNzubpS72YkVb+vyP+ODmuALSsQ5LD3JTRwmhWrL51mbYfplvERVfFExqzDS81xNdstmte808LUIacI/jWU3K46H3BTwSQNyxWQayoZ5xdueEEU9HfRvHy9J8A7xpr22zzvgoaNBWg+2CCivFAhdoIZY9ujplYNohAJnlYO6X1AdN+tVvszKdem1eqc1DFRj5eESXNoMceHTtxQRjBY8SBYSyr0jk8oW3gAFaeg/5P73D2XSUAcnUe6XWXabk+7eN/Yzq5Sa0mH/ue/nc2WRDUC3m+QjbJVCdLW/rgyiIG91iyEj06zVw204aOUI3N4twt8BNSuWWw4cZoeZT9FwxOuw61jQgxlmVO4aUzYzsOY6DM+9xhUoCkH+eiQPETVJtMsjtjmte2vjV1Wl15U7BtLBNbh54UhkNUE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(26005)(38100700002)(38350700002)(86362001)(54906003)(7416002)(83380400001)(316002)(31696002)(16576012)(5660300002)(52116002)(4326008)(30864003)(8936002)(66946007)(478600001)(956004)(2616005)(53546011)(8676002)(66476007)(66556008)(2906002)(186003)(44832011)(31686004)(6486002)(36756003)(16526019)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUVkVkFBUVhPZHpRbzE4RWxOSmc4U0x3M3dOMHZteGgvb2hOOGpIUGUrNXZx?=
 =?utf-8?B?MnFqN05RSU91Wnh2RkxxelBqYVRaeEl0U1c5R3VOTU03ZGovL1pFRUNuOFEw?=
 =?utf-8?B?QndBOVNQVE41VjNNclhYb3ZVVnpyQWRSOUpUMWVwQUJjTys0bGpKczN0aDBr?=
 =?utf-8?B?VVRCY0IzQnd0NTNlVDBtdnp6UzZnWlFMMmtreCtxTFBlVzh6N3V3WldSZFNG?=
 =?utf-8?B?ZzNOTjNFK29nRGx4MFY0aEt6RWpxZlBWUTJJT3BGZXZ2UnpVSU0wSmFnNVRi?=
 =?utf-8?B?bWRXalJTQnpZYkl6cHFYdGF1aFlsT0R6akpxdVpEL3IzdEMzbWM2d2NQcGlV?=
 =?utf-8?B?YlU4bXV5OEY2STFhZW05VnhZU3grNXlKaFcvMU8zL0pKUGJjTGxKbkFvYUNG?=
 =?utf-8?B?L2IwOFFiSTdRT2tLZDlmbGZXeHp1NXRVU05lUzRraXRYQStoaXB2TmM3VGJX?=
 =?utf-8?B?TzgxNjljajg4cTNMUlE0cXJzeEN0MUIxN2w2ZTFMMlFsVmgzWEpTODhiNkJ4?=
 =?utf-8?B?VHVBK2ZZYWtFU3pJcWFaQjJmWGF1QWUvaDFlSjluTWtxNlRPZVVlNjlsY3Ni?=
 =?utf-8?B?WVo2UkQzRldqQlhJN2VKNWkydDJyaU9mZGZCZzVMVzJEYTVuTXZWVkZJUmE2?=
 =?utf-8?B?Y05FRVN3M2NmK2t2Zm1EbUNuZU51Wk1jNWFvWHFoa255WGxhalBNMU9Ia00z?=
 =?utf-8?B?Q3kxVDJGY2tZRzRDSCtqci9ma3JOS3oyV1dPeXUwRVAwMXFqQUJoRitVd1Q1?=
 =?utf-8?B?L0s3S1p4dU5YcVpEWU1JQkpIYU9LdFZJeFZxWnVPd0JJbzkyLzU1V2p6TW5z?=
 =?utf-8?B?MTN3Wk04U3Vid2ZocFhiTStKWVpVZnY4dUd5Zi9oeHhOemVmNXlhQjNFMHln?=
 =?utf-8?B?dlFrYjdxMXFhS0Y0QjlIeEdBVjFxK3NjQmdNcXRBRjhoRTYyeEM0VFBCRVhD?=
 =?utf-8?B?MHpoVW5XS2NwNDF4c1dYNDF0Z3h5VlMyQk4xdUVnZXNneHlDMG1HbGdJYXN5?=
 =?utf-8?B?bTh4Sm5oUy9MeGR4VEU5SFZTVTRSQ1VZY09tM1dWOEEvNmFWbE9tOG02aGR2?=
 =?utf-8?B?aTZLdUJIRFRWWFl2Y2FzTnl4VW9CbTRjM3ZvY08yemxaMmJGUFZTaEdITjkw?=
 =?utf-8?B?YlZmSjd1ejdIK3RJUlRqaWpRQkJHZHp4bFpPR0ZSNk4vNzdnT2dQZE9PS2t4?=
 =?utf-8?B?MkxWU20zVEdHODdnRVRBZ3NSSC94cGZ1dlJyZ2NiQ0dSa1dIeExpWXdnUkR6?=
 =?utf-8?B?MnNheCt3aURIOXBqbkoyNzRCUS9rbTErTUxDOWxQT3dhYjBpQlBVSHZnZE1B?=
 =?utf-8?B?MmxITkM0WGQ5RzVYWklsMTErZGF3VjVyTmpyVjI3REh3c0h4aUpQNEh3eFA4?=
 =?utf-8?B?Q2ZVVTErUjl1ZUUzSWhhZVkvN0owUGhObkppb09aaldTNVJVU09PTUpPV2d3?=
 =?utf-8?B?LzVaNHhYSHRJck1QdytYaXBVcTFxTWJlQWd6ZGRPNnhwN0o1Qjc4NjRGbHRp?=
 =?utf-8?B?MXFVYm5nUHd6cUpTd0NVQmoxNzFjcENYSVdEdnd0aWY1MTQ0WUx1R3ZSdjJQ?=
 =?utf-8?B?Z3piZSs4K1N2UmVLWW54cDk4SXhGcUFyVWdtbEd1aDRFVkhZWjdmNGRqeDF1?=
 =?utf-8?B?elFRY04wK2dhZkwrdWk5dUlRVUsrV3ZhSUxpTWJLVzUzVzBkUmtDQjNwZlhF?=
 =?utf-8?B?RzAwcG11OTU1LzZGaDNSNkRoTmRFcmIybDk4Y2VubjROWFBDYWJxeGRKU05R?=
 =?utf-8?Q?BfPuHLh+0f5JzX09or6e/CM0T1J6VW9xuwg0O4m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b79031-53d1-4400-70d5-08d930263824
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 17:51:36.0260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: waJaSQwm6D3wr9AZsJK7zvzyWiBRX+xjOUgpGBytPM42cQZuH/cPyUbIXRAonhxc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0206
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/14/21 3:09 PM, James Morse wrote:
> resctrl is the defacto Linux ABI for SoC resource partitioning features.
> 
> To support it on another architecture, it needs to be abstracted from
> the features provided by Intel RDT and AMD PQoS, and moved to /fs/.
> struct rdt_resource contains a mix of architecture private details
> and properties of the filesystem interface user-space users.
> 
> Continue by splitting struct rdt_domain, into an architecture private
> 'hw' struct, which contains the common resctrl structure that would be
> used by any architecture. The hardware values in ctrl_val and mbps_val
> need to be accessed via helpers to allow another architecture to convert
> these into a different format if necessary. After this split, filesystem
> code paths touching a 'hw' struct indicates where an abstraction
> is needed.
> 
> Splitting this structure only moves types around, and should not lead
> to any change in behaviour.
> 
> Reviewed-by: Jamie Iles <jamie@nuviainc.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v3:
>  * Removed a double word, removed a space.
> 
> Changes since v2:
>  * Shuffled commit message,
>  * Changed kerneldoc text above rdt_hw_domain
> 
> Changes since v1:
>  * Tabs space and other whitespace
>  * cpu becomes CPU in all comments touched
> ---
>  arch/x86/kernel/cpu/resctrl/core.c        | 32 ++++++++++-------
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 10 ++++--
>  arch/x86/kernel/cpu/resctrl/internal.h    | 43 +++++++----------------
>  arch/x86/kernel/cpu/resctrl/monitor.c     |  8 +++--
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 29 +++++++++------
>  include/linux/resctrl.h                   | 32 ++++++++++++++++-
>  6 files changed, 94 insertions(+), 60 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 415d0f04efd7..aff5d0dde6c1 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -385,10 +385,11 @@ static void
>  mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
>  {
>  	unsigned int i;
> +	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>  
>  	for (i = m->low; i < m->high; i++)
> -		wrmsrl(hw_res->msr_base + i, d->ctrl_val[i]);
> +		wrmsrl(hw_res->msr_base + i, hw_dom->ctrl_val[i]);
>  }
>  
>  /*
> @@ -410,21 +411,23 @@ mba_wrmsr_intel(struct rdt_domain *d, struct msr_param *m,
>  		struct rdt_resource *r)
>  {
>  	unsigned int i;
> +	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>  
>  	/*  Write the delay values for mba. */
>  	for (i = m->low; i < m->high; i++)
> -		wrmsrl(hw_res->msr_base + i, delay_bw_map(d->ctrl_val[i], r));
> +		wrmsrl(hw_res->msr_base + i, delay_bw_map(hw_dom->ctrl_val[i], r));
>  }
>  
>  static void
>  cat_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
>  {
>  	unsigned int i;
> +	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>  
>  	for (i = m->low; i < m->high; i++)
> -		wrmsrl(hw_res->msr_base + cbm_idx(r, i), d->ctrl_val[i]);
> +		wrmsrl(hw_res->msr_base + cbm_idx(r, i), hw_dom->ctrl_val[i]);
>  }
>  
>  struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r)
> @@ -510,21 +513,22 @@ void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm)
>  static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
>  {
>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
> +	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
>  	struct msr_param m;
>  	u32 *dc, *dm;
>  
> -	dc = kmalloc_array(hw_res->num_closid, sizeof(*d->ctrl_val), GFP_KERNEL);
> +	dc = kmalloc_array(hw_res->num_closid, sizeof(*hw_dom->ctrl_val), GFP_KERNEL);
>  	if (!dc)
>  		return -ENOMEM;
>  
> -	dm = kmalloc_array(hw_res->num_closid, sizeof(*d->mbps_val), GFP_KERNEL);
> +	dm = kmalloc_array(hw_res->num_closid, sizeof(*hw_dom->mbps_val), GFP_KERNEL);
>  	if (!dm) {
>  		kfree(dc);
>  		return -ENOMEM;
>  	}
>  
> -	d->ctrl_val = dc;
> -	d->mbps_val = dm;
> +	hw_dom->ctrl_val = dc;
> +	hw_dom->mbps_val = dm;
>  	setup_default_ctrlval(r, dc, dm);
>  
>  	m.low = 0;
> @@ -586,6 +590,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  {
>  	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
>  	struct list_head *add_pos = NULL;
> +	struct rdt_hw_domain *hw_dom;
>  	struct rdt_domain *d;
>  
>  	d = rdt_find_domain(r, id, &add_pos);
> @@ -601,10 +606,11 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  		return;
>  	}
>  
> -	d = kzalloc_node(sizeof(*d), GFP_KERNEL, cpu_to_node(cpu));
> -	if (!d)
> +	hw_dom = kzalloc_node(sizeof(*hw_dom), GFP_KERNEL, cpu_to_node(cpu));
> +	if (!hw_dom)
>  		return;
>  
> +	d = &hw_dom->resctrl;
>  	d->id = id;
>  	cpumask_set_cpu(cpu, &d->cpu_mask);
>  
> @@ -633,6 +639,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>  {
>  	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
> +	struct rdt_hw_domain *hw_dom;
>  	struct rdt_domain *d;
>  
>  	d = rdt_find_domain(r, id, NULL);
> @@ -640,6 +647,7 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>  		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
>  		return;
>  	}
> +	hw_dom = resctrl_to_arch_dom(d);
>  
>  	cpumask_clear_cpu(cpu, &d->cpu_mask);
>  	if (cpumask_empty(&d->cpu_mask)) {
> @@ -672,12 +680,12 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>  		if (d->plr)
>  			d->plr->d = NULL;
>  
> -		kfree(d->ctrl_val);
> -		kfree(d->mbps_val);
> +		kfree(hw_dom->ctrl_val);
> +		kfree(hw_dom->mbps_val);
>  		bitmap_free(d->rmid_busy_llc);
>  		kfree(d->mbm_total);
>  		kfree(d->mbm_local);
> -		kfree(d);
> +		kfree(hw_dom);
>  		return;
>  	}
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index ab6e584c9d2d..2e7466659af3 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -238,6 +238,7 @@ static int parse_line(char *line, struct rdt_resource *r,
>  
>  int update_domains(struct rdt_resource *r, int closid)
>  {
> +	struct rdt_hw_domain *hw_dom;
>  	struct msr_param msr_param;
>  	cpumask_var_t cpu_mask;
>  	struct rdt_domain *d;
> @@ -254,7 +255,8 @@ int update_domains(struct rdt_resource *r, int closid)
>  
>  	mba_sc = is_mba_sc(r);
>  	list_for_each_entry(d, &r->domains, list) {
> -		dc = !mba_sc ? d->ctrl_val : d->mbps_val;
> +		hw_dom = resctrl_to_arch_dom(d);
> +		dc = !mba_sc ? hw_dom->ctrl_val : hw_dom->mbps_val;
>  		if (d->have_new_ctrl && d->new_ctrl != dc[closid]) {
>  			cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
>  			dc[closid] = d->new_ctrl;
> @@ -375,17 +377,19 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
>  
>  static void show_doms(struct seq_file *s, struct rdt_resource *r, int closid)
>  {
> +	struct rdt_hw_domain *hw_dom;
>  	struct rdt_domain *dom;
>  	bool sep = false;
>  	u32 ctrl_val;
>  
>  	seq_printf(s, "%*s:", max_name_width, r->name);
>  	list_for_each_entry(dom, &r->domains, list) {
> +		hw_dom = resctrl_to_arch_dom(dom);
>  		if (sep)
>  			seq_puts(s, ";");
>  
> -		ctrl_val = (!is_mba_sc(r) ? dom->ctrl_val[closid] :
> -			    dom->mbps_val[closid]);
> +		ctrl_val = (!is_mba_sc(r) ? hw_dom->ctrl_val[closid] :
> +			    hw_dom->mbps_val[closid]);
>  		seq_printf(s, r->format_str, dom->id, max_data_width,
>  			   ctrl_val);
>  		sep = true;
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 43c8cf6b2b12..235cf621c878 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -299,44 +299,25 @@ struct mbm_state {
>  };
>  
>  /**
> - * struct rdt_domain - group of cpus sharing an RDT resource
> - * @list:	all instances of this resource
> - * @id:		unique id for this instance
> - * @cpu_mask:	which cpus share this resource
> - * @rmid_busy_llc:
> - *		bitmap of which limbo RMIDs are above threshold
> - * @mbm_total:	saved state for MBM total bandwidth
> - * @mbm_local:	saved state for MBM local bandwidth
> - * @mbm_over:	worker to periodically read MBM h/w counters
> - * @cqm_limbo:	worker to periodically read CQM h/w counters
> - * @mbm_work_cpu:
> - *		worker cpu for MBM h/w counters
> - * @cqm_work_cpu:
> - *		worker cpu for CQM h/w counters
> + * struct rdt_hw_domain - Arch private attributes of a set of CPUs that share
> + *			  a resource
> + * @resctrl:	Properties exposed to the resctrl file system
>   * @ctrl_val:	array of cache or mem ctrl values (indexed by CLOSID)
>   * @mbps_val:	When mba_sc is enabled, this holds the bandwidth in MBps
> - * @new_ctrl:	new ctrl value to be loaded
> - * @have_new_ctrl: did user provide new_ctrl for this domain
> - * @plr:	pseudo-locked region (if any) associated with domain
> + *
> + * Members of this structure are accessed via helpers that provide abstraction.
>   */
> -struct rdt_domain {
> -	struct list_head		list;
> -	int				id;
> -	struct cpumask			cpu_mask;
> -	unsigned long			*rmid_busy_llc;
> -	struct mbm_state		*mbm_total;
> -	struct mbm_state		*mbm_local;
> -	struct delayed_work		mbm_over;
> -	struct delayed_work		cqm_limbo;
> -	int				mbm_work_cpu;
> -	int				cqm_work_cpu;
> +struct rdt_hw_domain {
> +	struct rdt_domain		resctrl;

Naming is bit confusing here. There is another field with the same
name(patch1).

+struct rdt_hw_resource {
+	struct rdt_resource	resctrl;

I think we should make this bit more clearer. May be or something similar.

struct rdt_hw_domain {
    struct rdt_domain		d_resctrl;

>  	u32				*ctrl_val;
>  	u32				*mbps_val;
> -	u32				new_ctrl;
> -	bool				have_new_ctrl;
> -	struct pseudo_lock_region	*plr;
>  };
>  
> +static inline struct rdt_hw_domain *resctrl_to_arch_dom(struct rdt_domain *r)
> +{
> +	return container_of(r, struct rdt_hw_domain, resctrl);
> +}
> +
>  /**
>   * struct msr_param - set a range of MSRs from a domain
>   * @res:       The resource to use
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 685e7f86d908..76eea10f2e2c 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -418,6 +418,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
>  	u32 closid, rmid, cur_msr, cur_msr_val, new_msr_val;
>  	struct mbm_state *pmbm_data, *cmbm_data;
>  	struct rdt_hw_resource *hw_r_mba;
> +	struct rdt_hw_domain *hw_dom_mba;
>  	u32 cur_bw, delta_bw, user_bw;
>  	struct rdt_resource *r_mba;
>  	struct rdt_domain *dom_mba;
> @@ -438,11 +439,12 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
>  		pr_warn_once("Failure to get domain for MBA update\n");
>  		return;
>  	}
> +	hw_dom_mba = resctrl_to_arch_dom(dom_mba);
>  
>  	cur_bw = pmbm_data->prev_bw;
> -	user_bw = dom_mba->mbps_val[closid];
> +	user_bw = hw_dom_mba->mbps_val[closid];
>  	delta_bw = pmbm_data->delta_bw;
> -	cur_msr_val = dom_mba->ctrl_val[closid];
> +	cur_msr_val = hw_dom_mba->ctrl_val[closid];
>  
>  	/*
>  	 * For Ctrl groups read data from child monitor groups.
> @@ -479,7 +481,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
>  
>  	cur_msr = hw_r_mba->msr_base + closid;
>  	wrmsrl(cur_msr, delay_bw_map(new_msr_val, r_mba));
> -	dom_mba->ctrl_val[closid] = new_msr_val;
> +	hw_dom_mba->ctrl_val[closid] = new_msr_val;
>  
>  	/*
>  	 * Delta values are updated dynamically package wise for each
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 5126a1e58d97..9a8665c8ab89 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -915,7 +915,7 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
>  	list_for_each_entry(dom, &r->domains, list) {
>  		if (sep)
>  			seq_putc(seq, ';');
> -		ctrl = dom->ctrl_val;
> +		ctrl = resctrl_to_arch_dom(dom)->ctrl_val;
>  		sw_shareable = 0;
>  		exclusive = 0;
>  		seq_printf(seq, "%d=", dom->id);
> @@ -1193,7 +1193,7 @@ static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d
>  	}
>  
>  	/* Check for overlap with other resource groups */
> -	ctrl = d->ctrl_val;
> +	ctrl = resctrl_to_arch_dom(d)->ctrl_val;
>  	for (i = 0; i < closids_supported(); i++, ctrl++) {
>  		ctrl_b = *ctrl;
>  		mode = rdtgroup_mode_by_closid(i);
> @@ -1262,6 +1262,7 @@ bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
>   */
>  static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
>  {
> +	struct rdt_hw_domain *hw_dom;
>  	int closid = rdtgrp->closid;
>  	struct rdt_resource *r;
>  	bool has_cache = false;
> @@ -1272,7 +1273,8 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
>  			continue;
>  		has_cache = true;
>  		list_for_each_entry(d, &r->domains, list) {
> -			if (rdtgroup_cbm_overlaps(r, d, d->ctrl_val[closid],
> +			hw_dom = resctrl_to_arch_dom(d);
> +			if (rdtgroup_cbm_overlaps(r, d, hw_dom->ctrl_val[closid],
>  						  rdtgrp->closid, false)) {
>  				rdt_last_cmd_puts("Schemata overlaps\n");
>  				return false;
> @@ -1404,6 +1406,7 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
>  static int rdtgroup_size_show(struct kernfs_open_file *of,
>  			      struct seq_file *s, void *v)
>  {
> +	struct rdt_hw_domain *hw_dom;
>  	struct rdtgroup *rdtgrp;
>  	struct rdt_resource *r;
>  	struct rdt_domain *d;
> @@ -1438,14 +1441,15 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
>  		sep = false;
>  		seq_printf(s, "%*s:", max_name_width, r->name);
>  		list_for_each_entry(d, &r->domains, list) {
> +			hw_dom = resctrl_to_arch_dom(d);
>  			if (sep)
>  				seq_putc(s, ';');
>  			if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
>  				size = 0;
>  			} else {
>  				ctrl = (!is_mba_sc(r) ?
> -						d->ctrl_val[rdtgrp->closid] :
> -						d->mbps_val[rdtgrp->closid]);
> +						hw_dom->ctrl_val[rdtgrp->closid] :
> +						hw_dom->mbps_val[rdtgrp->closid]);
>  				if (r->rid == RDT_RESOURCE_MBA)
>  					size = ctrl;
>  				else
> @@ -1940,6 +1944,7 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r)
>  static int set_mba_sc(bool mba_sc)
>  {
>  	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].resctrl;
> +	struct rdt_hw_domain *hw_dom;
>  	struct rdt_domain *d;
>  
>  	if (!is_mbm_enabled() || !is_mba_linear() ||
> @@ -1947,8 +1952,10 @@ static int set_mba_sc(bool mba_sc)
>  		return -EINVAL;
>  
>  	r->membw.mba_sc = mba_sc;
> -	list_for_each_entry(d, &r->domains, list)
> -		setup_default_ctrlval(r, d->ctrl_val, d->mbps_val);
> +	list_for_each_entry(d, &r->domains, list) {
> +		hw_dom = resctrl_to_arch_dom(d);
> +		setup_default_ctrlval(r, hw_dom->ctrl_val, hw_dom->mbps_val);
> +	}
>  
>  	return 0;
>  }
> @@ -2265,6 +2272,7 @@ static int rdt_init_fs_context(struct fs_context *fc)
>  static int reset_all_ctrls(struct rdt_resource *r)
>  {
>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
> +	struct rdt_hw_domain *hw_dom;
>  	struct msr_param msr_param;
>  	cpumask_var_t cpu_mask;
>  	struct rdt_domain *d;
> @@ -2283,10 +2291,11 @@ static int reset_all_ctrls(struct rdt_resource *r)
>  	 * from each domain to update the MSRs below.
>  	 */
>  	list_for_each_entry(d, &r->domains, list) {
> +		hw_dom = resctrl_to_arch_dom(d);
>  		cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
>  
>  		for (i = 0; i < hw_res->num_closid; i++)
> -			d->ctrl_val[i] = r->default_ctrl;
> +			hw_dom->ctrl_val[i] = r->default_ctrl;
>  	}
>  	cpu = get_cpu();
>  	/* Update CBM on this cpu if it's in cpu_mask. */
> @@ -2665,7 +2674,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct rdt_resource *r,
>  	d->have_new_ctrl = false;
>  	d->new_ctrl = r->cache.shareable_bits;
>  	used_b = r->cache.shareable_bits;
> -	ctrl = d->ctrl_val;
> +	ctrl = resctrl_to_arch_dom(d)->ctrl_val;
>  	for (i = 0; i < closids_supported(); i++, ctrl++) {
>  		if (closid_allocated(i) && i != closid) {
>  			mode = rdtgroup_mode_by_closid(i);
> @@ -2682,7 +2691,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct rdt_resource *r,
>  			 * with an exclusive group.
>  			 */
>  			if (d_cdp)
> -				peer_ctl = d_cdp->ctrl_val[i];
> +				peer_ctl = resctrl_to_arch_dom(d_cdp)->ctrl_val[i];
>  			else
>  				peer_ctl = 0;
>  			used_b |= *ctrl | peer_ctl;
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index ee92df9c7252..be6f5df78e31 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -15,7 +15,37 @@ int proc_resctrl_show(struct seq_file *m,
>  
>  #endif
>  
> -struct rdt_domain;
> +/**
> + * struct rdt_domain - group of CPUs sharing a resctrl resource
> + * @list:		all instances of this resource
> + * @id:			unique id for this instance
> + * @cpu_mask:		which CPUs share this resource
> + * @new_ctrl:		new ctrl value to be loaded
> + * @have_new_ctrl:	did user provide new_ctrl for this domain
> + * @rmid_busy_llc:	bitmap of which limbo RMIDs are above threshold
> + * @mbm_total:		saved state for MBM total bandwidth
> + * @mbm_local:		saved state for MBM local bandwidth
> + * @mbm_over:		worker to periodically read MBM h/w counters
> + * @cqm_limbo:		worker to periodically read CQM h/w counters
> + * @mbm_work_cpu:	worker CPU for MBM h/w counters
> + * @cqm_work_cpu:	worker CPU for CQM h/w counters
> + * @plr:		pseudo-locked region (if any) associated with domain
> + */
> +struct rdt_domain {
> +	struct list_head		list;
> +	int				id;
> +	struct cpumask			cpu_mask;
> +	u32				new_ctrl;
> +	bool				have_new_ctrl;
> +	unsigned long			*rmid_busy_llc;
> +	struct mbm_state		*mbm_total;
> +	struct mbm_state		*mbm_local;
> +	struct delayed_work		mbm_over;
> +	struct delayed_work		cqm_limbo;
> +	int				mbm_work_cpu;
> +	int				cqm_work_cpu;
> +	struct pseudo_lock_region	*plr;
> +};
>  
>  /**
>   * struct resctrl_cache - Cache allocation related data
> 
