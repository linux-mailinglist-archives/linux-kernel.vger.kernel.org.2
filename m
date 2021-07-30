Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDF63DC079
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 23:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhG3VzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 17:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhG3Vyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 17:54:53 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3C0C061765
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 14:54:46 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id r23so14349053lji.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 14:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7aKMKn982p52Fvo+RafbN4nbzmOZcaHi43o8L8qnY+4=;
        b=e3gD2omhgrGKs5t8W/r7K60LV5VhuqUli3ecVKeHtZwHM7LBwgxR5XeOkr9ewdjd2c
         xj7a/kTRU7IGkPLriaWTtOL1eBK9al/wjxGWkB8yqh2majJgR9YYX+ywzrfrf/V9JOXZ
         zWJXESZp+8E/VgCG4qnblM8fAdGwsxYdb03HI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7aKMKn982p52Fvo+RafbN4nbzmOZcaHi43o8L8qnY+4=;
        b=gwggE/BV0jix+7UATmKQMZH/4Wioyn+y3P8G2CAsh4NWXH8x9OcC1k1MUyHN7MAdu2
         tdvBD4rWWtcgMbW+fwtXd0EGPnLErL9rzZBPLUuncxfUQYQEpAmiX/QibyvC79PeG0AF
         HG1bR1sQDTHTPM3bKdfTfyrJor1GVh1b3qcIej9cOW0bgZgrw8Dfxmxb9lTDe6kkRSRC
         zZJwrEJ64ZzeQdNZve+BjjPsssNEzHcQrm1z4g8S0lbyeqJiJ8cCwG9wUgZF6OA6OKFv
         WELRRX0ZM1hOoa/sUxL0TfFK+WO0oKOLV2j90UlOxkOMrs6mopFagWDwFDsjC6oH5zay
         aAKQ==
X-Gm-Message-State: AOAM530qPGs30uO+k6tgEabxDoECN7svTg/IWkeX6UzSMYEJKvP9X/up
        nInq9RNbbNUAkSKC5cC0YLfddsIzhPMu8Wwd
X-Google-Smtp-Source: ABdhPJw7MelbxpsB6pKPkaTn9dtVGPrpxjLjn8um8cMhNtRZ+frqRg2Ssnc8SXjYT/XAMvXPk8nbVw==
X-Received: by 2002:a2e:9599:: with SMTP id w25mr3162160ljh.271.1627682084629;
        Fri, 30 Jul 2021 14:54:44 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id e21sm269900lfq.240.2021.07.30.14.54.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 14:54:43 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id m13so20600852lfg.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 14:54:42 -0700 (PDT)
X-Received: by 2002:a19:c3c1:: with SMTP id t184mr3428280lff.41.1627682071251;
 Fri, 30 Jul 2021 14:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210730201701.3146910-1-ndesaulniers@google.com> <20210730201701.3146910-2-ndesaulniers@google.com>
In-Reply-To: <20210730201701.3146910-2-ndesaulniers@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Jul 2021 14:54:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgh_gk17OoVjXSiuT+7=oYDUKjYGWibd+tCfQRpYJ7cGA@mail.gmail.com>
Message-ID: <CAHk-=wgh_gk17OoVjXSiuT+7=oYDUKjYGWibd+tCfQRpYJ7cGA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] Makefile: infer --target from ARCH for CC=clang
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Arnd Bergmann <arnd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 1:17 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> +ifeq ($(SRCARCH),arm)
> +CLANG_FLAGS    += --target=arm-linux-gnueabi
..,.

Ugh.

A wise man once said: "All problems in computer science can be solved
with another level of indirection".

Just do it like this:

   CLANG_TARGET_FLAGS_arm = arm-linux-gnueabi
   CLANG_TARGET_FLAGS_hexagon = hexagon-linux-gnu
   ..
   CLANG_TARGET_FLAGS = $(CLANG_TARGET_FLAGS_$(ARCH))

Which is a lot denser and simpler.

And then the only if-statement can be something along the lines of

   ifeq ($(CLANG_TARGET_FLAGS),)
   $(error Specify clang target flags)
   else
   CLANG_FLAGS    += --target=$(CLANG_TARGET_FLAGS)
   endif

Plus add *random handwaving* about all the details for CROSS_COMPILE
and friends.

            Linus
