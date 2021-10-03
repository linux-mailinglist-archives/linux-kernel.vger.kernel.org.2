Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBBC6420311
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 19:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhJCRSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 13:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbhJCRSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 13:18:03 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95430C0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 10:16:15 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id q6so15922136ilm.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 10:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LvbtWHhJ2QLzR2m5rN3+eMw6+xLJZ5dbABBjFP9K8VA=;
        b=GpnNmP4B6Z6PBaYkxrt9Nlu1ZLHxBPVu3yX6c6Y4oYkiK4YIUPFCfUU0k5qcIHxyXJ
         AW75dQQaoZ46Jg+jw6XNZ8cISG6rJDTW+W+NxejjKW3rvHTZflEqU8pJlGPia5pbzdAG
         Lx6FDZCQ6LzYueH21ELfGIMJfAD5QWBu9C32+JPkGBU9zdq+VPQS5ig21WYCPO/fYI+f
         9g1wHFrOuaJiZJDhoOQCtN3xVdaUKX4A4uhD9vcXdxRLEVJ1MPi6B3Ua3FxW9vbQKkEb
         blBm3LDYp4OO+asBEuPzluUAzzpVJPyc7/RvwrmywhrzSINrmBfa4z2L1VTdrqZUq/6z
         sWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LvbtWHhJ2QLzR2m5rN3+eMw6+xLJZ5dbABBjFP9K8VA=;
        b=LXiWKtwvzzZhprubJbXJDvR63SLU21wUsAep7K1a2Q/+vFmfCzvtd/dIJTkAc/s1JQ
         VDTB2GI8jNwQMY+7cMgPDyv0B3ry9gkX3fuLeiThyEHc1D+SGwsGBPil8MnxFsmZ7l2e
         tBrWMQzT0KN6jmMM9EoXmB49YN6S6mq9pNw56rVyW7kzTw4svphqN//OJk+J7C0bniLD
         Az8KXH8Xy9NvOadbrRrzXBkarVxkOIwAffovBDvdjRVaFBOPLNm6F4Ie/lSCN7JjsJGj
         TPoM67o9MrUV3COHcqigQGbWlQIs9vdOmKFvpV9FkSMxA/7V21QrlvYvEFwSkEn7FhsA
         mPag==
X-Gm-Message-State: AOAM530LQqn2B9t2NY7WP9mtGgkzkw1bEz+5LBd8Q8sz97Xa3v7XjlYV
        JmO2MdgbjCmE3L4zCB6DA0s+k8De5giXAvg/3pM=
X-Google-Smtp-Source: ABdhPJwmNHzX5Ab37NQL6tTa5ueYM1TH+wmuIZbpjDwwkSosoDJLxqcMB5gt9X5KnImsRcmI6Z1PsMy7GDdCawlYmnA=
X-Received: by 2002:a05:6e02:1a69:: with SMTP id w9mr1245501ilv.235.1633281375073;
 Sun, 03 Oct 2021 10:16:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210913081424.48613-1-vincenzo.frascino@arm.com>
 <20210913081424.48613-6-vincenzo.frascino@arm.com> <CANpmjNN5atO1u6+Y71EiEvr9V8+WhdOGzC_8gvviac+BDkP+sA@mail.gmail.com>
 <f789ede2-3fa2-8a50-3d82-8b2dc2f12386@arm.com>
In-Reply-To: <f789ede2-3fa2-8a50-3d82-8b2dc2f12386@arm.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sun, 3 Oct 2021 19:16:04 +0200
Message-ID: <CA+fCnZe-gogW1yMuiHhXmKXTsmfkb+-iWp1Vf9K6ZY9madtxfw@mail.gmail.com>
Subject: Re: [PATCH 5/5] kasan: Extend KASAN mode kernel parameter
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Marco Elver <elver@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 9:46 AM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> On 9/16/21 12:43 PM, Marco Elver wrote:
> >
> > Shouldn't kasan.h also define kasan_asymm_mode_enabled() similar to
> > kasan_async_mode_enabled()?
> >
> > And based on that, also use it where kasan_async_mode_enabled() is
> > used in tests to ensure the tests do not fail. Otherwise, there is no
> > purpose for kasan_flag_asymm.
> >
>
> I was not planning to have the tests shipped as part of this series, they will
> come in a future one.
>
> For what concerns kasan_flag_asymm, I agree with you it is meaningful only if
> the tests are implemented hence I will remove it in v2.

Hi Vincenzo,

Up till now, the code assumes that not having the async mode enabled
means that the sync mode is enabled. There are two callers to
kasan_async_mode_enabled(): lib/test_kasan.c and mm/kasan/report.c.
Assuming tests support will be added later, at least the second one
should be adjusted.

Maybe we should rename kasan_async_mode_enabled() to
kasan_async_fault_possible(), make it return true for both async and
asymm modes, and use that in mm/kasan/report.c. And also add
kasan_sync_fault_possible() returning true for sync and asymm, and use
that in lib/test_kasan.c. (However, it seems that the tests don't work
with async faults right now.)

Thanks!
