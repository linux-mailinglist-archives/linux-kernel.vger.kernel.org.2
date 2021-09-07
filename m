Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64DD4030D3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 00:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347640AbhIGWTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 18:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347523AbhIGWTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 18:19:49 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AE6C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 15:18:42 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id x27so756071lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 15:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I0zmMnIiAhcfycStlfZRMWh53/bzZhPDg9yKAX8nkCc=;
        b=cNF0wdQ/TI780fTJbXH+7PorV+kNufKENvngWCa75x9+fsFjdodc8BLriyvTsCTO8U
         3xhHhbhNl3mJ8vyi986ZALpOUaKDIIiRRrmudAYEM+8oj2aPJHDjMPeTyMLxFH9iIA3K
         h4nrgFG911smxfTzCOCLFHotIQtnlmu1V6DQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I0zmMnIiAhcfycStlfZRMWh53/bzZhPDg9yKAX8nkCc=;
        b=Kc63fu4pDjBLU48HXEP+seu5yoSaoSzg8A4sBybWjp9AOhFxGdeDQ9m+uVifboEQNG
         ulF28EGLdXHSDcABRtUg80o6x+lSjE2i2aoN0OiF/E1OyWb4S4nh65FWWpDaq06hBCMb
         bC5pIWLHyVag6AmYbWKDt0wtRXCbUwK5Sl8LYaqDEpeYuIyUN4sXqbR4m/PiefePLiMJ
         3Z5CNc/erwECoJAueBinG7Be4qjkb7ypD1ao9KpPtMbMCZMrViZp6pw6mQBnVhN5kx3H
         J6EaJohoFprYWxBeKFELpP64TMEt2q0hQZ1XOwUDznG/sX22Dsg1wWSIfqU1LE7gssrE
         kMjA==
X-Gm-Message-State: AOAM532U2omfdNXvL0af5M1TQBLhEQkYNjV4uFfdyfk36kTcV3iYlSbM
        7RzzKa0uKw73+NP3hlQn4u0e3ue6vLpXwWoch1w=
X-Google-Smtp-Source: ABdhPJxo+EqrMhWEyTC7pcY7g+tsGMcC6SKmsSLBTFDwIH6uhD86eSqotshAQfX2haZgnzT+48yBdw==
X-Received: by 2002:a05:6512:34c3:: with SMTP id w3mr419425lfr.173.1631053120942;
        Tue, 07 Sep 2021 15:18:40 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id z8sm19065lfs.177.2021.09.07.15.18.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 15:18:40 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id t19so248276lfe.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 15:18:40 -0700 (PDT)
X-Received: by 2002:a05:6512:3da5:: with SMTP id k37mr426102lfv.655.1631053110042;
 Tue, 07 Sep 2021 15:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210907183843.33028-1-ndesaulniers@google.com>
 <CAHk-=whJOxDefgSA1_ojGbweRJGonWX9_nihA-=fbXFV1DhuxQ@mail.gmail.com>
 <CAKwvOdkuYoke=Sa8Qziveo9aSA2zaNWEcKW8LZLg+d3TPwHkoA@mail.gmail.com> <YTfkO2PdnBXQXvsm@elver.google.com>
In-Reply-To: <YTfkO2PdnBXQXvsm@elver.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Sep 2021 15:18:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPaQsEr+En=cqCqAC_sWmVP6x5rD2rmZRomH9EnTQL7Q@mail.gmail.com>
Message-ID: <CAHk-=wgPaQsEr+En=cqCqAC_sWmVP6x5rD2rmZRomH9EnTQL7Q@mail.gmail.com>
Subject: Re: [PATCH] Revert "Enable '-Werror' by default for all kernel builds"
To:     Marco Elver <elver@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, llvm@lists.linux.dev,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-toolchains@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vipin Sharma <vipinsh@google.com>,
        Chris Down <chris@chrisdown.name>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 3:14 PM Marco Elver <elver@google.com> wrote:
>
>
>  config WERROR
>         bool "Compile the kernel with warnings as errors"
> -       default y
> +       default COMPILE_TEST

That seems reasonable. It very much is about build-testing.

              Linus
