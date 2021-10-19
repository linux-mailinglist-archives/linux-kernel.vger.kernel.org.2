Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6E34341FB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 01:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhJSXUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 19:20:31 -0400
Received: from mail-co1nam11on2078.outbound.protection.outlook.com ([40.107.220.78]:55040
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229498AbhJSXU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 19:20:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NX4vcvvAc6aSC8ZWIqag0xjn6lCc6HvyYsNeew5Mfs7rW/NtLhok++44O6BGJHEmSiBO2zHzto2h6ONn651UatGCqjDGkujF7DZ3uKBH/VCKPA19a9zPdJ6+2pnYQAi/JvVjDvCu0p3tZ7zVd9MuPbE1f731hEEYZh0FZkfUJXj7hiI+nuTgaZgNtE4e5WfmHK7V23vjyn/r2xBpkhf9I4vQQ/k3/Csj9YhftrVv5bA3h4YhbCe69Tj2SOzcXg2Iz7lnH/q8VrCESWMmD6FHLufDaJ1LC61vh8FbR6i2KKMdIwx2XXpBHkm/U3edbS7naXM/LNfbfbO+gaB4V+CsAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRSqdflQvfKcz9fBtFwfuokLOUKOP4Oh9emUSDaWSn0=;
 b=hRgbYXV3kBbWMeDsZcaaLzIiA3VCfUgP5FAiF+xB6Z93DxdEkWBMKU48Fj0WcQrUBbWhR1E5QbMZghzzLPIkOKkaE40S4j5J45nJonQOrKQdGSgw1bNEPf3iWHEUDkiLacd0veqEHDVrCb5GJ98/Bk8oltldAQftHRG6bLssuNWey3/efRRz+9mG3Bd0lkrMmTxFTKdoEzd0sVEBdLor6B/BKitXn2u05gH8Uyk/DmFTLyWbFUdfKNxVcpStACz1x4+T8Ouk1ffuAnGxrakdgk9X+bBT9hoEn4KUCYJFVkHZQYLZXfcX/E0QAs6SVcxerSwpLJWDfJLinT/g+sS4Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRSqdflQvfKcz9fBtFwfuokLOUKOP4Oh9emUSDaWSn0=;
 b=PAYd4j7oDXChMZIJluqBKWNAQqR4hEAqFX/SHWbObJOmxwUMg3VBqKxERZ/rQdvoaoyGHk8tKLzZH+GjidTpB+4tZ26S9XJ9Pf7Icvy+gCraLe1yiuGP1r4/OiOD22VLjfWz0TL37R8nxrrOXoUt2OOMbAQtMd4MYX0gi85OTOI=
Authentication-Results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MWHPR1201MB0062.namprd12.prod.outlook.com (2603:10b6:301:54::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 23:18:13 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::41ef:d712:79a2:30c1]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::41ef:d712:79a2:30c1%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 23:18:13 +0000
From:   Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v2 04/23] x86/resctrl: Merge mon_capable and mon_enabled
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
 <20211001160302.31189-5-james.morse@arm.com>
Message-ID: <44ce43de-b6d9-cfbf-b991-0b7cfd819d39@amd.com>
Date:   Tue, 19 Oct 2021 18:18:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211001160302.31189-5-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0056.namprd02.prod.outlook.com
 (2603:10b6:207:3d::33) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
Received: from [10.236.30.47] (165.204.77.1) by BL0PR02CA0056.namprd02.prod.outlook.com (2603:10b6:207:3d::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17 via Frontend Transport; Tue, 19 Oct 2021 23:18:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f8dab59-014c-4a28-b2ca-08d99356b8bc
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0062:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0062B793EBA0899A667F52BE95BD9@MWHPR1201MB0062.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z5u9rbDv3UG2kDZ0jF9lhulQCtce8iVOzkmwyf6WKXpS4IZ6wBZPHWHVovjkisyPgZtLJGlZHw0Q7tAXDbdukjaQ2ILcHuKwtOv9WwCc72Q+h5hlTLe1v7xhDNxQo1FyNzjhtq9qvfUq6iiCVC7uy3rkLvCmUnrkbSg4IzTvBF4xbK+UImXo/Lbw8/Zf6fp64QB25sgdApNhuclw7C/NDkyVXh+tpwT21VpOyeSO7A3fPRkallVWaB+CHguzHXjRtMvej/aBw6IiZYFCRICXlNz/d++IbaDfjHJltRnRtaIcDgwYjuxNgYP2xwq8KWVpqAGb+6Z0hekv4HZ4JLNzU0T6v6NsH87f8fqCLrLH1TBREQ6PrPA8AtOLPmqJB+WCZ6uuldx6EaDwrmKccKLjeY+FeyJSQ1iGp1V6FLR0wuuxZbIUZ7GYuy8D9gA9uPBPDdm12mCaZQGQVxd6LJ03HYhVT4l5hZ5eqbN2qGJqSvk75jXaIJZszMOWBDrJBDRsdjhl1V8+68C61QazR1/w3E6ho1FroCuF9hntZrkfVCWdMwmbAy8PA4KScHogGOTYvuZNypWEq6UzaQ+2j/xmMoSKrRgkJTcSIZY+YSkEzTDTdv3mrrdYCsd/LGspt0bumpEzUhU0Ly6XBEcD/rd9iEMeqPFCLDneRxP3vRbCSOLb1ebHZfaQeeguHbrRLsq067kbnibIEPnghKIva9XrTMxiQCFqLFKywzpb39ua27R23fhESZzUNAk8uYYK6XHq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(508600001)(66556008)(2616005)(44832011)(66476007)(83380400001)(186003)(5660300002)(31686004)(66946007)(36756003)(38100700002)(16576012)(316002)(4326008)(8936002)(8676002)(53546011)(54906003)(86362001)(7416002)(31696002)(26005)(6486002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWZoWXFPditNVzlPd1dJR3EvaGR4NHFkZHBKbE5tRDdNbEJBcE1xazFwNXpC?=
 =?utf-8?B?UHBzZjl6REp1VWpQekc5R1M4REo1S2xoZnc2VVpJOUNseXZmYkliQ1hFMHFL?=
 =?utf-8?B?SVNyTCtoR05TZ1JmenZLRjNtNjN6ODlGZDk5SHJnQ2kwdXFDWU41c1Uvai9T?=
 =?utf-8?B?aXA1NExyZkRVSHFjYllyMjkzYW43dHM2N2NKRW5CeVpQSUtUSC9mOWNkTWRm?=
 =?utf-8?B?cGlQY1FqYjI5VG9STGpObnNVSndGdzRoSXRIbEdVYmsvWmlsZ3Noa1NQNU9E?=
 =?utf-8?B?dFA3VkhrQzM4cXQ3cSsySnhyTVFDWE9wblZyMXJoeVU0Ry90YXl1RGkrT2hT?=
 =?utf-8?B?RmRkejBvWVZzRXBBTnNJZjJ1NXdac1hwTkFDaUdxWkJ4NkZvVElTUUdsck1z?=
 =?utf-8?B?Ykc4TkdHd0NkQ0NOUUJHSit6QVN3c3hkV1BXRE5jc0hDZUtXZkxma1BGalpV?=
 =?utf-8?B?eENYbW5RWTN6TkEydzlKdFZ6akRPZ1FtZ2FLZEszVis5cGl5dmxJRUxOOUt4?=
 =?utf-8?B?bUp5MXlpRzgxNmdXd0taSGNZMEFrbnU2Y1pGRW5OcTZ2OWlIMVloRjdQeCtX?=
 =?utf-8?B?VlBKa3JFUTFiRURtdmRKVW1TaHZDa1NFV1pLb0w0ZjhoSEpCblBBUUFxK2pI?=
 =?utf-8?B?MWV1b1paSXRtenZOeHVrYUZpVWpPRWpNK2VtLzRTMFJZUFZMV211SDhuMjZw?=
 =?utf-8?B?UGFXZUVCTU94b3g2U3ZBYUJsMTlqcHV4a3ROSXc0UURSM3FLNExnazB2bXZP?=
 =?utf-8?B?amQ1Yk1XQVEzbEdmWXFZL3F4RmxpUjkzdVhoREtNZzN2ZWltRVVzKys4SXpw?=
 =?utf-8?B?NEdzTnhTbEVsQmE0NisxZzhDN2psRFNCOStRQldrYlMyWno4R2E5cVI2VE9k?=
 =?utf-8?B?ZmRGV2hDbTVjZHdOQVpENGZXYkFrc0VyQmRWTndXSzVQeDZwRmMrS0Zid045?=
 =?utf-8?B?WmxwUTBxOVI1dUdSalB5TzVtSXFIMXRKbXhNamZWN21DRUxmVXFWZDdncjFE?=
 =?utf-8?B?US9FejhsOWRFSkF2R2hrYitKdWtoQTl6aFROZnNrRll2bWp1SzhHMFloNXZq?=
 =?utf-8?B?OXg3dXFPcDN0VzJyb2xuR0pLcStDTHF0S2Zoc0lRS0Z5YkhTNXBsZGtkN3pX?=
 =?utf-8?B?ZU5MUFgrajNMWTVEd0FGQ241dExmdWh6MUMyQ1J4WkVtbFF5Z2x4bGxmcHpz?=
 =?utf-8?B?WTZzZXBJVGpUYjU3YVBWSEErNXFndjVucUg4TVAwZmJqV2I3Q1VQaTVMYWw0?=
 =?utf-8?B?WnpLbGxBSWZFVEI2U2p3MmU3bzVQNHpHTmcvUGM3Y0VESmVaYnYwbEFCcG9Q?=
 =?utf-8?B?QjM2dllwTnNZWnFwUjBXLzlxL3VIWnJ5UlRyaGpIQ2VWaDVWellidEozdzFo?=
 =?utf-8?B?NG0xT3BSMG1qN0EvNzBkUmNxamxhK21DZ2Z3NFl6Z2g1NzN2RTNFZW5xemtk?=
 =?utf-8?B?TVVGRy9EOFNoWWJydklvQVo4YUc0bEk5amVpbklRMjduQ1lSeFUxcWFyU3BR?=
 =?utf-8?B?M05Kd3VBTnQ4V1N4K291OHdvNjNJNnZIUmVLV0Y1ZHRHVTlDNTRXbTB6cU1P?=
 =?utf-8?B?NjNoZkJ4MVlqakNzaC9tanh0VllGbm12QWlYcnpaOUFEWEhMZENJaWJlUU1k?=
 =?utf-8?B?aTlxcjJObDV0ZXBUM1U5QkpmRnFmaWo5RmpSYS9KNnNzcUtTTWJNcnJEL0Y1?=
 =?utf-8?B?QWNCZjJtOVExZlo0WG5tUjNZVnNSVVM1WFdPZGVZNkJ0UHl3Ui8zR1hvRGJa?=
 =?utf-8?Q?9baqcoGZdCoF9DEMYrjNReqoAGLSlaoZdCh6sXb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8dab59-014c-4a28-b2ca-08d99356b8bc
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 23:18:12.8059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bmoger@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0062
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/1/21 11:02 AM, James Morse wrote:
> mon_enabled and mon_capable are always set as a pair by
> rdt_get_mon_l3_config().
> 
> There is no point having two values.
> 
> Merge them together.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v1:
>  * Removed stray cdp_capable changes.
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h | 4 ----
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 1 -
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 8 ++++----
>  include/linux/resctrl.h                | 2 --
>  4 files changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 53f3d275a98f..8828b5c1b6d2 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -459,10 +459,6 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
>  	for_each_rdt_resource(r)					      \
>  		if (r->mon_capable)
>  
> -#define for_each_mon_enabled_rdt_resource(r)				      \
> -	for_each_rdt_resource(r)					      \
> -		if (r->mon_enabled)
> -
>  /* CPUID.(EAX=10H, ECX=ResID=1).EAX */
>  union cpuid_0x10_1_eax {
>  	struct {
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index c9f0f3d63f75..37af1790337f 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -717,7 +717,6 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
>  	l3_mon_evt_init(r);
>  
>  	r->mon_capable = true;
> -	r->mon_enabled = true;
>  
>  	return 0;
>  }
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index e327f8d1c8a3..e243c7d15b81 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1765,7 +1765,7 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
>  			goto out_destroy;
>  	}
>  
> -	for_each_mon_enabled_rdt_resource(r) {
> +	for_each_mon_capable_rdt_resource(r) {
>  		fflags =  r->fflags | RF_MON_INFO;
>  		sprintf(name, "%s_MON", r->name);
>  		ret = rdtgroup_mkdir_info_resdir(r, name, fflags);
> @@ -2504,7 +2504,7 @@ void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r, unsigned int dom_id)
>  	struct rdtgroup *prgrp, *crgrp;
>  	char name[32];
>  
> -	if (!r->mon_enabled)
> +	if (!r->mon_capable)
>  		return;
>  
>  	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
> @@ -2572,7 +2572,7 @@ void mkdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
>  	struct rdtgroup *prgrp, *crgrp;
>  	struct list_head *head;
>  
> -	if (!r->mon_enabled)
> +	if (!r->mon_capable)
>  		return;
>  
>  	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
> @@ -2642,7 +2642,7 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
>  	 * Create the subdirectories for each domain. Note that all events
>  	 * in a domain like L3 are grouped into a resource whose domain is L3
>  	 */
> -	for_each_mon_enabled_rdt_resource(r) {
> +	for_each_mon_capable_rdt_resource(r) {
>  		ret = mkdir_mondata_subdir_alldom(kn, r, prgrp);
>  		if (ret)
>  			goto out_destroy;
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 386ab3a41500..8180c539800d 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -130,7 +130,6 @@ struct resctrl_schema;
>  /**
>   * struct rdt_resource - attributes of a resctrl resource
>   * @rid:		The index of the resource
> - * @mon_enabled:	Is monitoring enabled for this feature
>   * @alloc_capable:	Is allocation available on this machine
>   * @mon_capable:	Is monitor feature available on this machine
>   * @num_rmid:		Number of RMIDs available
> @@ -149,7 +148,6 @@ struct resctrl_schema;
>   */
>  struct rdt_resource {
>  	int			rid;
> -	bool			mon_enabled;
>  	bool			alloc_capable;
>  	bool			mon_capable;

Also we should probably rename alloc_capable and mon_capable to
alloc_supported and mon_supported respectively. We dont have an option to
enable and disable these feature. If it is supported, it is always supported.

Thanks
Babu
