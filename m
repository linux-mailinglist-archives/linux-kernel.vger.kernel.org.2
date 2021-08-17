Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771483EE5BC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 06:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbhHQEiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 00:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbhHQEis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 00:38:48 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A3EC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 21:38:16 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id i9so18151645lfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 21:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uq/bBAwcycy9ILdK1/MFcUjGkBg8B9u5tF1ftRi5Jvs=;
        b=eQWhMGR4Wzx2VRiWFtn6HkHbefAZwK1koiIBF+/62t/04vISEOfEHz4jctSwiCwSym
         8/eJ0NnAss13r8v8P+RlBorAGjWvxqUb5flQvKImCB2tiOiklZv0qrFt3pQ2nOIwNz1r
         GvW4LNXZh+y8c7F5cAJRs0quHLY4glemS906I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uq/bBAwcycy9ILdK1/MFcUjGkBg8B9u5tF1ftRi5Jvs=;
        b=IK+pHNfIt0jY2qq4XRpHzLihuZwF3iL54IJ5pHHDhWJN7U3uhIQf45uBNOXpwdAOaU
         E6doR7pIKldR80g5dvFa2zFw56vQspoeQzWD04E8siYEjTiwUAQ8dok+jV+5Ug+bjcj2
         2vj00sTERM/j0km5IilzfS2Btoou4NP/4QOHhhqX4q/W2k0jXLZWyZ2qqJ9zt1enpmNb
         ZvTsYGv1kxQH/Bv+8yr5Cbx8pAADLwHc/dT7MsERxePl7RipisF6aWGZFjSS3umJ+PME
         VDnM/AT8EfroMJK6TmAWFLxDqlzxYLIJPChq3+ZDFC/J+TZ+sJnTDzMA8l8FmQU/jC/0
         GXkg==
X-Gm-Message-State: AOAM531AVL1/Lnd0UyjfgNcJHmlwqMzWn9UQZYukhmOJ+n18Ca0FiS1Y
        gGQSaPhfd+KeM3h+QlW1iB9aelSXGy5I2pos
X-Google-Smtp-Source: ABdhPJx9TJNk0gDvY3rOcU7p8J8vYycosPn29nSyCCn3WRuTraM0bKfnQ2eo4FkJ4OhcH9/jyjtcfw==
X-Received: by 2002:ac2:57cb:: with SMTP id k11mr960520lfo.119.1629175094211;
        Mon, 16 Aug 2021 21:38:14 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id m20sm99183ljp.85.2021.08.16.21.38.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 21:38:13 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id x27so38906811lfu.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 21:38:13 -0700 (PDT)
X-Received: by 2002:a05:6512:114c:: with SMTP id m12mr943646lfg.40.1629175093063;
 Mon, 16 Aug 2021 21:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210817005624.1455428-1-nathan@kernel.org> <80fa539a-b767-76ed-dafa-4d8d1a6b063e@kernel.org>
In-Reply-To: <80fa539a-b767-76ed-dafa-4d8d1a6b063e@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Aug 2021 18:37:57 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgFXOf9OUh3+vmWjhp1PC47RVsUkL0NszBxSWhbGzx4tw@mail.gmail.com>
Message-ID: <CAHk-=wgFXOf9OUh3+vmWjhp1PC47RVsUkL0NszBxSWhbGzx4tw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Enable -Wimplicit-fallthrough for clang 14.0.0+
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 6:20 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Additionally, there should be some time for the CI systems to update
> their clang-14 builds, as the recent 0day report shows.

What?

No, the 0day report shows that the patch is buggy, and that the

  ifeq ($(shell test $(CONFIG_CLANG_VERSION) -ge 140000; echo $$?),0)

clearly doesn't work at all, since the flag is enabled on those
systems with old clang versions.

Alternatively, the test works, but the 140000 version is not enough.

So no. This patch is simply completely wrong, and doesn't fix the
problem with Clang's buggy -Wimplicit-fallthrough flag.

              Linus
