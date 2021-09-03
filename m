Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1703FFEAA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 13:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242903AbhICLIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 07:08:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:21661 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233284AbhICLIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 07:08:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="216249714"
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="216249714"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 04:07:14 -0700
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="500314109"
Received: from ojcasey-mobl.ger.corp.intel.com (HELO [10.213.195.251]) ([10.213.195.251])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 04:07:12 -0700
Subject: Re: [Intel-gfx] [PATCH v7 3/8] i915/gvt: use
 DEFINE_DYNAMIC_DEBUG_CATEGORIES to create "gvt:core:" etc categories
To:     Jim Cromie <jim.cromie@gmail.com>, jbaron@akamai.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
References: <20210831202133.2165222-1-jim.cromie@gmail.com>
 <20210831202133.2165222-4-jim.cromie@gmail.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
Message-ID: <9fe5e962-e65e-6844-269a-058cce944a89@linux.intel.com>
Date:   Fri, 3 Sep 2021 12:07:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210831202133.2165222-4-jim.cromie@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 31/08/2021 21:21, Jim Cromie wrote:
> The gvt component of this driver has ~120 pr_debugs, in 9 categories
> quite similar to those in DRM.  Following the interface model of
> drm.debug, add a parameter to map bits to these categorizations.
> 
> DEFINE_DYNAMIC_DEBUG_CATEGORIES(debug_gvt, __gvt_debug,
> 	"dyndbg bitmap desc",
> 	{ "gvt:cmd: ",  "command processing" },
> 	{ "gvt:core: ", "core help" },
> 	{ "gvt:dpy: ",  "display help" },
> 	{ "gvt:el: ",   "help" },
> 	{ "gvt:irq: ",  "help" },
> 	{ "gvt:mm: ",   "help" },
> 	{ "gvt:mmio: ", "help" },
> 	{ "gvt:render: ", "help" },
> 	{ "gvt:sched: " "help" });
> 
> The actual patch has a few details different, cmd_help() macro emits
> the initialization construct.
> 
> if CONFIG_DRM_USE_DYNAMIC_DEBUG, then -DDYNAMIC_DEBUG_MODULE is added
> cflags, by gvt/Makefile.
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
> v5:
> . static decl of vector of bit->class descriptors - Emil.V
> . relocate gvt-makefile chunk from elsewhere
> v7:
> . move ccflags addition up to i915/Makefile from i915/gvt
> ---
>   drivers/gpu/drm/i915/Makefile      |  4 ++++
>   drivers/gpu/drm/i915/i915_params.c | 35 ++++++++++++++++++++++++++++++

Can this work if put under gvt/ or at least intel_gvt.h|c?

>   2 files changed, 39 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
> index 4f22cac1c49b..5a4e371a3ec2 100644
> --- a/drivers/gpu/drm/i915/Makefile
> +++ b/drivers/gpu/drm/i915/Makefile
> @@ -30,6 +30,10 @@ CFLAGS_display/intel_fbdev.o = $(call cc-disable-warning, override-init)
>   
>   subdir-ccflags-y += -I$(srctree)/$(src)
>   
> +#ifdef CONFIG_DRM_USE_DYNAMIC_DEBUG
> +ccflags-y += -DDYNAMIC_DEBUG_MODULE
> +#endif

Ignores whether CONFIG_DRM_I915_GVT is enabled or not?

> +
>   # Please keep these build lists sorted!
>   
>   # core driver code
> diff --git a/drivers/gpu/drm/i915/i915_params.c b/drivers/gpu/drm/i915/i915_params.c
> index e07f4cfea63a..e645e149485e 100644
> --- a/drivers/gpu/drm/i915/i915_params.c
> +++ b/drivers/gpu/drm/i915/i915_params.c
> @@ -265,3 +265,38 @@ void i915_params_free(struct i915_params *params)
>   	I915_PARAMS_FOR_EACH(FREE);
>   #undef FREE
>   }
> +
> +#ifdef CONFIG_DRM_USE_DYNAMIC_DEBUG
> +/* todo: needs DYNAMIC_DEBUG_MODULE in some cases */
> +
> +unsigned long __gvt_debug;
> +EXPORT_SYMBOL(__gvt_debug);
> +
> +#define _help(key)	"\t    \"" key "\"\t: help for " key "\n"
> +
> +#define I915_GVT_CATEGORIES(name) \
> +	" Enable debug output via /sys/module/i915/parameters/" #name	\
> +	", where each bit enables a debug category.\n"			\
> +	_help("gvt:cmd:")						\
> +	_help("gvt:core:")						\
> +	_help("gvt:dpy:")						\
> +	_help("gvt:el:")						\
> +	_help("gvt:irq:")						\
> +	_help("gvt:mm:")						\
> +	_help("gvt:mmio:")						\
> +	_help("gvt:render:")						\
> +	_help("gvt:sched:")
> +
> +DEFINE_DYNAMIC_DEBUG_CATEGORIES(debug_gvt, __gvt_debug,
> +				I915_GVT_CATEGORIES(debug_gvt),
> +				_DD_cat_("gvt:cmd:"),
> +				_DD_cat_("gvt:core:"),
> +				_DD_cat_("gvt:dpy:"),
> +				_DD_cat_("gvt:el:"),
> +				_DD_cat_("gvt:irq:"),
> +				_DD_cat_("gvt:mm:"),
> +				_DD_cat_("gvt:mmio:"),
> +				_DD_cat_("gvt:render:"),
> +				_DD_cat_("gvt:sched:"));
> +
> +#endif

So just the foundation - no actual use sites I mean? How would these be 
used from the code?

Regards,

Tvrtko
