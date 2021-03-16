Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EECC33D7F3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 16:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237176AbhCPPpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 11:45:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46734 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233069AbhCPPpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615909517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Rzi/DnuxqTWJ4y4tp35WijHklZugQQcG9SEJZITAfw4=;
        b=hsjYjQb5+hRsKgWH8VXxKe22bzReWpva2vW8P+E9sQz9dJpo3iTwkN7jcldQQyVvEfxAeM
        pCQqAFPCdCRM5J3wCH+NpjZW1EA56B5OSPR8snG/U7pCSpGYHx3K7O4kthvOZvbtJ8kn1d
        oQFdMCTrPZ20q7TzDpegTBpn41Z1yzw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-itSH1_z_Pkivesq8IZt6Mw-1; Tue, 16 Mar 2021 11:45:13 -0400
X-MC-Unique: itSH1_z_Pkivesq8IZt6Mw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB609100C660;
        Tue, 16 Mar 2021 15:45:11 +0000 (UTC)
Received: from krava (unknown [10.40.193.217])
        by smtp.corp.redhat.com (Postfix) with SMTP id E6B8F1F410;
        Tue, 16 Mar 2021 15:45:02 +0000 (UTC)
Date:   Tue, 16 Mar 2021 16:45:02 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     x86@kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Stanislav Kozina <skozina@redhat.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Pierre Amadio <pamadio@redhat.com>, onatalen@redhat.com,
        darcari@redhat.com
Subject: unknown NMI on AMD Rome
Message-ID: <YFDSSxftYw9tCGC6@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
when running 'perf top' on AMD Rome (/proc/cpuinfo below)
with fedora 33 kernel 5.10.22-200.fc33.x86_64

we got unknown NMI messages:

[  226.700160] Uhhuh. NMI received for unknown reason 3d on CPU 90.
[  226.700162] Do you have a strange power saving mode enabled?
[  226.700163] Dazed and confused, but trying to continue
[  226.769565] Uhhuh. NMI received for unknown reason 3d on CPU 84.
[  226.769566] Do you have a strange power saving mode enabled?
[  226.769567] Dazed and confused, but trying to continue
[  226.769771] Uhhuh. NMI received for unknown reason 2d on CPU 24.
[  226.769773] Do you have a strange power saving mode enabled?
[  226.769774] Dazed and confused, but trying to continue
[  226.812844] Uhhuh. NMI received for unknown reason 2d on CPU 23.
[  226.812846] Do you have a strange power saving mode enabled?
[  226.812847] Dazed and confused, but trying to continue
[  226.893783] Uhhuh. NMI received for unknown reason 2d on CPU 27.
[  226.893785] Do you have a strange power saving mode enabled?
[  226.893786] Dazed and confused, but trying to continue
[  226.900139] Uhhuh. NMI received for unknown reason 2d on CPU 40.
[  226.900141] Do you have a strange power saving mode enabled?
[  226.900143] Dazed and confused, but trying to continue
[  226.908763] Uhhuh. NMI received for unknown reason 3d on CPU 120.
[  226.908765] Do you have a strange power saving mode enabled?
[  226.908766] Dazed and confused, but trying to continue
[  227.751296] Uhhuh. NMI received for unknown reason 2d on CPU 83.
[  227.751298] Do you have a strange power saving mode enabled?
[  227.751299] Dazed and confused, but trying to continue
[  227.752937] Uhhuh. NMI received for unknown reason 3d on CPU 23.

also when discussing ths with Borislav, he managed to reproduce easily
on his AMD Rome machine

any idea?

thanks,
jirka


---
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 23
model           : 49
model name      : AMD EPYC 7742 64-Core Processor
stepping        : 0
microcode       : 0x8301034
cpu MHz         : 1497.024
cache size      : 512 KB
physical id     : 0
siblings        : 64
core id         : 0
cpu cores       : 64
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 16
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate sme ssbd mba sev ibrs ibpb stibp vmmcall sev_es fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif umip rdpid overflow_recov succor smca
bugs            : sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
bogomips        : 4491.76
TLB size        : 3072 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 43 bits physical, 48 bits virtual
power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]

