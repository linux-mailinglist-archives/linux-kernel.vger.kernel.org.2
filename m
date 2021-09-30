Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A25141DE26
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 17:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347212AbhI3P5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 11:57:34 -0400
Received: from mga04.intel.com ([192.55.52.120]:58861 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347152AbhI3P5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 11:57:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="223329889"
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="223329889"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 08:55:48 -0700
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="457485570"
Received: from kjepstei-mobl.amr.corp.intel.com (HELO ldmartin-desk2) ([10.212.192.243])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 08:55:47 -0700
Date:   Thu, 30 Sep 2021 08:55:47 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     intel-gfx <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] Move IS_CONFIG_NONZERO() to kconfig.h
Message-ID: <20210930155547.rtz6pdae42gqvm6p@ldmartin-desk2>
X-Patchwork-Hint: comment
References: <20210929183357.1490204-1-lucas.demarchi@intel.com>
 <20210929183357.1490204-4-lucas.demarchi@intel.com>
 <CAK7LNAQ765CBjg83Kpt8XdOjqPw8Xuv--_bcTvd3udZ=tsgMdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAK7LNAQ765CBjg83Kpt8XdOjqPw8Xuv--_bcTvd3udZ=tsgMdA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 11:01:36PM +0900, Masahiro Yamada wrote:
>On Thu, Sep 30, 2021 at 3:34 AM Lucas De Marchi
><lucas.demarchi@intel.com> wrote:
>>
>> The check for config value doesn't really belong to i915_utils.h - we
>> are trying to eliminate that utils helper and share them when possible
>> with other drivers and subsystems.
>>
>> Rationale for having such macro is in commit
>> babaab2f4738 ("drm/i915: Encapsulate kconfig constant values inside boolean predicates")
>> whereas later it is improved to not break the build if used with
>> undefined configs. The caveat is detailed in the documentation: unlike
>> IS_ENABLED(): it's not preprocessor-only logic so can't be used for
>> things like `#if IS_CONFIG_NONZERO(...)`
>>
>> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>
>
>Hypothetical "it would be nice to have ..." is really unneeded.
>
>       if (context && CONFIG_DRM_I915_FENCE_TIMEOUT > 0)
>                     return
>msecs_to_jiffies_timeout(CONFIG_DRM_I915_FENCE_TIMEOUT);
>
>
>is enough, and much cleaner.
>
>
>
>This warning is shown only when a constant is used
>together with '&&'.
>
>Most of IS_ACTIVE can go away.
>
>Given that, there are not many places where the IS_ACTIVE macro
>is useful, even in the i915 driver.
>
>For a few sources of the warnings,
>replacing it with  != 0 or > 0 is just fine.

humn... maybe. Let me do a conversion in that direction and see what is
the outcome.

My original intention was to make IS_ENABLED() even uglier to cover the
int case, but after some tries it seems impossible to do on preprocessor
context, so I thought maybe it would be ok as a separate one.

>
>Of course, such an ugly macro is not worth being moved to <linux/kconfig.h>

if we don't handle the undefined case and only worry about encapsulating
it inside a boolean predicate, the macro would be very simple. Would
that be worth having in kconfig.h maybe?


thanks
Lucas De Marchi
