Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223DF4341FF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 01:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhJSXVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 19:21:32 -0400
Received: from mail-co1nam11on2077.outbound.protection.outlook.com ([40.107.220.77]:9641
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229920AbhJSXVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 19:21:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KtkiMJJK/T5Wx25gU+V/DpcGgjTJXswjA8Wjfua4JKIH96HywbLYCImW/AxptI20CcVYBzR3Qs7yxUc23qTpaCHEAkBW4WzMplpCEguouOz3otCczVogdZysmv9Y0nFHd9u31o6CbTHc3GkJVICr2Qe8/9yCgQPOrg0CKFC+TFCup+dbECKaWsvW4VVSxymS9KsnFSw+vIQFaAAW5Qet57wFowKvqlkXXKSC+BW5Kps1n463rqOcq0CVr2zHeSZIB3a/bYY5j3bMtgKw0l9S7KixAMgji297HEq1k1pTh7hdtJR6I4iAqhEirnlr02o7k/OUWgtqKahJxhtQ3G+7MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kM84+lVDwhaibNsRbM4NQN0FPlxTjYQevZPbOm8dedg=;
 b=kWU6r8XHOx9qpLmYX4A52G0InTVlqgpqCjsdocUR/eozOnYfP8u3lcEbEkXjJxSte87HCNi+Ietbeg//cjmarirp6kq2qk+9Y4WaGz5N7axeeJ2KRYma3Clwct9yww0ou9jAa6axg73qMIie1E/CUup3n6R6Pn4K6o7zZVdfSBuUeV6H/jT9g0qMPS4grE/je3kpspOOFLyWDSaZaY8bB3MCIXLQmx1FEsD3LtVjreJZCRUUoy01ZeGnDeLhqX1hjZsUx/Hpx9F0nOmk2kI7Sbrc1DLD1WTIBmfzbbm6wHRiQIMzkoJtNnHv0GMN8p2Eyg8I+IWv6riUZpshUYuPxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kM84+lVDwhaibNsRbM4NQN0FPlxTjYQevZPbOm8dedg=;
 b=FJsA7PHR2oNGwagpLVi7b+v7iSYDIMnOTjRIDFdR79sezhXrHg/emtfBrLgwPiPUMKq6B8QJ8vTakZUPEdy20TgIxJuS1CWKZET5DakqUEwGzoy5XfJpZ4ocjG8XTkMlEwFep8oLv3TXYMU2laDgpRKEuQWIWOD/YnvrVNl86jU=
Authentication-Results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MWHPR1201MB0062.namprd12.prod.outlook.com (2603:10b6:301:54::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 23:19:08 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::41ef:d712:79a2:30c1]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::41ef:d712:79a2:30c1%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 23:19:08 +0000
From:   Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v2 05/23] x86/resctrl: Add domain online callback for
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
 <20211001160302.31189-6-james.morse@arm.com>
Message-ID: <26c3ef82-6c1f-5852-891a-7ba2e4cfe971@amd.com>
Date:   Tue, 19 Oct 2021 18:19:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211001160302.31189-6-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR11CA0016.namprd11.prod.outlook.com
 (2603:10b6:610:54::26) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
Received: from [10.236.30.47] (165.204.77.1) by CH2PR11CA0016.namprd11.prod.outlook.com (2603:10b6:610:54::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Tue, 19 Oct 2021 23:19:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf79c1ac-496b-469c-95db-08d99356d988
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0062:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB006253197001B78CE75DB56495BD9@MWHPR1201MB0062.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tDr5Pe4M3cohy4Fq7r4Y/uS1rETbanQvLWHtaj9zXRPV+/LRqxIEe0XdUNQsy9NpS//PATnzFJDxmA3K83CiZAoZ1fwzgwHIWXkqoyJPX6YNxYgY/u5PHvaE8NVKE2ASvcY/vDKjBavWJlWN2bcin3yE9lDhzd10/gQGQPQsTSk2JhB5lsJhrykOTNGryhnXisQk3gmA7fhCHzPaE3xoxPI/rLQ1wnpZX95W2XvakSqC1lGhvf+VZKE0RMH6fCGwDQ3i8CGNZ6WHQHT7JFrZ2vFlR32U3Ntmx7N8HP3PK5TNE2lwH/G5d+IuJrEfvaDH0HTsTJIDTZS6g/VSb0YjgUpzM3/80bFJoRu841K9swvbO1fJ2o2prC05CSjFFGjsbqMOk+/IWwDZAWjyD/1xnKyC7T9DHvxrMN64eVb4q7QVTF3/xuMIZl36wEMWyMSUHKmQyUSbm6wauiNbW+HPE05N+VMQWxehEOY4EJZkA8amMcjF0Xj7BwYb1rScAjRoymwudTnDHS1qUC7zXo3A4bYyTMC+iY9FH5yFuDoP6KIwd2CkgJEEVksaIt5qFqpFCKTwzwlRquPj1XDEtJuJN28t1tP7c1+6xm/qDOh1aEgDGxUNdwnLOUL1am6a2Dz3wgPNzcNIKXrVUR5DQFAkZQFz2cZMSIV63lRn26hZgCYlMFLMRksDPX7O955/Nni3psWhTGyoT94aJq4N5uLc/ZVpQHj9+346dd9A7cWELv8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(508600001)(66556008)(2616005)(44832011)(66476007)(83380400001)(186003)(5660300002)(31686004)(66946007)(36756003)(38100700002)(16576012)(316002)(4326008)(8936002)(8676002)(53546011)(54906003)(86362001)(7416002)(31696002)(26005)(6486002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkRNa3J1ZW1KZG9uNU1TZnpqS1QrWG16L1BDTUMySjAzd1gyOGRWaEVEQ2FU?=
 =?utf-8?B?TmE3azdjT3Bkb01nQzY1YWdvRnBhL1RpRWZqSTRYcDBKR01DSzV1NFR2bnpa?=
 =?utf-8?B?VnEyOFF2cE9EcXpwUUl4YldBclkyd1gvUnhLZnQxWGxmNEVBUFJ2T1BZdSs3?=
 =?utf-8?B?ajN4SXMrWCswMW9jMVA1N21EakI4Y0RUaVBMRWZIRWhyV1Vjb3p3Ulo3aHND?=
 =?utf-8?B?dnJ1dEQ3clpnclcvUjMwYU02SnNDVlpsSEg0STN6Z0VTdkhrZ2ZnbmVrS0c1?=
 =?utf-8?B?TWpCcU80TEdPc0hIbnVLM29GQURyc2tVdkY1OHhUYlFZNHd2QXBvOU1BRzlE?=
 =?utf-8?B?aDc5L3lOeWtHYVhwZ2MrUElBR2FvWlJEWmVxUWxGUDREU1ZUOTlNN3JyRFBK?=
 =?utf-8?B?RnlLUm1Da1dTRU5PUTVwREIybVNmVkZDc21ZMndyKzhkSXRzbW5CdUNXTGdF?=
 =?utf-8?B?MGdkNHhVNzZzVTI3ZWVNdlFUdmNaMWJaM1VJVzZGRXlsdjV1c0tFdzNaYVpa?=
 =?utf-8?B?MXBzd0J1eUJtZEViNTVtZ0ZVOTc1d0xxazRnK0VmVnB1QnhpekR5WThhTjdS?=
 =?utf-8?B?a04rQ0RRR1h0eHhPa0p2OWZkYnBNeUp1L3JnMUcxRUNDTTZLRm9KS25DOGRN?=
 =?utf-8?B?S2NIRTBTWHlFN0Mxb05YeVNhYmZya1hTQlBuQ0VrWUhuYXF4bGtFOVJEREpP?=
 =?utf-8?B?YjdSbHcwN3BGOFo4OXpiSkVxYjdWK1BXcUQrSm8wK0s3SmFpL3FBZEJ3Sm9m?=
 =?utf-8?B?TXl4VlBnTnpMNHU0NnZEcDRQZFlFNDRzOUkvMElJL3YwekxPblhTajBVVTc3?=
 =?utf-8?B?WGVuNWpqcEZsYnFDTlhSVWo0Rkx4M0wwbXh5NW9SNC9rRUFXT24wUmk0L1I1?=
 =?utf-8?B?OVczL2pXbmU2QTVXeFlESGxhaUFiNUY4blJ6Tmx0cENCeWlxaUZxYzJVNUo5?=
 =?utf-8?B?RERzZFhpQjJuZndscjNJaENMM0IrYjF1UjhyQ05yQk02emRnVC83YjRWZFJ2?=
 =?utf-8?B?ZE9GbER4STNTNWlnSkRZT0FEOG5LcVNkc3piOEYxZUhZQ2FQWnNMdGR6aUJm?=
 =?utf-8?B?VC9hTmM4WE5DNjFKQ2ZDUjJlK2s1TGFrdS9jTjNSZEhyYnJvNmxwbDE5RlFP?=
 =?utf-8?B?elp3aDFZeGxDdFc1aGxLMXptNS9paXRlc2xMTjR2dk1BWEZPd01yNWlHNFV6?=
 =?utf-8?B?QWNQcjZtb0tYamY4MWtTcXpvZFFzaS94TWVEajhKay9zVlNpOXE3ZFNGdUxC?=
 =?utf-8?B?bGZrbXR2emVPdFJFVGp2RGFoUzIreW9UejlYaEN4QUdnNnExQkI5aDlmM2dD?=
 =?utf-8?B?Zkp0SVJkeWh0TWhGV01sa2xhOVk4Y0RZRnlGRytzVktIekdLWGl6eDRJeGJN?=
 =?utf-8?B?NW1hcVJvVXJRLzV2YVVwZGs1S1R1eDZudW5EcHBzK21wZXlDMjZxYzNRNmpM?=
 =?utf-8?B?VVV4aGZxdmtTa2VGblZFbnF1cW5KdEVUek9lNnZjaG03Q2EvRGNaTW5wWm91?=
 =?utf-8?B?WTdwQ2V0cmxUOGVhZjViZHNGclNlVER4OHJMTFNXalQvb3RRT21vbzM5VlZ4?=
 =?utf-8?B?VXVGQ0crbGY2SzlSbkhpMWxJMEFVREY5azBqNzVqc1lSd0tjS0dWSlRsd3p1?=
 =?utf-8?B?T3lWQXZSQVVIVWFNOVp3OWtFcWpHd0JlWXhBbkJydzJLcDQ2cTB0amxIUmJP?=
 =?utf-8?B?dFNydVJ5U2Q1MWJLMUxTNnkwOFR0UGNOeUxmZzczN3lmemtmbjhiLzRrUjFr?=
 =?utf-8?Q?veBU35pMrTkI3Hy2VxlY03RvyrKJRW7iFitrO5k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf79c1ac-496b-469c-95db-08d99356d988
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 23:19:07.8172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bmoger@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0062
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/1/21 11:02 AM, James Morse wrote:
> Because domains are exposed to user-space via resctrl, the filesystem
> must update its state when CPU hotplug callbacks are triggered.
> 
> Some of this work is common to any architecture that would support
> resctrl, but the work is tied up with the architecture code to
> allocate the memory.
> 
> Move domain_setup_mon_state(), the monitor subdir creation call and the
> mbm/limbo workers into a new resctrl_online_domain() call. These bits
> are not specific to the architecture. Grouping them in one function
> allows that code to be moved to /fs/ and re-used by another architecture.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v1:
>  * Capitalisation
>  * Removed inline comment
>  * Added to the commit message
> ---
>  arch/x86/kernel/cpu/resctrl/core.c     | 57 ++++------------------
>  arch/x86/kernel/cpu/resctrl/internal.h |  2 -
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 65 ++++++++++++++++++++++++--
>  include/linux/resctrl.h                |  1 +
>  4 files changed, 69 insertions(+), 56 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 2f87177f1f69..f1fa54de8136 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -443,42 +443,6 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
>  	return 0;
>  }
>  
> -static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
> -{
> -	size_t tsize;
> -
> -	if (is_llc_occupancy_enabled()) {
> -		d->rmid_busy_llc = bitmap_zalloc(r->num_rmid, GFP_KERNEL);
> -		if (!d->rmid_busy_llc)
> -			return -ENOMEM;
> -		INIT_DELAYED_WORK(&d->cqm_limbo, cqm_handle_limbo);
> -	}
> -	if (is_mbm_total_enabled()) {
> -		tsize = sizeof(*d->mbm_total);
> -		d->mbm_total = kcalloc(r->num_rmid, tsize, GFP_KERNEL);
> -		if (!d->mbm_total) {
> -			bitmap_free(d->rmid_busy_llc);
> -			return -ENOMEM;
> -		}
> -	}
> -	if (is_mbm_local_enabled()) {
> -		tsize = sizeof(*d->mbm_local);
> -		d->mbm_local = kcalloc(r->num_rmid, tsize, GFP_KERNEL);
> -		if (!d->mbm_local) {
> -			bitmap_free(d->rmid_busy_llc);
> -			kfree(d->mbm_total);
> -			return -ENOMEM;
> -		}
> -	}
> -
> -	if (is_mbm_enabled()) {
> -		INIT_DELAYED_WORK(&d->mbm_over, mbm_handle_overflow);
> -		mbm_setup_overflow_handler(d, MBM_OVERFLOW_INTERVAL);
> -	}
> -
> -	return 0;
> -}
> -
>  /*
>   * domain_add_cpu - Add a cpu to a resource's domain list.
>   *
> @@ -498,6 +462,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  	struct list_head *add_pos = NULL;
>  	struct rdt_hw_domain *hw_dom;
>  	struct rdt_domain *d;
> +	int err;
>  
>  	d = rdt_find_domain(r, id, &add_pos);
>  	if (IS_ERR(d)) {
> @@ -527,21 +492,15 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  		return;
>  	}
>  
> -	if (r->mon_capable && domain_setup_mon_state(r, d)) {
> -		kfree(hw_dom->ctrl_val);
> -		kfree(hw_dom->mbps_val);
> -		kfree(hw_dom);
> -		return;
> -	}
> -
>  	list_add_tail(&d->list, add_pos);
>  
> -	/*
> -	 * If resctrl is mounted, add
> -	 * per domain monitor data directories.
> -	 */
> -	if (static_branch_unlikely(&rdt_mon_enable_key))
> -		mkdir_mondata_subdir_allrdtgrp(r, d);
> +	err = resctrl_online_domain(r, d);
> +	if (err) {
> +		list_del(&d->list);
> +		kfree(hw_dom->ctrl_val);
> +		kfree(hw_dom->mbps_val);
> +		kfree(d);
> +	}
>  }
>  
>  static void domain_remove_cpu(int cpu, struct rdt_resource *r)
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 8828b5c1b6d2..be48a682dbdb 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -524,8 +524,6 @@ void mon_event_count(void *info);
>  int rdtgroup_mondata_show(struct seq_file *m, void *arg);
>  void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
>  				    unsigned int dom_id);
> -void mkdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
> -				    struct rdt_domain *d);
>  void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>  		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
>  		    int evtid, int first);
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index e243c7d15b81..19691f9ab061 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2565,16 +2565,13 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
>   * Add all subdirectories of mon_data for "ctrl_mon" groups
>   * and "monitor" groups with given domain id.
>   */
> -void mkdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
> -				    struct rdt_domain *d)
> +static void mkdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
> +					   struct rdt_domain *d)
>  {
>  	struct kernfs_node *parent_kn;
>  	struct rdtgroup *prgrp, *crgrp;
>  	struct list_head *head;
>  
> -	if (!r->mon_capable)
> -		return;
> -
>  	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
>  		parent_kn = prgrp->mon.mon_data_kn;
>  		mkdir_mondata_subdir(parent_kn, d, r, prgrp);
> @@ -3236,6 +3233,64 @@ static int __init rdtgroup_setup_root(void)
>  	return ret;
>  }
>  
> +static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
> +{
> +	size_t tsize;
> +
> +	if (is_llc_occupancy_enabled()) {
> +		d->rmid_busy_llc = bitmap_zalloc(r->num_rmid, GFP_KERNEL);
> +		if (!d->rmid_busy_llc)
> +			return -ENOMEM;
> +	}
> +	if (is_mbm_total_enabled()) {
> +		tsize = sizeof(*d->mbm_total);
> +		d->mbm_total = kcalloc(r->num_rmid, tsize, GFP_KERNEL);
> +		if (!d->mbm_total) {
> +			bitmap_free(d->rmid_busy_llc);
> +			return -ENOMEM;
> +		}
> +	}
> +	if (is_mbm_local_enabled()) {
> +		tsize = sizeof(*d->mbm_local);
> +		d->mbm_local = kcalloc(r->num_rmid, tsize, GFP_KERNEL);
> +		if (!d->mbm_local) {
> +			bitmap_free(d->rmid_busy_llc);
> +			kfree(d->mbm_total);
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
> +{
> +	int err;
> +
> +	lockdep_assert_held(&rdtgroup_mutex);

Looks like lockdep_assert_held was not there in this sequence.
Are you concerned about this lock not being held?
Thanks
Babu Moger
