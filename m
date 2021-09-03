Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553384007CA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 00:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbhICWOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 18:14:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:9525 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229875AbhICWOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 18:14:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10096"; a="199068224"
X-IronPort-AV: E=Sophos;i="5.85,266,1624345200"; 
   d="scan'208";a="199068224"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 15:13:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,266,1624345200"; 
   d="scan'208";a="692470444"
Received: from lkp-server01.sh.intel.com (HELO 2115029a3e5c) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 03 Sep 2021 15:13:39 -0700
Received: from kbuild by 2115029a3e5c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mMHRK-0000sW-Oz; Fri, 03 Sep 2021 22:13:38 +0000
Date:   Sat, 04 Sep 2021 06:12:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.08.25a] BUILD REGRESSION
 2ba1d046d9bc5b4496027d120e3ddcdfbb2fe9f4
Message-ID: <61329de6.swpKkFiW783zlzg0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.08.25a
branch HEAD: 2ba1d046d9bc5b4496027d120e3ddcdfbb2fe9f4  EXP softirq: More aggressively update tick

Error/Warning reports:

https://lore.kernel.org/lkml/202109030618.7Na6ua2f-lkp@intel.com
https://lore.kernel.org/lkml/202109030640.6NuTjfs6-lkp@intel.com
https://lore.kernel.org/lkml/202109030655.LfhRW51M-lkp@intel.com
https://lore.kernel.org/lkml/202109030701.i87lX52g-lkp@intel.com
https://lore.kernel.org/lkml/202109030732.o6eTW2YJ-lkp@intel.com
https://lore.kernel.org/lkml/202109030841.7XDRMfwz-lkp@intel.com

Error/Warning in current branch:

kernel/time/hrtimer.c:1478:7: warning: no previous prototype for '__run_hrtimer_get_debug' [-Wmissing-prototypes]
kernel/time/hrtimer.c:1478:7: warning: no previous prototype for function '__run_hrtimer_get_debug' [-Wmissing-prototypes]
kernel/time/hrtimer.c:1483:7: warning: no previous prototype for '__run_hrtimer_get_debug' [-Wmissing-prototypes]
kernel/time/hrtimer.c:1483:7: warning: no previous prototype for function '__run_hrtimer_get_debug' [-Wmissing-prototypes]
kernel/time/hrtimer.c:1631:6: warning: no previous prototype for 'hrtimer_interrupt_get_debug' [-Wmissing-prototypes]
kernel/time/hrtimer.c:1631:6: warning: no previous prototype for function 'hrtimer_interrupt_get_debug' [-Wmissing-prototypes]
kernel/time/hrtimer.c:1645:6: warning: no previous prototype for 'hrtimer_interrupt_get_debug' [-Wmissing-prototypes]
kernel/time/hrtimer.c:1645:6: warning: no previous prototype for function 'hrtimer_interrupt_get_debug' [-Wmissing-prototypes]
kernel/time/tick-oneshot.c:22:7: warning: no previous prototype for function 'tick_program_event_get_debug' [-Wmissing-prototypes]
kernel/time/tick-oneshot.c:27:55: warning: integer overflow in expression of type 'long int' results in '-1857093632' [-Woverflow]
kernel/time/tick-oneshot.c:34:48: warning: integer overflow in expression of type 'long int' results in '-1857093632' [-Woverflow]
kernel/time/tick-oneshot.c:34:55: warning: integer overflow in expression of type 'long int' results in '-1857093632' [-Woverflow]

possible Error/Warning in current branch (please contact us if interested):

(.text+0x140): undefined reference to `hrtimer_interrupt_get_debug'
arm-linux-gnueabi-ld: cpu.c:(.text+0x1a0c): undefined reference to `__aeabi_uldivmod'
arm-linux-gnueabi-ld: cpu.c:(.text+0xca8): undefined reference to `__aeabi_uldivmod'
cpu.c:(.text+0x19ac): undefined reference to `__aeabi_uldivmod'
cpu.c:(.text+0xc60): undefined reference to `__aeabi_uldivmod'
hppa-linux-ld: (.text+0x148): undefined reference to `get_sysvec_apic_timer_interrupt_ns'
hppa-linux-ld: (.text+0x1b4): undefined reference to `tick_program_event_get_debug'
hppa-linux-ld: stop_machine.o:(.text+0x248): undefined reference to `get_sysvec_apic_timer_interrupt_ns'
ia64-linux-ld: stop_machine.c:(.text+0x2f2): undefined reference to `get_api_timer_irqs'
ia64-linux-ld: stop_machine.c:(.text+0x302): undefined reference to `get_sysvec_apic_timer_interrupt_ns'
ia64-linux-ld: stop_machine.c:(.text+0x382): undefined reference to `tick_program_event_get_debug'
ia64-linux-ld: stop_machine.c:(.text+0x6d2): undefined reference to `get_sysvec_apic_timer_interrupt_ns'
kernel/stop_machine.c:220: undefined reference to `hrtimer_interrupt_get_debug'
kernel/stop_machine.c:222: undefined reference to `hrtimer_interrupt_get_debug'
kernel/time/tick-oneshot.c:22:7: warning: no previous prototype for 'tick_program_event_get_debug' [-Wmissing-prototypes]
ld: kernel/stop_machine.c:223: undefined reference to `tick_program_event_get_debug'
riscv64-linux-ld: stop_machine.c:(.text+0x656): undefined reference to `get_sysvec_apic_timer_interrupt_ns'
riscv64-linux-ld: stop_machine.c:(.text+0x688): undefined reference to `tick_program_event_get_debug'
s390-linux-ld: stop_machine.c:(.text+0x152): undefined reference to `get_api_timer_irqs'
s390-linux-ld: stop_machine.c:(.text+0x192): undefined reference to `get_api_timer_irqs'
s390-linux-ld: stop_machine.c:(.text+0x2a0): undefined reference to `get_api_timer_irqs'
s390-linux-ld: stop_machine.c:(.text+0x8c): undefined reference to `get_api_timer_irqs'
s390-linux-ld: stop_machine.c:(.text+0xe6): undefined reference to `get_api_timer_irqs'
s390-linux-ld: stop_machine.c:(.text+0xea): undefined reference to `get_sysvec_apic_timer_interrupt_ns'
stop_machine.c:(.text+0x1070): undefined reference to `get_sysvec_apic_timer_interrupt_ns'
stop_machine.c:(.text+0x184): undefined reference to `get_sysvec_apic_timer_interrupt_ns'
stop_machine.c:(.text+0x214): undefined reference to `get_sysvec_apic_timer_interrupt_ns'
stop_machine.c:(.text+0x302): undefined reference to `hrtimer_interrupt_get_debug'
stop_machine.c:(.text+0x550): undefined reference to `get_sysvec_apic_timer_interrupt_ns'
stop_machine.c:(.text+0x598): undefined reference to `get_sysvec_apic_timer_interrupt_ns'
stop_machine.c:(.text+0x64c): undefined reference to `hrtimer_interrupt_get_debug'
stop_machine.c:(.text+0x7e): undefined reference to `get_sysvec_apic_timer_interrupt_ns'
stop_machine.c:(.text+0x88): undefined reference to `get_sysvec_apic_timer_interrupt_ns'
stop_machine.o:(.text+0x240): undefined reference to `hrtimer_interrupt_get_debug'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|-- alpha-defconfig
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- arc-allyesconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- arc-defconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- arc-randconfig-r033-20210903
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- arc-randconfig-r043-20210903
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- arm-allmodconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   |-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|   |-- kernel-time-tick-oneshot.c:warning:no-previous-prototype-for-tick_program_event_get_debug
|   `-- stop_machine.c:(.text):undefined-reference-to-get_sysvec_apic_timer_interrupt_ns
|-- arm-allyesconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   |-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|   |-- kernel-time-tick-oneshot.c:warning:no-previous-prototype-for-tick_program_event_get_debug
|   `-- stop_machine.c:(.text):undefined-reference-to-get_sysvec_apic_timer_interrupt_ns
|-- arm-cns3420vb_defconfig
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- arm-davinci_all_defconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- arm-defconfig
|   |-- arm-linux-gnueabi-ld:cpu.c:(.text):undefined-reference-to-__aeabi_uldivmod
|   |-- cpu.c:(.text):undefined-reference-to-__aeabi_uldivmod
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   |-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|   |-- kernel-time-tick-oneshot.c:warning:no-previous-prototype-for-tick_program_event_get_debug
|   `-- stop_machine.c:(.text):undefined-reference-to-get_sysvec_apic_timer_interrupt_ns
|-- arm-nhk8815_defconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   |-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|   `-- kernel-time-tick-oneshot.c:warning:no-previous-prototype-for-tick_program_event_get_debug
|-- arm-pcm027_defconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- arm-s3c6400_defconfig
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- arm-tegra_defconfig
|   |-- arm-linux-gnueabi-ld:cpu.c:(.text):undefined-reference-to-__aeabi_uldivmod
|   |-- cpu.c:(.text):undefined-reference-to-__aeabi_uldivmod
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- arm64-allyesconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   |-- kernel-time-tick-oneshot.c:warning:no-previous-prototype-for-tick_program_event_get_debug
|   `-- stop_machine.c:(.text):undefined-reference-to-get_sysvec_apic_timer_interrupt_ns
|-- arm64-defconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   |-- kernel-time-tick-oneshot.c:warning:no-previous-prototype-for-tick_program_event_get_debug
|   `-- stop_machine.c:(.text):undefined-reference-to-get_sysvec_apic_timer_interrupt_ns
|-- arm64-randconfig-r016-20210903
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- arm64-randconfig-r024-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- stop_machine.c:(.text):undefined-reference-to-get_sysvec_apic_timer_interrupt_ns
|-- csky-buildonly-randconfig-r004-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- csky-defconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- h8300-allyesconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- h8300-randconfig-r014-20210903
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- h8300-randconfig-r036-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- i386-allyesconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- i386-defconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- i386-randconfig-a011-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- i386-randconfig-a012-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- i386-randconfig-a013-20210903
|   |-- kernel-stop_machine.c:undefined-reference-to-hrtimer_interrupt_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   `-- ld:kernel-stop_machine.c:undefined-reference-to-tick_program_event_get_debug
|-- i386-randconfig-a014-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- i386-randconfig-a015-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- i386-randconfig-a016-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- i386-randconfig-c021-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- i386-randconfig-m021-20210903
|   |-- kernel-stop_machine.c:undefined-reference-to-hrtimer_interrupt_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- i386-randconfig-s001-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- i386-randconfig-s002-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- i386-tinyconfig
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- ia64-allmodconfig
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- ia64-allyesconfig
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- ia64-defconfig
|   |-- ia64-linux-ld:stop_machine.c:(.text):undefined-reference-to-get_api_timer_irqs
|   |-- ia64-linux-ld:stop_machine.c:(.text):undefined-reference-to-get_sysvec_apic_timer_interrupt_ns
|   |-- ia64-linux-ld:stop_machine.c:(.text):undefined-reference-to-tick_program_event_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   `-- stop_machine.c:(.text):undefined-reference-to-hrtimer_interrupt_get_debug
|-- ia64-randconfig-r025-20210903
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- ia64-randconfig-r032-20210903
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- ia64-randconfig-r034-20210903
|   |-- ia64-linux-ld:stop_machine.c:(.text):undefined-reference-to-get_sysvec_apic_timer_interrupt_ns
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- m68k-allmodconfig
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- m68k-allyesconfig
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- m68k-bvme6000_defconfig
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- m68k-defconfig
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- m68k-mac_defconfig
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- m68k-randconfig-r021-20210903
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- m68k-randconfig-r036-20210903
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- microblaze-randconfig-r022-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- mips-allmodconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- mips-allyesconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- mips-capcella_defconfig
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- mips-gcw0_defconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- mips-randconfig-r033-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- mips-rbtx49xx_defconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- nds32-allnoconfig
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- nds32-allyesconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- nds32-defconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- nds32-randconfig-r006-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- nds32-randconfig-r012-20210903
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- nds32-randconfig-r036-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- nios2-allyesconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- nios2-defconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- nios2-randconfig-r011-20210903
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- nios2-randconfig-r023-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- nios2-randconfig-r032-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   |-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|   `-- kernel-time-tick-oneshot.c:warning:no-previous-prototype-for-tick_program_event_get_debug
|-- openrisc-randconfig-c024-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- openrisc-randconfig-r004-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- openrisc-randconfig-r013-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- parisc-allyesconfig
|   |-- hppa-linux-ld:stop_machine.o:(.text):undefined-reference-to-get_sysvec_apic_timer_interrupt_ns
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   `-- stop_machine.o:(.text):undefined-reference-to-hrtimer_interrupt_get_debug
|-- parisc-defconfig
|   |-- (.text):undefined-reference-to-hrtimer_interrupt_get_debug
|   |-- hppa-linux-ld:(.text):undefined-reference-to-get_sysvec_apic_timer_interrupt_ns
|   |-- hppa-linux-ld:(.text):undefined-reference-to-tick_program_event_get_debug
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- parisc-randconfig-r015-20210903
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- parisc-randconfig-r031-20210903
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- powerpc-allmodconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:no-previous-prototype-for-tick_program_event_get_debug
|-- powerpc-allnoconfig
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- powerpc-allyesconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:no-previous-prototype-for-tick_program_event_get_debug
|-- powerpc-mpc512x_defconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- powerpc-randconfig-r015-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- powerpc-sequoia_defconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- powerpc64-allnoconfig
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- powerpc64-randconfig-m031-20210904
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- powerpc64-randconfig-s031-20210904
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:no-previous-prototype-for-tick_program_event_get_debug
|-- powerpc64-randconfig-s032-20210904
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- riscv-alldefconfig
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- riscv-allmodconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|-- riscv-allnoconfig
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- riscv-allyesconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|-- riscv-defconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|-- riscv-nommu_k210_defconfig
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- riscv-nommu_virt_defconfig
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- riscv-randconfig-r042-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- riscv64-linux-ld:stop_machine.c:(.text):undefined-reference-to-get_sysvec_apic_timer_interrupt_ns
|   |-- riscv64-linux-ld:stop_machine.c:(.text):undefined-reference-to-tick_program_event_get_debug
|   `-- stop_machine.c:(.text):undefined-reference-to-hrtimer_interrupt_get_debug
|-- riscv-rv32_defconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- s390-allmodconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   |-- kernel-time-tick-oneshot.c:warning:no-previous-prototype-for-tick_program_event_get_debug
|   |-- s390-linux-ld:stop_machine.c:(.text):undefined-reference-to-get_api_timer_irqs
|   `-- stop_machine.c:(.text):undefined-reference-to-get_sysvec_apic_timer_interrupt_ns
|-- s390-allyesconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   |-- kernel-time-tick-oneshot.c:warning:no-previous-prototype-for-tick_program_event_get_debug
|   |-- s390-linux-ld:stop_machine.c:(.text):undefined-reference-to-get_api_timer_irqs
|   `-- stop_machine.c:(.text):undefined-reference-to-get_sysvec_apic_timer_interrupt_ns
|-- s390-buildonly-randconfig-r001-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- s390-linux-ld:stop_machine.c:(.text):undefined-reference-to-get_api_timer_irqs
|-- s390-defconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   |-- kernel-time-tick-oneshot.c:warning:no-previous-prototype-for-tick_program_event_get_debug
|   |-- s390-linux-ld:stop_machine.c:(.text):undefined-reference-to-get_api_timer_irqs
|   `-- stop_machine.c:(.text):undefined-reference-to-get_sysvec_apic_timer_interrupt_ns
|-- s390-randconfig-r011-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|-- s390-randconfig-r012-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- s390-linux-ld:stop_machine.c:(.text):undefined-reference-to-get_api_timer_irqs
|-- s390-randconfig-r044-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-tick-oneshot.c:warning:no-previous-prototype-for-tick_program_event_get_debug
|   |-- s390-linux-ld:stop_machine.c:(.text):undefined-reference-to-get_api_timer_irqs
|   `-- s390-linux-ld:stop_machine.c:(.text):undefined-reference-to-get_sysvec_apic_timer_interrupt_ns
|-- sh-allmodconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- sh-rsk7201_defconfig
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- sparc-allyesconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|-- sparc-defconfig
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- sparc-randconfig-r014-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|-- sparc-randconfig-r033-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|-- sparc-randconfig-r035-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- sparc-sparc32_defconfig
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- sparc64-randconfig-r001-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|-- sparc64-randconfig-r034-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|-- sparc64-randconfig-r035-20210903
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- um-i386_defconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- um-x86_64_defconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|-- x86_64-allmodconfig
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- x86_64-allyesconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|-- x86_64-defconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|-- x86_64-kexec
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|-- x86_64-randconfig-c022-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|-- x86_64-randconfig-c023-20210903
|   |-- kernel-stop_machine.c:undefined-reference-to-hrtimer_interrupt_get_debug
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- x86_64-rhel-8.3
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|-- x86_64-rhel-8.3-kselftests
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|-- xtensa-allnoconfig
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|-- xtensa-allyesconfig
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- xtensa-randconfig-r014-20210903
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug
`-- xtensa-randconfig-r015-20210903
    `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-__run_hrtimer_get_debug

clang_recent_errors
|-- arm-randconfig-r011-20210903
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-function-__run_hrtimer_get_debug
|-- arm-randconfig-r013-20210903
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-function-__run_hrtimer_get_debug
|-- arm64-randconfig-r032-20210903
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-function-__run_hrtimer_get_debug
|-- hexagon-randconfig-r012-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-function-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-function-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:no-previous-prototype-for-function-tick_program_event_get_debug
|-- hexagon-randconfig-r041-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-function-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:no-previous-prototype-for-function-tick_program_event_get_debug
|-- hexagon-randconfig-r045-20210903
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-function-__run_hrtimer_get_debug
|-- i386-randconfig-r002-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-function-__run_hrtimer_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:no-previous-prototype-for-function-tick_program_event_get_debug
|-- mips-randconfig-r016-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-function-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-function-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:no-previous-prototype-for-function-tick_program_event_get_debug
|-- powerpc-randconfig-r005-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-function-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-function-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:no-previous-prototype-for-function-tick_program_event_get_debug
|-- powerpc64-buildonly-randconfig-r003-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-function-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-function-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:no-previous-prototype-for-function-tick_program_event_get_debug
|-- powerpc64-randconfig-r003-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-function-__run_hrtimer_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:no-previous-prototype-for-function-tick_program_event_get_debug
|-- powerpc64-randconfig-r031-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-function-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-function-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:no-previous-prototype-for-function-tick_program_event_get_debug
|-- x86_64-buildonly-randconfig-r002-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-function-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-function-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:no-previous-prototype-for-function-tick_program_event_get_debug
|-- x86_64-buildonly-randconfig-r006-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-function-__run_hrtimer_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:no-previous-prototype-for-function-tick_program_event_get_debug
|-- x86_64-randconfig-a001-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-function-__run_hrtimer_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:no-previous-prototype-for-function-tick_program_event_get_debug
|-- x86_64-randconfig-a002-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-function-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-function-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:no-previous-prototype-for-function-tick_program_event_get_debug
|-- x86_64-randconfig-a003-20210903
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-function-__run_hrtimer_get_debug
|-- x86_64-randconfig-a004-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-function-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-function-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:no-previous-prototype-for-function-tick_program_event_get_debug
|-- x86_64-randconfig-a005-20210903
|   `-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-function-__run_hrtimer_get_debug
|-- x86_64-randconfig-a006-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-function-__run_hrtimer_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:no-previous-prototype-for-function-tick_program_event_get_debug
|-- x86_64-randconfig-r033-20210903
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-function-__run_hrtimer_get_debug
|   |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-function-hrtimer_interrupt_get_debug
|   `-- kernel-time-tick-oneshot.c:warning:no-previous-prototype-for-function-tick_program_event_get_debug
`-- x86_64-randconfig-r034-20210903
    |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-function-__run_hrtimer_get_debug
    |-- kernel-time-hrtimer.c:warning:no-previous-prototype-for-function-hrtimer_interrupt_get_debug
    `-- kernel-time-tick-oneshot.c:warning:no-previous-prototype-for-function-tick_program_event_get_debug

elapsed time: 1501m

configs tested: 84
configs skipped: 4

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         s3c6400_defconfig
riscv                            alldefconfig
arm                       cns3420vb_defconfig
m68k                       bvme6000_defconfig
sparc                       sparc32_defconfig
powerpc                     mpc512x_defconfig
sh                   sh7724_generic_defconfig
arm                         nhk8815_defconfig
arm                     davinci_all_defconfig
mips                           gcw0_defconfig
sh                           se7724_defconfig
arm                          pcm027_defconfig
mips                       capcella_defconfig
powerpc                     sequoia_defconfig
mips                       rbtx49xx_defconfig
m68k                            mac_defconfig
arm                           tegra_defconfig
sh                          rsk7201_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a012-20210903
i386                 randconfig-a015-20210903
i386                 randconfig-a011-20210903
i386                 randconfig-a013-20210903
i386                 randconfig-a014-20210903
i386                 randconfig-a016-20210903
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210903
x86_64               randconfig-a006-20210903
x86_64               randconfig-a003-20210903
x86_64               randconfig-a005-20210903
x86_64               randconfig-a001-20210903
x86_64               randconfig-a002-20210903
hexagon              randconfig-r045-20210903
hexagon              randconfig-r041-20210903

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
