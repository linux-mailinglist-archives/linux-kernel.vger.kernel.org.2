Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D792D315367
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 17:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbhBIQHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 11:07:10 -0500
Received: from mout.gmx.net ([212.227.15.19]:53773 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232498AbhBIQHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 11:07:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612886716;
        bh=liCVqJdInexFlkdxrzLiLbdT1xrkjtEKp5UIHNNtXWA=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Elu4VYpQ6ve9DrQEvTe2dWlFyljm5cXtVPwSA5AlVmnR0uxnO5Wje/9/a8f+0ZIo1
         VSMYKuhG4Joa88N+ZUHW65ko4lK69dQKnUGVTwqEpXh+i9OqRvihHXVkjH8UevzzcB
         XA1gnhXMLCRJCyRQkCJegVQa6EJmKaTAsqT+Wd0g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.148.88]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRTN9-1lWwDB2dJl-00NNTF; Tue, 09
 Feb 2021 17:05:16 +0100
Message-ID: <269ee10aac93d819e48dc81f09a01d01fcd44fb1.camel@gmx.de>
Subject: Re: [patch] preempt: select PREEMPT_DYNAMIC under PREEMPTION
 instead of PREEMPT
From:   Mike Galbraith <efault@gmx.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Tue, 09 Feb 2021 17:05:14 +0100
In-Reply-To: <YCKmhnoSKgdYqxOL@hirez.programming.kicks-ass.net>
References: <7d129a84b0858fd7fbc3e38ede62a848fbec536e.camel@gmx.de>
         <YCKmhnoSKgdYqxOL@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pZx4QK4pVBFrORvuoq1W+J2gWqL45/dAjkg17xfmzCDnh1nmxCD
 dvO/7mW0PRT48Bbs6rVuGWPRASHDDRbBIUgs4F4/mHc1/9F8GBgstBxr6SGaKzWcj0aicn/
 OZhAHCy1Q9mJWvgZ9EvBaTlu/KQHFlv2faXIq//kb2t1ZzecCje3N65NLx5NqfUWprhBXqA
 DQwvG+l+1ug7tbJaQxiRg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vo5txAL6DN8=:xX/m2t+aqtyUwP6yIGcdqk
 DiNQtzGujqf9eIM7MSlrUYwtcpSTfw7f/4IuAeXTsyhdMleuL95nKudi9O23FyHVQkxKaxm7Z
 Mrp26gUKA6jntXYRTAT0NtdPtlMJKBtCvdRh3OQnc3p86/yP1jZcFdy7SpI6rEWZXI1zNVAT8
 MvtTWKfkyunH7RPJZIiCtHkHes9Bq0y9aiqiYPltl0gI4w5rDdKKjwTdXGHWnU0ArAkR4Kh1+
 yuMIjaownE0OBOgXhO1S2kazWFukqgsrQ1uyvpQnRJ4GI3zFRJ3nOLgUWekAAVph2C2m2rbze
 YrBZuSqCU2wexnbWZv895m2j73XIxKIJwYNNzeKC+FvefTE6nnmZsNTbePQ/4gtdWCwa9XWXt
 oaADCzqEOHlhR3Pibbae3hBd+U1VLaBLQdllx4tfJ14sdsf3IwdarqIxa3VpFbWdJ1vQ8dmej
 q2YhFKHcv/u7EU19EsWxRJ8rLo1D7lS6wnK/FAN+F/V5bY3T2tGk+96SXE+L4cdOYrGzzJmS9
 7nY9DMg2rNymD0bbBnhXP+/ucFRWp5py8fgQkco1j3LRYOtwAmgf6zx5ocLiOPXThz54/xvyT
 9xNUe/OCfXJhy8wxXBSb2Ve7DYtMMLVGUKNxs7FqjVc6xy56hiYuRU6nIgR2OdqOCjwR7ha50
 8wZSuEyCHrUjl7ZVM8Ry2P0Qh18EoRWxy0024G3P83BoTyg/pUxPmgxTYkT6L7EbSdZVuIn0c
 8N7NuLUE3q/47ASZqPLp6/sVS/263l3onzCcLcQy9zhWyCpr7fUEaB1khygsgsAqBlnYf1i7h
 Km2+RVUpc7hDf6Xixv9LdouO1PIMYVdm/+A5W4qNSt/0JWT9DIiAJzuFNccuT4dH3TeoNNnLA
 pTz5uVwU+ubrs8tJxrEg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-02-09 at 16:13 +0100, Peter Zijlstra wrote:
> On Tue, Feb 09, 2021 at 02:45:37PM +0100, Mike Galbraith wrote:
> >
> > PREEMPT_RT and PREEMPT both needs PREEMPT_DYNAMIC to build, so move
> > selection of PREEMPT_DYNAMIC to the common denominator, PREEMPTION.
>
> I'm confused, why would you want PREEMPT_DYNAMIC for
> PREEMPT_RT ?
>
> PREEMPT_RT without full preemption is just plain daft, no?

If you turn on PREEMPT, PREEMPT_DYNAMIC is selected because
HAVE_PREEMPT_DYNAMIC is true.

homer:..kernel/linux-tip # grep PREEMPT .config
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=3Dy
CONFIG_PREEMPT_COUNT=3Dy
CONFIG_PREEMPTION=3Dy
CONFIG_PREEMPT_DYNAMIC=3Dy
CONFIG_PREEMPT_RCU=3Dy
CONFIG_HAVE_PREEMPT_DYNAMIC=3Dy
CONFIG_PREEMPT_NOTIFIERS=3Dy
CONFIG_DRM_I915_PREEMPT_TIMEOUT=3D640
CONFIG_DEBUG_PREEMPT=3Dy
# CONFIG_PREEMPT_TRACER is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set

Now over to tip-rt, with patchlet...

homer:..kernel/linux-tip-rt # grep PREEMPT .config
CONFIG_HAVE_PREEMPT_LAZY=3Dy
CONFIG_PREEMPT_LAZY=3Dy
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_RT=3Dy
CONFIG_PREEMPT_COUNT=3Dy
CONFIG_PREEMPTION=3Dy
CONFIG_PREEMPT_DYNAMIC=3Dy
CONFIG_PREEMPT_RCU=3Dy
CONFIG_HAVE_PREEMPT_DYNAMIC=3Dy
CONFIG_PREEMPT_NOTIFIERS=3Dy
CONFIG_DRM_I915_PREEMPT_TIMEOUT=3D640
CONFIG_DEBUG_PREEMPT=3Dy
# CONFIG_PREEMPT_TRACER is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set

...tree builds/runs.  Pop patchlet, and...

  LD      vmlinux.o
  MODPOST vmlinux.symvers
  MODINFO modules.builtin.modinfo
  GEN     modules.builtin
  LD      .tmp_vmlinux.kallsyms1
ld: init/main.o: in function `trace_initcall_start':
/backup/usr/local/src/kernel/linux-tip-rt/./include/trace/events/initcall.=
h:27: undefined reference to `__SCT__preempt_schedule_notrace'
ld: init/main.o: in function `trace_initcall_finish':
/backup/usr/local/src/kernel/linux-tip-rt/./include/trace/events/initcall.=
h:48: undefined reference to `__SCT__preempt_schedule_notrace'
ld: init/main.o: in function `trace_initcall_level':
/backup/usr/local/src/kernel/linux-tip-rt/./include/trace/events/initcall.=
h:10: undefined reference to `__SCT__preempt_schedule_notrace'
ld: init/main.o:(.static_call_sites+0x4): undefined reference to `__SCK__p=
reempt_schedule_notrace'
ld: init/main.o:(.static_call_sites+0x14): undefined reference to `__SCK__=
preempt_schedule_notrace'
ld: init/main.o:(.static_call_sites+0x24): undefined reference to `__SCK__=
preempt_schedule_notrace'
ld: arch/x86/entry/vsyscall/vsyscall_64.o: in function `trace_emulate_vsys=
call':
/backup/usr/local/src/kernel/linux-tip-rt/arch/x86/entry/vsyscall/vsyscall=
_trace.h:10: undefined reference to `__SCT__preempt_schedule_notrace'
ld: arch/x86/entry/vsyscall/vsyscall_64.o:(.static_call_sites+0x4): undefi=
ned reference to `__SCK__preempt_schedule_notrace'
ld: arch/x86/events/amd/ibs.o: in function `ibs_eilvt_valid':
/backup/usr/local/src/kernel/linux-tip-rt/arch/x86/events/amd/ibs.c:865: u=
ndefined reference to `__SCT__preempt_schedule'
ld: arch/x86/events/amd/ibs.o: in function `force_ibs_eilvt_setup':
/backup/usr/local/src/kernel/linux-tip-rt/arch/x86/events/amd/ibs.c:923: u=
ndefined reference to `__SCT__preempt_schedule'
ld: /backup/usr/local/src/kernel/linux-tip-rt/arch/x86/events/amd/ibs.c:94=
3: undefined reference to `__SCT__preempt_schedule'
ld: arch/x86/events/amd/ibs.o: in function `ibs_eilvt_valid':
/backup/usr/local/src/kernel/linux-tip-rt/arch/x86/events/amd/ibs.c:865: u=
ndefined reference to `__SCT__preempt_schedule'
...


