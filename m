Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E35308C29
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 19:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhA2SKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 13:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbhA2SJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 13:09:53 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4CDC061574
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 10:09:13 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id g3so5680062plp.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 10:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Q4AnktCopaaF8p4i4SvSgWzJSCfa/2k82Zci80Nw3E=;
        b=FmG1cWU88IJpt27quaaKJKUe9U6Hhw1zAeAftY34OEcsxQ0rpOsluSZlijusR6o8mb
         LeEqFohM38SzPWn9NycDQAvwoysSL8TxBSM0Ee15HVnN4w4GcS/Ev43Uo6kKd9b0u/tF
         zbgGfjynw8wWpZ5Llic4XRqNiJUgAeBysi5dfUrfhBPTWaRbdAB0M/g+ar5XO9WqOxz5
         RFu0JcevKpFUIfZiX6/xqT9wC0B+gWfpvgbleGknbImkUsHnF/DP18m4t0NwYYQ+4SZx
         8Ho7Kat0vCWRw6+bLSIPRXJ7tjP2LogP+RGvEpXEGxTc9Gx8lKCyhPPwqCCfM73whe3P
         JSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Q4AnktCopaaF8p4i4SvSgWzJSCfa/2k82Zci80Nw3E=;
        b=e6VjZXgnaVMvLSP4W3qiQsmDPUJ/Z+OnWLNhyxgCkSU1C7qZWeFe1tfBMXAKrk4fpy
         WHsAB+CHLigppa72h/X5rqxIGOlve68W0HKQ1yBaWtyBWu0pHF45k+uxpytOKG5GAqt1
         gqp/MyPoGRpuSRym9TgAJBoZY+2Vagrm9tpWJ/9NBddRcUUxoducd+JchTvxl/T8L3nu
         rFKIjOaK1+OtXx5el8jykJx/ZFaGrL7KvQ7Y++wT3aBph4D/CuJvUuAZ/8OhJ3D4YeQB
         dyJvZ7QnYpRyEEFlR6G+Ny98DRcF0BmG/TpcbHF7VVdpHS2THsPEJlPWJZuAILVh1MXv
         iuVw==
X-Gm-Message-State: AOAM5302Sf4VxpPNdWAgkb3NBrVB0v1R4VYdt7trlpzthWLC1NRl+43Z
        r6ciWSdCe9Hx/FrFBfu4jplm0T6TlVxUjrU0SIb+ow==
X-Google-Smtp-Source: ABdhPJyRpE4aj/5tSCfDh1TaY8yC99qVZ4UcxZUVlJe/mX4CEmRsQoya0F+mx7IEINdw/o7hr0RkJERtn0qXZiyAwqU=
X-Received: by 2002:a17:90a:ce10:: with SMTP id f16mr5677685pju.136.1611943752637;
 Fri, 29 Jan 2021 10:09:12 -0800 (PST)
MIME-Version: 1.0
References: <20210126134603.49759-1-vincenzo.frascino@arm.com>
 <20210126134603.49759-4-vincenzo.frascino@arm.com> <CAAeHK+xAbsX9Zz4aKXToNTrbgrrYck23ohGJHXvgeSTyZy=Odg@mail.gmail.com>
 <e5582f87-2987-a258-350f-1fac61822657@arm.com>
In-Reply-To: <e5582f87-2987-a258-350f-1fac61822657@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 29 Jan 2021 19:09:00 +0100
Message-ID: <CAAeHK+x5O595yU9q03G8xPvwpU_3Y6bQhW=+09GziOuTPZNVHw@mail.gmail.com>
Subject: Re: [PATCH v9 3/4] kasan: Add report for async mode
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 6:56 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Hi Andrey,
>
> On 1/29/21 5:40 PM, Andrey Konovalov wrote:
> > I suggest to call end_report(&flags, 0) here and check addr !=0 in
> > end_report() before calling trace_error_report_end().
> >
>
> Probably this is better as:
>
> if (!IS_ENABLED(CONFIG_KASAN_HW_TAGS))
>
> Because that condition passes always addr == 0.

Not sure I understand. Call report_end(&flags, 0) and then there do:

if (addr) trace_error_report_end(...);

Although maybe it makes sense to still trace all async bugs to address
0. Or to some magic address.

Alex, WDYT?
