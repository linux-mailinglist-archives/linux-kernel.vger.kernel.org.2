Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA98141DDD8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 17:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345855AbhI3PpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 11:45:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:13607 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344638AbhI3Po7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 11:44:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="225255777"
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="225255777"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 08:43:16 -0700
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="709134016"
Received: from kjepstei-mobl.amr.corp.intel.com (HELO ldmartin-desk2) ([10.212.192.243])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 08:43:15 -0700
Date:   Thu, 30 Sep 2021 08:43:15 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Steven Price <steven.price@arm.com>
Cc:     intel-gfx@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        dri-devel@lists.freedesktop.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v2 2/3] drm/i915/utils: do not depend on config being
 defined
Message-ID: <20210930154315.xb43gowfhmxucsm4@ldmartin-desk2>
X-Patchwork-Hint: comment
References: <20210929183357.1490204-1-lucas.demarchi@intel.com>
 <20210929183357.1490204-3-lucas.demarchi@intel.com>
 <2dd723c8-6aed-857c-23f3-d0381fcb52c2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2dd723c8-6aed-857c-23f3-d0381fcb52c2@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 11:00:06AM +0100, Steven Price wrote:
>On 29/09/2021 19:33, Lucas De Marchi wrote:
>> Like the IS_ENABLED() counterpart, we can make IS_CONFIG_NONZERO() to
>> return the right thing when the config is not defined rather than a
>> build error, with the limitation that it can't be used on preprocessor
>> context.
>>
>> The trick here is that macro names can't start with a number or dash, so
>> we stringify the argument and check that the first char is a number != 0
>> (or starting with a dash to cover negative numbers). Except for -O0
>> builds the strings are all eliminated.
>>
>> Taking CONFIG_DRM_I915_REQUEST_TIMEOUT in
>> drivers/gpu/drm/i915/gem/i915_gem_context.c as example, we have the
>> following output of the preprocessor:
>>
>> old:
>>  if (((20000) != 0) &&
>> new:
>>  if (( ("20000"[0] > '0' && "20000"[0] < '9') || "20000"[0] == '-' ) &&
>>
>> New one looks worse, but is also eliminated from the object:
>>
>> $ size drivers/gpu/drm/i915/gem/i915_gem_context.o.*
>>    text    data     bss     dec     hex filename
>>   52021    1070     232   53323    d04b drivers/gpu/drm/i915/gem/i915_gem_context.o.new
>>   52021    1070     232   53323    d04b drivers/gpu/drm/i915/gem/i915_gem_context.o.old
>>
>> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>> ---
>>  drivers/gpu/drm/i915/i915_utils.h | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/i915/i915_utils.h b/drivers/gpu/drm/i915/i915_utils.h
>> index 02bbfa4d68d3..436ce612c46a 100644
>> --- a/drivers/gpu/drm/i915/i915_utils.h
>> +++ b/drivers/gpu/drm/i915/i915_utils.h
>> @@ -28,6 +28,7 @@
>>  #include <linux/list.h>
>>  #include <linux/overflow.h>
>>  #include <linux/sched.h>
>> +#include <linux/stringify.h>
>>  #include <linux/types.h>
>>  #include <linux/workqueue.h>
>>
>> @@ -469,6 +470,9 @@ static inline bool timer_expired(const struct timer_list *t)
>>   *
>>   * Returns 0 if @config is 0, 1 if set to any value.
>>   */
>> -#define IS_CONFIG_NONZERO(config) ((config) != 0)
>> +#define IS_CONFIG_NONZERO(config) (						\
>> +	(__stringify_1(config)[0] > '0' && __stringify_1(config)[0] < '9') ||	\
>
>Shouldn't this be "<= '9'". Otherwise numbers starting with a 9 are not
>"non zero".

yes! thanks for catching it. However from the other discussion it seems
we can either

a) just remove the macro, or
b) use the simpler version that doesn't cover undefined values

I will investigate those options.

Lucas De Marchi
