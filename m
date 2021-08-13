Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA1B3EB6FE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 16:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240890AbhHMOsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 10:48:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240885AbhHMOsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 10:48:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1156860F00;
        Fri, 13 Aug 2021 14:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628866083;
        bh=d0uhs55zTotKZsxm5M4Qposmy5Z1i6/X47n3w9NOB9s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NIM/x/+NU8M/txOQrL/XLVJ4ndJ9oZ8aWwjFpHJmalXdzxO+QM6dtczZUr08WgN3L
         iY1EmRJOZduObH05rMN857uH8v4keBD+iEFBZx7Q7CE8gzLq4Rs45aIrEia3AzOPk5
         0RoeWODcFboNlhHSLDX6g1zfa/OO3ukhhs6Scyyd2V2g5CHMb+3dstf4QRzqdLAoy3
         ESA5yToWyWmZ++gQ4mnQKjrDSAmMkh5eeKOW0luy+uZv9tesGIQGL4J9CXOKR8b7mq
         4dFV5WdDOpVHsuPdYbuNiEviEj81Du8gzFZ3c1WiU6KQKVsOnz5sMPEFV95rBoWsmX
         0Qq71LFHHjqTw==
Subject: Re: [PATCH v2 13/19] ARC: mm: disintegrate mmu.h (arcv2 bits out)
To:     kernel test robot <lkp@intel.com>,
        Vineet Gupta <vgupta@kernel.org>,
        linux-snps-arc@lists.infradead.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>
References: <20210812233753.104217-14-vgupta@kernel.org>
 <202108131142.NfJFd0gO-lkp@intel.com>
From:   Vineet Gupta <vgupta@kernel.org>
Message-ID: <99d09d5f-0655-18bf-54ac-27914a42aace@kernel.org>
Date:   Fri, 13 Aug 2021 07:48:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <202108131142.NfJFd0gO-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/21 9:01 PM, kernel test robot wrote:
> Hi Vineet,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on arc/for-next]
> [also build test ERROR on next-20210812]
> [cannot apply to linux/master linus/master v5.14-rc5]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:https://github.com/0day-ci/linux/commits/Vineet-Gupta/ARC-mm-updates-support-3-4-levels-and-asm-generic-pgalloc/20210813-074023
> base:https://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git  for-next
> config: arc-allyesconfig (attached as .config)
> compiler: arceb-elf-gcc (GCC) 10.3.0
> reproduce (this is a W=1 build):
>          wgethttps://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross  -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          #https://github.com/0day-ci/linux/commit/0411d3a95cb73722d026f7b3d9c9d8abab8c0d79
>          git remote add linux-reviewhttps://github.com/0day-ci/linux
>          git fetch --no-tags linux-review Vineet-Gupta/ARC-mm-updates-support-3-4-levels-and-asm-generic-pgalloc/20210813-074023
>          git checkout 0411d3a95cb73722d026f7b3d9c9d8abab8c0d79
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross ARCH=arc
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot<lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>     In file included from arch/arc/include/asm/mmu.h:19,
>                      from include/linux/mm_types.h:19,
>                      from include/linux/buildid.h:5,
>                      from include/linux/module.h:14,
>                      from lib/test_bitops.c:9:
>>> arch/arc/include/asm/mmu-arcv2.h:80:1: error: 'inline' is not at beginning of declaration [-Werror=old-style-declaration]
>        80 | static void inline mmu_setup_asid(struct mm_struct *mm, unsigned long asid)
>           | ^~~~~~
>     arch/arc/include/asm/mmu-arcv2.h:85:1: error: 'inline' is not at beginning of declaration [-Werror=old-style-declaration]
>        85 | static void inline mmu_setup_pgd(struct mm_struct *mm, void *pgd)
>           | ^~~~~~
>     cc1: all warnings being treated as errors

Strange my gcc11 is not tripping on this snafu. Fixed now.
Thx for the report as always.

-Vineet
