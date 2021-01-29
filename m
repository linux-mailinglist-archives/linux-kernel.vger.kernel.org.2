Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10B3308CB5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 19:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbhA2SpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 13:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbhA2SpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 13:45:01 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CDFC061573
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 10:44:20 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id j12so6765005pfj.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 10:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yfdPqJx+KOQg2lShAaFTUWcq3owFmz8E/slr0pFcBmE=;
        b=LvbHs1K3KA/Nx3RiGSIjXK/ab1PfIUEpOQh9qka8x8enT+UNLde8PcY1sksM1mWIF1
         84K85322CqchXlF47QRppXOVkRdgkIKvJtRuRQrgc8noxXP1wjI+tyEcM5AmDAlsQEtS
         wRO5qdeFB1HMkfuRtLUi90ut5qY8wwrxYJppgA9KHRfh5mQy9YrwZvnFkeLeMCHSgo2A
         UezJ3yGZ8BRwJKSxgeNM9sUWj+B6g4KIO/T7LgK5ZVDBBjqLeubaL1cEo8zs1Fy1Jlw/
         k5wq+y5MVYyoyDdg3yi0v7B5rlui0CzXOkyXyUAASlyTB7V7HTCYd36Fv8L391nBmPcG
         mG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yfdPqJx+KOQg2lShAaFTUWcq3owFmz8E/slr0pFcBmE=;
        b=TxTzI9/9UA5iSQlk8VhIR83D/JHBpEudbQWbVDl2GqEt0u+OJS0A7OM0x1C/HLAsIf
         hPrWjPnndj1fQD+502zOGIUyEpTO0jQA6WtBx7207Rn2YiN3mKL65JeLbdEyILYv9YA6
         t4k3QgdKn1wme+t48bac0Bk17VlkwS4QFnZZm6FvFZ6ked4LUXqlNdrP3Ak5XJg9sq7q
         rN3YVLxVSlMbtQ3bKnSmDHf9JK5byzwDrhc1an6/TmmZYJBDGdGwwwyKbmb8Rk8shuey
         AnRHfz1TjTFjMBMecJucUWlUIdG+fYodT10f3qg1Rh4XV8ghcl2mQBJXKlctx+1LTFdL
         F8wQ==
X-Gm-Message-State: AOAM531o0YzEjjeC6HXBFCBADskM7N6wC9aqiD7DkcvAq877GPAismsh
        8Iq6Jxb8ZfXCTGg3PuN0Jy3LCHJT5c+BtqHqz3Jo3g==
X-Google-Smtp-Source: ABdhPJyNaGD7NaBFZt736NuMQUmoCnspqQAfpxnWISq8A2fEad/LdqSVgpVl3Xw0afsqyQO+Y3b3lYOwUlKYFAIlNS4=
X-Received: by 2002:a05:6a00:1:b029:1c1:2d5f:dc16 with SMTP id
 h1-20020a056a000001b02901c12d5fdc16mr5488629pfk.55.1611945860133; Fri, 29 Jan
 2021 10:44:20 -0800 (PST)
MIME-Version: 1.0
References: <20210126134603.49759-1-vincenzo.frascino@arm.com>
 <20210126134603.49759-4-vincenzo.frascino@arm.com> <CAAeHK+xAbsX9Zz4aKXToNTrbgrrYck23ohGJHXvgeSTyZy=Odg@mail.gmail.com>
 <e5582f87-2987-a258-350f-1fac61822657@arm.com> <CAAeHK+x5O595yU9q03G8xPvwpU_3Y6bQhW=+09GziOuTPZNVHw@mail.gmail.com>
 <f1ad988d-6385-45e0-d683-048bfca0b9c0@arm.com> <8021dbc4-8745-2430-8d52-6236ae8c47c7@arm.com>
In-Reply-To: <8021dbc4-8745-2430-8d52-6236ae8c47c7@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 29 Jan 2021 19:44:08 +0100
Message-ID: <CAAeHK+wcVMeqct2ime45eXckUpj7uvfuPe801tmRsFdxVLY-Fw@mail.gmail.com>
Subject: Re: [PATCH v9 3/4] kasan: Add report for async mode
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 7:42 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Hi Andrey,
>
> On 1/29/21 6:16 PM, Vincenzo Frascino wrote:
> > What I meant is instead of:
> >
> > if (addr) trace_error_report_end(...);
> >
> > you might want to do:
> >
> > if (!IS_ENABLED(CONFIG_KASAN_HW_TAGS)) trace_error_report_end(...);
> >
> > because, could make sense to trace 0 in other cases?
> >
> > I could not find the implementation of trace_error_report_end() hence I am not
> > really sure on what it does.
>
> I figured it out how trace_error_report_end() works.

It's intended for collecting crashes for CONFIG_KASAN_HW_TAGS.

> And in doing that I
> realized that the problem is sync vs async, hence I agree with what you are
> proposing:
>
> if (addr) trace_error_report_end(...);
>
> I will post v10 shortly. If we want to trace the async mode we can improve it in
> -rc1.

Sounds good, thanks!
