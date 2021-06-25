Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDFE3B41BF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 12:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbhFYKh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 06:37:59 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:7730 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229956AbhFYKh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 06:37:56 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4GBD0z3dZ6zB9GQ;
        Fri, 25 Jun 2021 12:35:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DPWbp_anq0a9; Fri, 25 Jun 2021 12:35:31 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4GBD0y1tdWzB9HV;
        Fri, 25 Jun 2021 12:35:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3003D8B802;
        Fri, 25 Jun 2021 12:35:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id yWD0eHdKLnYP; Fri, 25 Jun 2021 12:35:25 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 617A68B7FF;
        Fri, 25 Jun 2021 12:35:24 +0200 (CEST)
Subject: Re: [PATCH] powerpc: mark local variables around longjmp as volatile
To:     Arnd Bergmann <arnd@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
References: <20210429080708.1520360-1-arnd@kernel.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <5e3a48a2-3ce2-fadb-ee3d-4241bacf618f@csgroup.eu>
Date:   Fri, 25 Jun 2021 12:35:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210429080708.1520360-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 29/04/2021 à 10:06, Arnd Bergmann a écrit :
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc-11 points out that modifying local variables next to a
> longjmp/setjmp may cause undefined behavior:
> 
> arch/powerpc/kexec/crash.c: In function 'crash_kexec_prepare_cpus.constprop':
> arch/powerpc/kexec/crash.c:108:22: error: variable 'ncpus' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbere
> d]
> arch/powerpc/kexec/crash.c:109:13: error: variable 'tries' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbere
> d]
> arch/powerpc/xmon/xmon.c: In function 'xmon_print_symbol':
> arch/powerpc/xmon/xmon.c:3625:21: error: variable 'name' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
> arch/powerpc/xmon/xmon.c: In function 'stop_spus':
> arch/powerpc/xmon/xmon.c:4057:13: error: variable 'i' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
> arch/powerpc/xmon/xmon.c: In function 'restart_spus':
> arch/powerpc/xmon/xmon.c:4098:13: error: variable 'i' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
> arch/powerpc/xmon/xmon.c: In function 'dump_opal_msglog':
> arch/powerpc/xmon/xmon.c:3008:16: error: variable 'pos' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
> arch/powerpc/xmon/xmon.c: In function 'show_pte':
> arch/powerpc/xmon/xmon.c:3207:29: error: variable 'tsk' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
> arch/powerpc/xmon/xmon.c: In function 'show_tasks':
> arch/powerpc/xmon/xmon.c:3302:29: error: variable 'tsk' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
> arch/powerpc/xmon/xmon.c: In function 'xmon_core':
> arch/powerpc/xmon/xmon.c:494:13: error: variable 'cmd' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
> arch/powerpc/xmon/xmon.c:860:21: error: variable 'bp' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
> arch/powerpc/xmon/xmon.c:860:21: error: variable 'bp' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
> arch/powerpc/xmon/xmon.c:492:48: error: argument 'fromipi' might be clobbered by 'longjmp' or 'vfork' [-Werror=clobbered]
> 
> According to the documentation, marking these as 'volatile' is
> sufficient to avoid the problem, and it shuts up the warning.


I think this change deserves some comment in the code, and maybe also an update of 
https://www.kernel.org/doc/html/latest/process/volatile-considered-harmful.html

Otherwise, there's a risk that one day or another, someone removes those 'volatile' markings.

Christophe


> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/powerpc/kexec/crash.c |  4 ++--
>   arch/powerpc/xmon/xmon.c   | 22 +++++++++++-----------
>   2 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
> index 0196d0c211ac..10f997e6bb95 100644
> --- a/arch/powerpc/kexec/crash.c
> +++ b/arch/powerpc/kexec/crash.c
> @@ -105,8 +105,8 @@ void crash_ipi_callback(struct pt_regs *regs)
>   static void crash_kexec_prepare_cpus(int cpu)
>   {
>   	unsigned int msecs;
> -	unsigned int ncpus = num_online_cpus() - 1;/* Excluding the panic cpu */
> -	int tries = 0;
> +	volatile unsigned int ncpus = num_online_cpus() - 1;/* Excluding the panic cpu */
> +	volatile int tries = 0;
>   	int (*old_handler)(struct pt_regs *regs);
>   
>   	printk(KERN_EMERG "Sending IPI to other CPUs\n");
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index c8173e92f19d..ce0eacf77645 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -489,10 +489,10 @@ static void xmon_touch_watchdogs(void)
>   	touch_nmi_watchdog();
>   }
>   
> -static int xmon_core(struct pt_regs *regs, int fromipi)
> +static int xmon_core(struct pt_regs *regs, volatile int fromipi)
>   {
> -	int cmd = 0;
> -	struct bpt *bp;
> +	volatile int cmd = 0;
> +	struct bpt *volatile bp;
>   	long recurse_jmp[JMP_BUF_LEN];
>   	bool locked_down;
>   	unsigned long offset;
> @@ -857,7 +857,7 @@ static inline void force_enable_xmon(void)
>   static struct bpt *at_breakpoint(unsigned long pc)
>   {
>   	int i;
> -	struct bpt *bp;
> +	struct bpt *volatile bp;
>   
>   	bp = bpts;
>   	for (i = 0; i < NBPTS; ++i, ++bp)
> @@ -3005,7 +3005,7 @@ static void dump_opal_msglog(void)
>   {
>   	unsigned char buf[128];
>   	ssize_t res;
> -	loff_t pos = 0;
> +	volatile loff_t pos = 0;
>   
>   	if (!firmware_has_feature(FW_FEATURE_OPAL)) {
>   		printf("Machine is not running OPAL firmware.\n");
> @@ -3160,7 +3160,7 @@ memzcan(void)
>   		printf("%.8lx\n", a - mskip);
>   }
>   
> -static void show_task(struct task_struct *tsk)
> +static void show_task(struct task_struct *volatile tsk)
>   {
>   	char state;
>   
> @@ -3204,7 +3204,7 @@ static void format_pte(void *ptep, unsigned long pte)
>   static void show_pte(unsigned long addr)
>   {
>   	unsigned long tskv = 0;
> -	struct task_struct *tsk = NULL;
> +	struct task_struct *volatile tsk = NULL;
>   	struct mm_struct *mm;
>   	pgd_t *pgdp;
>   	p4d_t *p4dp;
> @@ -3299,7 +3299,7 @@ static void show_pte(unsigned long addr)
>   static void show_tasks(void)
>   {
>   	unsigned long tskv;
> -	struct task_struct *tsk = NULL;
> +	struct task_struct *volatile tsk = NULL;
>   
>   	printf("     task_struct     ->thread.ksp    ->thread.regs    PID   PPID S  P CMD\n");
>   
> @@ -3622,7 +3622,7 @@ static void xmon_print_symbol(unsigned long address, const char *mid,
>   			      const char *after)
>   {
>   	char *modname;
> -	const char *name = NULL;
> +	const char *volatile name = NULL;
>   	unsigned long offset, size;
>   
>   	printf(REG, address);
> @@ -4054,7 +4054,7 @@ void xmon_register_spus(struct list_head *list)
>   static void stop_spus(void)
>   {
>   	struct spu *spu;
> -	int i;
> +	volatile int i;
>   	u64 tmp;
>   
>   	for (i = 0; i < XMON_NUM_SPUS; i++) {
> @@ -4095,7 +4095,7 @@ static void stop_spus(void)
>   static void restart_spus(void)
>   {
>   	struct spu *spu;
> -	int i;
> +	volatile int i;
>   
>   	for (i = 0; i < XMON_NUM_SPUS; i++) {
>   		if (!spu_info[i].spu)
> 
