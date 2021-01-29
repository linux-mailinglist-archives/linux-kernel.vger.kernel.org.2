Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6FDD308C02
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 18:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbhA2R5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 12:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbhA2R5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 12:57:00 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51103C061573
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 09:56:20 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id o7so7218685pgl.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 09:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KY25Xh6DIR9IRYESFVzdYe8dpCzTrFCAYLNdKXuQz8E=;
        b=Xa+k/wr9SnzKCvx50xC8KYNmsZpwloPYSN1M5GyLV+DlnSvs/p/foXFrPZog+1Rjxc
         AxWsjarN3V0fUM5dkSZF4Fg9VK2L9tRizqFboyEAONfK1op1Gy2C2Uyv3IyPNOrq9sCP
         Cc9EeriBFeUsK8tVxgNASXnfx+nLUCTykYNbbHhaovxKjYhTVwNuZOGamPCfXt12tVD7
         X2Ia6f2EuLBuMDED55PUUF6/8tNEynPiVCesNonDuzosQyfc8JgsHl8DNTppmmLbxMpk
         ApzpsQ/Sb6gqW+EpwlAPdkzkymu25Ovz8xcGbqgEcBlrBdBHRBirZpu+P0cGeZWYIDs7
         NTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KY25Xh6DIR9IRYESFVzdYe8dpCzTrFCAYLNdKXuQz8E=;
        b=I1NKVUqyHs48AMBeTgy00X2NUaXlfCBf+AcX3DG7bkX8Z5/LasuBx8058EFmboJ9Wg
         LEv7s6eVO1xzw95nwB9X3+dcDYVZcycGCABktAWzd7lgRqEbEJxae8qWZbSVJHtitXYD
         Wnar8dIPLdGZkuFnhE1sbNZFFBZF+fROX1YXQ8cdFPukJONMz+iuKXjz4byrk4SpOJ/0
         iaJOzIGdJwjMwuSRWDxMYF4l46dhLaC/PGK0dyCvXgDqD85gaXFVmRBpK42lu8zhkQht
         pKaJp/RqaB5soR8xNI+oDloXoGt6iOO9Rs0pNBgtwSGBnid3u5uHrxi6TqyqKkCEcAwe
         6Atg==
X-Gm-Message-State: AOAM53024PhN+kIHxxvNKHmfu/A1wW7GJJpAJAcBlBfAcUwtpF0egizr
        KGlEQA7yBwN9eozu1D8yZODk/DKMLYBurJnyCVFRNg==
X-Google-Smtp-Source: ABdhPJyq8hSWDPemB1WH34mBm43nwDybMF8jhe2LAlcR2Y7rNni8mCTPQVG4l3DF35pJrZVVqXqcaiW5PS4V0Tm85JY=
X-Received: by 2002:a05:6a00:1:b029:1c1:2d5f:dc16 with SMTP id
 h1-20020a056a000001b02901c12d5fdc16mr5321304pfk.55.1611942979560; Fri, 29 Jan
 2021 09:56:19 -0800 (PST)
MIME-Version: 1.0
References: <20210126134603.49759-1-vincenzo.frascino@arm.com>
 <20210126134603.49759-4-vincenzo.frascino@arm.com> <CAAeHK+xAbsX9Zz4aKXToNTrbgrrYck23ohGJHXvgeSTyZy=Odg@mail.gmail.com>
 <77de8e48-6f68-bf27-0bed-02e49b69a12d@arm.com>
In-Reply-To: <77de8e48-6f68-bf27-0bed-02e49b69a12d@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 29 Jan 2021 18:56:07 +0100
Message-ID: <CAAeHK+xMWXpfLs6HuKN73e0p61nm+QrZO1-oXphJpjZprKQVKg@mail.gmail.com>
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

On Fri, Jan 29, 2021 at 6:44 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
>
>
> On 1/29/21 5:40 PM, Andrey Konovalov wrote:
> > On Tue, Jan 26, 2021 at 2:46 PM Vincenzo Frascino
> > <vincenzo.frascino@arm.com> wrote:
> >>
> >> KASAN provides an asynchronous mode of execution.
> >>
> >> Add reporting functionality for this mode.
> >>
> >> Cc: Dmitry Vyukov <dvyukov@google.com>
> >> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> >> Cc: Alexander Potapenko <glider@google.com>
> >> Cc: Andrey Konovalov <andreyknvl@google.com>
> >> Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
> >> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> >> ---
> >>  include/linux/kasan.h |  6 ++++++
> >>  mm/kasan/report.c     | 13 +++++++++++++
> >>  2 files changed, 19 insertions(+)
> >>
> >> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> >> index bb862d1f0e15..b6c502dad54d 100644
> >> --- a/include/linux/kasan.h
> >> +++ b/include/linux/kasan.h
> >> @@ -360,6 +360,12 @@ static inline void *kasan_reset_tag(const void *addr)
> >>
> >>  #endif /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS*/
> >>
> >> +#ifdef CONFIG_KASAN_HW_TAGS
> >> +
> >> +void kasan_report_async(void);
> >> +
> >> +#endif /* CONFIG_KASAN_HW_TAGS */
> >> +
> >>  #ifdef CONFIG_KASAN_SW_TAGS
> >>  void __init kasan_init_sw_tags(void);
> >>  #else
> >> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> >> index 87b271206163..69bad9c01aed 100644
> >> --- a/mm/kasan/report.c
> >> +++ b/mm/kasan/report.c
> >> @@ -360,6 +360,19 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
> >>         end_report(&flags, (unsigned long)object);
> >>  }
> >>
> >> +#ifdef CONFIG_KASAN_HW_TAGS
> >> +void kasan_report_async(void)
> >> +{
> >> +       unsigned long flags;
> >> +
> >> +       start_report(&flags);
> >> +       pr_err("BUG: KASAN: invalid-access\n");
> >> +       pr_err("Asynchronous mode enabled: no access details available\n");

Could you also add an empty line here before the stack trace while at it?

> >> +       dump_stack();
> >> +       end_report(&flags);
> >
> > This conflicts with "kasan: use error_report_end tracepoint" that's in mm.
> >
> > I suggest to call end_report(&flags, 0) here and check addr !=0 in
> > end_report() before calling trace_error_report_end().
> >
>
> I just noticed and about to post a rebased version with end_report(&flags, 0).
>
>
> >> +}
> >> +#endif /* CONFIG_KASAN_HW_TAGS */
> >> +
> >>  static void __kasan_report(unsigned long addr, size_t size, bool is_write,
> >>                                 unsigned long ip)
> >>  {
> >> --
> >> 2.30.0
> >>
>
> --
> Regards,
> Vincenzo
