Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C686B421701
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 21:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236336AbhJDTIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 15:08:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:46637 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233226AbhJDTIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 15:08:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="206367250"
X-IronPort-AV: E=Sophos;i="5.85,346,1624345200"; 
   d="scan'208";a="206367250"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 10:44:18 -0700
X-IronPort-AV: E=Sophos;i="5.85,346,1624345200"; 
   d="scan'208";a="477275904"
Received: from pmittal1-mobl.gar.corp.intel.com (HELO localhost) ([10.251.223.27])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 10:43:55 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v2] drm/i915: Clean up disabled warnings
In-Reply-To: <20210914194944.4004260-1-nathan@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20210914194944.4004260-1-nathan@kernel.org>
Date:   Mon, 04 Oct 2021 20:43:41 +0300
Message-ID: <87v92c1y9e.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2021, Nathan Chancellor <nathan@kernel.org> wrote:
> i915 enables a wider set of warnings with '-Wall -Wextra' then disables
> several with cc-disable-warning. If an unknown flag gets added to
> KBUILD_CFLAGS when building with clang, all subsequent calls to
> cc-{disable-warning,option} will fail, meaning that all of these
> warnings do not get disabled [1].
>
> A separate series will address the root cause of the issue by not adding
> these flags when building with clang [2]; however, the symptom of these
> extra warnings appearing can be addressed separately by just removing
> the calls to cc-disable-warning, which makes the build ever so slightly
> faster because the compiler does not need to be called as much before
> building.
>
> The following warnings are supported by GCC 4.9 and clang 10.0.1, which
> are the minimum supported versions of these compilers so the call to
> cc-disable-warning is not necessary. Masahiro cleaned this up for the
> reset of the kernel in commit 4c8dd95a723d ("kbuild: add some extra
> warning flags unconditionally").
>
> * -Wmissing-field-initializers
> * -Wsign-compare
> * -Wtype-limits
> * -Wunused-parameter
>
> -Wunused-but-set-variable was implemented in clang 13.0.0 and
> -Wframe-address was implemented in clang 12.0.0 so the
> cc-disable-warning calls are kept for these two warnings.
>
> Lastly, -Winitializer-overrides is clang's version of -Woverride-init,
> which is disabled for the specific files that are problematic. clang
> added a compatibility alias in clang 8.0.0 so -Winitializer-overrides
> can be removed.
>
> [1]: https://lore.kernel.org/r/202108210311.CBtcgoUL-lkp@intel.com/
> [2]: https://lore.kernel.org/r/20210824022640.2170859-1-nathan@kernel.org/
>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks for the patch, and sorry for the delay.

Exceptionally pushed to drm-intel-gt-next instead of drm-intel-next
because some of the dependencies such as 43192617f781 ("drm/i915: Enable
-Wsometimes-uninitialized") were queued there too.


BR,
Jani.


> ---
>
> v1 -> v2: https://lore.kernel.org/r/20210824232237.2085342-1-nathan@kernel.org/
>
> * Rebase on drm-intel-gt-next now that the prerequisite patch series has
>   been merged: https://lore.kernel.org/r/87wnnj13t5.fsf@intel.com/
>
> * Add Nick's reviewed-by tag.
>
>  drivers/gpu/drm/i915/Makefile | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
> index c584188aa15a..fd99374583d5 100644
> --- a/drivers/gpu/drm/i915/Makefile
> +++ b/drivers/gpu/drm/i915/Makefile
> @@ -13,13 +13,11 @@
>  # will most likely get a sudden build breakage... Hopefully we will fix
>  # new warnings before CI updates!
>  subdir-ccflags-y := -Wall -Wextra
> -subdir-ccflags-y += $(call cc-disable-warning, unused-parameter)
> -subdir-ccflags-y += $(call cc-disable-warning, type-limits)
> -subdir-ccflags-y += $(call cc-disable-warning, missing-field-initializers)
> +subdir-ccflags-y += -Wno-unused-parameter
> +subdir-ccflags-y += -Wno-type-limits
> +subdir-ccflags-y += -Wno-missing-field-initializers
> +subdir-ccflags-y += -Wno-sign-compare
>  subdir-ccflags-y += $(call cc-disable-warning, unused-but-set-variable)
> -# clang warnings
> -subdir-ccflags-y += $(call cc-disable-warning, sign-compare)
> -subdir-ccflags-y += $(call cc-disable-warning, initializer-overrides)
>  subdir-ccflags-y += $(call cc-disable-warning, frame-address)
>  subdir-ccflags-$(CONFIG_DRM_I915_WERROR) += -Werror
>  
>
> base-commit: 43192617f7816bb74584c1df06f57363afd15337

-- 
Jani Nikula, Intel Open Source Graphics Center
