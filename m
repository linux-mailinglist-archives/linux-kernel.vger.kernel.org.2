Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C5D34C525
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 09:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhC2Hmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 03:42:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:46086 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230364AbhC2Hmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:42:32 -0400
IronPort-SDR: CKdLvuH9SbdHKHthhSU/DUcEI6y6HdGB+4+r2ttgE1A2/8wLvB9BVtCRavnamhY+K576LFGDO3
 OjnTByJmG4sA==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="211691489"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="211691489"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 00:42:27 -0700
IronPort-SDR: +bj0GNmaDCIDQpC/lE/D6oIyk0dxw6sNBfn5iHu2X2lW/pusr6wPPtsC/IszM9sLDhzvm+pw80
 Hp5BDIdcyAAg==
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="417548286"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 00:42:24 -0700
Subject: Re: [kbuild-all] Re: [PATCH] riscv: Use $(LD) instead of $(CC) to
 link vDSO
To:     Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210325215156.1986901-1-nathan@kernel.org>
 <202103262325.9ejJuOqf-lkp@intel.com>
 <20210326235839.zgfvmtfxrb3hy6i4@archlinux-ax161>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <39afa2f7-c925-c1dd-669a-6c019b11cbdf@intel.com>
Date:   Mon, 29 Mar 2021 15:41:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20210326235839.zgfvmtfxrb3hy6i4@archlinux-ax161>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

On 3/27/21 7:58 AM, Nathan Chancellor wrote:
> On Sat, Mar 27, 2021 at 12:05:34AM +0800, kernel test robot wrote:
>> Hi Nathan,
>>
>> I love your patch! Yet something to improve:
>>
>> [auto build test ERROR on linus/master]
>> [also build test ERROR on v5.12-rc4 next-20210326]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url:    https://github.com/0day-ci/linux/commits/Nathan-Chancellor/riscv-Use-LD-instead-of-CC-to-link-vDSO/20210326-055421
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 002322402dafd846c424ffa9240a937f49b48c42
>> config: riscv-randconfig-r032-20210326 (attached as .config)
>> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project f490a5969bd52c8a48586f134ff8f02ccbb295b3)
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # install riscv cross compiling tool for clang build
>>          # apt-get install binutils-riscv64-linux-gnu
>>          # https://github.com/0day-ci/linux/commit/dfdcaf93f40f0d15ffc3f25128442c1688e612d6
>>          git remote add linux-review https://github.com/0day-ci/linux
>>          git fetch --no-tags linux-review Nathan-Chancellor/riscv-Use-LD-instead-of-CC-to-link-vDSO/20210326-055421
>>          git checkout dfdcaf93f40f0d15ffc3f25128442c1688e612d6
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=riscv
> For the record, I tried to use this script to reproduce but it has a
> couple of bugs:
>
> 1. It does not download the right version of clang. This report says
> that it is clang-13 but the one that the script downloaded is clang-12.
>
> 2. It does not download it to the right location. The script expects
> ~/0day/clang-latest but it is downloaded to ~/0day/clang it seems. I
> symlinked it to get around it.

Sorry for the inconvenience, we'll fix both asap.

Best Regards,
Rong Chen

>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>>> riscv64-linux-gnu-objcopy: 'arch/riscv/kernel/vdso/vdso.so.dbg': No such file
> This error only occurs because of errors before it that are not shown
> due to a denylist:
>
> ld.lld: error: arch/riscv/kernel/vdso/rt_sigreturn.o:(.text+0x0): relocation R_RISCV_ALIGN requires unimplemented linker relaxation; recompile with -mno-relax
> ld.lld: error: arch/riscv/kernel/vdso/getcpu.o:(.text+0x0): relocation R_RISCV_ALIGN requires unimplemented linker relaxation; recompile with -mno-relax
> ld.lld: error: arch/riscv/kernel/vdso/flush_icache.o:(.text+0x0): relocation R_RISCV_ALIGN requires unimplemented linker relaxation; recompile with -mno-relax
>
> My patch only adds another occurrence of this error because we move from
> $(CC)'s default linker (in clang's case, ld.bfd) to $(LD), which in the
> case of 0day appears to be ld.lld. ld.lld should not be used with RISC-V
> in its current form due to errors of this nature, which happen without
> my patch as well:
>
> https://github.com/ClangBuiltLinux/linux/issues/1020
>
> Linker relaxation in ld.lld for RISC-V is an ongoing debate/process.
> Please give RISC-V the current treatment as s390 with ld.lld for the
> time being to get meaningful reports. We will reach out once that issue
> has been resolved.
>
> TL;DR: Patch exposes existing issue with LD=ld.lld that would have
> happened without it in different areas, the report can be ignored.
>
> Cheers!
> Nathan
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org

