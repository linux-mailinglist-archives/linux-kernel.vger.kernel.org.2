Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495633812C7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 23:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhENVWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 17:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbhENVWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 17:22:18 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C575FC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 14:21:06 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id g4so298531lfv.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 14:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kr02OQRBAUClRPq6pzrHz4TBil6QdXjMy0YYb2MF1hc=;
        b=u3bueLRypu0wYM/PhDv20UOfoUyiLMETf/vvFMNUaUk7+ikcvONEeot78kI4vIcgQK
         v95kfpcuOMDQPmEBX77HwcegX89WUhvjDorNrOMsshReuLuvB07C7rHjSxl0oEbfo0S6
         b3WrxZ79v1ZpR2F0qTyMCagCNkLaoRjJ1Sd3Yn2BKNRPERXG9AodbYO1QPp6YejU/nVW
         TCHaC5d2FbISKcjym65yLRSRxKsLISaruSW+fvVOq0AubfZ38Tr3Ulrv1YXJ22+ISo/9
         Qc9IAu9Kdgq6u2rTlWoEEV8a3UaWg/nxF6h0/XjIcbKplDHN5pYR2t5iSTjqcpbKSwlk
         XKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kr02OQRBAUClRPq6pzrHz4TBil6QdXjMy0YYb2MF1hc=;
        b=Tir7AipE/bs4vGnlxWejI1XeIBjhnvfJO7vKyLC8KSsiIKkkQii9EYFhpl2hjwoH/3
         t1CW2+wVNRqTjcFWUFdN6tBQbIj5/Rg/caqmq/go94QEwSuQihbVgGn600byNumKpqO0
         Zc2A0vX9Vyg04PpQhsZvYqCWE9Dz0Gxm0B7llQFnc/qRTZ8Z4uXXeZUHXnCL/YXQhPNH
         DYBWZAumotlAzBStvGQiXn8knDP9io1URtFqBndLg2FQ2yUgYo2efhGwJlcol3BLZZFA
         VR79g6GPL9lF08T8gNC8yT6PpGwpInEayJk+g1cTh85/dUtdCM8frBu/QFS22KTBcQgC
         8NIQ==
X-Gm-Message-State: AOAM532DjF550TCgJFADAph+2eyEqm+KAFnx1TtjAmMxkJo7KiJBeyiZ
        Kt+RkH3F0Bv0+hmuDP0iNoSezO2CtTgR91vMoLeZQw==
X-Google-Smtp-Source: ABdhPJw9/T5SjNYeE79N8p+u8GzkMRmZT3OX+xG35/M5AAQvXuUyCCvhbW6O/PrNQpK6fTft3iAZkIvdjddIO8KDP7A=
X-Received: by 2002:a05:6512:acc:: with SMTP id n12mr34825576lfu.9.1621027265153;
 Fri, 14 May 2021 14:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <1620871084-4639-1-git-send-email-wanpengli@tencent.com>
In-Reply-To: <1620871084-4639-1-git-send-email-wanpengli@tencent.com>
From:   David Matlack <dmatlack@google.com>
Date:   Fri, 14 May 2021 14:20:38 -0700
Message-ID: <CALzav=eTC3HhHyxndHvS3NyCfPiBL2Wb5NvU=-+UsxSoMfmqXA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] KVM: PPC: Book3S HV: exit halt polling on
 need_resched() as well
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Ben Segall <bsegall@google.com>,
        Venkatesh Srinivas <venkateshs@chromium.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 6:58 PM Wanpeng Li <kernellwp@gmail.com> wrote:
>
> From: Wanpeng Li <wanpengli@tencent.com>
>
> Inspired by commit 262de4102c7bb8 (kvm: exit halt polling on need_resched()
> as well), CFS_BANDWIDTH throttling will use resched_task() when there is just
> one task to get the task to block. It was likely allowing VMs to overrun their
> quota when halt polling. Due to PPC implements an arch specific halt polling
> logic, we should add the need_resched() checking there as well.
>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Venkatesh Srinivas <venkateshs@chromium.org>
> Cc: Jim Mattson <jmattson@google.com>
> Cc: David Matlack <dmatlack@google.com>
> Cc: Paul Mackerras <paulus@ozlabs.org>
> Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> v1 -> v2:
>  * update patch description
>
>  arch/powerpc/kvm/book3s_hv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 28a80d2..6199397 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -3936,7 +3936,8 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
>                                 break;
>                         }
>                         cur = ktime_get();
> -               } while (single_task_running() && ktime_before(cur, stop));
> +               } while (single_task_running() && !need_resched() &&
> +                        ktime_before(cur, stop));

Consider moving this condition to a helper function that can be shared
between book3s and the generic halt-polling loop.

>
>                 spin_lock(&vc->lock);
>                 vc->vcore_state = VCORE_INACTIVE;
> --
> 2.7.4
>
