Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAEE5421692
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 20:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237033AbhJDSew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 14:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhJDSev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 14:34:51 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAE1C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 11:33:01 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id i24so26080984lfj.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 11:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zwoGj5TiUa0A7agdZvrBz9UD3O3dDdKIGQX+inibl1s=;
        b=ddRmXF8X8j+bmGpyuQGk0heDxx22+vmZgoacQBq/+c1TT6df9s6Rtro2xLb64I2Yu+
         BmdU6+FmgvOXOdUgyftCb2yDr8n4vFlEW61Dp/GL+MbNdvLC0O2qFYO14k9k7d9V1Zvj
         pqpla6bpEpIuLSktFJMuZvZ8Kg7/xj/KP5SZJGad3JCBGf5dEIExcglz1j0bxeUJ4aPr
         u0BjLMY2wY/0oOepwyJJ8uuUz8YYUbo/MYg0ijj38cCHV7FIS4CGt8ek3TpmSt5VP/94
         YlOytCstTloL4nYEluzCPSWYya0HfFzS465zdp4iMlBfWcOBCoJ8XdddjoEnMZKqM8WS
         VJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zwoGj5TiUa0A7agdZvrBz9UD3O3dDdKIGQX+inibl1s=;
        b=YlYhwn+r3cqGXzVao5u0hTOSgUf9EfLFC1Qw/xEIM6mUATDGkFI0sPSXKPXLLuZNuD
         4qhyXmanM+opFCWNdSYt9SxeWpOK8wMzrt5c6lwIfzd91E38uQzumGdQtHl9XbG2TLHt
         lrXHtYbbhSNqOD5/MRqdfk2a24UMyVEgPxwZjMDCr9eCArqx2+VOcRrM19AjYqqvMpDj
         znVmZEDNDqmrONVj9PL/o0M9zW73Czn8EZo8tacA/bfF3DkqwfpJq1UG+scgI/k0gDE5
         V70bdOnQJngRxk/JX/djl8cR3U//MUVm1Qs6NM90e7y49RvIRoKBjlIpVayxpwDGsKyJ
         sanw==
X-Gm-Message-State: AOAM532EY7RwuEHa4FjA7snJEXRJnCIRV3ElcAD1oD7FzGnPRebOo7hJ
        Yay0d+rCu3PckPzG5dZnH7+S+qrak0YtLW5Se+8KoA==
X-Google-Smtp-Source: ABdhPJzUAdumac7faofur/bcBqVOc7MFPVVcHzNcxQx4QmrJgjZUPBivKiZQUJ2L7ONM8nHQC0hNMbAyc5EpAC5IQMU=
X-Received: by 2002:a2e:5059:: with SMTP id v25mr17260172ljd.128.1633372374879;
 Mon, 04 Oct 2021 11:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <202110020501.RKX4zca7-lkp@intel.com> <20211004162936.21961-1-ndesaulniers@google.com>
 <163337043811.3396838.458236649388694225.b4-ty@chromium.org>
In-Reply-To: <163337043811.3396838.458236649388694225.b4-ty@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 4 Oct 2021 11:32:43 -0700
Message-ID: <CAKwvOdm5bBUE0df8jbXq+bSCf9U0AM3Wm4NsZeHu=Nuhi0yd-A@mail.gmail.com>
Subject: Re: [PATCH v6] kallsyms: strip LTO suffixes from static functions
To:     Kees Cook <keescook@chromium.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, "KE . LI" <like1@oppo.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Fangrui Song <maskray@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Joe Perches <joe@perches.com>, Jessica Yu <jeyu@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 4, 2021 at 11:05 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, 4 Oct 2021 09:29:33 -0700, Nick Desaulniers wrote:
> > Similar to:
> > commit 8b8e6b5d3b01 ("kallsyms: strip ThinLTO hashes from static
> > functions")
> >
> > It's very common for compilers to modify the symbol name for static
> > functions as part of optimizing transformations. That makes hooking
> > static functions (that weren't inlined or DCE'd) with kprobes difficult.
> >
> > [...]
>
> Applied to for-next/hardening, thanks!
>
> [1/1] kallsyms: strip LTO suffixes from static functions
>       https://git.kernel.org/kees/c/6eb4bd92c1ce
>
> Also,if you get a moment, can you set up patatt (or b4) to sign your
> outgoing patches? DKIM is nice, but I'd like to see more folks signing
> their emailed patches: https://github.com/mricon/patatt
>
> tl;dr:
>
> add to ~/.gitconfig:
> [patatt]
>     signingkey = openpgp:FINGERPRINT-HERE
>
> # install git sendemail hook (assuming you send with git)
> $ patatt install-hook
>
> # or do it manually before sending:
> $ patatt sign $file-with-email
>

Sure thing, trying this out, the commit hook seems broken:
$ git format-patch HEAD~
0001-ARM-mm-proc-macros-ensure-_tlb_fns-are-4B-aligned.patch
$ git send-email --suppress-cc=body --to keescook@chromium.org
0001-ARM-mm-proc-macros-ensure-_tlb_fns-are-4B-aligned.patch
patatt: E: -: Not a valid RFC2822 message
fatal: 0001-ARM-mm-proc-macros-ensure-_tlb_fns-are-4B-aligned.patch:
rejected by sendemail-validate hook
fatal: command 'git hook run sendemail-validate -- <patch>' died with
exit code 1
warning: no patches were sent

`patatt sign 0001-ARM-mm-proc-macros-ensure-_tlb_fns-are-4B-aligned.patch`
seems to work.
-- 
Thanks,
~Nick Desaulniers
