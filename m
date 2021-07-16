Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844B83CBC7C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 21:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbhGPT3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 15:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhGPT3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 15:29:43 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8987DC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 12:26:47 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id g8so11916328lfh.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 12:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VgJDZkLc9fmkT1eM2NCtEiKFd4AK4SPRUAi+psPgPbg=;
        b=IJ70gg+bY2VDX9mgP0INImC7tbm3A1nuwjxrBTGyuveS2Yl2Y9TlwqvVsK8dzadEuR
         CteWexdNPU5UI5ml8rEh75q9fZz3x1ouE9iE+2eOt5Ox5nlkkNvWl2JZa+I1R1cG1OZI
         xjA4LCNrGkp1rxXx/j5bZPgO/Yh9Io4dq4GFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VgJDZkLc9fmkT1eM2NCtEiKFd4AK4SPRUAi+psPgPbg=;
        b=gaawezHmosDval1jtSzMRhIPNCAnaf2jjkeob2foG7RYKNYORCQWmOuVapfLngMciJ
         zH/8+SE9Jq59A4VsfVjRCPDzdsEWmNh4nhtK61xK63ExiIYMG1qosWj6Gj5LSjZCnmT1
         ZtAwA3V8Mi9LMdB+DAvdj799AVCfDZkLaEAJc0jwttlgiyhN67TNWRr+gkufWNQunMRB
         JEUZaGSoQYzGk/WOln6zgGeR3rw6QK77cshpZE5ZY1quM92aop+AYBqT0Jhh5rJhIARz
         6pwlh/MuZ9wnExPIh826BfgBW627TGlHFdlz7+uk4/Y8i/uX9LwK1gtbqy3UvLzng85z
         puCA==
X-Gm-Message-State: AOAM530EehqheEqd1scEmy1auHqPO7eSMGRttiFbYzcZmb9tgNqr40zW
        1B6rvk1S+TNfJ7jLlTEnajUS8Y6gHQ36Hyx+
X-Google-Smtp-Source: ABdhPJxSp+htQfqbwFsefPaSd0jnFjcIStwttzR722GVfeXKyWojEhNLaNGeW9vKzA9bWKcuIUNChg==
X-Received: by 2002:a05:6512:3d0f:: with SMTP id d15mr8970662lfv.246.1626463605704;
        Fri, 16 Jul 2021 12:26:45 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id j14sm764369lfc.20.2021.07.16.12.26.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 12:26:44 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id y7so15073837ljm.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 12:26:43 -0700 (PDT)
X-Received: by 2002:a2e:971a:: with SMTP id r26mr10499533lji.220.1626463603654;
 Fri, 16 Jul 2021 12:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210714200523.GA10606@embeddedor> <CAHk-=wjQeeUiv+P_4cZfCy-hY13yGqCGS-scKGhuJ-SAzz2doA@mail.gmail.com>
 <YPHUJsiaOuqzW0Od@archlinux-ax161> <54a99f59-0211-d9c2-4ab5-e74bbc72086b@embeddedor.com>
 <7774f876-6a60-03e4-b273-34f508d06404@kernel.org>
In-Reply-To: <7774f876-6a60-03e4-b273-34f508d06404@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 16 Jul 2021 12:26:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjGfJPROMSdC8n1xnvyQzxWiz2pXV9E6OE_vpti7rCdZQ@mail.gmail.com>
Message-ID: <CAHk-=wjGfJPROMSdC8n1xnvyQzxWiz2pXV9E6OE_vpti7rCdZQ@mail.gmail.com>
Subject: Re: [GIT PULL] fallthrough fixes for Clang for 5.14-rc2
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 12:18 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Hence why I suggested -Wimplicit-fallthrough-unreachable.

As long as it's a warning that the kernel would never set, that's fine.

I think it's an entirely bogus warning, but at some point as long as
we don't need to care about it, we can happily ignore it.

Or just continue to say "clang is spewing bogus warnings, don't use it".

But the sane naming for that warning should certainly not have
anything at all to do with "implicit". Quite the reverse. The warning
is about an  _explicit_ fallthrough being unreachable, and as such
thje warning name should reflect that.

So make it just "-Wfallthrough-unreachable" (maybe even
"-Wexplicit-..") to allow people who want that pointless warning to
enable it.

               Linus
