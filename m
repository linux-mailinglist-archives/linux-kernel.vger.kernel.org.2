Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAA733F539
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 17:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbhCQQO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 12:14:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35131 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbhCQQOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 12:14:21 -0400
Received: from mail-lj1-f198.google.com ([209.85.208.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lMYoO-0004pp-C5
        for linux-kernel@vger.kernel.org; Wed, 17 Mar 2021 16:14:20 +0000
Received: by mail-lj1-f198.google.com with SMTP id 74so15167778ljj.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 09:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0jDtMXm/8T16SOq+1HnXbEs1YaZqdkGTSbVIUmw5XVM=;
        b=NpiGDI+j81ml7uWdxJocREBeE2jRuhlHClA8xBdIfRGrtawI2FPRmfi3sO4jyWXtmO
         BXR/be+IstKsFTamwEZXvVl3kMCawhIqrqcriYcMthC9P7XWKk2FmQdohqUn++ZevB01
         0O6KfkotAwPrRASJw8bx598lVvfG6opEl/5nLEG2Kz7w3aZQCWRk/x6E2DbZfxxKDcbG
         wx9k1BaPkVOyxW3yjl4BBvwdHeOp7NxzdLz1flCD++KMfJy3vz7faPSDT9TVbDOhZwTq
         S/3IjXBoap+3f+l5las7HAFcMq+bNJUbKAVQwakCAACLBC2AjvgEgm/Opx+hXhe4riVH
         jUag==
X-Gm-Message-State: AOAM532g+lyeiSw8av6Fzk2ldyDu4d1QHEIKNQMHCX/BXbtCU7LESSUW
        ZxJthcGPE/wGm9ZCMX6+bPAZqPb7WC6QSb1imn6oG7rCOp9+Ngc5zneAS5q8G0YblxsMJxK1d+y
        s4+aVLjfawS7NOCJBBpl7YolpzBle1X5KrBibmfqW8GaIkQHC834QLwYQCA==
X-Received: by 2002:a2e:921a:: with SMTP id k26mr2402759ljg.149.1615997659806;
        Wed, 17 Mar 2021 09:14:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoMNl4JfI1ze5jYbs/OcJMfKRIn3ZVTEPTj9gqmO3kk2zU7SPPj4sIufUPyeKy1wCqgL8r0d/8E+xSRnKpIXY=
X-Received: by 2002:a2e:921a:: with SMTP id k26mr2402749ljg.149.1615997659528;
 Wed, 17 Mar 2021 09:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <b8db79e6857c41dab4ef08bdf826ea7c47e3bafc.1615947283.git.josef@toxicpanda.com>
 <CAAd53p5Vh_+tUeEQx3xf_aLiCiKP1u5Y3VgYCUzZ82Kgtr-iYw@mail.gmail.com> <bebcaffc-d485-912d-0c42-c0781f9c7603@toxicpanda.com>
In-Reply-To: <bebcaffc-d485-912d-0c42-c0781f9c7603@toxicpanda.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 18 Mar 2021 00:14:07 +0800
Message-ID: <CAAd53p7eJk9EtMTLjB5i7RdoKA3WS1W4TRjQs08adi7iAux_jQ@mail.gmail.com>
Subject: Re: [PATCH][RESEND] Revert "PM: ACPI: reboot: Use S5 for reboot"
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 11:19 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 3/16/21 10:50 PM, Kai-Heng Feng wrote:
> > Hi,
> >
> > On Wed, Mar 17, 2021 at 10:17 AM Josef Bacik <josef@toxicpanda.com> wrote:
> >>
> >> This reverts commit d60cd06331a3566d3305b3c7b566e79edf4e2095.
> >>
> >> This patch causes a panic when rebooting my Dell Poweredge r440.  I do
> >> not have the full panic log as it's lost at that stage of the reboot and
> >> I do not have a serial console.  Reverting this patch makes my system
> >> able to reboot again.
> >
> > But this patch also helps many HP laptops, so maybe we should figure
> > out what's going on on Poweredge r440.
> > Does it also panic on shutdown?
> >
>
> Sure I'll test whatever to get it fixed, but I just wasted 3 days bisecting and
> lost a weekend of performance testing on btrfs because of this regression, so
> until you figure out how it broke it needs to be reverted so people don't have
> to figure out why reboot suddenly isn't working.

That's unfortunate to hear. However, I've been spending tons of time
on bisecting kernels. To me it's just a normal part of kernel
development so I won't call it "wasted".

Feel free to revert the patch though.

>
> Running "halt" has the same effect with and without your patch, it gets to
> "system halted" and just sits there without powering off.  Not entirely sure why
> that is, but there's no panic.

What about shutdown? pm_power_off_prepare() is used by shutdown but
it's not used by halt.

Kai-Heng

>
> The panic itself is lost, but I see there's an NMI and I have the RIP
>
> (gdb) list *('mwait_idle_with_hints.constprop.0'+0x4b)
> 0xffffffff816dabdb is in mwait_idle_with_hints
> (./arch/x86/include/asm/current.h:15).
> 10
> 11      DECLARE_PER_CPU(struct task_struct *, current_task);
> 12
> 13      static __always_inline struct task_struct *get_current(void)
> 14      {
> 15              return this_cpu_read_stable(current_task);
> 16      }
> 17
> 18      #define current get_current()
> 19
>
> <mwait_idle_with_hints.constprop.0>:    jmp    0xffffffff936dac02
> <mwait_idle_with_hints.constprop.0+0x72>
> <mwait_idle_with_hints.constprop.0+0x2>:        nopl   (%rax)
> <mwait_idle_with_hints.constprop.0+0x5>:        jmp    0xffffffff936dabac
> <mwait_idle_with_hints.constprop.0+0x1c>
> <mwait_idle_with_hints.constprop.0+0x7>:        nopl   (%rax)
> <mwait_idle_with_hints.constprop.0+0xa>:        mfence
> <mwait_idle_with_hints.constprop.0+0xd>:        mov    %gs:0x17bc0,%rax
> <mwait_idle_with_hints.constprop.0+0x16>:       clflush (%rax)
> <mwait_idle_with_hints.constprop.0+0x19>:       mfence
> <mwait_idle_with_hints.constprop.0+0x1c>:       xor    %edx,%edx
> <mwait_idle_with_hints.constprop.0+0x1e>:       mov    %rdx,%rcx
> <mwait_idle_with_hints.constprop.0+0x21>:       mov    %gs:0x17bc0,%rax
> <mwait_idle_with_hints.constprop.0+0x2a>:       monitor %rax,%rcx,%rdx
> <mwait_idle_with_hints.constprop.0+0x2d>:       mov    (%rax),%rax
> <mwait_idle_with_hints.constprop.0+0x30>:       test   $0x8,%al
> <mwait_idle_with_hints.constprop.0+0x32>:       jne    0xffffffff936dabdb
> <mwait_idle_with_hints.constprop.0+0x4b>
> <mwait_idle_with_hints.constprop.0+0x34>:       jmpq   0xffffffff936dabd0
> <mwait_idle_with_hints.constprop.0+0x40>
> <mwait_idle_with_hints.constprop.0+0x39>:       verw   0x9f9fec(%rip)        #
> 0xffffffff940d4bbc
> <mwait_idle_with_hints.constprop.0+0x40>:       mov    $0x1,%ecx
> <mwait_idle_with_hints.constprop.0+0x45>:       mov    %rdi,%rax
> <mwait_idle_with_hints.constprop.0+0x48>:       mwait  %rax,%rcx
> <mwait_idle_with_hints.constprop.0+0x4b>:       mov    %gs:0x17bc0,%rax
> <mwait_idle_with_hints.constprop.0+0x54>:       lock andb $0xdf,0x2(%rax)
> <mwait_idle_with_hints.constprop.0+0x59>:       lock addl $0x0,-0x4(%rsp)
> <mwait_idle_with_hints.constprop.0+0x5f>:       mov    (%rax),%rax
> <mwait_idle_with_hints.constprop.0+0x62>:       test   $0x8,%al
> <mwait_idle_with_hints.constprop.0+0x64>:       je     0xffffffff936dac01
> <mwait_idle_with_hints.constprop.0+0x71>
> <mwait_idle_with_hints.constprop.0+0x66>:       andl
> $0x7fffffff,%gs:0x6c93cf7f(%rip)        # 0x17b80
> <mwait_idle_with_hints.constprop.0+0x71>:       retq
> <mwait_idle_with_hints.constprop.0+0x72>:       mov    %gs:0x17bc0,%rax
> <mwait_idle_with_hints.constprop.0+0x7b>:       lock orb $0x20,0x2(%rax)
> <mwait_idle_with_hints.constprop.0+0x80>:       mov    (%rax),%rax
> <mwait_idle_with_hints.constprop.0+0x83>:       test   $0x8,%al
> <mwait_idle_with_hints.constprop.0+0x85>:       jne    0xffffffff936dabdb
> <mwait_idle_with_hints.constprop.0+0x4b>
> <mwait_idle_with_hints.constprop.0+0x87>:       jmpq   0xffffffff936dab95
> <mwait_idle_with_hints.constprop.0+0x5>
> <mwait_idle_with_hints.constprop.0+0x8c>:       nopl   0x0(%rax)
>
> 0x4b is after the mwait, which means we're panicing in the
> current_clr_polling(), where we do clear_thread_flag(TIF_POLLING_NRFLAG).  Thanks,
>
> Josef
