Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D584B38C5A0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 13:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbhEULZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 07:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbhEULZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 07:25:41 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43ABCC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 04:24:17 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 76so19252330qkn.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 04:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UkWBXwz4jU1wfeZPH0TcLgdabL7pumSujVwmqN5JMTI=;
        b=CH9kJ8ADB3bDTaQhSg8tZ9DxYXfg8lzzrQZfRm93uSX5I1EdeRKNqGby3UhQaH6VkS
         oQ6K7GGqFlsdcgdy+fs6gAt2qO+O0QdW/h9TFXcbOlhqDQ9KuP7K7yTkcpyM3jQq9N43
         H5WCV09/4cMhnw1xA+4MZKyOgl+qCnUxOB80O9/SRLcCqTnxwtd0L2cxH7g+TFHjXfpA
         0oxBnTEH9usK1HV7rYpCIDaXMUKgzg3GPT9PANCx0EJftOs4aWGZrzZCFFGs0mW7tGTK
         /kG8VnYH/G2LRJn1PWj7McVFJ7EylmFFfw4+9egtHOTO6X8y5NUGQKIk+70Pp1cQ59Gt
         hnrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UkWBXwz4jU1wfeZPH0TcLgdabL7pumSujVwmqN5JMTI=;
        b=Uu0Nx8FYGvVPhpw3sfpJiaW6hZAUqrsg7Wnek4edFCOOP4RUmKEy7VBqJkD/CFPU13
         plNDZ2BTmFsjGkodYGUIJgNzMf4Tse9PYs/kAyHmac41CJADgMe4idz8rVsGjdmvF/g4
         QkrF4K8sgqRIc9gNCBjx88mPq/2lOS0UaWCtNX5CnEqq1NGCMV9rZGOrxDFkS9+cyP5Y
         8GyliLJF+I4mNa+TRYMd9jSPhFi1gh6pAUxMsMEuJi1xFby2Nw5P7Sf4EDkaR8cM0NnN
         Yj9KpSJLqCEi3vp+2Uhj+rGWoyxlOtQC0dyKSQQc1IYb4pkrwJaZWC9XKpkSblVgxZS3
         behQ==
X-Gm-Message-State: AOAM530QlZzxuFBJRQwNiLGauAF7UcbROQc4ABYIBErnHnhixWDBRkJN
        4LuPix/x9OsCjaa6Xh7yji8cbB6KTbm00xgdXziRfA==
X-Google-Smtp-Source: ABdhPJyZ5RcB0oaoiH70RweEbmZZ7mMBRbs+Nf7XDmhqKqXegPOY6WRI/lr3tptaxoEx702TeECb3zn+3bpqxAFXixM=
X-Received: by 2002:a37:b643:: with SMTP id g64mr11995439qkf.6.1621596256143;
 Fri, 21 May 2021 04:24:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210521111630.472579-1-elver@google.com>
In-Reply-To: <20210521111630.472579-1-elver@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 21 May 2021 13:23:39 +0200
Message-ID: <CAG_fn=UshTFy23PvM7_4ZVtdMCmfFTB47=LxEgkzgF0rHHK3-g@mail.gmail.com>
Subject: Re: [PATCH] kfence: unconditionally use unbound work queue
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitriy Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 1:16 PM Marco Elver <elver@google.com> wrote:
>
> Unconditionally use unbound work queue, and not just if
> wq_power_efficient is true. Because if the system is idle, KFENCE may
> wait, and by being run on the unbound work queue, we permit the
> scheduler to make better scheduling decisions and not require pinning
> KFENCE to the same CPU upon waking up.
>
> Fixes: 36f0b35d0894 ("kfence: use power-efficient work queue to run delay=
ed work")
> Reported-by: Hillf Danton <hdanton@sina.com>
> Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
>  mm/kfence/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 4d21ac44d5d3..d7666ace9d2e 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -636,7 +636,7 @@ static void toggle_allocation_gate(struct work_struct=
 *work)
>         /* Disable static key and reset timer. */
>         static_branch_disable(&kfence_allocation_key);
>  #endif
> -       queue_delayed_work(system_power_efficient_wq, &kfence_timer,
> +       queue_delayed_work(system_unbound_wq, &kfence_timer,
>                            msecs_to_jiffies(kfence_sample_interval));
>  }
>  static DECLARE_DELAYED_WORK(kfence_timer, toggle_allocation_gate);
> @@ -666,7 +666,7 @@ void __init kfence_init(void)
>         }
>
>         WRITE_ONCE(kfence_enabled, true);
> -       queue_delayed_work(system_power_efficient_wq, &kfence_timer, 0);
> +       queue_delayed_work(system_unbound_wq, &kfence_timer, 0);
>         pr_info("initialized - using %lu bytes for %d objects at 0x%p-0x%=
p\n", KFENCE_POOL_SIZE,
>                 CONFIG_KFENCE_NUM_OBJECTS, (void *)__kfence_pool,
>                 (void *)(__kfence_pool + KFENCE_POOL_SIZE));
> --
> 2.31.1.818.g46aad6cb9e-goog
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
