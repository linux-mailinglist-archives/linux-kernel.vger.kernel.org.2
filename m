Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A223A8821
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhFORyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:54:06 -0400
Received: from mail-mw2nam12on2058.outbound.protection.outlook.com ([40.107.244.58]:26209
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231627AbhFORyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:54:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKXxKWgj5nmRra0G9n7aM2vce8G5Epi9JRW9COAYiZ2++R/BxRMhQydUJxJqMnkrZI61sEVE5YaLgUr8g2DtNlQ3CezsKLECJEXoTZQI1M4hoNE5bz+LpkM2itUEqIGIYSj27y965GJQCsIkWRcGV+qZ0qT/iuhJAO1L7IP4urWdI9A7ElO1HM0LI5RWGvVyknUw2mbt97ZhWfBAisNih4Dq6BcWLxTX3wA9WrXrFUHShENX9/6NbKIDmBgP0D2vClvoAqJ44DGYqlMXF1sYjuZ65pf9+R4UV98b6KEh1oSgyIsG7EZIaIvvsj1q8abGTw5VMQ9eQgYSFKNcUzCIDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xS6B59d7hgEFv2fqeFN/L5Q3+zmqfO9mVM31FFk09DA=;
 b=D0HC/QMkgJZtqAvjIrH92pXGq5JS6aCLWUvQ1/XsJK+i3Gg1sSSoaH+dkWevS03o5bww7ssMdN5ghg+fKkjuWuI8aI248Fd6d10RKLeEFrEkHEzpcuKkWVe9/QBzxmWqy21NvdJ4Mo5qJKbr0ZNVYEpuz9gxrrw5K5jQBqaCzwiM7r3zrAUWVTGITzIJCjZ+8opOZLtl3cYGPsk94FxeqVRWo+jIMQMekGhAtMCduUYmihiAKnaClsnSYQP19ZMrBdTqD528xFLg5CrguVWgXoVEdiT+q9zzAqm8YJc0GmE3MNHYBI6ewwnaWQoejtHcE7tQvy8i871QQ/vbe/KklQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xS6B59d7hgEFv2fqeFN/L5Q3+zmqfO9mVM31FFk09DA=;
 b=pZH8FQRESXzAefk4CU520UGoar3VUphEotxK6e4gW1p4piUwxbz9bezY/4MLvBiVvdM4E8UBpGrZfi6sqa9TJs6Rkb6/l3zRFENuf0QBA5tO+/O/nOEWcoAejzPmrmSks8u385qow+ZaJNuHmRYVQjWDhFk8RuvjPZkX4gu+4fc=
Authentication-Results: marvell.com; dkim=none (message not signed)
 header.d=none;marvell.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MWHPR1201MB0256.namprd12.prod.outlook.com (2603:10b6:301:53::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Tue, 15 Jun
 2021 17:51:57 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::bdeb:29f3:2bf1:bfa7]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::bdeb:29f3:2bf1:bfa7%8]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 17:51:57 +0000
From:   Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v4 03/24] x86/resctrl: Add a separate schema list for
 resctrl
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
 <20210614200941.12383-4-james.morse@arm.com>
Message-ID: <8626fde4-ed22-be80-e36f-45a16e5eceaa@amd.com>
Date:   Tue, 15 Jun 2021 12:51:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210614200941.12383-4-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SA9P223CA0029.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::34) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.136] (165.204.77.1) by SA9P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Tue, 15 Jun 2021 17:51:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62840cf4-97e0-42d2-8428-08d930264515
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0256:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB025666FBD12A87451E66109C95309@MWHPR1201MB0256.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:421;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mQ4ETwKTyrDL/BXA6qHZDYbv5awaWzmSvy5D5AlAb0xMJc5xJgJuWaZDjOBczv0HmfVMOYNTXpyEuRoKrrIJ/f/QKh2dkihsP/jPrwOfKMwhQ4UN8hKFopLBLC8o1pkX7QfyXEjM3i8SCdHNHMr2eVV7Vdha5ny258dL2od1g71HyGNuPdeZJDz5aL/4G7QGwuWKHSvp8AIYtgwjUIDaWrasjtc+foA2sEzop6/vFwEG+KVcq3k/Oa7L1yFaAh7CrZpfsf6IaiUFeNZskIGcVpWh44y1z4iGKnsTHriWdU/j4QKm2Cv1maW2XAsY8q9TAoFGJ6oo1Nj68tNAXKcu3uSmi//AdcvrHQ3BZP5bChkSdqUyiwrvFUqFtxh6P3I4pUfJdZmzEBl6nwv6p3nanx4LBCw8GMF9KO2BrFxm9mM1ZVG1y8W0GyWQYJT/JDNwtrbXQmpCcISUy8mlC86B7SCWWyXq784Rn+TxMJFdZbTwjmf+uVQ1y0eLoaq5HmFRsq0Yuo1w9qNQALOk3L274gmy/6+Hbj80URkLc19JF1R7eSQj3+4desjDmbvd6SvF1b4xslvR/fL1+KjGHcuRKKg6eY7HyH9fnzhh6tkRXVEzVH+5bjNRsHaQ1Wtdfeu0QtkMP3yMNGKNnSZxKjuZoPMdHBfdRcK10I/I3VUOJ72RuMchPGffgmQ7NiO33nVJ2lyMTID+GAI3/Ds0WHYCJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(44832011)(4326008)(186003)(66476007)(16526019)(2616005)(956004)(31686004)(54906003)(66946007)(66556008)(16576012)(316002)(2906002)(8676002)(478600001)(38350700002)(38100700002)(26005)(6486002)(53546011)(8936002)(86362001)(52116002)(36756003)(5660300002)(83380400001)(31696002)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clpBdUJhRXBrLzRUTHYxWWNyY1dsU1RucDQ1UURUd1BhVVBJZG54U2RUbHQ2?=
 =?utf-8?B?STVjVXcxRGRrSTl4TnB3eVplYlRBZEdIdkNMUHlINXBXbnVDbUZhZmt2YW1a?=
 =?utf-8?B?bGtpL3FNdWVmdlREanoyQ3ZVcEtDbXorUmlXUis2T2hjUDg2ZXZrWHJYbnQr?=
 =?utf-8?B?T0V2Qjhicm5xUzN0b0JTU2NTcTRhY1o1cnlDMXBBZ0hvUjI2aDI4MlpkNnJ5?=
 =?utf-8?B?anNFaFRRMnZldkxtTGV0T0g0R1FJR1llSnB5cVdrTHlUbjBpNml3RnE2ZTZK?=
 =?utf-8?B?SkU4S1lVMFRlejFvWFZDZXpRSmlWa24wd290T3BpM3hzUk1Pc0w4djBxWmhE?=
 =?utf-8?B?TTErYmtHUGV0WGdRekRnV1Q5MXQzdlJFaE13Z0ZVa01pWnFMdWFpRU5aK2lT?=
 =?utf-8?B?OFlrQXJhWnlmZEovWWJOcnJzZ2xXYUU3cGh2eDBKeEI0R1hsUHJxcDdNc2FU?=
 =?utf-8?B?eTIrcGJMYStpczdYSCtQNFhYZ0FhdmVPZitMSFE2bW9UMWwrUXdOTXlNTm0v?=
 =?utf-8?B?V0YrRWRVaUZaUW9TTExqcE1XYW5qRGIrZTBYa1V3dHZqdCt6eE1XUVluV3pH?=
 =?utf-8?B?Uno5Uzd2Q2Foalo2ZHlwTTREdGs4VlJzWjEralErUStRK0gxUFk1NzdWd3Jw?=
 =?utf-8?B?WmZzSGVSUXZIZkNhNEVRM3czM2MxRWhGNHJlcUxxTFZiZHlmbDdJMXJzNEdD?=
 =?utf-8?B?R1h3UkdMekI3bTBWNDJNV1F3eFFnY1R6K0VtUlpLa0dwVkpTRjdJbmJpcUNj?=
 =?utf-8?B?QVpYcFBBcUZpWm1PaVFGdGw5dEhaR010SHVxa3BaeFVZbWI5REVESlhkQ2dT?=
 =?utf-8?B?cSs3TE13SFE3NGxIK3diWUd0NS9wcmJaVUdhcDc0VWwrSHV2ekdTUnBPb1Jr?=
 =?utf-8?B?U3NrYVZTYWZ6b2IyaVQ1UE4xNGpiRitBSmtXS01MZzh3MWxabkxSbnVyVkRz?=
 =?utf-8?B?K3llKy9kbGRoUDFkUHlFZE1aa2ZYYmE3Qit4cjdHMk1LS0ZrZ3FUdW9YSkI3?=
 =?utf-8?B?ZnVVRUpVZXlnSkd1UHZudG5qOUhUTVFvb1RWTllXVzE4Qjk3cGJ2SXhib1ps?=
 =?utf-8?B?YzROaEZ0SG5uazUrM054R3lTRXFTeDJUcnpreXBacytaYWwwRWRSeE8rbk8r?=
 =?utf-8?B?dzNrYzJYTWtvc1puc1piUUxFVC82bHkwcG1mOUJoQWlNeG0wT0JrbGdkNW1C?=
 =?utf-8?B?UWU0Y1ZneW9xdVdRRnpKYmt0QmdmSVRaNHd6QmpHQi9nRllCQUxQTjJCMnpX?=
 =?utf-8?B?a01FSnZxYy9PcGpQSC91dnFLYWRGb3NvWkFaSUR4cGtpZ3BzMUhJWERoZGx3?=
 =?utf-8?B?eXZvZUcxK3ZmRUZaaCtYenpXeE0wVE9CRWdIVHZSdXpBWW5zWHpja3pQbTFC?=
 =?utf-8?B?Tm1nT1VNYTl4eVJtMXJ1WlZISEhPYkpUMU82enBaS1p0Um9OTENFYjc2a0dR?=
 =?utf-8?B?UWdwQXdUcmtLcUlONElrRGF1VllsOVZWSGpQU0drUVk1NjJHV1FYQkNjVGRn?=
 =?utf-8?B?c1hDaFRGa3hjVklMY2JKVTg0a0JBWlVEZ2Z5UHhJR2lDZHNCamZnY1lNbjlh?=
 =?utf-8?B?WmRoWEdlWEQvMlpoQzBwdUhqaGptNmwzSzBDbmtoTWlYTUpDWWwyVVYvVDho?=
 =?utf-8?B?Z0M5L3ZjNEZYRldOMmJEZUJHa09zNjR3VHBnem1aVGs4enlYVDZzcE1yZGhM?=
 =?utf-8?B?UFJzM2dSbUQwUVhiOUJVMHVGZGxZTjdOOWNOTDd4TjN5R2NoWDQ4bTh3dy81?=
 =?utf-8?Q?Z9IVqRtUDYWMZ+9it/xluL6lePdHTbH/fZRaczz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62840cf4-97e0-42d2-8428-08d930264515
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 17:51:57.6828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MyOVUhq/QHzj3EQTREC2X1k/8cgKGADE5FuxIPPpA1kTL1gGJEmyGZ/+r5mb9JFQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/14/21 3:09 PM, James Morse wrote:
> Resctrl exposes schemata to user-space, which allow the control values
> to be specified for a group of tasks.
> 
> User-visible properties of the interface, (such as the schemata names
> and how the values are parsed) are rooted in a struct provided by the
> architecture code. (struct rdt_hw_resource). Once a second architecture
> uses resctrl, this would allow user-visible properties to diverge
> between architectures.
> 
> These properties should come from the resctrl code that will be common
> to all architectures. Resctrl has no per-schema structure, only struct
> rdt_{hw_,}resource. Create a struct resctrl_schema to hold the
> rdt_resource. Before a second architecture can be supported, this
> structure will also need to hold the schema name visible to user-space
> and the type of configuration values for resctrl.
> 
> Reviewed-by: Jamie Iles <jamie@nuviainc.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v3:
>  * Fixed a spelling mistake, removed a space.
> 
> Changes since v2:
>  * Expanded comments.
>  * Shuffled commit message,
> 
> Changes since v1:
>  * Renamed resctrl_all_schema list
>  * Used schemata_list as a prefix to make these easier to search for
>  * Added kerneldoc string
>  * Removed 'pending configuration' reference in commit message
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |  1 +
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 43 +++++++++++++++++++++++++-
>  include/linux/resctrl.h                | 11 +++++++
>  3 files changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 235cf621c878..f6790d03f056 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -106,6 +106,7 @@ extern unsigned int resctrl_cqm_threshold;
>  extern bool rdt_alloc_capable;
>  extern bool rdt_mon_capable;
>  extern unsigned int rdt_mon_features;
> +extern struct list_head resctrl_schema_all;
>  
>  enum rdt_group_type {
>  	RDTCTRL_GROUP = 0,
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 9a8665c8ab89..14ea1212f476 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -39,6 +39,9 @@ static struct kernfs_root *rdt_root;
>  struct rdtgroup rdtgroup_default;
>  LIST_HEAD(rdt_all_groups);
>  
> +/* list of entries for the schemata file */
> +LIST_HEAD(resctrl_schema_all);
> +
>  /* Kernel fs node for "info" directory under root */
>  static struct kernfs_node *kn_info;
>  
> @@ -2109,6 +2112,35 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)
>  	return ret;
>  }
>  
> +static int schemata_list_create(void)
> +{
> +	struct resctrl_schema *s;
> +	struct rdt_resource *r;
> +
> +	for_each_alloc_enabled_rdt_resource(r) {
> +		s = kzalloc(sizeof(*s), GFP_KERNEL);
> +		if (!s)
> +			return -ENOMEM;
> +
> +		s->res = r;
> +
> +		INIT_LIST_HEAD(&s->list);
> +		list_add(&s->list, &resctrl_schema_all);
> +	}
> +
> +	return 0;
> +}
> +
> +static void schemata_list_destroy(void)
> +{
> +	struct resctrl_schema *s, *tmp;
> +
> +	list_for_each_entry_safe(s, tmp, &resctrl_schema_all, list) {
> +		list_del(&s->list);
> +		kfree(s);
> +	}
> +}
> +
>  static int rdt_get_tree(struct fs_context *fc)
>  {
>  	struct rdt_fs_context *ctx = rdt_fc2context(fc);
> @@ -2130,11 +2162,17 @@ static int rdt_get_tree(struct fs_context *fc)
>  	if (ret < 0)
>  		goto out_cdp;
>  
> +	ret = schemata_list_create();
> +	if (ret) {
> +		schemata_list_destroy();
> +		goto out_mba;
> +	}
> +
>  	closid_init();
>  
>  	ret = rdtgroup_create_info_dir(rdtgroup_default.kn);
>  	if (ret < 0)
> -		goto out_mba;
> +		goto out_schemata_free;
>  
>  	if (rdt_mon_capable) {
>  		ret = mongroup_create_dir(rdtgroup_default.kn,
> @@ -2184,6 +2222,8 @@ static int rdt_get_tree(struct fs_context *fc)
>  		kernfs_remove(kn_mongrp);
>  out_info:
>  	kernfs_remove(kn_info);
> +out_schemata_free:
> +	schemata_list_destroy();
>  out_mba:
>  	if (ctx->enable_mba_mbps)
>  		set_mba_sc(false);
> @@ -2425,6 +2465,7 @@ static void rdt_kill_sb(struct super_block *sb)
>  	rmdir_all_sub();
>  	rdt_pseudo_lock_release();
>  	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
> +	schemata_list_destroy();
>  	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
>  	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
>  	static_branch_disable_cpuslocked(&rdt_enable_key);
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index be6f5df78e31..425e7913dc8d 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -154,4 +154,15 @@ struct rdt_resource {
>  
>  };
>  
> +/**
> + * struct resctrl_schema - configuration abilities of a resource presented to
> + *			   user-space
> + * @list:	Member of resctrl_schema_all.
> + * @res:	The resource structure exported by the architecture to describe
> + *		the hardware that is configured by this schema.
> + */
> +struct resctrl_schema {
> +	struct list_head		list;
> +	struct rdt_resource		*res;

It will be better to be consistent with the naming.
        struct rdt_resource		*resctrl;

> +};
>  #endif /* _RESCTRL_H */
> 
