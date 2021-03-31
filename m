Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE4935099F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 23:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhCaVhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 17:37:48 -0400
Received: from mga14.intel.com ([192.55.52.115]:56835 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232334AbhCaVhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 17:37:20 -0400
IronPort-SDR: RMKIh9CS4t5RMKv/t3TQljh7eeZg6QlxeJAtFrGiyA/3aeAV3h2cYSOX2aOqelPNLubgib+cHI
 yVhNLJ/FaWzw==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="191575789"
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="191575789"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 14:37:18 -0700
IronPort-SDR: QmDIS1+fwBNyEMKnN3MrK7yloG9GdH12eXGd+Ro14jzg47vMrjax+Rply/NwPsheV8FWuYUz5B
 o68bP1526muw==
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="377432946"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.177.63]) ([10.212.177.63])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 14:37:18 -0700
Subject: Re: [PATCH v2 03/24] x86/resctrl: Add a separate schema list for
 resctrl
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>
References: <20210312175849.8327-1-james.morse@arm.com>
 <20210312175849.8327-4-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <a9b25df5-763d-d6f7-4038-21769900b84e@intel.com>
Date:   Wed, 31 Mar 2021 14:37:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210312175849.8327-4-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 3/12/2021 9:58 AM, James Morse wrote:
> To support multiple architectures, the resctrl code needs to be split
> into a 'fs' specific part in core code, and an arch-specific backend.
> 
> It should be difficult for the arch-specific backends to diverge,
> supporting slightly different ABIs for user-space. For example,
> generating, parsing and validating the schema configuration values
> should be done in what becomes the core code to prevent divergence.
> Today, the schema emerge from which entries in the rdt_resources_all

rdt_resources_all -> rdt_resources_all[]

> array the arch code has chosen to enable.

Throughout this series the commit messages do not have a consistent 
format. On top of this some commit messages uses terms like "Today" or 
"Previously" to document the context of the change ... sometimes in the 
middle of a commit message like here after the solution has been 
presented. In a long series like this it does make things increasingly 
harder to follow. There is an established commit message format in the 
x86 area that makes communicating changes much easier to do. Quoting 
Thomas ([1]) "A good structure is to explain the context, the problem 
and the solution in separate paragraphs and this order." Following this 
format makes changes much easier to communicate in a commit message and 
would definitely help this series during the next level of review by the 
contributors to [1].

[1] https://lore.kernel.org/lkml/20181107171149.165693799@linutronix.de/


> 
> Start by creating a struct resctrl_schema, which will eventually hold

This term "eventually" shows up a lot in the commit messages of this 
series and causing some trouble because sometimes what it refers to is 
done in this series but sometimes what it refers to is _not_ done in 
this series. For example, the changes mentioned here are indeed made in 
this series but the changes mentioned in patch 6 as "eventually" are 
not. This concerns me about how many gaps are created by these changes.

> the name and type of configuration values for resctrl.

The future members are mentioned but the one introduced here and why is not.

...

> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 8c29304d3e01..73a695e7096d 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -39,6 +39,9 @@ static struct kernfs_root *rdt_root;
>   struct rdtgroup rdtgroup_default;
>   LIST_HEAD(rdt_all_groups);
>   
> +/* list of entries for the schemata file */
> +LIST_HEAD(resctrl_schema_all);
> +
>   /* Kernel fs node for "info" directory under root */
>   static struct kernfs_node *kn_info;
>   
> @@ -2109,6 +2112,35 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)
>   	return ret;
>   }
>   
> +static int schemata_list_create(void)
> +{
> +	struct rdt_resource *r;
> +	struct resctrl_schema *s;

Please maintain reverse fir tree format.

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

...

> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index be6f5df78e31..092ff0c13b9b 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -154,4 +154,13 @@ struct rdt_resource {
>   
>   };
>   
> +/**
> + * struct resctrl_schema - configuration abilities of a resource presented to user-space
> + * @list:	Member of resctrl's schema list
> + * @res:	The rdt_resource for this entry

Could this description be improved? It merely states what can be seen 
from the code.

Thank you

Reinette
