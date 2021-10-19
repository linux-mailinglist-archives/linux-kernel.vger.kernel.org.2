Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D37434203
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 01:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhJSXWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 19:22:19 -0400
Received: from mail-bn8nam11on2061.outbound.protection.outlook.com ([40.107.236.61]:6742
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229554AbhJSXWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 19:22:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/l0AYIwdm1Ct7P1QuW3DylkRQeu980dHBAhVz7U1wx5+YlNiOsR333byOSWLJHTLvuRFYAZyIBgb7xcX3Vs0eGtiCy2Bo/myCEvWk/5IbAoPGlzQ7UFhcef6utDgPMTaYgzyIEXqZJbPy1vtLStnMYEuOyrpVKhkdNYYoEhgcarvoMxj+NtDR3akJ794U3WVFTs8Alzjy6PdcBECW7QIO+G5/XJcCX1p6aBTniYEOVVko+Ag6otM569ctAj+1elRd2jf0VOaVBrrpwx8DJW5DH5TP7JVkUGugWhiF1uXtrreRl2qf4UX6YfEAIljAfecrLnEfyqN948ngfMlmaqcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJb1jhV8Iq8P/vkygJlAh1jrfYFQWvCBeBAjYBIL9dM=;
 b=BVNOGrxpSJbskg5p3Yk73aeuRxiUlYTJeuCjE/y0gm6uwurep8hr58lVqnO0a82Q+ObgE+MgaJltN2o78HBIcGGOalQ97U5CHiTvqEimRWJJvzN8lj1Ms07lxSZrTufJQLLKobnCgfIMuLLokXU5jq6kSQ/vq3e+gh/mUSM5wRW9WJSZzWSGY7UmmbwChmRzaWbDbvBpuUl4o6n4EsS7TrnkE2SsP8xQXOE6d5bqbjwWbf+BPC35obgrnkVLgA4VT3KDUXT761t6Gv/gpJ0WIPI7yOjlgXu8DBwNp7/NmKI3FTwmrkgEvFNXKDb0QZa59gfeSy7ItpaOdxG/gf1cLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJb1jhV8Iq8P/vkygJlAh1jrfYFQWvCBeBAjYBIL9dM=;
 b=nmxlH0ylQBdYPija5Btwm5jmX1SiBt/YGuQ3S2F2YuSULpoEM4MCnWMezs+xfTZkoIq01hcB6gA9mjl2EYvI82BKyXlHrYVk1H09LN/TiV+oUN1+mKpTtKmjAehWh85z075obXs849q5jeMsPMl0RS/9oa49ZWdSmaWbGsNx0RA=
Authentication-Results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MWHPR12MB1168.namprd12.prod.outlook.com (2603:10b6:300:e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 23:20:01 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::41ef:d712:79a2:30c1]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::41ef:d712:79a2:30c1%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 23:20:01 +0000
From:   Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v2 07/23] x86/resctrl: Add domain offline callback for
 resctrl work
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
        lcherian@marvell.com, bobo.shaobowang@huawei.com,
        tan.shaopeng@fujitsu.com
References: <20211001160302.31189-1-james.morse@arm.com>
 <20211001160302.31189-8-james.morse@arm.com>
Message-ID: <47b1bfc9-1b31-d905-955d-638f3504778f@amd.com>
Date:   Tue, 19 Oct 2021 18:19:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211001160302.31189-8-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAP220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::21) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
Received: from [10.236.30.47] (165.204.77.1) by BLAP220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18 via Frontend Transport; Tue, 19 Oct 2021 23:19:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9ea3847-f1e7-45ce-c323-08d99356f9b1
X-MS-TrafficTypeDiagnostic: MWHPR12MB1168:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1168435F3CB9A33B802B538495BD9@MWHPR12MB1168.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tiy6yDSvZ6dKhd9jGfuOOq6bHh3cg3X1bNEZaz7YBgIy7zYf5Xooj5tRaXmdiQlZ+QzGdelD9EWA7oxfIfGGG9+wmm/qs3Uaho5wWHthKt/VKoP7bTX8XYYdcfbhtMwpixBZYelLVLxIsxq+ojkMfmwmwg7sByqXoLMCSlDIC9ouFkBFoMd0ovZ1EDH7c1a+ADJX4Pl+n/SAuMgus13pjoFZM6AKpY61+3wasahk9cHrTuN32iNGLTK9qjD/qrw19XtulaxPCHWSpgrRVkX5XY9sFQqo3yyTxOe+JrL/yz0S3IrM07bd5z9RaZE/Kn2EN6hZ22MMFV3JsGgonU+03qmUIsIKbDzofo+i5GVs6gjROPkgmXSosgVRH9UNTEliz0ahzehvWTwOpgJ1sQ2a4X3OOL67WQPIQA5TOuKAWxHtu5cUrWJ3DunEIxGOyt/lILdSN5GQ4YdWLq82D7QfurQI0lMjgHtm3FAgcuBlnkvSK9BpbwpGWPo1thBYHkj9BaXtyjlKlu9Q7GOxuJdDGGwB2XYdwh0ie/xWRpxSIABRmqZ7Q1jysUfxwG1jlJ3LbyKUCuzmUYoQ3BsxO48wsVZ8L6VTtm8gq9r1huzSroc0EDOmCsViNuhxe5l06vXAYCeBPJHh6sVURfSK3pypXBg+kI3Y/lJEiu3U7o6RPB5R/3sYBgeyCSKWjGsr4AHqjgr6T5bnR+shZqfzftjnbL4tMFsAGVpr3W7MwuIawf0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(86362001)(38100700002)(53546011)(31696002)(26005)(31686004)(83380400001)(8676002)(6486002)(66476007)(956004)(508600001)(66946007)(186003)(44832011)(2906002)(66556008)(2616005)(4326008)(5660300002)(316002)(7416002)(36756003)(16576012)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RThzajVXVFNoSGUvSWZ5Vk8rMWwvT09yL09YWXprMEhYQlhQQzd3NUkraHk3?=
 =?utf-8?B?eG1yVnF0SEJmKzJtTHlNRlJnNWJJWktjWTR1Q1lVSjJZRmg0QnQ0ckhJN21o?=
 =?utf-8?B?YUJ4RWN1d0tnQjZLbzc1a3Btb1Q3S2RLWVM2K2xTVVJ4ZnFGZjBUanRsRlMy?=
 =?utf-8?B?WTRqaXl6bzFEQngvUzc2cURJbTVybXY5ejVMV29LSkE0VFNKNEtlejROUXpK?=
 =?utf-8?B?UGc1V0JwUzBUeFNLM1kxRmtRMjdJQUhiNWREOGdMMSswQXdlOUR3VUZDaWVH?=
 =?utf-8?B?d29YSTZCK3dra3NaS3FadEwxRElsUUFUUkYyUjBibXFRZWNMUlZrdlhkckdx?=
 =?utf-8?B?S0EyUG96Q2xDNDNNWUExWWtyNTg1UGw4aFRXMERnZUNxR1pFSGVXM3BwaWNF?=
 =?utf-8?B?Ty9MNmd4cW5uNjkrRTVvVk9wNmEvOEdNdy9jRlZxRTFITitjcnljaEtoRkg1?=
 =?utf-8?B?em4wZk1PRjZFTlNLNW5RUTFuRHkvWjdyWVpNNDlYNTZNdDRTTTA2K1V5TGNQ?=
 =?utf-8?B?dm9TVzRzUHFPalRXcFhtWXFjSHRFWEttR1JDcmYwYTVPTWFvdWNNTGFabk8y?=
 =?utf-8?B?amlQcDVhL1FqdCt3WU0vSFlicEhrY2dMeWxXZ3kxM0hQSG1ka2JVZTlwRnAx?=
 =?utf-8?B?Rm85UFFiZHFnUnNtd2pzMFFjRVhlUEtjMHdObFFONER0Nmk5cFA3RXBVek9M?=
 =?utf-8?B?VTBmM0dEaFRXbUE3eEQvT2lpY3FUMFcvWlAxekF5djllOVZ5bFhQNTZjSkF4?=
 =?utf-8?B?MlR5VkloanhLbmdLNXpYWWYyTU92cWpZRUhzZE4zOSszcU9ndzk1LzBGV2F2?=
 =?utf-8?B?NEcyWWRhcDVQaDNHdktlMGhxVEZ0b1VHZWUyS1NuZnRkbU44ZkcrYkRjYUpH?=
 =?utf-8?B?T1RPREJ0ZTBHaENHUEx0OEdSSm5IQWJwRTVEU0Z1R2Nxa3BZckdwdktBbmJJ?=
 =?utf-8?B?dDhubDVrNXJjTEM2VTJhKzl6R2xxdnp0aHJNZUNWMWJ6Q0tPVTdLSHFxdnhY?=
 =?utf-8?B?VlJSTXJWOFhDUEpWaTk4VW4yMlM4aTIzZjdQUWR5d1Y5VGtLNWJrUGc1RjEv?=
 =?utf-8?B?eFZ6b3V6dG9LUytJQ1hGUWQ2MG1Vd29nZDB5QTBxWkpJVkxJNFJpU2M4V3hI?=
 =?utf-8?B?Z3N3UGdvUzBuc2hybDk4SVpNUFRCdGRqYzVnUG1seXJHb3p3TzAzMGxDcFM3?=
 =?utf-8?B?Sno1R3VHRkJ6NDhjZ1dGVlp4eTdLU3RLY1pyLzQ2QmpUbVhvdWV2eGFSeGZt?=
 =?utf-8?B?ZzRURVpjVEZ4WWJLT2s0cm1wQVRDSjg3VUcwci96MFhBSGpWREtibWZpVnlF?=
 =?utf-8?B?WHNrRnJ2UHJHZkxzQVNua0lPbXZ0ZFJ6MTliWjMxT3NHRlBDMEdZdGRNVkxn?=
 =?utf-8?B?WWY2OG1FbndmVy9wTjRXZ296cDVSSDU2RFhFbHV4czArYnNRTHVlSEN6RjUr?=
 =?utf-8?B?ZEFzN2NVc25WeWs3UmJoTWdPWFNpYU9IZmV6MFRGbW4rUmN2bTI4Z3BqV2hk?=
 =?utf-8?B?TXVqQ3dhZDBaOStlWHZqT2pxeXBsanFTdWwwdUNoWVpNSTdCeEN0aFFJSmhm?=
 =?utf-8?B?ZGxWakVTdEUrTU9EQkhUakNNUVA1QitHRGxrblhVUEx0R0ZUZW5EMHlJNU41?=
 =?utf-8?B?Y2ZrZnZiQTZXR09PNUlBUE5nWThZT0lOVWtaeUVHOTg5dzV4cGhrVG0wZmFP?=
 =?utf-8?B?MVlhcUlEVStSWmt3ZXVSYmphTllBcHdpNTRXTlRULzRYQTRxcGR6Y05tV0Vy?=
 =?utf-8?Q?vkLMuI4f4ArOhVqp/emLn2MxTAFO5Jn199jYBhi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ea3847-f1e7-45ce-c323-08d99356f9b1
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 23:20:01.7553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bmoger@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1168
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/1/21 11:02 AM, James Morse wrote:
> Because domains are exposed to user-space via resctrl, the filesystem
> must update its state when CPU hotplug callbacks are triggered.
> 
> Some of this work is common to any architecture that would support
> resctrl, but the work is tied up with the architecture code to
> free the memory.
> 
> Move the monitor subdir removal and the cancelling of the mbm/limbo
> works into a new resctrl_offline_domain() call. These bits are not
> specific to the architecture. Grouping them in one function allows
> that code to be moved to /fs/ and re-used by another architecture.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v1:
>  * Removed a redundant mon_capable check
>  * Capitalisation
>  * Removed inline comment
>  * Added to the commit message
> ---
>  arch/x86/kernel/cpu/resctrl/core.c     | 26 ++---------------
>  arch/x86/kernel/cpu/resctrl/internal.h |  2 --
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 39 +++++++++++++++++++++++---
>  include/linux/resctrl.h                |  1 +
>  4 files changed, 38 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 7a2c24c5652c..1dd8428df008 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -523,27 +523,8 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>  
>  	cpumask_clear_cpu(cpu, &d->cpu_mask);
>  	if (cpumask_empty(&d->cpu_mask)) {
> -		/*
> -		 * If resctrl is mounted, remove all the
> -		 * per domain monitor data directories.
> -		 */
> -		if (static_branch_unlikely(&rdt_mon_enable_key))
> -			rmdir_mondata_subdir_allrdtgrp(r, d->id);
> +		resctrl_offline_domain(r, d);
>  		list_del(&d->list);
> -		if (r->mon_capable && is_mbm_enabled())
> -			cancel_delayed_work(&d->mbm_over);
> -		if (is_llc_occupancy_enabled() &&  has_busy_rmid(r, d)) {
> -			/*
> -			 * When a package is going down, forcefully
> -			 * decrement rmid->ebusy. There is no way to know
> -			 * that the L3 was flushed and hence may lead to
> -			 * incorrect counts in rare scenarios, but leaving
> -			 * the RMID as busy creates RMID leaks if the
> -			 * package never comes back.
> -			 */
> -			__check_limbo(d, true);
> -			cancel_delayed_work(&d->cqm_limbo);
> -		}
>  
>  		/*
>  		 * rdt_domain "d" is going to be freed below, so clear
> @@ -551,11 +532,8 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>  		 */
>  		if (d->plr)
>  			d->plr->d = NULL;
> -
> -		bitmap_free(d->rmid_busy_llc);
> -		kfree(d->mbm_total);
> -		kfree(d->mbm_local);
>  		domain_free(hw_dom);
> +
>  		return;
>  	}
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index be48a682dbdb..e12b55f815bf 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -522,8 +522,6 @@ void free_rmid(u32 rmid);
>  int rdt_get_mon_l3_config(struct rdt_resource *r);
>  void mon_event_count(void *info);
>  int rdtgroup_mondata_show(struct seq_file *m, void *arg);
> -void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
> -				    unsigned int dom_id);
>  void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>  		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
>  		    int evtid, int first);
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 19691f9ab061..38670bb810cb 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2499,14 +2499,12 @@ static int mon_addfile(struct kernfs_node *parent_kn, const char *name,
>   * Remove all subdirectories of mon_data of ctrl_mon groups
>   * and monitor groups with given domain id.
>   */
> -void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r, unsigned int dom_id)
> +static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
> +					   unsigned int dom_id)
>  {
>  	struct rdtgroup *prgrp, *crgrp;
>  	char name[32];
>  
> -	if (!r->mon_capable)
> -		return;
> -
>  	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
>  		sprintf(name, "mon_%s_%02d", r->name, dom_id);
>  		kernfs_remove_by_name(prgrp->mon.mon_data_kn, name);
> @@ -3233,6 +3231,39 @@ static int __init rdtgroup_setup_root(void)
>  	return ret;
>  }
>  
> +void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
> +{
> +	lockdep_assert_held(&rdtgroup_mutex);

Is this really required?

> +
> +	if (!r->mon_capable)
> +		return;

I don't see the need for this check either.

Thanks
Babu
