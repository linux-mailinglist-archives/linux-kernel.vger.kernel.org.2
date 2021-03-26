Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CD834B337
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 00:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhCZX65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 19:58:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230027AbhCZX6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 19:58:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C58BC619E4;
        Fri, 26 Mar 2021 23:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616803124;
        bh=a3dDdnXrrs57TfBaTl7alXhup2BDKH4a64f3EAdGZ+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c909TIJ9AdLcTMo/bkPIQREacj+dvK3KSQI6QXYhjlSl5QWnBCWVqptHiAhH6J2tU
         VvgRzqOAdyRO6Pl6IxAl9TvzFYXdDGYQOvVjJtPeYiFIU2GwXhBWDlTfhlt6/4MWg7
         I44G03OXSDu8zRn7XTIgdo5qR6WLO3Ya+ceqtxOC0XdPmDmbeADv8qmBKim3GEe5D+
         /KpSsdmIIoZuQeHA9/bYvLtNVigAT86kNiFyyZE0bSFmKwDq8fSDGYZiaa6VnTPIC+
         qAdoSouUBBt4QQcAKlH0anFFzuehabZ3g4b+nXNekEnfe9t2G19ciwwQjJ3RMrSb3u
         fDzOj0pil/xYQ==
Date:   Fri, 26 Mar 2021 16:58:39 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Use $(LD) instead of $(CC) to link vDSO
Message-ID: <20210326235839.zgfvmtfxrb3hy6i4@archlinux-ax161>
References: <20210325215156.1986901-1-nathan@kernel.org>
 <202103262325.9ejJuOqf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202103262325.9ejJuOqf-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2021 at 12:05:34AM +0800, kernel test robot wrote:
> Hi Nathan,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v5.12-rc4 next-20210326]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Nathan-Chancellor/riscv-Use-LD-instead-of-CC-to-link-vDSO/20210326-055421
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 002322402dafd846c424ffa9240a937f49b48c42
> config: riscv-randconfig-r032-20210326 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project f490a5969bd52c8a48586f134ff8f02ccbb295b3)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install riscv cross compiling tool for clang build
>         # apt-get install binutils-riscv64-linux-gnu
>         # https://github.com/0day-ci/linux/commit/dfdcaf93f40f0d15ffc3f25128442c1688e612d6
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Nathan-Chancellor/riscv-Use-LD-instead-of-CC-to-link-vDSO/20210326-055421
>         git checkout dfdcaf93f40f0d15ffc3f25128442c1688e612d6
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=riscv 

For the record, I tried to use this script to reproduce but it has a
couple of bugs:

1. It does not download the right version of clang. This report says
that it is clang-13 but the one that the script downloaded is clang-12.

2. It does not download it to the right location. The script expects
~/0day/clang-latest but it is downloaded to ~/0day/clang it seems. I
symlinked it to get around it.

> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> riscv64-linux-gnu-objcopy: 'arch/riscv/kernel/vdso/vdso.so.dbg': No such file

This error only occurs because of errors before it that are not shown
due to a denylist:

ld.lld: error: arch/riscv/kernel/vdso/rt_sigreturn.o:(.text+0x0): relocation R_RISCV_ALIGN requires unimplemented linker relaxation; recompile with -mno-relax
ld.lld: error: arch/riscv/kernel/vdso/getcpu.o:(.text+0x0): relocation R_RISCV_ALIGN requires unimplemented linker relaxation; recompile with -mno-relax
ld.lld: error: arch/riscv/kernel/vdso/flush_icache.o:(.text+0x0): relocation R_RISCV_ALIGN requires unimplemented linker relaxation; recompile with -mno-relax

My patch only adds another occurrence of this error because we move from
$(CC)'s default linker (in clang's case, ld.bfd) to $(LD), which in the
case of 0day appears to be ld.lld. ld.lld should not be used with RISC-V
in its current form due to errors of this nature, which happen without
my patch as well:

https://github.com/ClangBuiltLinux/linux/issues/1020

Linker relaxation in ld.lld for RISC-V is an ongoing debate/process.
Please give RISC-V the current treatment as s390 with ld.lld for the
time being to get meaningful reports. We will reach out once that issue
has been resolved.

TL;DR: Patch exposes existing issue with LD=ld.lld that would have
happened without it in different areas, the report can be ignored.

Cheers!
Nathan
