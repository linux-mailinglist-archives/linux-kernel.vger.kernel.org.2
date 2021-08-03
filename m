Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0845F3DF108
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 17:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbhHCPEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 11:04:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26306 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236628AbhHCPD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 11:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628003025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7tbb0CsnnLf2HSZfxDfKO/Er3Zkctrt268hAInT4vLU=;
        b=bEFDZCksmFSIkYhYuRYLmvcOhOMqwQrF28dw8vn1XwdGWCjS5oOzaJynh97G+IlQDJCgJK
        W8cGz/ovgSwwBQ1d5ZsSknVblYcDrs3jaNCyGY0mSWx0auoq9kI1eTtjWstUNUb8kdViW+
        Asqx7ITPhYEzZACIXadctsa25WzX9IA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-krjSLKVKMcyQj9XTqwETCw-1; Tue, 03 Aug 2021 11:03:44 -0400
X-MC-Unique: krjSLKVKMcyQj9XTqwETCw-1
Received: by mail-wr1-f69.google.com with SMTP id q13-20020a05600000cdb02901545f1bdac1so3930778wrx.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 08:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7tbb0CsnnLf2HSZfxDfKO/Er3Zkctrt268hAInT4vLU=;
        b=c97WDpO6xArMBeHTh7HjcSuROXEQGyYyEno+uEQ7RzbHhuB0lqb01L1pMV8NiCB/Fg
         0vPOekNOEUmWI0HCA2FC9SD2UOm3bulHrC0HjiSNWOCMRdhGQ+dXVhiWqUiKldeIYDgs
         85/4Q9pXw7heezJz4oGLoqqwxTViDRo/14hsezblmsw/KE6j6CxbYoUnTGreE60r0+li
         IbGhxuna51bTk1eHKcQeXIysHLvWy+vVefrjiBaE0F/tZloBgiHRm90ueTUETK5QEQK3
         Q2taLmtvjf47+mdqJFxjWBKuNWhmuwN829qRzNJT5ItVVluQt34P4ZRWdVXZj164qvoZ
         4dTg==
X-Gm-Message-State: AOAM532EGhFEVZQdAb3v+stCTbrgcxueVLnJvjspl3OatGgXgvaSpiv+
        duMA+Z+0ooPETlMl0SDPDBj/QruD0YXdsGj6mNZGYLH2WOwcdTMTCfBMf4O54TdJPDJhRMfWnAA
        UIXPB7jcI3Es3jydii1vaQ0HWW3lBZZKnXD5z6I8I
X-Received: by 2002:a1c:4c06:: with SMTP id z6mr4843730wmf.163.1628003023104;
        Tue, 03 Aug 2021 08:03:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykRywpEC7AOtnyF33drX5yQPQK6cTLMRKJswnyy1gmxHAG7bcbQHRlUM/7z8pByC9MVYVggHDv1kinAc16ErE=
X-Received: by 2002:a1c:4c06:: with SMTP id z6mr4843706wmf.163.1628003022887;
 Tue, 03 Aug 2021 08:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210803141621.780504-1-bigeasy@linutronix.de> <20210803141621.780504-7-bigeasy@linutronix.de>
In-Reply-To: <20210803141621.780504-7-bigeasy@linutronix.de>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 3 Aug 2021 17:03:32 +0200
Message-ID: <CACO55tvuMM2HcYOUguZzJPi5TvYgeY=N=+psM9T1G7CMA8d=Dg@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 06/38] x86/mmiotrace: Replace deprecated
 CPU-hotplug functions.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Karol Herbst <karolherbst@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        nouveau <nouveau@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 3, 2021 at 4:25 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> The functions get_online_cpus() and put_online_cpus() have been
> deprecated during the CPU hotplug rework. They map directly to
> cpus_read_lock() and cpus_read_unlock().
>
> Replace deprecated CPU-hotplug functions with the official version.
> The behavior remains unchanged.
>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Karol Herbst <karolherbst@gmail.com>
> Cc: Pekka Paalanen <ppaalanen@gmail.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: nouveau@lists.freedesktop.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/x86/mm/mmio-mod.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/mm/mmio-mod.c b/arch/x86/mm/mmio-mod.c
> index cd768dafca9e9..933a2ebad471b 100644
> --- a/arch/x86/mm/mmio-mod.c
> +++ b/arch/x86/mm/mmio-mod.c
> @@ -376,12 +376,12 @@ static void enter_uniprocessor(void)
>                 goto out;
>         }
>
> -       get_online_cpus();
> +       cpus_read_lock();
>         cpumask_copy(downed_cpus, cpu_online_mask);
>         cpumask_clear_cpu(cpumask_first(cpu_online_mask), downed_cpus);
>         if (num_online_cpus() > 1)
>                 pr_notice("Disabling non-boot CPUs...\n");
> -       put_online_cpus();
> +       cpus_read_unlock();
>
>         for_each_cpu(cpu, downed_cpus) {
>                 err = remove_cpu(cpu);
> --
> 2.32.0
>

Reviewed-by: Karol Herbst <kherbst@redhat.com>

