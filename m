Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCAEE4237FC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 08:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbhJFGcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 02:32:24 -0400
Received: from mga07.intel.com ([134.134.136.100]:36775 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229956AbhJFGcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 02:32:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10128"; a="289429915"
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; 
   d="scan'208";a="289429915"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 23:30:29 -0700
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; 
   d="scan'208";a="484034646"
Received: from pwali-mobl1.amr.corp.intel.com (HELO ldmartin-desk2) ([10.213.170.68])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 23:30:29 -0700
Date:   Tue, 5 Oct 2021 23:30:29 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] lib/string_helpers: add linux/string.h for strlen()
Message-ID: <20211006063029.owhu5hjtaivib5d5@ldmartin-desk2>
X-Patchwork-Hint: comment
References: <20211005212634.3223113-1-lucas.demarchi@intel.com>
 <CAHp75VfT+dSNYSntj9O5a9NVGnbf_raxWLiS7ciDMe-kRL-+=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VfT+dSNYSntj9O5a9NVGnbf_raxWLiS7ciDMe-kRL-+=A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 08:57:27AM +0300, Andy Shevchenko wrote:
>On Wednesday, October 6, 2021, Lucas De Marchi <lucas.demarchi@intel.com>
>wrote:
>
>> linux/string_helpers.h uses strlen(), so include the correpondent
>> header. Otherwise we get a compilation error if it's not also included
>> by whoever included the helper.
>>
>> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>> ---
>>  include/linux/string_helpers.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/include/linux/string_helpers.h b/include/linux/string_
>> helpers.h
>> index 68189c4a2eb1..4ba39e1403b2 100644
>> --- a/include/linux/string_helpers.h
>> +++ b/include/linux/string_helpers.h
>> @@ -4,6 +4,7 @@
>>
>>  #include <linux/bits.h>
>>  #include <linux/ctype.h>
>> +#include <linux/string.h>
>>  #include <linux/types.h>
>
>
>I’m afraid this potentially can add into header dependencies hell. What
>about moving the user to the C file?

I can do that, but I don't see the problem here... afaics it has been like this
for 7 years, since commit c8250381c827 ("lib / string_helpers: introduce string_escape_mem()"),
and the only way it was never borken is because
linux/string.h is already being indirectly included from other headers.
So just adding it here is harmless.

I reproduced this while following the normal header order in i915 and
adding linux/string_helpers.h like this:


diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs.c b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
index 309d74fd86ce..1dfc01617258 100644
--- a/drivers/gpu/drm/i915/display/intel_display_debugfs.c
+++ b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
@@ -3,6 +3,8 @@
   * Copyright © 2020 Intel Corporation
   */
  
+#include <linux/string_helpers.h>
+
  #include <drm/drm_debugfs.h>
  #include <drm/drm_fourcc.h>
  

Note that this became the first header included, producing the following
error:

  make -j$(nproc) drivers/gpu/drm/i915/display/intel_display_debugfs.o
   DESCEND objtool
   CALL    scripts/atomic/check-atomics.sh
   CALL    scripts/checksyscalls.sh
   CC [M]  drivers/gpu/drm/i915/display/intel_display_debugfs.o
In file included from drivers/gpu/drm/i915/display/intel_display_debugfs.c:6:
./include/linux/string_helpers.h: In function ‘string_escape_str’:
./include/linux/string_helpers.h:75:32: error: implicit declaration of function ‘strlen’ [-Werror=implicit-function-declaration]
    75 |  return string_escape_mem(src, strlen(src), dst, sz, flags, only);
       |                                ^~~~~~
./include/linux/string_helpers.h:75:32: error: incompatible implicit declaration of built-in function ‘strlen’ [-Werror]
./include/linux/string_helpers.h:7:1: note: include ‘<string.h>’ or provide a declaration of ‘strlen’
     6 | #include <linux/ctype.h>
   +++ |+#include <string.h>
     7 | #include <linux/types.h>
cc1: all warnings being treated as errors


Anyway, if it's preferable to move these functions out of line, I can do
so.

thanks
Lucas De Marchi

>
>
>>
>>  struct file;
>> --
>> 2.33.0
>>
>>
>
>-- 
>With Best Regards,
>Andy Shevchenko
