Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF256413FC3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 04:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhIVCuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 22:50:39 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:19995 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhIVCui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 22:50:38 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HDjLv341nzbmbj;
        Wed, 22 Sep 2021 10:44:55 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 22 Sep 2021 10:49:06 +0800
Received: from DESKTOP-R64PNO0.china.huawei.com (10.67.102.35) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 22 Sep 2021 10:49:06 +0800
From:   JinHui GUO <guojinhui@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <guojinhui@huawei.com>, <linux-kernel@vger.kernel.org>,
        <peterz@infradead.org>, <pmladek@suse.com>,
        <valentin.schneider@arm.com>
Subject: Re: [PATCH] [RFC] watchdog/softlockup: Fix softlockup_stop_all() hungtask bug
Date:   Wed, 22 Sep 2021 10:49:05 +0800
Message-ID: <20210922024905.1488-1-guojinhui@huawei.com>
X-Mailer: git-send-email 2.32.0.windows.2
In-Reply-To: <20210916124413.89735fd447667b627552df55@linux-foundation.org>
References: <20210916124413.89735fd447667b627552df55@linux-foundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.102.35]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> x86_64 allnoconfig:

> ld: arch/x86/kernel/cpu/cacheinfo.o: in function `populate_cache_leaves':
> cacheinfo.c:(.text+0xa27): undefined reference to `cpu_llc_shared_map'
> ld: cacheinfo.c:(.text+0xa49): undefined reference to `cpu_llc_shared_map'

> Because the new for_each_cpu() now references `mask' and some code isn't
> able to handle that change.  There are probably other instances of this
> across all our architectures and configs.

There is another bug in file arch/x86/include/asm/smp.h. The per-cpu value
cpu_llc_shared_map is defined in file arch/x86/kernel/smpboot.c. But the
file arch/x86/kernel/smpboot.c would not be compiled while CONFIG_SMP is
not defined.

declared in file arch/x86/include/asm/smp.h:
DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);

defined in file arch/x86/kernel/smpboot.c:
DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);

the stack:
cpu_llc_shared_map
cpu_llc_shared_mask
__cache_amd_cpumap_setup
__cache_cpumap_setup
populate_cache_leaves

CONFIG_SMP in makefile arch/x86/kernel/Makefile:
obj-$(CONFIG_SMP)               += smpboot.o

cpu_llc_shared_mask is just used in arch/x86/kernel/cpu/cacheinfo.c by for_each_cpu
while CONFIG_SMP is not defined:
./arch/x86/kernel/cpu/cacheinfo.c:889:          for_each_cpu(i, cpu_llc_shared_mask(cpu)) {
./arch/x86/kernel/cpu/cacheinfo.c:894:                  for_each_cpu(sibling, cpu_llc_shared_mask(cpu)) {
./arch/x86/include/asm/smp.h:22:static inline struct cpumask *cpu_llc_shared_mask(int cpu)

It can be fixed just as follow:

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h1
index 630ff08532be..f5d3ca5696b3 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -21,7 +21,12 @@ DECLARE_PER_CPU_READ_MOSTLY(int, cpu_number);

 static inline struct cpumask *cpu_llc_shared_mask(int cpu)
 {
+#ifdef CONFIG_SMP
        return per_cpu(cpu_llc_shared_map, cpu);
+#else
+ /* cpu_llc_shared_map is not defined while !CONFIG_SMP */
+ return cpu_all_mask;
+#endif
 }

 DECLARE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_cpu_to_apicid);
