Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1713D9303
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 18:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhG1QRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 12:17:30 -0400
Received: from foss.arm.com ([217.140.110.172]:60102 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229607AbhG1QRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 12:17:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1ECE6D;
        Wed, 28 Jul 2021 09:17:10 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96B9D3F70D;
        Wed, 28 Jul 2021 09:17:08 -0700 (PDT)
Subject: Re: [PATCH v6 01/24] x86/resctrl: Split struct rdt_resource
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, bobo.shaobowang@huawei.com
References: <20210715173043.14222-1-james.morse@arm.com>
 <20210715173043.14222-2-james.morse@arm.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <76911cf6-799e-c8ae-b5c9-51d260d87402@arm.com>
Date:   Wed, 28 Jul 2021 17:17:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210715173043.14222-2-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 15/07/2021 18:30, James Morse wrote:
> resctrl is the defacto Linux ABI for SoC resource partitioning features.
> 
> To support it on another architecture, it needs to be abstracted from
> the features provided by Intel RDT and AMD PQoS, and moved to /fs/.
> struct rdt_resource contains a mix of architecture private details
> and properties of the filesystem interface user-space uses.
> 
> Start by splitting struct rdt_resource, into an architecture private
> 'hw' struct, which contains the common resctrl structure that would be
> used by any architecture.

> The foreach helpers are most commonly used by
> the filesystem code, and should return the common resctrl structure.
> for_each_rdt_resource() is changed to walk the common structure in its
> parent arch private structure.

[...]

> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 6a5f60a37219..88d71c889328 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h

> @@ -524,33 +439,42 @@ enum {
>  	RDT_NUM_RESOURCES,
>  };
>  
> +static inline struct rdt_resource *resctrl_inc(struct rdt_resource *res)
> +{
> +	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(res);
> +
> +	hw_res++;
> +	return &hw_res->r_resctrl;
> +}
> +
> +/*
> + * To return the common struct rdt_resource, which is contained in struct
> + * rdt_hw_resource, walk the resctrl member of struct rdt_hw_resource.
> + * This makes the limit the resctrl member past the end of the array.
> + */
>  #define for_each_rdt_resource(r)					      \
> -	for (r = rdt_resources_all; r < rdt_resources_all + RDT_NUM_RESOURCES;\
> -	     r++)
> +	for (r = &rdt_resources_all[0].r_resctrl;			      \
> +	     r < &rdt_resources_all[RDT_NUM_RESOURCES].r_resctrl;	      \
> +	     r = resctrl_inc(r))

Kbuild robot reports UBSAN doesn't like this, presumably the dastardly compiler has gone
and generated some accesses. Easily fixed, (but now looks less like the original)

v6's branch gets a patch on top, I'll squash this into v7:
----%<----
@@ -441,11 +441,10 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
 /*
  * To return the common struct rdt_resource, which is contained in struct
  * rdt_hw_resource, walk the resctrl member of struct rdt_hw_resource.
- * This makes the limit the resctrl member past the end of the array.
  */
 #define for_each_rdt_resource(r)                                             \
        for (r = &rdt_resources_all[0].r_resctrl;                             \
-            r < &rdt_resources_all[RDT_NUM_RESOURCES].r_resctrl;             \
+            r <= &rdt_resources_all[RDT_NUM_RESOURCES - 1].r_resctrl;        \
             r = resctrl_inc(r))

 #define for_each_capable_rdt_resource(r)                                     \
----%<----


Thanks,

James
