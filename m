Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0366E31524D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 16:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbhBIPDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 10:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhBIPDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 10:03:17 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41865C061786
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 07:02:37 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id m2so5880827pgq.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 07:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mjT+lhycmX18IGJ07x7zbycUtzukCo5yZRMUX1bB2L4=;
        b=BkzUN4Mrx/FAzII2hMRZCkd3Cn0JutGjJD6Onfyw/GX+9WM+v1c1hTp24Z4YkoM92G
         4yt9J6GfhtqTO4cKUfL3uswjr1M0/lCzn9txl/m48at09hLrJcExNCGy5uNpN7nmOHKJ
         D8NJy+HBYpMb5jPEF1NS2bw8wiaTnanJQYH9cmplyrL6S1UirZWgld/OoWeN3hel2pzJ
         oybMvYMxSNpHlR1Vyp40x8Z/cIOfMJGGf5han1c7gJftpgMMPqRPaH3nEK9AYIXwA+7j
         B0q0tKCoyWQQqbn0Mrp0c7LQrjLmkercFavHkgkWqtXoHwX3IfF5Za7ada+hmw5kFyWt
         6lLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mjT+lhycmX18IGJ07x7zbycUtzukCo5yZRMUX1bB2L4=;
        b=OsP7Cdrci7tHlJ7ee8qw1AFfzL/sK+4rmK7O5zOBq96AYWgrEoe2GBkyjmIFCV1FNd
         dGHYNYI0eQyPV4f2R2Yg+EaeyvJIcfi3ghYVEvKZiRxoe35jrfGbUUmZ7uiMxZGGkxoH
         NQdkIk8leLy84Id02KEeaymzwY54prp4RdgQ2yjIxJNwQEEW5PqLmZmKaky9IfXyAT6Q
         iEhKctRGQsAcKnzF9CJGn2iGGBtRq+f1u10Ele/JXcnIamT6iEdSBX+tWspLizQSngdb
         UCggLgTdWkBvJQjWFvVEnu2c4ikmaDS1E5USIn1UhPNZ+aTLjDA4gNuAWJmYWyNDx9iL
         e1vQ==
X-Gm-Message-State: AOAM531+KH8SHMEgnAVgfPQIixa2rLnpHCEmertIjdthTzofSRSy18ZI
        IVHzKdA7V8D85BVu5h6P/cbbZ7ubMxRcO4XQm0W/ZQ==
X-Google-Smtp-Source: ABdhPJwgkpfEb4sao/+ZM4cUVJyLihLR4h/EVVhL8fmNUBGkU0iJmUsyXihgPVFO+jQY1QGVvn5EuBKasRSwQ58JHmg=
X-Received: by 2002:a62:8cd7:0:b029:1d9:447c:e21a with SMTP id
 m206-20020a628cd70000b02901d9447ce21amr18569418pfd.2.1612882956610; Tue, 09
 Feb 2021 07:02:36 -0800 (PST)
MIME-Version: 1.0
References: <20210208165617.9977-1-vincenzo.frascino@arm.com>
 <20210208165617.9977-8-vincenzo.frascino@arm.com> <20210209120241.GF1435@arm.com>
 <0e373526-0fa8-c5c0-fb41-5c17aa47f07c@arm.com>
In-Reply-To: <0e373526-0fa8-c5c0-fb41-5c17aa47f07c@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 9 Feb 2021 16:02:25 +0100
Message-ID: <CAAeHK+yj9PR2Tw_xrpKKh=8GyNwgOaEu1pK8L6XL4zz0NtVs3A@mail.gmail.com>
Subject: Re: [PATCH v12 7/7] kasan: don't run tests in async mode
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
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

On Tue, Feb 9, 2021 at 1:16 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
>
>
> On 2/9/21 12:02 PM, Catalin Marinas wrote:
> > On Mon, Feb 08, 2021 at 04:56:17PM +0000, Vincenzo Frascino wrote:
> >> From: Andrey Konovalov <andreyknvl@google.com>
> >>
> >> Asynchronous KASAN mode doesn't guarantee that a tag fault will be
> >> detected immediately and causes tests to fail. Forbid running them
> >> in asynchronous mode.
> >>
> >> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> >
> > That's missing your SoB.
> >
>
> Yes, I will add it in the next iteration.
>
> >> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> >> index 7285dcf9fcc1..f82d9630cae1 100644
> >> --- a/lib/test_kasan.c
> >> +++ b/lib/test_kasan.c
> >> @@ -51,6 +51,10 @@ static int kasan_test_init(struct kunit *test)
> >>              kunit_err(test, "can't run KASAN tests with KASAN disabled");
> >>              return -1;
> >>      }
> >> +    if (kasan_flag_async) {
> >> +            kunit_err(test, "can't run KASAN tests in async mode");
> >> +            return -1;
> >> +    }
> >>
> >>      multishot = kasan_save_enable_multi_shot();
> >>      hw_set_tagging_report_once(false);
> >
> > I think we can still run the kasan tests in async mode if we check the
> > TFSR_EL1 at the end of each test by calling mte_check_tfsr_exit().
> >
>
> IIUC this was the plan for the future. But I let Andrey comment for more details.

If it's possible to implement, then it would be good to have. Doesn't
have to be a part of this series though.
