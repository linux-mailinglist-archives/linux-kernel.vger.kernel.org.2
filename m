Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9781540FAC6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 16:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbhIQOwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 10:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbhIQOwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 10:52:11 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB7CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 07:50:49 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 97-20020a9d006a000000b00545420bff9eso6268216ota.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 07:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A+8jh6PTO10F45HFFMFUU3EONxnA5C8W34XTxIGW9XU=;
        b=HajIqhomOKwHHAnweJfpIkIH1K4ZokJNPuaOc08Z7E0+gBbVGpT7/XRWA60YGbTYHk
         lf466UOo8M8KOAD9L2mUfNrDSCng4jEc0+ktZ8psLp6W77CvXExLPvu/QLQqSvU4LFXM
         CQqgoR4hc/Q7WK49aevAkw2s2sVyN+TTkptp4T/4CPkOaw38dNiaLK8RyboO6+1WemP2
         EWS4ljGoDwExPg5/CClL5Nul2S0i7GlZiptDKu64GJiXmgryEMFc18Ecw0+iG7Daxp9g
         P7rJfSL8jQUfWvrcdFaDo0AyXQNTzkg0vphFOpyROmQ9EmLp6Z4EyFaJHMveKiTLQZsC
         Ratg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A+8jh6PTO10F45HFFMFUU3EONxnA5C8W34XTxIGW9XU=;
        b=in/JN0BBzj2LNfkl/qnBmq8BQgPqw+fCs+O4YxeQZau2qOcqc6C65o+N1kciiglIAp
         MQK0XjwNsga8iv4zhFvB4j2y5G/aozuNjhgTd/TXGUvL89ruaz21nhUvEmESvcFDP+YI
         +/9YUxYBFyOirIzJOHZmrlmBg3ShrYK0J9PkxR3VptXVrTLf7iof+RzYJ458BMiEhc1j
         cBaRPLPsB8fi//PwbHDr02aKCwXUkAbUz6ur6GOB1M8D1YJFS89JCrxbBTCocN8hEKUx
         eLWjsCMhdOmhEYP+FVFuoiOPF/Bgw3vZR16AwDJAr7Tv3nJuUa3oFdpyXqIzX04XerCb
         2KUQ==
X-Gm-Message-State: AOAM532ZSjL2qJ9JHajeFzNZ1e2YCGU/hPMJhbqGgEyrGyO17aWCd6yk
        LbAqIOj4zRyeBKM+UtEqlKe2nGW0g4ppU+oCkISkdL9wLZ9cyA==
X-Google-Smtp-Source: ABdhPJzkfElp6YfA2gWVfQ3+Dxvs60qOg/aMoMcQP1SR4PcFNCaNYfNFmZiqaPi34NWoVOtSsT+sPEl8xkgtKpnnzg8=
X-Received: by 2002:a05:6830:34b:: with SMTP id h11mr10005271ote.319.1631890248615;
 Fri, 17 Sep 2021 07:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210830172627.267989-1-bigeasy@linutronix.de> <20210830172627.267989-5-bigeasy@linutronix.de>
In-Reply-To: <20210830172627.267989-5-bigeasy@linutronix.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 17 Sep 2021 16:50:37 +0200
Message-ID: <CACT4Y+aCm60gfP9uyEdb-KKaikGGXkrcY8FXhESnPyO_cWBw4A@mail.gmail.com>
Subject: Re: [PATCH 4/5] kcov: Avoid enable+disable interrupts if !in_task().
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marco Elver <elver@google.com>,
        Clark Williams <williams@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Aug 2021 at 19:26, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> kcov_remote_start() may need to allocate memory in the in_task() case
> (otherwise per-CPU memory has been pre-allocated) and therefore requires
> enabled interrupts.
> The interrupts are enabled before checking if the allocation is required
> so if no allocation is required then the interrupts are needlessly
> enabled and disabled again.
>
> Enable interrupts only if memory allocation is performed.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  kernel/kcov.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index 4f910231d99a2..620dc4ffeb685 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -869,19 +869,19 @@ void kcov_remote_start(u64 handle)
>                 size = CONFIG_KCOV_IRQ_AREA_SIZE;
>                 area = this_cpu_ptr(&kcov_percpu_data)->irq_area;
>         }
> -       spin_unlock_irqrestore(&kcov_remote_lock, flags);
> +       spin_unlock(&kcov_remote_lock);
>
>         /* Can only happen when in_task(). */
>         if (!area) {
> +               local_irqrestore(flags);
>                 area = vmalloc(size * sizeof(unsigned long));
>                 if (!area) {
>                         kcov_put(kcov);
>                         return;
>                 }
> +               local_irq_save(flags);
>         }
>
> -       local_irq_save(flags);
> -
>         /* Reset coverage size. */
>         *(u64 *)area = 0;
>
> --
> 2.33.0
>
