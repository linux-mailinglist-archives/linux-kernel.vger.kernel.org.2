Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A04315518
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 18:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbhBIR2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 12:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbhBIR1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:27:33 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DF8C061574
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 09:26:53 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id r38so12865075pgk.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 09:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ukuRLDcQbuu9Wej1M0AS5B/9jDoZ1QokOXA2WrrNxEY=;
        b=YoIMbsWIFWv8KpmtLg8QTcpbt/fUVhBHACu3czCeX0tEmzVDiLrY0Hiw+9Bsv5ukzZ
         ZT6haRQBAUQ2Nlmj2SdCE08HXNG/8jIMjAA3MV1zMqEq4QN3nFDdXkqvK6zYMZ4JIUl5
         fOqqzVqV689MBNMj2xWu7x/kwzRFHmUvnzbHk7frhsyHd/J7BvCjhpp1WTPqsGc7g9Tc
         TXJQe9rsn7m31GtYMvwHCWSbcrNBlDzloWQTRJ5fZ55EOaDghvUu79jpxlXwAHvbuJlQ
         hfB5JWR0pNLKMzu6stN0ZgEMG1uEPZ/LFDgcfZp7C9T1F2sKjdAirJC8a6Y78D65VAvl
         DqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ukuRLDcQbuu9Wej1M0AS5B/9jDoZ1QokOXA2WrrNxEY=;
        b=t2bZJWtqyLhQlufAZ53hr2AQBgHpq17JKp3D6gA7TKS2fHF0sx6hguO8fRHh5x67ZE
         H+X8GFJD+XKwTds4BuDVru7BqBNU1Q8rT0h+FxEx5Z7TyT6MTeTjqxbJuQknlA7oXWKE
         GE14lhHvNDQrRBKHmLgm3h+76eox4wKe6Wl0qJAMfq0r+AunZNTc9Pq4YC+vu23ECyLf
         u8RZK0NVaOnP5QVKZWkADm5TF/3hli/JzRteC7fLAf27yzlFVyejXSacabxXvt530rNQ
         W9jjClmY+Tpz4beNlLWPqeUSNPWrIG/YCh8wFbbnJaf0qnHCgDwfwvf/sW7DIwgIolxc
         ZrBA==
X-Gm-Message-State: AOAM532o5DOAnPQTU3jwV/e6RiIXq9SYue4663kUk9xJFK3NtkQy0cfX
        cttlPhGNZvDa5zWqQ83vSDI+9eQfUORVUTS/LAXOxw==
X-Google-Smtp-Source: ABdhPJz6N+eKvhfv1cZSCC1ZthfavGY4wG1OcdH37S0B5a2XLNoJJaJ3NNyMnTmrR4e3lawZLx9/koEkfFbBVOL1qTg=
X-Received: by 2002:a62:8cd7:0:b029:1d9:447c:e21a with SMTP id
 m206-20020a628cd70000b02901d9447ce21amr19146610pfd.2.1612891613122; Tue, 09
 Feb 2021 09:26:53 -0800 (PST)
MIME-Version: 1.0
References: <20210208165617.9977-1-vincenzo.frascino@arm.com>
 <20210208165617.9977-8-vincenzo.frascino@arm.com> <20210209120241.GF1435@arm.com>
 <0e373526-0fa8-c5c0-fb41-5c17aa47f07c@arm.com> <CAAeHK+yj9PR2Tw_xrpKKh=8GyNwgOaEu1pK8L6XL4zz0NtVs3A@mail.gmail.com>
 <20210209170654.GH1435@arm.com>
In-Reply-To: <20210209170654.GH1435@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 9 Feb 2021 18:26:41 +0100
Message-ID: <CAAeHK+wz1LWQmDgem8ts30gXc=SkwZ-HM507=a+iiNpOYM-ssw@mail.gmail.com>
Subject: Re: [PATCH v12 7/7] kasan: don't run tests in async mode
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 9, 2021 at 6:07 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Tue, Feb 09, 2021 at 04:02:25PM +0100, Andrey Konovalov wrote:
> > On Tue, Feb 9, 2021 at 1:16 PM Vincenzo Frascino
> > <vincenzo.frascino@arm.com> wrote:
> > > On 2/9/21 12:02 PM, Catalin Marinas wrote:
> > > > On Mon, Feb 08, 2021 at 04:56:17PM +0000, Vincenzo Frascino wrote:
> > > >> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> > > >> index 7285dcf9fcc1..f82d9630cae1 100644
> > > >> --- a/lib/test_kasan.c
> > > >> +++ b/lib/test_kasan.c
> > > >> @@ -51,6 +51,10 @@ static int kasan_test_init(struct kunit *test)
> > > >>              kunit_err(test, "can't run KASAN tests with KASAN disabled");
> > > >>              return -1;
> > > >>      }
> > > >> +    if (kasan_flag_async) {
> > > >> +            kunit_err(test, "can't run KASAN tests in async mode");
> > > >> +            return -1;
> > > >> +    }
> > > >>
> > > >>      multishot = kasan_save_enable_multi_shot();
> > > >>      hw_set_tagging_report_once(false);
> > > >
> > > > I think we can still run the kasan tests in async mode if we check the
> > > > TFSR_EL1 at the end of each test by calling mte_check_tfsr_exit().
> > > >
> > >
> > > IIUC this was the plan for the future. But I let Andrey comment for more details.
> >
> > If it's possible to implement, then it would be good to have. Doesn't
> > have to be a part of this series though.
>
> I think it can be part of this series but after the 5.12 merging window
> (we are a few days away from final 5.11 and I don't think we should
> rush the MTE kernel async support in).
>
> It would be nice to have the kasan tests running with async by the time
> we merge the patches (at a quick look, I think it's possible but, of
> course, we may hit some blockers when implementing it).

OK, sounds good.

If it's possible to put an explicit check for tag faults at the end of
each test, then adding async support shouldn't be hard.

Note, that some of the tests trigger bugs that are detected via
explicit checks within KASAN. For example, KASAN checks that a pointer
that's being freed points to a start of a slab object, or that the
object is accessible when it gets freed, etc. I don't see this being a
problem, so just FYI.

Thanks!
