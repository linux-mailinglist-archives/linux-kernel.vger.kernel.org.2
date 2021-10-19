Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF63433EE9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 21:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbhJSTEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 15:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbhJSTEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 15:04:06 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55183C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 12:01:53 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id x1so19492086ilv.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 12:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WobMCGHbd5iE8RXCKMYU25vcm8PDvkdc5bc8OyqVW5s=;
        b=iGJ44RcAwe0LUv+MQxo6HEWoTqk4jJySctYq88Z7zREHp9rezPalo4koU/wfR0C/Nv
         0H9hRpvy/FRxEyXFQmTb2d0rfQFmdkiEGj0fFm+VaXmfNZecNaOD0pFRZgLBtXAYnSJ4
         rVKh45jNrKu9Riy2IwY0gFX3torYsWGp1aJD3FToIErNBIYpEfo3um5mICrtHgKmVdPV
         C79pD493xMQAaGyveiZb3Ny2i13GmwOZ3bJLdlC3WhQjm4KTfp7rfbnfVV6t0iJGJLUr
         27X3iMpoc8TAHrssN1rNTi/rcM+ZLQPv5N9q6GgnA05AvT9x54XmTYY1wu/T2ZwM/E29
         hV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WobMCGHbd5iE8RXCKMYU25vcm8PDvkdc5bc8OyqVW5s=;
        b=6m+IPjmwIsBZeR5OxV5gtTxAHNMbF4xLsJNQUrtOODPp47WhB5fWQQErYGzaKVUI07
         iy5XHKgqps7q9iw+lF8CL84gjWhzvUjq61BGaniOPfVjGEzbIYEO/D0xITEldiSw2Svx
         dqVtGMEpi03Tk77erXiX5IBE29EIn3VOiydRp+po1w7LfjukAMNCpRGmvURvw/Sggz7E
         jSP6YC3HVj3zyq61c2tIhTVIRn6sXyMbyHLfDgN1BdLNtRwP977TKGYn/WcvpMhvSoiq
         4ryIk9jgkWCdKjanSJ9vS5JwsSxWzc/nbaAjrUPoAu1/6t2BWFyGyIBYhZeBFf5xVafZ
         MdfQ==
X-Gm-Message-State: AOAM531DXZa7YXcyz45e2js4CAqx/Nt5wLkq318AiblGNyo6LgKkXuWf
        1zg75bNPLPyzq9vvz49QyHI8DofbFRy0+o0yCH4=
X-Google-Smtp-Source: ABdhPJzU2z69O7Fqug+dPQ5GAVvRp04WE2rMCgYGOE487by9Yq9YbM36FEYlS9uT+ieFNlJILMVNTFhq9sT1rYHAXfg=
X-Received: by 2002:a05:6e02:188c:: with SMTP id o12mr18622447ilu.321.1634670112704;
 Tue, 19 Oct 2021 12:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <20211019171121.3510624-1-arnd@kernel.org>
In-Reply-To: <20211019171121.3510624-1-arnd@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 19 Oct 2021 21:01:41 +0200
Message-ID: <CANiq72kckY71gg=xMFOHEraW+PYGbRBsm2xv1tBn7013ipyyWg@mail.gmail.com>
Subject: Re: [PATCH] [RFC] x86: avoid -mtune=atom with clang
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 7:11 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> +ifdef CONFIG_CC_IS_CLANG
> +        cflags-$(CONFIG_MATOM)         += -march=atom -mtune=generic
> +else
>          cflags-$(CONFIG_MATOM)         += -march=atom
> +endif

Is it possible to factor it out? Also, a comment with the LLVM version
we last checked would be good. Something like...

    cflags-$(CONFIG_MATOM)         += -march=atom

    # Atom optimizations do not seem well exercised in, at least, LLVM <= 13,
    # to the point of getting problems with register allocation.
    ifdef CONFIG_CC_IS_CLANG
            cflags-$(CONFIG_MATOM)         += -mtune=generic
    endif

Cheers,
Miguel
