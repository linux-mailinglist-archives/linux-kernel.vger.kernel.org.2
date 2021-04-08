Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38553589E3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 18:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbhDHQjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 12:39:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231480AbhDHQjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:39:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A903D61006;
        Thu,  8 Apr 2021 16:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617899933;
        bh=rVHV09Co/R/FqTZwdC2A+Y8krQYsRQgwt3naDZsAtQY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fud8xRXCD0LCX3RYtyGCRHk53uRtkW1zollCZDq5a1uIe972/lrjFf+QWhXRQfNkn
         vfvIH0xeWmXIYZjk74VuezuQJwu8hx+szr1K/JgJ6k9WQcKdYSvImbFPdPBPZjpP/i
         7jyDPrbLCg+98ZhU6k0lQaO1ZetuNYD5N81u+EMAiSwkLe5qAybODpF/WYLrqyaSLo
         Wh1pXC3L+nPK1Gi9H6bq+yFifcwicovnAWfu7pAXY82Jsu4GoZMrIEp+cPWIGoFyR0
         MwVep16QISiBnHYy1xNTcO04+d5dooM6B+0hO5lOzlUU/dbGrZarTUf+aB7lgGiNhK
         ExNXOyIaxlRHQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4F4435C048D; Thu,  8 Apr 2021 09:38:53 -0700 (PDT)
Date:   Thu, 8 Apr 2021 09:38:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2021.04.02a] BUILD REGRESSION
 4bc4fd6b7e87ff0bdb1aa2493af85be2784717c0
Message-ID: <20210408163853.GK4510@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <606ef2a8.ZUQbsxuaVoNvXNas%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <606ef2a8.ZUQbsxuaVoNvXNas%lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 08:10:16PM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.04.02a
> branch HEAD: 4bc4fd6b7e87ff0bdb1aa2493af85be2784717c0  rcu: Fix RCU priority boosting and add more debug output

Good catch, but this was an early version of this code.  The current version
is spread across the following commits in -rcu:

a6886d763248 ("rcu: Make RCU priority boosting work on single-CPU rcu_node structures")
141bf0242116 ("rcu: Add quiescent states and boost states to show_rcu_gp_kthreads() output")

Hopefully these fix this problem.

								Thanx, Paul

> Error/Warning reports:
> 
> https://lore.kernel.org/lkml/202104081002.GeatLTuT-lkp@intel.com
> https://lore.kernel.org/lkml/202104081118.JbLGAuB9-lkp@intel.com
> 
> Error/Warning in current branch:
> 
> ia64-linux-ld: (.text+0xf9a2): undefined reference to `rcu_spawn_one_boost_kthread'
> kernel/rcu/tree.h:420:13: warning: 'rcu_spawn_one_boost_kthread' used but never defined
> 
> possible Error/Warning in current branch:
> 
> arc-elf-ld: tree.c:(.text+0x60fe): undefined reference to `rcu_spawn_one_boost_kthread'
> arc-elf-ld: tree.c:(.text+0x6ad6): undefined reference to `rcu_spawn_one_boost_kthread'
> kernel/rcu/tree.c:4205: undefined reference to `rcu_spawn_one_boost_kthread'
> kernel/rcu/tree.h:420:13: warning: function 'rcu_spawn_one_boost_kthread' has internal linkage but is not defined [-Wundefined-internal]
> nds32le-linux-ld: tree.c:(.text+0x6afa): undefined reference to `rcu_spawn_one_boost_kthread'
> tree.c:(.text+0x1b190): undefined reference to `rcu_spawn_one_boost_kthread'
> tree.c:(.text+0x1b1b0): undefined reference to `rcu_spawn_one_boost_kthread'
> tree.c:(.text+0x200c): undefined reference to `rcu_spawn_one_boost_kthread'
> tree.c:(.text+0x24d6): undefined reference to `rcu_spawn_one_boost_kthread'
> tree.c:(.text+0x3571): undefined reference to `rcu_spawn_one_boost_kthread'
> tree.c:(.text+0x4756): undefined reference to `rcu_spawn_one_boost_kthread'
> tree.c:(.text+0x492a): undefined reference to `rcu_spawn_one_boost_kthread'
> tree.c:(.text+0x67c0): undefined reference to `rcu_spawn_one_boost_kthread'
> tree.c:(.text+0x8110): undefined reference to `rcu_spawn_one_boost_kthread'
> tree.c:(.text+0xb1fc): undefined reference to `rcu_spawn_one_boost_kthread'
> 
> Error/Warning ids grouped by kconfigs:
> 
> gcc_recent_errors
> |-- alpha-allmodconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- alpha-allyesconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- alpha-randconfig-r026-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- arc-allyesconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- arc-axs101_defconfig
> |   |-- arc-elf-ld:tree.c:(.text):undefined-reference-to-rcu_spawn_one_boost_kthread
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- arc-defconfig
> |   |-- arc-elf-ld:tree.c:(.text):undefined-reference-to-rcu_spawn_one_boost_kthread
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- arc-randconfig-r012-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- arm-allmodconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- arm-allyesconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- arm-defconfig
> |   |-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |   `-- tree.c:(.text):undefined-reference-to-rcu_spawn_one_boost_kthread
> |-- arm-keystone_defconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- arm-mvebu_v7_defconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- arm-omap2plus_defconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- arm-oxnas_v6_defconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- arm-randconfig-r033-20210407
> |   |-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |   `-- tree.c:(.text):undefined-reference-to-rcu_spawn_one_boost_kthread
> |-- arm-shmobile_defconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- arm-trizeps4_defconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- arm-u8500_defconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- arm64-allmodconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- arm64-allyesconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- arm64-defconfig
> |   |-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |   `-- tree.c:(.text):undefined-reference-to-rcu_spawn_one_boost_kthread
> |-- arm64-randconfig-c024-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- arm64-randconfig-r011-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- arm64-randconfig-r014-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- arm64-randconfig-r021-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- arm64-randconfig-r023-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- arm64-randconfig-r024-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- arm64-randconfig-r026-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- h8300-randconfig-c004-20210407
> |   |-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |   `-- tree.c:(.text):undefined-reference-to-rcu_spawn_one_boost_kthread
> |-- h8300-randconfig-r016-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- i386-allmodconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- i386-allyesconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- i386-defconfig
> |   |-- kernel-rcu-tree.c:undefined-reference-to-rcu_spawn_one_boost_kthread
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- i386-randconfig-a002-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- i386-randconfig-a004-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- i386-randconfig-a006-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- i386-randconfig-a011-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- i386-randconfig-a014-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- i386-randconfig-a016-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- i386-randconfig-c001-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- i386-randconfig-r006-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- i386-randconfig-s002-20210407
> |   |-- kernel-rcu-tree.c:undefined-reference-to-rcu_spawn_one_boost_kthread
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- ia64-allmodconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- ia64-allyesconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- ia64-defconfig
> |   |-- ia64-linux-ld:(.text):undefined-reference-to-rcu_spawn_one_boost_kthread
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- ia64-randconfig-r014-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- ia64-randconfig-r015-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- ia64-randconfig-r033-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- ia64-randconfig-r035-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- microblaze-randconfig-r004-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- mips-allmodconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- mips-allyesconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- mips-bmips_be_defconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- mips-ci20_defconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- mips-loongson3_defconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- mips-maltaup_defconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- mips-nlm_xlr_defconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- mips-pistachio_defconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- nds32-defconfig
> |   |-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |   `-- nds32le-linux-ld:tree.c:(.text):undefined-reference-to-rcu_spawn_one_boost_kthread
> |-- openrisc-allmodconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- openrisc-allyesconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- parisc-allyesconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- parisc-defconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- parisc-randconfig-r022-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- parisc-randconfig-r032-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- powerpc-allmodconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- powerpc-allyesconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- powerpc-randconfig-r016-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- riscv-allmodconfig
> |   |-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |   `-- tree.c:(.text):undefined-reference-to-rcu_spawn_one_boost_kthread
> |-- riscv-allyesconfig
> |   |-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |   `-- tree.c:(.text):undefined-reference-to-rcu_spawn_one_boost_kthread
> |-- riscv-defconfig
> |   |-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |   `-- tree.c:(.text):undefined-reference-to-rcu_spawn_one_boost_kthread
> |-- riscv-nommu_k210_defconfig
> |   |-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |   `-- tree.c:(.text):undefined-reference-to-rcu_spawn_one_boost_kthread
> |-- riscv-nommu_k210_sdcard_defconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- riscv-nommu_virt_defconfig
> |   |-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |   `-- tree.c:(.text):undefined-reference-to-rcu_spawn_one_boost_kthread
> |-- riscv-randconfig-s031-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- riscv-rv32_defconfig
> |   |-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |   `-- tree.c:(.text):undefined-reference-to-rcu_spawn_one_boost_kthread
> |-- s390-allmodconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- s390-allyesconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- s390-defconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- s390-randconfig-r014-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- s390-randconfig-r016-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- s390-randconfig-r023-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- sh-randconfig-c004-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- sh-randconfig-r013-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- sparc-allyesconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- sparc-randconfig-p001-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- sparc-randconfig-r011-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- sparc64-randconfig-r021-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- sparc64-randconfig-r025-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- x86_64-allmodconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- x86_64-allyesconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- x86_64-defconfig
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- x86_64-kexec
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- x86_64-randconfig-a011-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- x86_64-randconfig-a013-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- x86_64-randconfig-a014-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- x86_64-randconfig-a016-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- x86_64-randconfig-c022-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- x86_64-randconfig-c023-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- x86_64-randconfig-s021-20210407
> |   |-- kernel-rcu-tree.c:undefined-reference-to-rcu_spawn_one_boost_kthread
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- x86_64-rhel-8.3
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- x86_64-rhel-8.3-kbuiltin
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- x86_64-rhel-8.3-kselftests
> |   |-- kernel-rcu-tree.c:undefined-reference-to-rcu_spawn_one_boost_kthread
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> |-- xtensa-randconfig-r011-20210407
> |   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> `-- xtensa-randconfig-r035-20210407
>     `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
> 
> clang_recent_errors
> `-- s390-randconfig-r034-20210407
>     `-- kernel-rcu-tree.h:warning:function-rcu_spawn_one_boost_kthread-has-internal-linkage-but-is-not-defined
> 
> elapsed time: 720m
> 
> configs tested: 112
> configs skipped: 2
> 
> gcc tested configs:
> arm                                 defconfig
> arm64                            allyesconfig
> arm64                               defconfig
> arm                              allyesconfig
> arm                              allmodconfig
> x86_64                           allyesconfig
> riscv                            allmodconfig
> riscv                            allyesconfig
> arm                         hackkit_defconfig
> arm                           u8500_defconfig
> mips                       bmips_be_defconfig
> arm                           h5000_defconfig
> mips                      loongson3_defconfig
> ia64                             allyesconfig
> arc                          axs101_defconfig
> powerpc                      chrp32_defconfig
> arm                        keystone_defconfig
> alpha                            allyesconfig
> sh                            shmin_defconfig
> mips                           ci20_defconfig
> arm                        oxnas_v6_defconfig
> powerpc                      ppc44x_defconfig
> powerpc                     mpc5200_defconfig
> arm                       omap2plus_defconfig
> csky                                defconfig
> arm                        mvebu_v7_defconfig
> arm                        neponset_defconfig
> m68k                        stmark2_defconfig
> arm                        spear3xx_defconfig
> arm                  colibri_pxa300_defconfig
> sh                          kfr2r09_defconfig
> arm                      footbridge_defconfig
> xtensa                           alldefconfig
> powerpc                       maple_defconfig
> arm                        shmobile_defconfig
> mips                        maltaup_defconfig
> riscv             nommu_k210_sdcard_defconfig
> mips                malta_kvm_guest_defconfig
> powerpc                      tqm8xx_defconfig
> powerpc                     tqm8541_defconfig
> mips                            ar7_defconfig
> powerpc                        fsp2_defconfig
> um                               allyesconfig
> nios2                         3c120_defconfig
> powerpc                      ppc40x_defconfig
> mips                        nlm_xlr_defconfig
> sh                         ap325rxa_defconfig
> powerpc                 mpc832x_mds_defconfig
> powerpc                      bamboo_defconfig
> arm                          iop32x_defconfig
> mips                      pistachio_defconfig
> arm                        trizeps4_defconfig
> ia64                             allmodconfig
> ia64                                defconfig
> m68k                             allmodconfig
> m68k                                defconfig
> m68k                             allyesconfig
> nios2                               defconfig
> arc                              allyesconfig
> nds32                             allnoconfig
> nds32                               defconfig
> nios2                            allyesconfig
> alpha                               defconfig
> xtensa                           allyesconfig
> h8300                            allyesconfig
> arc                                 defconfig
> sh                               allmodconfig
> parisc                              defconfig
> s390                             allyesconfig
> s390                             allmodconfig
> parisc                           allyesconfig
> s390                                defconfig
> i386                             allyesconfig
> sparc                            allyesconfig
> sparc                               defconfig
> i386                                defconfig
> mips                             allyesconfig
> mips                             allmodconfig
> powerpc                          allyesconfig
> powerpc                          allmodconfig
> powerpc                           allnoconfig
> i386                 randconfig-a006-20210407
> i386                 randconfig-a003-20210407
> i386                 randconfig-a001-20210407
> i386                 randconfig-a004-20210407
> i386                 randconfig-a002-20210407
> i386                 randconfig-a005-20210407
> x86_64               randconfig-a014-20210407
> x86_64               randconfig-a015-20210407
> x86_64               randconfig-a013-20210407
> x86_64               randconfig-a011-20210407
> x86_64               randconfig-a012-20210407
> x86_64               randconfig-a016-20210407
> i386                 randconfig-a014-20210407
> i386                 randconfig-a011-20210407
> i386                 randconfig-a016-20210407
> i386                 randconfig-a012-20210407
> i386                 randconfig-a015-20210407
> i386                 randconfig-a013-20210407
> riscv                    nommu_k210_defconfig
> riscv                    nommu_virt_defconfig
> riscv                             allnoconfig
> riscv                               defconfig
> riscv                          rv32_defconfig
> um                               allmodconfig
> um                                allnoconfig
> um                                  defconfig
> x86_64                    rhel-8.3-kselftests
> x86_64                              defconfig
> x86_64                               rhel-8.3
> x86_64                      rhel-8.3-kbuiltin
> x86_64                                  kexec
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
