Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558E944FBCF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 22:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236382AbhKNV3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 16:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236355AbhKNV2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 16:28:46 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFA0C061766
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 13:25:51 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id y12so6292546eda.12
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 13:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tZSSynsKcz8SQQ9wlQiwyLd1LjN5A0/Q7Az2vBog8fs=;
        b=f/viiwPOa9QV59R4dkB8sPRey//vAi2MFsdmXxOnQDPgzBE5u6TsL8/xevZYp8DEoj
         E9DBrfwFkIxLTkn+Ciwp2Pk5aalk/Tl6op7yjcFs+9R219irGePGGHcCsQImGNUgixv8
         J51bTeoO3LyQrNlcHCfVtoFUoRdWd7B/iriEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tZSSynsKcz8SQQ9wlQiwyLd1LjN5A0/Q7Az2vBog8fs=;
        b=4esID4V5VkS58vz3RMgStTAj7UBg0ACfvNTR/HxfsKvY4C3sv3Se0FfXo0sYF27RvQ
         NdGbjwmimANbb9U633V9jf9k8fis6p1LME7Q63vfdMrfDAEABTuy3jjSEPN/0BtUsI9T
         pM8lp52BKROweGY21/XdfSiqt3VQzCJnBsizcsBcqF0uDwzuEXaYiJD51uwmcHv2zAGP
         1og772bq5tfFwDVO8InxZMYOT2tM24b4PLjM2oHR+l/ZWNSBOVyiA6eWP7zy/CeUTLog
         zqy1dk4B157lSqoU2h2fIb5M4uNL/WVoe818RVXC92fGVtYENF1G5d7zPHlnS99q+/di
         mlmQ==
X-Gm-Message-State: AOAM531OfO24QCEb1sCsmboGrUoNsKe0CFeGoH6GMn1Mpmjq6lam1eja
        wUAHR79F+UcBrH4i7J/HV8a61/2teJjO2elW
X-Google-Smtp-Source: ABdhPJx1+yf5k+rVJS+GcvaC4ganin4aWVJIE+UIbPEKM6a6Lc2M56lUbmkZWaiBg3pTYTMgrgeTBA==
X-Received: by 2002:a17:907:1c0a:: with SMTP id nc10mr43430447ejc.211.1636925150323;
        Sun, 14 Nov 2021 13:25:50 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id nc30sm5688151ejc.35.2021.11.14.13.25.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Nov 2021 13:25:49 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso14192273wml.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 13:25:48 -0800 (PST)
X-Received: by 2002:a1c:7405:: with SMTP id p5mr51964221wmc.152.1636925148688;
 Sun, 14 Nov 2021 13:25:48 -0800 (PST)
MIME-Version: 1.0
References: <20211114005725.GA27075@embeddedor> <YZF9MY6rRLQwdTgM@archlinux-ax161>
In-Reply-To: <YZF9MY6rRLQwdTgM@archlinux-ax161>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Nov 2021 13:25:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgqEfw1wFcj98VxyvnoDsUhmYm_P_KuFOpEWe5zmYAp1w@mail.gmail.com>
Message-ID: <CAHk-=wgqEfw1wFcj98VxyvnoDsUhmYm_P_KuFOpEWe5zmYAp1w@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Add support for -Wimplicit-fallthrough
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2021 at 1:18 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> It feels a little odd to have this in Kconfig but if it works and gets
> the warning enabled, then so be it.

We've actually been actively moving more and more of the compiler
flags configuration to Kconfig time.

The Kconfig language makes it fairly easy and natural to do these
days, and in some cases the compiler flags end up having a number of
other dependencies (not in this case, but look at things like
CC_HAS_KASAN_GENERIC etc, where the existence of some compiler flag
ends up then also affecting whether other options can be enabled).

So the whole "move it to config time" ends up being the direction
we've been going, and the only really unusual case here is that it
ends up being done as a string config rather than as a boolean.

And that's just because the different compilers also have different
flags in this case ;(

              Linus
