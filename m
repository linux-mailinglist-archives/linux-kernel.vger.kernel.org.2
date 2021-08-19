Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FB23F1BCF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 16:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240587AbhHSOo1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 Aug 2021 10:44:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:36017 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240502AbhHSOo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 10:44:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="213446890"
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="213446890"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 07:43:49 -0700
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="522455413"
Received: from pbhadrir-mobl.gar.corp.intel.com (HELO localhost) ([10.251.211.137])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 07:43:46 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20210819082929.GB13928@zhen-hp.sh.intel.com>
References: <20210727121224.GA2145868@nvidia.com> <20210728175925.GU1721383@nvidia.com> <20210729072022.GB31896@lst.de> <20210803094315.GF13928@zhen-hp.sh.intel.com> <20210803143058.GA1721383@nvidia.com> <20210804052606.GG13928@zhen-hp.sh.intel.com> <20210816173458.GA9183@lst.de> <20210817010851.GW13928@zhen-hp.sh.intel.com> <20210817052203.GX13928@zhen-hp.sh.intel.com> <20210819082929.GB13928@zhen-hp.sh.intel.com>
From:   Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: Re: refactor the i915 GVT support
To:     Christoph Hellwig <hch@lst.de>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "Wang, Zhi A" <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Message-ID: <162938422376.18233.1867777087725408939@jlahtine-mobl.ger.corp.intel.com>
User-Agent: alot/0.8.1
Date:   Thu, 19 Aug 2021 17:43:43 +0300
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Zhenyu Wang (2021-08-19 11:29:29)
> On 2021.08.17 13:22:03 +0800, Zhenyu Wang wrote:
> > > On 2021.08.16 19:34:58 +0200, Christoph Hellwig wrote:
> > > > Any updates on this?  I'd really hate to miss this merge window.
> > > 
> > > I'm still waiting for our validation team's report on this. I'm afraid
> > > it might be missing for next version as i915 merge window is mostly
> > > till rc5...and for any change outside of gvt, it still needs to be
> > > acked by i915 maintainers.
> > 
> > Looks our validation team did have problem against recent i915 change.
> > If you like to try, we have a gvt-staging branch on
> > https://github.com/intel/gvt-linux which is generated against drm-tip
> > with gvt changes for testing, currently it's broken.
> > 
> > One issue is with i915 export that intel_context_unpin has been
> > changed into static inline function. Another is that intel_gvt.c
> > should be part of i915 for gvt interface instead of depending on KVMGT
> > config.
> 
> I'm working on below patch to resolve this. But I met a weird issue in
> case when building i915 as module and also kvmgt module, it caused
> busy wait on request_module("kvmgt") when boot, it doesn't happen if
> building i915 into kernel. I'm not sure what could be the reason?
> 
> > But the problem I see is that after moving gvt device model (gvt/*.c
> > except kvmgt.c) into kvmgt module, we'll have issue with initial mmio
> > state which current gvt relies on, that is in design supposed to get
> > initial HW state before i915 driver has taken any operation.

As mentioned in some past discussions, I think it would be best rely on
golden MMIO located in /lib/firmware or elsewhere. This way we will better
isolate the guest system from host system updates/changes.

This should also hopefully allow enabling kvmgt module after i915 has
already loaded, as the initialization would not be conditional to
capture the MMIO.

Regards, Joonas

> > Before
> > we can ensure that, I think we may only remove MPT part first but
> > still keep gvt device model as part of i915 with config. I'll try to
> > split that out.
> 
> Sorry I misread the code that as we always request kvmgt module when
> gvt init, so it should still apply original method that this isn't a
> problem. Our current validation result has shown no regression as well.
> 
> ---8<---
> From 58ff84572f1a0f9d79ca1d7ec0cff5ecbe78d280 Mon Sep 17 00:00:00 2001
> From: Zhenyu Wang <zhenyuw@linux.intel.com>
> Date: Thu, 19 Aug 2021 16:36:33 +0800
> Subject: [PATCH] TESTONLY:drm/i915/gvt: potential fix for refactor against
>  current tip
> 
> ---
>  drivers/gpu/drm/i915/Makefile           | 4 +++-
>  drivers/gpu/drm/i915/gt/intel_context.c | 5 +++++
>  drivers/gpu/drm/i915/gt/intel_context.h | 3 ++-
>  drivers/gpu/drm/i915/i915_trace.h       | 1 +
>  4 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
> index c4f953837f72..2248574428a1 100644
> --- a/drivers/gpu/drm/i915/Makefile
> +++ b/drivers/gpu/drm/i915/Makefile
> @@ -296,7 +296,9 @@ i915-$(CONFIG_DRM_I915_SELFTEST) += \
>  
>  # virtual gpu code
>  i915-y += i915_vgpu.o
> -i915-$(CONFIG_DRM_I915_GVT_KVMGT) += intel_gvt.o
> +ifneq ($(CONFIG_DRM_I915_GVT_KVMGT),)
> +i915-y += intel_gvt.o
> +endif
>  
>  kvmgt-y += gvt/kvmgt.o \
>         gvt/gvt.o \
> diff --git a/drivers/gpu/drm/i915/gt/intel_context.c b/drivers/gpu/drm/i915/gt/intel_context.c
> index 745e84c72c90..20e7522fed84 100644
> --- a/drivers/gpu/drm/i915/gt/intel_context.c
> +++ b/drivers/gpu/drm/i915/gt/intel_context.c
> @@ -328,6 +328,11 @@ void __intel_context_do_unpin(struct intel_context *ce, int sub)
>         intel_context_put(ce);
>  }
>  
> +void intel_context_unpin(struct intel_context *ce)
> +{
> +       _intel_context_unpin(ce);
> +}
> +
>  static void __intel_context_retire(struct i915_active *active)
>  {
>         struct intel_context *ce = container_of(active, typeof(*ce), active);
> diff --git a/drivers/gpu/drm/i915/gt/intel_context.h b/drivers/gpu/drm/i915/gt/intel_context.h
> index c41098950746..f942cbf6300a 100644
> --- a/drivers/gpu/drm/i915/gt/intel_context.h
> +++ b/drivers/gpu/drm/i915/gt/intel_context.h
> @@ -131,7 +131,7 @@ static inline void intel_context_sched_disable_unpin(struct intel_context *ce)
>         __intel_context_do_unpin(ce, 2);
>  }
>  
> -static inline void intel_context_unpin(struct intel_context *ce)
> +static inline void _intel_context_unpin(struct intel_context *ce)
>  {
>         if (!ce->ops->sched_disable) {
>                 __intel_context_do_unpin(ce, 1);
> @@ -150,6 +150,7 @@ static inline void intel_context_unpin(struct intel_context *ce)
>                 }
>         }
>  }
> +void intel_context_unpin(struct intel_context *ce);
>  
>  void intel_context_enter_engine(struct intel_context *ce);
>  void intel_context_exit_engine(struct intel_context *ce);
> diff --git a/drivers/gpu/drm/i915/i915_trace.h b/drivers/gpu/drm/i915/i915_trace.h
> index 806ad688274b..2c6a8bcef7c1 100644
> --- a/drivers/gpu/drm/i915/i915_trace.h
> +++ b/drivers/gpu/drm/i915/i915_trace.h
> @@ -17,6 +17,7 @@
>  
>  #undef TRACE_SYSTEM
>  #define TRACE_SYSTEM i915
> +#undef TRACE_INCLUDE_FILE
>  #define TRACE_INCLUDE_FILE i915_trace
>  
>  /* watermark/fifo updates */
> -- 
> 2.32.0
> ---8<---
> 
> 
