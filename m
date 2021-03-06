Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5C932FAA8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 13:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhCFM0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 07:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhCFMZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 07:25:50 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217ADC06175F
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 04:25:50 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id y12so7911760ljj.12
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 04:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9QHA/auC828Jqan2akyk0NJH1AQcH9ax/tK0w9DMNcw=;
        b=RjeGfMg07ilX+5+ALabW4rNuZA59tc6R+55MKGqB7nmpBuwVwbWCyBDCJRIs9P7QTy
         5BAqpbHKQPiz3s3ORQRNdCKy8vx+KKbW3sPbPHuvlcI4nj3wgl9sQS3bmaLvpE8vMwJ0
         ngnc2n1J0TfkfJIorDuasnLUIGvdKUM9EERxb4uS4BOcxxDdAtv3fUxAErZSU4LJBbLe
         cXIQJuCKfywKJ+mPg7/Y0nTgHcq5BnkOI7u1cxBK+UHbj4j+tO/ilSEVW7cDKvI/IgTs
         SpLh7rpgi/11lncH87L6pRwn0bIKR2fzlSsGFGexrWck01+k15gXcybuHjkWZAYDXo+Z
         6r8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9QHA/auC828Jqan2akyk0NJH1AQcH9ax/tK0w9DMNcw=;
        b=m4OTUDknfOVS5+0sww/lsKiBPfU1qVchwnfIhT4q8F3LYpTWWK2HAKyXhJEAESS1Re
         6q11GVaFXaZOouMr+NrAG7Au24Jd+C8YR0rOKnoP68OYPVrCBh11evVbbUPGDf7zDP2D
         fLTWzPoLbZ425gU7TCc7/yPn6hiQhXd+pblTP6tZExdx1on3qKeNSoVzX60GyA3e+LKk
         aF4m4Xa3LrMX4vebeqYIdH12T7/Z7hBcLtt8fx8+xDrh2i4SLtDgj3QTq+cVvDSVwRYD
         x5uZTtJ9QfkuoUQJq0IDlV75bE8X6FuVpAmsNi8+lCzcyfbO+NTSj7h5K3UBYyjMIol3
         wgTQ==
X-Gm-Message-State: AOAM531aR73jiwSU5/hvtEmn9EwkoYD78K2TTw+XwVzFDeEBsEdm++6U
        LAX7k8Py1aQHbNLjuTS11zh/AqENp1XkSgrrC+Sz3A==
X-Google-Smtp-Source: ABdhPJyENu+1DZB38ombukTrlidYFs75f5DQ8cOROWqImvC/TvRimyOKx2FAWAj2nHXanlTxlxY5o6G1svhNN/nzePQ=
X-Received: by 2002:a2e:9cb:: with SMTP id 194mr8159473ljj.438.1615033547728;
 Sat, 06 Mar 2021 04:25:47 -0800 (PST)
MIME-Version: 1.0
References: <20210223023125.2265845-1-jiancai@google.com> <20210223023542.2287529-1-jiancai@google.com>
 <CACRpkdYC3iDD23SESM0j2=f56kr6ByKeedDQvkGwXbUC0br0fw@mail.gmail.com> <CA+SOCL+M5YfhygG=ogqvqp7y40v+32RiteGr=53THzwvdGugyA@mail.gmail.com>
In-Reply-To: <CA+SOCL+M5YfhygG=ogqvqp7y40v+32RiteGr=53THzwvdGugyA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 6 Mar 2021 13:25:36 +0100
Message-ID: <CACRpkdYrqy78EfB_+UY0QtA0v0tD+_+O09Pod8-1Vd-p-VyMWA@mail.gmail.com>
Subject: Re: [PATCH v5] ARM: Implement SLS mitigation
To:     Jian Cai <jiancai@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <nathan@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Will Deacon <will@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        James Morse <james.morse@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 5, 2021 at 12:23 AM Jian Cai <jiancai@google.com> wrote:
> On Wed, Mar 3, 2021 at 7:04 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > On Tue, Feb 23, 2021 at 3:36 AM Jian Cai <jiancai@google.com> wrote:
> >
> > > This patch adds CONFIG_HARDEN_SLS_ALL that can be used to turn on
> > > -mharden-sls=all, which mitigates the straight-line speculation
> > > vulnerability, speculative execution of the instruction following some
> > > unconditional jumps. Notice -mharden-sls= has other options as below,
> > > and this config turns on the strongest option.
> > >
> > > all: enable all mitigations against Straight Line Speculation that are implemented.
> > > none: disable all mitigations against Straight Line Speculation.
> > > retbr: enable the mitigation against Straight Line Speculation for RET and BR instructions.
> > > blr: enable the mitigation against Straight Line Speculation for BLR instructions.
> >
> > I heard about compiler protection for this, so nice to see it happening!
> >
> > Would you happen to know if there is any plan to do the same for GCC?
> > I know you folks at Google like LLVM, but if you know let us know.
>
> I think gcc also has these options.
> https://gcc.gnu.org/onlinedocs/gcc/AArch64-Options.html

And how does that work with this part of your patch:

+#define SLS_TEXT                                       \
+       ALIGN_FUNCTION();                              \
+       *(.text.__llvm_slsblr_thunk_*)

This does not look compiler agnostic?

Yours,
Linus Walleij
