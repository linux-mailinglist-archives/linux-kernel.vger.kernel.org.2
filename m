Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABFA39AE7E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 01:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhFCXEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 19:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhFCXEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 19:04:51 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84256C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 16:02:52 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a1so1585165lfr.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 16:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K03/jFS8243EBKIW104XpUPzFaUPfTIO5wbL9YnqR3U=;
        b=uZE3ToVsjO88qmCR8+Al4+lieZWW684oeBngNk/zBEymUJAENU/3lkhPI/x4s3Lzk2
         LeNeKUW0gko6vDMio2a+UmCkCnP8gQN4YGGggh/EDdkl9d/Artgj6b7Ay0EtkJvaNZuy
         jUBk/jIQX+IayowiPki9Q2bGyT/MOYk81GxDELp+kgf2r8hCXH3VBbF8kmI7UAVd1RMy
         oNyFfyEGRESopWoRAhLp3fQxNqueHSfj9mz+4vgptj7Rzt4h3xoKhcbKFZBr8A23A6B3
         cFHx9J+c+1pSsbAkF2TQIItuVIDOPDn9DcjZrL/oYkgWXB2IXxTrY5MG5zMrSXu+Nbeg
         BJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K03/jFS8243EBKIW104XpUPzFaUPfTIO5wbL9YnqR3U=;
        b=iij3qLQFr1UqIzaWMQkYQaZTDyXxyBjpMlDaVGIloEeekBpYer2ZL5lLBamuYmAgQQ
         wV+bIymZJvcWoftRgTws/KswJKNH+IhC2EzngbZmOEGbkfqwtI3JL8z/Mx3IOWJ1s7l6
         FfBk3AKDKVjAIbMxjl1qkfnypqE8W/Qdjh9b27cIjShbv/9qQMYOKJZWyfgMgOzt2vpe
         aRIJGHIE7Ey0uEUySMEQw9uDA+SR7uaF6Qk/tBgTyYiP7/jYWC7VWEAtQ70sdgu3CUcm
         m9odQm2m1xwYNBj7TnFmmIqp0UptHAMd5AIoUCWEDSqjSTLEV1nHq90692WIy34BK9sS
         djgA==
X-Gm-Message-State: AOAM532SaL9N2KnAH7SNbp4DCKqm4Id/eKKZ2SVVbeQdZ+1KquDZqRwA
        YHZr3zG+NFChHqW8Q1NiPtIWtgFd73eQwr7LYR0P4CfsP1GPaw==
X-Google-Smtp-Source: ABdhPJxa+61dJokvsPDicoNRcDklKBp8AeszwGAJIGovrOGINu2YWvfVOey03AW1rZ5jo2UtbBWNQr8wbzdw1DuvzZc=
X-Received: by 2002:a05:6512:3f8d:: with SMTP id x13mr808516lfa.278.1622761370592;
 Thu, 03 Jun 2021 16:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <1622710841-76604-1-git-send-email-wanpengli@tencent.com>
In-Reply-To: <1622710841-76604-1-git-send-email-wanpengli@tencent.com>
From:   David Matlack <dmatlack@google.com>
Date:   Thu, 3 Jun 2021 16:02:23 -0700
Message-ID: <CALzav=e9pbkk0=Yz9s1b+53MEy7yuo_otoFM75fNeoJGCQjqCg@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: LAPIC: write 0 to TMICT should also cancel
 vmx-preemption timer
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 3, 2021 at 2:04 AM Wanpeng Li <kernellwp@gmail.com> wrote:
>
> From: Wanpeng Li <wanpengli@tencent.com>
>
> According to the SDM 10.5.4.1:
>
>   A write of 0 to the initial-count register effectively stops the local
>   APIC timer, in both one-shot and periodic mode.

If KVM is not correctly emulating this behavior then could you also
add a kvm-unit-test to test for the correct behavior?

>
> The lapic timer oneshot/periodic mode which is emulated by vmx-preemption
> timer doesn't stop since vmx->hv_deadline_tsc is still set. This patch
> fixes it by also cancel vmx-preemption timer when writing 0 to initial-count
> register.
>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/lapic.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 8120e86..20dd2ae 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1494,6 +1494,15 @@ static void limit_periodic_timer_frequency(struct kvm_lapic *apic)
>
>  static void cancel_hv_timer(struct kvm_lapic *apic);
>
> +static void cancel_timer(struct kvm_lapic *apic)
> +{
> +       hrtimer_cancel(&apic->lapic_timer.timer);
> +       preempt_disable();
> +       if (apic->lapic_timer.hv_timer_in_use)
> +               cancel_hv_timer(apic);
> +       preempt_enable();
> +}
> +
>  static void apic_update_lvtt(struct kvm_lapic *apic)
>  {
>         u32 timer_mode = kvm_lapic_get_reg(apic, APIC_LVTT) &
> @@ -1502,11 +1511,7 @@ static void apic_update_lvtt(struct kvm_lapic *apic)
>         if (apic->lapic_timer.timer_mode != timer_mode) {
>                 if (apic_lvtt_tscdeadline(apic) != (timer_mode ==
>                                 APIC_LVT_TIMER_TSCDEADLINE)) {
> -                       hrtimer_cancel(&apic->lapic_timer.timer);
> -                       preempt_disable();
> -                       if (apic->lapic_timer.hv_timer_in_use)
> -                               cancel_hv_timer(apic);
> -                       preempt_enable();
> +                       cancel_timer(apic);
>                         kvm_lapic_set_reg(apic, APIC_TMICT, 0);
>                         apic->lapic_timer.period = 0;
>                         apic->lapic_timer.tscdeadline = 0;
> @@ -2092,7 +2097,7 @@ int kvm_lapic_reg_write(struct kvm_lapic *apic, u32 reg, u32 val)
>                 if (apic_lvtt_tscdeadline(apic))
>                         break;
>
> -               hrtimer_cancel(&apic->lapic_timer.timer);
> +               cancel_timer(apic);
>                 kvm_lapic_set_reg(apic, APIC_TMICT, val);
>                 start_apic_timer(apic);
>                 break;
> --
> 2.7.4
>
