Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F2133DE44
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 20:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238266AbhCPTyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 15:54:14 -0400
Received: from casper.infradead.org ([90.155.50.34]:33098 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbhCPTxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0OqpqIoIlZeXmzonyj8plWijbwmfzINlTvjLVXgNNBI=; b=cGJ0ux7wCVM1HDn7O1yHGCSKTZ
        HPzWlRRdegRk5SKhFIxA/nB25OcmiVcSKGbHH8IQdoT8wZuaQfF5SikrKc1CetEWhNjG35gdBLCjD
        q2pHuyLvRyZECpFBI8BozefBw2KDjK6CJfEL8FB0soNnqaV3VJUBnDNruzdZJgFp4tCX4TNhAy7+2
        pkI6GC85rhScjn+/j4ChV4Qt8rBIWuB6TNFmUL/sYPUr05jWHMqal80pyKe8DtSz3fIPdA0MSal/s
        haIz7fNGg2kPko1Tfpa8d/ZJbHr/DtC+PHTsX/T8P2Lo4CslapEEKboDha+pb4/WttWd57V1urQ3N
        PZFaHVmQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMFke-000XtH-6C; Tue, 16 Mar 2021 19:53:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 049BC3012DF;
        Tue, 16 Mar 2021 20:53:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E1EAD29A439E9; Tue, 16 Mar 2021 20:53:10 +0100 (CET)
Date:   Tue, 16 Mar 2021 20:53:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Stanislav Kozina <skozina@redhat.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Pierre Amadio <pamadio@redhat.com>, onatalen@redhat.com,
        darcari@redhat.com, kim.phillips@amd.com
Subject: Re: unknown NMI on AMD Rome
Message-ID: <YFEMpo6GxxJS9Wvl@hirez.programming.kicks-ass.net>
References: <YFDSSxftYw9tCGC6@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFDSSxftYw9tCGC6@krava>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 04:45:02PM +0100, Jiri Olsa wrote:
> hi,
> when running 'perf top' on AMD Rome (/proc/cpuinfo below)
> with fedora 33 kernel 5.10.22-200.fc33.x86_64
> 
> we got unknown NMI messages:
> 
> [  226.700160] Uhhuh. NMI received for unknown reason 3d on CPU 90.
> [  226.700162] Do you have a strange power saving mode enabled?
> [  226.700163] Dazed and confused, but trying to continue
> [  226.769565] Uhhuh. NMI received for unknown reason 3d on CPU 84.
> [  226.769566] Do you have a strange power saving mode enabled?
> [  226.769567] Dazed and confused, but trying to continue
> [  226.769771] Uhhuh. NMI received for unknown reason 2d on CPU 24.
> [  226.769773] Do you have a strange power saving mode enabled?
> [  226.769774] Dazed and confused, but trying to continue
> [  226.812844] Uhhuh. NMI received for unknown reason 2d on CPU 23.
> [  226.812846] Do you have a strange power saving mode enabled?
> [  226.812847] Dazed and confused, but trying to continue
> [  226.893783] Uhhuh. NMI received for unknown reason 2d on CPU 27.
> [  226.893785] Do you have a strange power saving mode enabled?
> [  226.893786] Dazed and confused, but trying to continue
> [  226.900139] Uhhuh. NMI received for unknown reason 2d on CPU 40.
> [  226.900141] Do you have a strange power saving mode enabled?
> [  226.900143] Dazed and confused, but trying to continue
> [  226.908763] Uhhuh. NMI received for unknown reason 3d on CPU 120.
> [  226.908765] Do you have a strange power saving mode enabled?
> [  226.908766] Dazed and confused, but trying to continue
> [  227.751296] Uhhuh. NMI received for unknown reason 2d on CPU 83.
> [  227.751298] Do you have a strange power saving mode enabled?
> [  227.751299] Dazed and confused, but trying to continue
> [  227.752937] Uhhuh. NMI received for unknown reason 3d on CPU 23.
> 
> also when discussing ths with Borislav, he managed to reproduce easily
> on his AMD Rome machine
> 
> any idea?

Kim is the AMD point person for this I think..

> 
> thanks,
> jirka
> 
> 
> ---
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 23
> model           : 49
> model name      : AMD EPYC 7742 64-Core Processor
> stepping        : 0
> microcode       : 0x8301034
> cpu MHz         : 1497.024
> cache size      : 512 KB
> physical id     : 0
> siblings        : 64
> core id         : 0
> cpu cores       : 64
> apicid          : 0
> initial apicid  : 0
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 16
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate sme ssbd mba sev ibrs ibpb stibp vmmcall sev_es fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif umip rdpid overflow_recov succor smca
> bugs            : sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
> bogomips        : 4491.76
> TLB size        : 3072 4K pages
> clflush size    : 64
> cache_alignment : 64
> address sizes   : 43 bits physical, 48 bits virtual
> power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
> 
