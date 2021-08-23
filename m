Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D403D3F53C1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 01:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbhHWXra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 19:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbhHWXrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 19:47:24 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC950C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 16:46:41 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id g8so4110810ilc.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 16:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DoLC1EF3mIR0GlW76GBSt/BwmQNgwhehtB+DBCRZ1+A=;
        b=ieObiuqzWjKenmS5fhA2KlEkngO02xDQilv8lvyC4D+Pum4HGeAM9YxrBJ5RPaEH5c
         PGwcQsuTYK9YcMbFvagX/tRluioVmxc7JQ/E+ZVw74iOQ6LsUBKtpPK4jaP5BXHtEL4x
         SmlfHvpixi+DllUCXuPzWjk6zA/bHNc5X7kKlPwDC7KYnYUitdlnuKoubqVwn2cV7gOG
         ulU1tZsjuJop5z0MpLhwF91iwokwJU9Z3bomsD5Bk6Y7d8MArYcUfNpo8XIx8Hi+8Kxs
         KqiQ43yho6JDD+dtIDSv50yTeg4macRVXUgyVaAuhZWmWsa290Q1RghpXqQhiy4RJxzC
         WFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DoLC1EF3mIR0GlW76GBSt/BwmQNgwhehtB+DBCRZ1+A=;
        b=gohuDRRd9w++Z32QHeBwZYbRmIab5Pkqa1KhUq4TFTEixQZyvAhfTIMBBDQKvZuDKM
         JhTJkFOlT43hwPjAJFU5CLvXsQVFSTZbiBhfeRPgFU4zy2SCRL3hidwnGWQmemaPu6iV
         5sC4LreIHek2Y61Ws0J9JLak1QEZpUPitYg93AwU37M8v+YMn5bKyIPYXIwbd+brXaWf
         rInU+Km+bwO+U7ir4zhBAC11aGuJPhovLMseysWnRVkIrUwo/GkiKaMTyVVFCYwSyFyo
         zTeUmQpdV6hPy+sYWG3I0Wltqje+F4VSHfaNgfxRzhvMTaLOgB4UmyZ4407XOvZNUD76
         Uulw==
X-Gm-Message-State: AOAM530f5E/ijFdL/6AJkSr3r16PXUBvDxN3MxZ4mFrWL6iHjo/CdPeq
        KysUxYweyqxhxV3N1LYSXuOc3GoaGkPkt50FBnXoKw==
X-Google-Smtp-Source: ABdhPJyUnfiO2iZsMzYl0bECsz2yA5wsBXuFbRA5eIkM+UStG915jCcxL3fRugWbjAHUfvQrnihJ/kDPcNr29FpWrqY=
X-Received: by 2002:a05:6e02:524:: with SMTP id h4mr24801438ils.203.1629762401039;
 Mon, 23 Aug 2021 16:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210820225002.310652-1-seanjc@google.com> <20210820225002.310652-6-seanjc@google.com>
In-Reply-To: <20210820225002.310652-6-seanjc@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Mon, 23 Aug 2021 16:46:30 -0700
Message-ID: <CANgfPd_Vh52oWyMMcqL2iTVgcXQp3QDsM5MrAZxr=xe33rPMhg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] KVM: selftests: Remove __NR_userfaultfd syscall fallback
To:     Sean Christopherson <seanjc@google.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, linux-csky@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Peter Foley <pefoley@google.com>,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 3:50 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Revert the __NR_userfaultfd syscall fallback added for KVM selftests now
> that x86's unistd_{32,63}.h overrides are under uapi/ and thus not in
> KVM sefltests' search path, i.e. now that KVM gets x86 syscall numbers
> from the installed kernel headers.
>
> No functional change intended.
>
> Cc: Ben Gardon <bgardon@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Ben Gardon <bgardon@google.com>

> ---
>  tools/arch/x86/include/uapi/asm/unistd_64.h | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/tools/arch/x86/include/uapi/asm/unistd_64.h b/tools/arch/x86/include/uapi/asm/unistd_64.h
> index 4205ed4158bf..cb52a3a8b8fc 100644
> --- a/tools/arch/x86/include/uapi/asm/unistd_64.h
> +++ b/tools/arch/x86/include/uapi/asm/unistd_64.h
> @@ -1,7 +1,4 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __NR_userfaultfd
> -#define __NR_userfaultfd 282
> -#endif
>  #ifndef __NR_perf_event_open
>  # define __NR_perf_event_open 298
>  #endif
> --
> 2.33.0.rc2.250.ged5fa647cd-goog
>
