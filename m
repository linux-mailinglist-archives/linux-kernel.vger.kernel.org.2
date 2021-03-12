Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614CB3385E5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 07:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbhCLGba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 01:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbhCLGbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 01:31:09 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D205BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 22:31:08 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id a14so3784492qvj.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 22:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z9Y5RvSkaW0IxENx4c2BiKmmwTuvzpC+ZpJjCrqNlZk=;
        b=qx+X35KrcUquZKcR/arCoMyS0MeI7SN8lfFbbYbkBRpmG6fYeYw6PJrVSj+gxx0flH
         hBND67ewe98qph+UvyR/92jqkvL3CtNvPLaUr1JLRZFeO5/gD+HqPq7S60CfpWA+u/Z9
         rKbkq5f7+dnCKvx2K2sJfpd77Xxo3Nysu/suSzrCFu3DRui3f+vDu9BdhRQvoSemoCzc
         H3+RGtPka5AxsA6U/4y0Ch3rX8pS/QervCdHrZzr9dLw0FiZysd2+1q0N0yFe3GcGbv+
         AaQIOqHP+0S8Hiv+t6CZSQYXizzQsKe6XWtXbfMeZUrwsX2pHL9yKhOz1CgvSDR1JbrN
         RhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z9Y5RvSkaW0IxENx4c2BiKmmwTuvzpC+ZpJjCrqNlZk=;
        b=B9IpT+Z549JNStzaZJuAU6PQTJO9JozRDXwsFUxy0f0sIl52ST49t5yYCpADKdbi83
         KgDvCP1fXasumJx0n69hGqU1zqfeOXh4qyI5OD52uyx7GOzqTLMwBo2MT3DNuTLebXYE
         gMbE2TdGHPQfKZJuZCXHfTgwLrO59FWOgIaMFvQDTztoYrEEap9OP+l4iy+P+ajzMiu0
         5HXomH0eIY+KUkRUkSjCIO3w0ObEhJJGNMzoPRVsJJAg5Gp4Zjj9h/SkCLdiHtQtFQ6b
         xZn+9qujaFTCNqrRPBL4Sqgv+BjKnTHr6mNAJF8112GEyorcaY02yWfe65h6ABx5Su6o
         xasQ==
X-Gm-Message-State: AOAM533tLir6/Lywjc2icMundBuhEUv9jGOfoF9KvxUG2J6FBz22/Nrd
        OpC3yxOKug4vsnvilSJaz/7d3ABz2SIVIEKBWEzw0sCZPoviuw==
X-Google-Smtp-Source: ABdhPJx+QjOZyf4vF6VUUW3BN7jEDVJzDltHgz5g3wbaHNAnKrmvzB3e2PXgkB7v1aPu06tuE/1zz9yYpV6bT+yAr6k=
X-Received: by 2002:ad4:50d0:: with SMTP id e16mr11103743qvq.37.1615530667801;
 Thu, 11 Mar 2021 22:31:07 -0800 (PST)
MIME-Version: 1.0
References: <20210312041246.15113-1-qiang.zhang@windriver.com>
In-Reply-To: <20210312041246.15113-1-qiang.zhang@windriver.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 12 Mar 2021 07:30:56 +0100
Message-ID: <CACT4Y+ZS5ehyHrm0i-4fAX-Zk6OUN5PqGs0ZT_RC5K=fFgst5w@mail.gmail.com>
Subject: Re: [PATCH] ARM: Fix incorrect use of smp_processor_id() by syzbot report
To:     "Zhang, Qiang" <qiang.zhang@windriver.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 5:13 AM <qiang.zhang@windriver.com> wrote:
>
> From: Zqiang <qiang.zhang@windriver.com>
>
> BUG: using smp_processor_id() in preemptible [00000000] code:
> syz-executor.0/15841
> caller is debug_smp_processor_id+0x20/0x24
> lib/smp_processor_id.c:64
>
> The smp_processor_id() is used in a code segment when
> preemption has been disabled, otherwise, when preemption
> is enabled this pointer is usually no longer useful
> since it may no longer point to per cpu data of the
> current processor.
>
> Reported-by: syzbot <syzbot+a7ee43e564223f195c84@syzkaller.appspotmail.com>
> Fixes: f5fe12b1eaee ("ARM: spectre-v2: harden user aborts in kernel space")
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> ---
>  arch/arm/include/asm/system_misc.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/include/asm/system_misc.h b/arch/arm/include/asm/system_misc.h
> index 66f6a3ae68d2..61916dc7d361 100644
> --- a/arch/arm/include/asm/system_misc.h
> +++ b/arch/arm/include/asm/system_misc.h
> @@ -21,8 +21,10 @@ typedef void (*harden_branch_predictor_fn_t)(void);
>  DECLARE_PER_CPU(harden_branch_predictor_fn_t, harden_branch_predictor_fn);
>  static inline void harden_branch_predictor(void)
>  {
> +       preempt_disable();
>         harden_branch_predictor_fn_t fn = per_cpu(harden_branch_predictor_fn,
>                                                   smp_processor_id());
> +       preempt_enable();
>         if (fn)
>                 fn();
>  }

Hi Qiang,

If the CPU can change here, what if it changes right after preempt_enable()?
Disabling preemption just around reading the callback looks like a
no-op. Shouldn't we disable preemption at least around reading and
calling the callback?

On the second look, the fn seems to be const after init, so maybe we
need to use raw_smp_processor_id() instead with an explanatory
comment?
