Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC5141CFFA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 01:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347547AbhI2Xan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 19:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347291AbhI2Xam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 19:30:42 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81ED0C061769
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 16:29:00 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id x27so17356522lfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 16:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wu7M9DqJBeP0nkRCi2RNd2jpALrZarew4V0B2j/Hy5M=;
        b=bhHpZyvcnjj667ISJMLub0celi+kt+zVqfIzcCPfZukUu5XefTPXRfdWC8knj6kXPc
         jgMg2WV5OIO31aRDSyVX4N6krkVbNHuqKLNa4W/V101X8LhdVflUZwttL6myDyzVAHJM
         XI3kq/uqBUUwVKgeHOH6PKPwESm35JtMrexfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wu7M9DqJBeP0nkRCi2RNd2jpALrZarew4V0B2j/Hy5M=;
        b=W8/TNYPpWyI7uNHSfeL0wZSvaGajbJsLI0nRxesv77xt43OPFyqzcE4lVOzD5FREm+
         VFNoh2rg9g+qHRaSB5dujpq+KSqEemMV7d9PWXrizXmBxAMFWucFCh818nQibCXsPTQp
         dIxJCzpccWvHOTGNYlZONcKMKs9TMYdmbG0j0l2+xC1vsM7B3OQiJ6mzIMwXClv5zZSY
         sZYOSIrssPM98R0CFDXxh5txYAX0EApSSa6RQV+vqErzzEdvdUJmPpmHnUgtEzx/QUcD
         bbkRZGAeXC7meJcB0ldhPX/uqmX+XsZaS9IG7SKp4jsUd19OtszD3PhCFI94aYujv4Kq
         c7nw==
X-Gm-Message-State: AOAM533DE+hZD55XUXm21yPSPqwcLMQdLYCxn3uH3mZLbkbHykkreKjT
        u7kFUAufvUqnHJj6dAGKiNkEOl68Fqm8FsdYqbg=
X-Google-Smtp-Source: ABdhPJxh01XFs8jHpR9gd6wbe/jWPpc3PfPHHt8MSj+3H7zXIUKlxTmV+Ia1gV99bekfQ3I3OHRLyQ==
X-Received: by 2002:a05:6512:238b:: with SMTP id c11mr2336815lfv.321.1632958138499;
        Wed, 29 Sep 2021 16:28:58 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id a11sm153079lfo.5.2021.09.29.16.28.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 16:28:57 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id e15so17450748lfr.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 16:28:56 -0700 (PDT)
X-Received: by 2002:a2e:4e01:: with SMTP id c1mr2701754ljb.31.1632958136150;
 Wed, 29 Sep 2021 16:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210929225850.3889950-1-ndesaulniers@google.com>
In-Reply-To: <20210929225850.3889950-1-ndesaulniers@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Sep 2021 16:28:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh0BNEDz+uOdJWG8iW=n0PeOEjZpHyuSN2g0pKSCj+6iQ@mail.gmail.com>
Message-ID: <CAHk-=wh0BNEDz+uOdJWG8iW=n0PeOEjZpHyuSN2g0pKSCj+6iQ@mail.gmail.com>
Subject: Re: [PATCH] modpost: add allow list for llvm IPSCCP
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 3:59 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> +static const struct secref_exception secref_allowlist[] = {
> +       { .fromsym = "__first_node", .tosym = "numa_nodes_parsed" },
> +       { .fromsym = "__next_node", .tosym = "numa_nodes_parsed" },
> +       { .fromsym = "__nodes_weight", .tosym = "numa_nodes_parsed" },
> +       { .fromsym = "early_get_smp_config", .tosym = "x86_init" },
> +       { .fromsym = "test_bit", .tosym = "numa_nodes_parsed" },
> +};

This list is basically made-up and random.

Why did those functions not get inlined? Wouldn't it be better to make
them always-inline?

Or, like in at least the early_get_smp_config() case, just make it be
marked __init, so that if it doesn't get inlined it gets the right
section?

It seems silly to add random source mappings to a checking program.

It was bad for the gcc constprop hack, but at least there it was a
clear case of "this inlining failed". This ad-hoc list has cases of
things that are clearly wrong in general ("test_bit()" must not use
initdata), and that "ok, the function just doesn't have the right
section marker.

(All of get_smp_config/early_get_smp_config/find_smp_config should be
__init, since they most definitely cannot work after __init time - but
why a compiler doesn't just inline them when they are one single
indirect call, I don't really get)

         Linus
