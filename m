Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDC43EB6A8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 16:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240072AbhHMOZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 10:25:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233567AbhHMOZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 10:25:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7090F6103A;
        Fri, 13 Aug 2021 14:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628864723;
        bh=Pg8/Icgmmh9tdB5PBuJn/UBvXusnIC9tMqOURN6zA60=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iVTBeYI4OabSa6AWUh+yTGkBmA9jepG4TryvcTBebSyw0bdh7EYT+MvDTKsABAHWm
         9mWt7pSuszxRt7jQ5MpIBDuB735HL7iG0sngemdgSqnCf38hlnYXh9B1NbanT6twj/
         2JA9u0BDi0APPw3S3gPf2eYII6SSr58eJN1XB+h4bqlBgofm3U876V4jR8YImvosTq
         vDIpiRlzXptm9Gf4Z35aEBmw4U8Gmwx14R3agZ5qoyMnXNTkhX0uisUfHIqJUNG4v8
         1/q96YaNdvZRSC2pI7c03ceOQYShz69Uzyf1pDUimU8V54oQijYrRZcjT5JOW3Czyw
         LkLhCO/7BWqqQ==
Subject: Re: [PATCH v2 08/19] ARC: mm: switch pgtable_t back to struct page *
To:     kernel test robot <lkp@intel.com>,
        linux-snps-arc@lists.infradead.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>
References: <20210812233753.104217-9-vgupta@kernel.org>
 <202108131844.wJYo94q5-lkp@intel.com>
From:   Vineet Gupta <vgupta@kernel.org>
Message-ID: <ac88a90f-ca2e-4ba7-0eb5-cf1d1250f304@kernel.org>
Date:   Fri, 13 Aug 2021 07:25:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <202108131844.wJYo94q5-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/21 3:45 AM, kernel test robot wrote:
> Hi Vineet,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on arc/for-next]
> [also build test ERROR on linux/master linus/master v5.14-rc5 next-20210812]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Vineet-Gupta/ARC-mm-updates-support-3-4-levels-and-asm-generic-pgalloc/20210813-074023
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git for-next
> config: arc-randconfig-s032-20210812 (attached as .config)
> compiler: arceb-elf-gcc (GCC) 10.3.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # apt-get install sparse
>          # sparse version: v0.6.3-348-gf0e6938b-dirty
>          # https://github.com/0day-ci/linux/commit/36e618e081c5a49b2aff51823c5f012045e902ef
>          git remote add linux-review https://github.com/0day-ci/linux
>          git fetch --no-tags linux-review Vineet-Gupta/ARC-mm-updates-support-3-4-levels-and-asm-generic-pgalloc/20210813-074023
>          git checkout 36e618e081c5a49b2aff51823c5f012045e902ef
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=arc
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>     arch/arc/mm/init.c:35:13: warning: no previous prototype for 'arc_get_mem_sz' [-Wmissing-prototypes]
>        35 | long __init arc_get_mem_sz(void)
>           |             ^~~~~~~~~~~~~~
>     arch/arc/mm/init.c:88:13: warning: no previous prototype for 'setup_arch_memory' [-Wmissing-prototypes]
>        88 | void __init setup_arch_memory(void)
>           |             ^~~~~~~~~~~~~~~~~
>     In file included from <command-line>:
>     arch/arc/mm/init.c: In function 'mem_init':
>>> include/linux/compiler_types.h:328:38: error: call to '__compiletime_assert_328' declared with attribute error: BUILD_BUG_ON failed: (PTRS_PER_PGD * sizeof(pgd_t)) > PAGE_SIZE
>       328 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>           |                                      ^
>     include/linux/compiler_types.h:309:4: note: in definition of macro '__compiletime_assert'
>       309 |    prefix ## suffix();    \
>           |    ^~~~~~
>     include/linux/compiler_types.h:328:2: note: in expansion of macro '_compiletime_assert'
>       328 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>           |  ^~~~~~~~~~~~~~~~~~~
>     include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>        39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>           |                                     ^~~~~~~~~~~~~~~~~~
>     include/linux/build_bug.h:50:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>        50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>           |  ^~~~~~~~~~~~~~~~
>     arch/arc/mm/init.c:193:2: note: in expansion of macro 'BUILD_BUG_ON'
>       193 |  BUILD_BUG_ON((PTRS_PER_PGD * sizeof(pgd_t)) > PAGE_SIZE);
>           |  ^~~~~~~~~~~~
>

Thx for the report. This is 4K page config, where PGDIR_SHIFT 21 causes 
32-21 = 11 bits or 2k entries which won't fit in 4k page.
I've added the fix and added Tested-by.

-Vineet
