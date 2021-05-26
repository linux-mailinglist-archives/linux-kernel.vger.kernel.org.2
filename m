Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F0C39121D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhEZIOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:14:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:15164 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231410AbhEZIOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:14:44 -0400
IronPort-SDR: hFYgFMg+XGPVlIpw3GfnBeoli4+Y+mJwOkyZ3KA99sdXW6RWvuFTIqCXRtcolKebGDmcSzXHBG
 SPoaDB6Lcr3w==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="199356802"
X-IronPort-AV: E=Sophos;i="5.82,330,1613462400"; 
   d="scan'208";a="199356802"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 01:13:09 -0700
IronPort-SDR: zr2kQKDzF9wdSZcCuhXI6/J+hEJWyKn4o5NLKO9pSytsxONkOdzjZEqbcjDkhpK5pxypxVDco9
 IYGranyz7VuQ==
X-IronPort-AV: E=Sophos;i="5.82,330,1613462400"; 
   d="scan'208";a="476823976"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 01:13:05 -0700
Subject: Re: [kbuild-all] Re: [PATCH] kcov: add __no_sanitize_coverage to fix
 noinstr for all architectures
To:     Marco Elver <elver@google.com>, kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
References: <20210525175819.699786-1-elver@google.com>
 <202105260629.X6n5yc4D-lkp@intel.com>
 <CANpmjNMT=HQQpK9U4bnoGb-=+KJC246dSZ3u2VB0TXw4itsB-w@mail.gmail.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <f213338f-a98d-27a2-a785-821f60c4d708@intel.com>
Date:   Wed, 26 May 2021 16:11:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CANpmjNMT=HQQpK9U4bnoGb-=+KJC246dSZ3u2VB0TXw4itsB-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/26/21 6:29 AM, Marco Elver wrote:
> On Wed, 26 May 2021 at 00:23, kernel test robot <lkp@intel.com> wrote:
> [...]
>> [auto build test WARNING on linux/master]
>> [also build test WARNING on kees/for-next/pstore linus/master v5.13-rc3 next-20210525]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url:    https://github.com/0day-ci/linux/commits/Marco-Elver/kcov-add-__no_sanitize_coverage-to-fix-noinstr-for-all-architectures/20210526-020046
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git dd860052c99b1e088352bdd4fb7aef46f8d2ef47
>> config: s390-randconfig-r002-20210525 (attached as .config)
>> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 99155e913e9bad5f7f8a247f8bb3a3ff3da74af1)
> ^^^ you're using a Clang pre-release, breakages are expected until
> Clang 13 is final.

Hi Marco,

I really appreciate for your comment, we'll update clang to the latest 
version.

Best Regards,
Rong Chen

>
> I think there was a thread about this at some point. I guess LKP has
> decided that testing Clang pre-releases is fair game? I guess it's
> useful, but this warning here needs to be ignored. It'll go away when
> you rebuild your pre-release Clang 13 from the latest LLVM main
> branch.
>
> [...]
>>>> arch/s390/kernel/nmi.c:182:6: warning: unknown sanitizer 'coverage' ignored [-Wunknown-sanitizers]
>>     void noinstr s390_handle_mcck(void)
>>          ^
>>     include/linux/compiler_types.h:213:35: note: expanded from macro 'noinstr'
>>             __no_kcsan __no_sanitize_address __no_sanitize_coverage
>>                                              ^
>>     include/linux/compiler-clang.h:49:59: note: expanded from macro '__no_sanitize_coverage'
>>     #define __no_sanitize_coverage __attribute__((no_sanitize("coverage")))
>>                                                               ^
> Clang 13 will support the attribute, but this is a pre-release Clang
> 13 -- so please ignore the report. FWIW, I tested my patch of course
> with a version of Clang 13 that supports the attribute. :-)
>
> Thanks,
> -- Marco
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org

