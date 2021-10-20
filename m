Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2D04345DB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 09:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhJTH0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 03:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbhJTH0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 03:26:02 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5378C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 00:23:47 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so5110243otb.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 00:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kU2IPRL8ftmwSTb+WFMJqCEa8tDzkDYqWbLRrE2BrPc=;
        b=Z9H2n0S4Jqv5TODlbAm7IEoBWEjHonzCDw5KhMOcpgcNdwafYI5hl846Do/Y9Ou8J4
         Nh9OI+lYpQzGZMNfGRO5QbZ3+xMSih4c4Sek/fz3wq3jfaA/UhQ2PmJWPIEmt6QuquOL
         TP0BXd6qyBb1af+2OwX6ri4+SwH+99imu7LTzy8zZbi5ghPzIVwiN653Ye0nq5o+rrrC
         E4zVgo7S5oKkaq+dyNLBBqBDm+vGVzYTAXQ3mV25+maP2TZbNC3ej7WdCTsqIr+v6DVp
         6eWasHRDjPiSmADHQhTkCVqLTX0SCxJjzT13WM6fvlfGRBPkhyjzxRa1lZ2XjHzTBFeA
         w0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kU2IPRL8ftmwSTb+WFMJqCEa8tDzkDYqWbLRrE2BrPc=;
        b=LLtegN4k4Pzw72ZPtrRasSdrvMc0twzq3F6qfqamkSmq8NdCkcOKlRLoXBUQYlRIYG
         M1BcchUWE3fF/kR8zakDXK/HB+zjnC8RxNmrGwXUuTUqA3YMDDdPridM2lns1vLkiGKK
         3GP9FrG/HiPbASxx3Mcn2k7qLY2ODcTZ61es0htE1dMTPUDdDphVMoVlmCIbJS9Cospg
         QcJ2n2N4SYfgzE8FZdcpQrsb8j5e0GBH9ZU2oMhHcvpCSMLAOU3Or0noyIePfNXHmnKZ
         afQVThuqibdek/uYFfKDGQMpvmIh76TO16KWgzZ41PkTzd5xYYcCj5hTtODuAyuU4qN+
         db+g==
X-Gm-Message-State: AOAM531vSOZD/gNmKkHMJbA8kYhCFDi89rzMHizgk5/1slUkxFZbupeH
        svTVh11zJfCq7OxWz/zkaSqrzmw+X3rtbZnfNeSPLg==
X-Google-Smtp-Source: ABdhPJxYaB/xUITs/EEyisEF1CX0Q9AbBpoCaL8yuO7fy/xV4PTxIosNxyf5PIF+8caN552qxFShQqzctqUgQlFvyzY=
X-Received: by 2002:a9d:2ac2:: with SMTP id e60mr1361127otb.92.1634714627015;
 Wed, 20 Oct 2021 00:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211020061248.13270-1-Kuan-Ying.Lee@mediatek.com>
In-Reply-To: <20211020061248.13270-1-Kuan-Ying.Lee@mediatek.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 20 Oct 2021 09:23:35 +0200
Message-ID: <CANpmjNNxQRM5rSxcdxNOicpOvwQ=vsutQO3j1hUmGAfS9+pQDA@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: add kasan mode messages when kasan init
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        chinwen.chang@mediatek.com, yee.lee@mediatek.com,
        nicholas.tang@mediatek.com, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2021 at 08:13, Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com> wrote:
>
> There are multiple kasan modes. It makes sense that we add some messages
> to know which kasan mode is when booting up. see [1].
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=212195 [1]
> Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
> ---
> change since v2:
>  - Rebase to linux-next
>  - HW-tags based mode need to consider asymm mode
>  - Thanks for Marco's suggestion
>
>  arch/arm64/mm/kasan_init.c |  2 +-
>  mm/kasan/hw_tags.c         |  4 +++-
>  mm/kasan/kasan.h           | 10 ++++++++++
>  mm/kasan/sw_tags.c         |  2 +-
>  4 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> index 5b996ca4d996..6f5a6fe8edd7 100644
> --- a/arch/arm64/mm/kasan_init.c
> +++ b/arch/arm64/mm/kasan_init.c
> @@ -309,7 +309,7 @@ void __init kasan_init(void)
>         kasan_init_depth();
>  #if defined(CONFIG_KASAN_GENERIC)
>         /* CONFIG_KASAN_SW_TAGS also requires kasan_init_sw_tags(). */
> -       pr_info("KernelAddressSanitizer initialized\n");
> +       pr_info("KernelAddressSanitizer initialized (generic)\n");
>  #endif
>  }
>
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index dc892119e88f..1d5c89c7cdfe 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -177,7 +177,9 @@ void __init kasan_init_hw_tags(void)
>                 break;
>         }
>
> -       pr_info("KernelAddressSanitizer initialized\n");
> +       pr_info("KernelAddressSanitizer initialized (hw-tags, mode=%s, stacktrace=%s)\n",
> +               kasan_mode_info(),
> +               kasan_stack_collection_enabled() ? "on" : "off");
>  }
>
>  void kasan_alloc_pages(struct page *page, unsigned int order, gfp_t flags)
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index aebd8df86a1f..387ed7b6de37 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -36,6 +36,16 @@ static inline bool kasan_sync_fault_possible(void)
>  {
>         return kasan_mode == KASAN_MODE_SYNC || kasan_mode == KASAN_MODE_ASYMM;
>  }
> +
> +static inline const char *kasan_mode_info(void)
> +{
> +       if (kasan_mode == KASAN_MODE_ASYNC)
> +               return "async";
> +       else if (kasan_mode == KASAN_MODE_ASYMM)
> +               return "asymm";
> +       else
> +               return "sync";
> +}

This creates an inconsistency, because for
kasan_stack_collection_enabled(), kasan_async_fault_possible(), and
kasan_sync_fault_possible() there are !KASAN_HW_TAGS stubs.

A stub for kasan_mode_info() if !KASAN_HW_TAGS appears useless though,
and I wouldn't know what its return value should be.

Do you expect this helper to be used outside hw_tags.c? If not,
perhaps just move it into hw_tags.c.

Thanks,
-- Marco
