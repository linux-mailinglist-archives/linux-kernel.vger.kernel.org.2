Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A4E39048A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 17:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhEYPGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 11:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhEYPF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 11:05:59 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CFBC061756
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 08:04:28 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id k4so19578909qkd.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 08:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=khU4iaS6Na4W6atMcRo3OSUoU5Ql5/4Uc8V3esaLajE=;
        b=OqdPD+NJhqXnoKqA7hSUAo3PdNuzcL0D4dt1kUgJEuQVdRImBlucQc6j82hepLgpUV
         o93/WXB/0xkORZdyJrSR5kp01ZXg2nLptjIPm9dpvc49jwqJwx0GdOV2CT1g17rFcjAa
         r8t4Tp0jkIrEnsY4rAoK9Q8Gx8Rxz6vhM1FDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=khU4iaS6Na4W6atMcRo3OSUoU5Ql5/4Uc8V3esaLajE=;
        b=IIxaAlmFRa0Ud38T6EoqVCTfOdDOdyfI491t0e07hxKUiGNF7dy3Lv5Yrk8yxZVAh+
         dX5pVHnWTTwpV/843+mxBVmSPQVEac0mvsmntpJgCl5hV4IAJOCiI2ZKEvdbhjtnqev8
         G6aRpl6c4iOhVnxNqmC4v+IH4aXy/z9e6P2w1VhcQ1Donmi9hzBoAYTTeUsxjUwXvall
         o41QuCro242gH3IBFhUY3a7MLkbLr+IpsMGU/a/ibu/IJattjEyKNg+WDQRdg0sasWGp
         y1jJwmTCVO/nr4dDbCGYNFrrcfsjAn40CX842+BToJCPhzS4M0nuDxtCbu9/NIjjiKNJ
         Khlw==
X-Gm-Message-State: AOAM533Xj4UvNA0eYDdGgZ3ylHGkfBd63GUuk9eOlEjy/LwpIhSygHhf
        ABD0lCTqaZ4ZL55iQgqdeGpB/NU75q64tA==
X-Google-Smtp-Source: ABdhPJwT0ojtw9HwXk5SJB0Cd6jtwBe/5u0AH28AfoxcmNux5o2cb9S992OD6cMmMsdEa3tGMLdyTQ==
X-Received: by 2002:a37:a1c2:: with SMTP id k185mr35750808qke.210.1621955067067;
        Tue, 25 May 2021 08:04:27 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id c20sm12788469qtm.52.2021.05.25.08.04.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 08:04:26 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id z38so13878043ybh.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 08:04:25 -0700 (PDT)
X-Received: by 2002:a5b:54a:: with SMTP id r10mr43342321ybp.476.1621955065162;
 Tue, 25 May 2021 08:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210507205513.640780-1-dianders@chromium.org>
In-Reply-To: <20210507205513.640780-1-dianders@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 25 May 2021 08:04:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VwhMQ3wV0AsB1cbb3j6q3WzJS=DftUc0MRbTKi8uBs6g@mail.gmail.com>
Message-ID: <CAD=FV=VwhMQ3wV0AsB1cbb3j6q3WzJS=DftUc0MRbTKi8uBs6g@mail.gmail.com>
Subject: Re: [PATCH 0/3] arm64: perf: Make compat tracing better
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Seth LaForge <sethml@google.com>,
        Ricky Liang <jcliang@chromium.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Catalin / Will,

On Fri, May 7, 2021 at 1:55 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> The goal for this series is to improve "perf" behavior when 32-bit
> userspace code is involved. This turns out to be fairly important for
> Chrome OS which still runs 32-bit userspace for the time being (long
> story there).
>
> I won't repeat everything said in the individual patches since since
> they are wordy enough as it is.
>
> Please enjoy and I hope this isn't too ugly/hacky for inclusion in
> mainline.
>
> Thanks to Nick Desaulniers for his early review of these patches and
> to Ricky for the super early prototype that some of this is based on.
>
>
> Douglas Anderson (3):
>   arm64: perf: perf_callchain_user() compat support for
>     clang/non-APCS-gcc-arm
>   arm64: perf: Improve compat perf_callchain_user() for clang leaf
>     functions
>   arm64: perf: Add a config option saying 32-bit thumb code uses R11 for
>     FP
>
>  arch/arm64/Kconfig                 |  12 ++
>  arch/arm64/kernel/perf_callchain.c | 329 +++++++++++++++++++++++++----
>  2 files changed, 305 insertions(+), 36 deletions(-)

While this isn't massively urgent, I'd like to confirm that this is on
your plate to eventually review and/or land. If it's not, do you have
any suggestions for how I should proceed?

Thanks!

-Doug
