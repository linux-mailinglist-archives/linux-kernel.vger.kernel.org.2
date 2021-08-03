Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43813DF668
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 22:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhHCUbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 16:31:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229935AbhHCUbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 16:31:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4214260F56;
        Tue,  3 Aug 2021 20:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628022673;
        bh=awjUccGQayRDRtNZRBwmZn//tWOKuD4QnjO8gbxNR8c=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=W9cP1MJoNRvfpwr+BjaEnNvWHaCbxlndMerd1ffTx9a0/Pxf7PUokcuLnF+qfJPZK
         newAcMvP94TvDkx8rKRHbZwhY0OVOV1ERD3bkfnulqFxrSfy+7Fe/pPTQFefOwpCf6
         bwL67EO2u/UDOay/fygpTNsFDEElVaEicGG6QFpVqudlHswkISYbLCumPn9tM6dAbc
         MDXhtae20GwswAkbGUslLhct+ngGSe0HCFjEMeBFC4NC/1p4M0Tgt3BVR3GLYWhnGR
         tKABPVLOOGXYth3fwn9S9Jc+2YXntNngCSGCVHHITP5+LAWaRSGTRcpKHRFxEm3+WW
         XA2174GtV0yOg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0E0485C04D4; Tue,  3 Aug 2021 13:31:13 -0700 (PDT)
Date:   Tue, 3 Aug 2021 13:31:13 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2021.07.27b 33/57] kernel/cpu.c:155:6: error:
 conflicting types for 'cpu_hp_check_delay'
Message-ID: <20210803203113.GV4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202108040359.rVW1hCYi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202108040359.rVW1hCYi-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 03:32:04AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.07.27b
> head:   11e66439ec35a4e59ab0bafdc33b56f395cc3b49
> commit: b2bdd2a98b4b3b955b4f226cea37372ec04874af [33/57] EXP cpu: Add yet more CPU-hotplug progress debugging code
> config: arc-allyesconfig (attached as .config)
> compiler: arceb-elf-gcc (GCC) 10.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=b2bdd2a98b4b3b955b4f226cea37372ec04874af
>         git remote add rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>         git fetch --no-tags rcu dev.2021.07.27b
>         git checkout b2bdd2a98b4b3b955b4f226cea37372ec04874af
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

This is in experimental code that is not to be mainlined, but may as
well fix it.  Does the patch below do it for you?

							Thanx, Paul

------------------------------------------------------------------------

commit fb843d5528f5b743729424561673203a71dd71de
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Tue Aug 3 13:29:03 2021 -0700

    EXP cpu: Correctly place cpu_hp_start_now declarations
    
    Reported-by: kernel test robot <lkp@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 93b9a28ea2bcd..143e5c445068b 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -88,6 +88,7 @@ extern ssize_t arch_cpu_release(const char *, size_t);
 #define CPU_BROKEN		0x000B /* CPU did not die properly */
 
 #ifdef CONFIG_SMP
+extern void cpu_hp_start_now(void);
 extern bool cpuhp_tasks_frozen;
 int add_cpu(unsigned int cpu);
 int cpu_device_up(struct device *dev);
@@ -98,6 +99,7 @@ int bringup_hibernate_cpu(unsigned int sleep_cpu);
 void bringup_nonboot_cpus(unsigned int setup_max_cpus);
 
 #else	/* CONFIG_SMP */
+static inline void cpu_hp_start_now(void) { }
 #define cpuhp_tasks_frozen	0
 
 static inline void cpu_maps_update_begin(void)
@@ -128,7 +130,6 @@ void clear_tasks_mm_cpumask(int cpu);
 int remove_cpu(unsigned int cpu);
 int cpu_device_down(struct device *dev);
 extern void smp_shutdown_nonboot_cpus(unsigned int primary_cpu);
-extern void cpu_hp_start_now(void);
 extern void cpu_hp_stop_now(void);
 extern bool cpu_hp_check_delay(const char *s, const void *func);
 
@@ -144,7 +145,6 @@ static inline void cpu_hotplug_disable(void) { }
 static inline void cpu_hotplug_enable(void) { }
 static inline int remove_cpu(unsigned int cpu) { return -EPERM; }
 static inline void smp_shutdown_nonboot_cpus(unsigned int primary_cpu) { }
-static inline void cpu_hp_start_now(void) { }
 static inline void cpu_hp_stop_now(void) { }
 static inline bool cpu_hp_check_delay(const char *s, void *func) { return false; }
 #endif	/* !CONFIG_HOTPLUG_CPU */
