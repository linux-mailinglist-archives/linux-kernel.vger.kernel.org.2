Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D247A458AC9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 09:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238875AbhKVIyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 03:54:44 -0500
Received: from mga02.intel.com ([134.134.136.20]:24637 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232786AbhKVIym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 03:54:42 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10175"; a="221970335"
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800"; 
   d="scan'208";a="221970335"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 00:51:36 -0800
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800"; 
   d="scan'208";a="537812292"
Received: from rmcdonax-mobl.ger.corp.intel.com (HELO localhost) ([10.252.19.217])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 00:51:32 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Alejandro Colomar <alx.manpages@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 16/20] linux/compiler.h, linux/array_size.h: Move
 __must_be_array() into <linux/array_size.h>
In-Reply-To: <CAK8P3a1XiyAnKPyd-pu1CXAjnsZ+nMdULSWWGasCYgiUU_WdjQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20211119113644.1600-1-alx.manpages@gmail.com>
 <20211120130104.185699-1-alx.manpages@gmail.com>
 <20211120130104.185699-18-alx.manpages@gmail.com>
 <CAK8P3a1XiyAnKPyd-pu1CXAjnsZ+nMdULSWWGasCYgiUU_WdjQ@mail.gmail.com>
Date:   Mon, 22 Nov 2021 10:51:29 +0200
Message-ID: <87tug4o9ny.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Nov 2021, Arnd Bergmann <arnd@arndb.de> wrote:
> On Sat, Nov 20, 2021 at 2:01 PM Alejandro Colomar
> <alx.manpages@gmail.com> wrote:
>>
>> Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
>
> Each patch should describe why you move this, it's not clear what the
> benefit is here.
>
>> diff --git a/drivers/gpu/drm/i915/i915_utils.h b/drivers/gpu/drm/i915/i915_utils.h
>> index 7a5925072466..f6fc1c72dfa7 100644
>> --- a/drivers/gpu/drm/i915/i915_utils.h
>> +++ b/drivers/gpu/drm/i915/i915_utils.h
>> @@ -25,6 +25,8 @@
>>  #ifndef __I915_UTILS_H
>>  #define __I915_UTILS_H
>>
>> +
>> +#include <linux/array_size.h>
>
> Avoid adding the extra whitespace here.

And throughout the series, really. In particular, please avoid adding
the double blank lines both in old and new files.

BR,
Jani.

>
>      Arnd

-- 
Jani Nikula, Intel Open Source Graphics Center
