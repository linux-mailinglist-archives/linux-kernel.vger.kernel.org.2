Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F739308BCC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 18:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbhA2RnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 12:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbhA2Rlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 12:41:49 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2BAC061573
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 09:41:09 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id j11so3008862plt.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 09:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z7/2anDq5WllUjyju4vzEFhuV34H44LI/WUUefdFyEk=;
        b=PHbYJzbOBDxaiTYsHlUN0vG98HBgzsYHOwTnDjYseWUt7FajCD1JceR32UCFpeD3GL
         CZaNJZeppgB2oMFcimKGTpsWKUi1yxxkK1EdYEwVlNG95oqdCsO0AX3T5KXe4l+Pe9Zg
         YO3z2dQS+X/tycQsWZGn3ppdbaKp1U5sYVu/R1h4p6yLQucP4z0PMWCEr13n2ukceEeR
         0BB7iIn5TBb1Y0tCIEO/tZajgri2ID0q6Zqxe0PlgC7835PIg8FWQp7m6jneihN+FsFk
         FuwYYD0UGEmE+WtShsmgRdK/kSQrL2DIJ/tKYEtl0o+1/QNnJtoBTDbUfAEC2GTF/I84
         H87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z7/2anDq5WllUjyju4vzEFhuV34H44LI/WUUefdFyEk=;
        b=A/OxdNYEZM4Db9q5G1pfkQdwTAu5/81bmByo5AxNq2G7aoLQJDyPjjvbVT5Gnp3Xpq
         ZxJ/ldc81QZPX1Mhrve1Wc9AQHdyF3fUY1Badxqdr8yxdHe7mFBvtIyGTUSoQBOHTk40
         x7C3ISRkxvOv2BHTB3Mt5h116NKLJdUOPI5PxRwggqEsO4ffxjTqvm/o3SXnjFwjlIyQ
         xabsapJIpDAFWaXzdrtVZsQBrfLg7yOryUUYA9uNUwxkaCUFSecnKlixbzY3R7gH01Hx
         wY3ERMG1LdXbMaVNXuQefLTJegJZmkN1HuEtejWtMxjsY7JocFDx3R/GAES0aKaoZTqV
         eSqw==
X-Gm-Message-State: AOAM533woSxitcMf994PcI16T/ev5KjzY+8pofWZWxMY6O1/716+1+jr
        CniTL9EUJKQiggJs4DqqjrHSE4GkhcJYRPJ8Ft0XTQ==
X-Google-Smtp-Source: ABdhPJxwAXu62AaW6sRe+V86NWWQeoX998BbHU4FfKikO10NfBtQz82o/AZ8p34GaykiDfIUOOJXEIgIs0YHhDOHItk=
X-Received: by 2002:a17:90b:350b:: with SMTP id ls11mr5515927pjb.166.1611942068673;
 Fri, 29 Jan 2021 09:41:08 -0800 (PST)
MIME-Version: 1.0
References: <20210126134603.49759-1-vincenzo.frascino@arm.com> <20210126134603.49759-4-vincenzo.frascino@arm.com>
In-Reply-To: <20210126134603.49759-4-vincenzo.frascino@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 29 Jan 2021 18:40:57 +0100
Message-ID: <CAAeHK+xAbsX9Zz4aKXToNTrbgrrYck23ohGJHXvgeSTyZy=Odg@mail.gmail.com>
Subject: Re: [PATCH v9 3/4] kasan: Add report for async mode
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 2:46 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> KASAN provides an asynchronous mode of execution.
>
> Add reporting functionality for this mode.
>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  include/linux/kasan.h |  6 ++++++
>  mm/kasan/report.c     | 13 +++++++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index bb862d1f0e15..b6c502dad54d 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -360,6 +360,12 @@ static inline void *kasan_reset_tag(const void *addr)
>
>  #endif /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS*/
>
> +#ifdef CONFIG_KASAN_HW_TAGS
> +
> +void kasan_report_async(void);
> +
> +#endif /* CONFIG_KASAN_HW_TAGS */
> +
>  #ifdef CONFIG_KASAN_SW_TAGS
>  void __init kasan_init_sw_tags(void);
>  #else
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 87b271206163..69bad9c01aed 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -360,6 +360,19 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
>         end_report(&flags, (unsigned long)object);
>  }
>
> +#ifdef CONFIG_KASAN_HW_TAGS
> +void kasan_report_async(void)
> +{
> +       unsigned long flags;
> +
> +       start_report(&flags);
> +       pr_err("BUG: KASAN: invalid-access\n");
> +       pr_err("Asynchronous mode enabled: no access details available\n");
> +       dump_stack();
> +       end_report(&flags);

This conflicts with "kasan: use error_report_end tracepoint" that's in mm.

I suggest to call end_report(&flags, 0) here and check addr !=0 in
end_report() before calling trace_error_report_end().

> +}
> +#endif /* CONFIG_KASAN_HW_TAGS */
> +
>  static void __kasan_report(unsigned long addr, size_t size, bool is_write,
>                                 unsigned long ip)
>  {
> --
> 2.30.0
>
