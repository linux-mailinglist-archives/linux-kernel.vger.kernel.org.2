Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD3B325939
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 23:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbhBYWFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 17:05:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:35988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233902AbhBYWFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 17:05:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8537464F35
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 22:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614290676;
        bh=l2PljfWdgORWpMkKP++LYTc6Q0RJUHrCOYwpRFKOcrI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=to2a1hheMyIIHIFIn+rlIDREMGnx9S2IupNO9QLyHOp6+GqNgudgeduuzAi69+AjR
         UeGl3PgtXS6aF5sU84VVIcIEK37A8ESHGx4fo7jikNhs14xwQP16PMnFWt485UyRsK
         Y9klWxVH2kgryRMTXwbDVqadCvRjq1EFGMwGU3JmRiEr0mHgW/Y52/JKfyF1A9ALk1
         0dJgNWG5AinD/d6jpaIcJaQTr/dNiGtsDuZj7AxeHOmmqlR3RMs5KGUq8OOPDm9pht
         QEFlCQTkOaiSWpQMqZkocMehtDIy3wsVxjploP42rybIu1hVFEnNDudGsGmayZdv+i
         HFgsNlEZyyF9A==
Received: by mail-oo1-f42.google.com with SMTP id x19so1742579ooj.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 14:04:36 -0800 (PST)
X-Gm-Message-State: AOAM5338m6Qs/CgYxk6vS8ziPF3WEPGTy9Ug4JYbRscGUnJs3xYMx50X
        RJqYL1YMKExTNbbUysmigw3g4IgSMC+jJeWz9xw=
X-Google-Smtp-Source: ABdhPJx+xdKnM6uqlsThkGKDvrM4g/9k8Lo8J3KqeNGYmmU+YkapR+Qj19yCWgUZBYrysz0TuokMM1/uonYbWaYRn1Y=
X-Received: by 2002:a4a:870c:: with SMTP id z12mr48017ooh.15.1614290675584;
 Thu, 25 Feb 2021 14:04:35 -0800 (PST)
MIME-Version: 1.0
References: <20210225094324.3542511-1-arnd@kernel.org> <20210225164522.GA3554437@xps15>
 <CAKwvOdm_yh6gw_ecjeKgepRb12Q69Wk64x7xj=L2CDjBekiioA@mail.gmail.com>
In-Reply-To: <CAKwvOdm_yh6gw_ecjeKgepRb12Q69Wk64x7xj=L2CDjBekiioA@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 25 Feb 2021 23:04:19 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2XD7yA7s4d1t1Ogy0vnX-YGYRaHkY9Civ0H4Z9VJ22Tw@mail.gmail.com>
Message-ID: <CAK8P3a2XD7yA7s4d1t1Ogy0vnX-YGYRaHkY9Civ0H4Z9VJ22Tw@mail.gmail.com>
Subject: Re: [PATCH] coresight: etm4x: work around clang-12+ build failure
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        coresight@lists.linaro.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 10:23 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> On Thu, Feb 25, 2021 at 8:45 AM Mathieu Poirier
> <mathieu.poirier@linaro.org> wrote:
> >
> > Good morning,
> >
> > On Thu, Feb 25, 2021 at 10:42:58AM +0100, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > clang-12 fails to build the etm4x driver with -fsanitize=array-bounds:
>
> Is a sanitizer enabled, that would trap on OOB?
>
> > >
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/1310

As described over there, this happens only with the array-bounds
sanitizer.

Actually, looking at it again now, in the reduced test case, the inline
assembly is not even parsable, it only works because it never gets
emitted without  -fsanitize=array-bounds, and the alternative
code path is used in

#define read_etm4x_sysreg_offset(offset, _64bit)
         \
        ({
         \
                u64 __val;
         \

         \
                if (__builtin_constant_p((offset)))
         \
                        __val =
read_etm4x_sysreg_const_offset((offset));       \
                else
         \
                        __val = etm4x_sysreg_read((offset), true,
(_64bit));    \
                __val;
         \
         })

read_etm4x_sysreg_const_offset() eventually turns into something
like

asm("msr_s " __stringify(offset));

so the offset has to be something that can be parsed by the
assembler. __builtin_constant_p() checks that it is a constant
value at compile-time, and in this case it can be because there
is a small upper bound and clang just unrolls the loop.

I don't think there is an alternative to __builtin_constant_p()
that can be used to decide if the argument is something that
can be used as a constant expression in an inline assembly.

            Arnd
