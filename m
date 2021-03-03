Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7106A32BFAA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835818AbhCCSE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383657AbhCCPcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:32:55 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378C4C061762
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 07:31:55 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id t9so35847ljt.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 07:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q7aMRHBSl7NHJrCVQqtGWHia3CjmS5YDu6hw58y3144=;
        b=hkdy5FBkaxL7oFI9pp6BeMVjXk1o2Zt23WsIuuhAsSqtfX/Lkdh5QXZgzfKaUqS23u
         K1jHi7CUCZWk0Tkq6ilWcqzhkppJcMDQOoYIxXUmwHI2+IaLdiUHbPxeswfkA7qqhSpS
         pKYdrnKYGY5zt2oWiN6416OdUPfJu0fiXi//jCyntJwgs/F1zHyBTUmwr/An0H1g3sMV
         oJZt/kEFBbGvwmrsSdX3jRgJWTFiUjUTu25FSHX53XSGUD5hVjhAwZSTTuH+ALJIyY0M
         cN/yOfXiA+5ZEUP7GtBNG6upTHFbP7F3jvQDN5n5C09CWxqFX03vtp9XWckYZv0S1u+e
         aPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q7aMRHBSl7NHJrCVQqtGWHia3CjmS5YDu6hw58y3144=;
        b=Hloonc7ljZIuXDkMdoPVYS5xgJAiuHCe6nmv1tgrsgfrkKLIpk1jSmACvkzn5N5ABg
         Tv6op09Kf4HnV7Hlziqv6PQ/v4ofhy/JPKltrKuEdQ8xXzpeVxcl+Lajtzlks4mwR6xW
         GdtN3DKJ2S5JXHEQKfQph9Y8xFwbMnDtqcjwcaQ88yuvEEyLJbYZ/iodhEIaAGzPgFYC
         zzRclKhPrF+WYy1w98SvKWiN0+QDgsjqs1GLExtQy2KYtr8QGsiTE0s936EQaLuEEx+y
         carKg0iAiSrUcwaQH63BXqXu9Za91J7Gp4r1wC2a5Lr+NvqlSTkIKjOOfmDvZIGhwKTr
         rwyg==
X-Gm-Message-State: AOAM532Mm4qblBRm0cfcsrLh4S4zRUujWarjMm0cA+FhL2ubeSYhnRC1
        jbJh5IwZbTiEA1/h8E1rUm+81uhWG1v1EbuNKSiA4w==
X-Google-Smtp-Source: ABdhPJzAav+i0MnJO4TXhlAbYWsXCSj1Sqlgf1GE1KDm/iMLl0vYd0ihsE6lM2OO6Q6m4gLeLJTMLiHnS0JztKnAFus=
X-Received: by 2002:a2e:864a:: with SMTP id i10mr14866199ljj.467.1614785512273;
 Wed, 03 Mar 2021 07:31:52 -0800 (PST)
MIME-Version: 1.0
References: <20210219201852.3213914-1-jiancai@google.com> <20210219230841.875875-1-jiancai@google.com>
 <20210222115816.GA8605@willie-the-truck> <CA+SOCLJVGJSn67VU24wPDdsOVeHhGe+KO5ekOCusano=bhn1Mg@mail.gmail.com>
 <20210223100453.GB10254@willie-the-truck> <CACRpkdYaSEb8bAztR-s_K17K+Zqusiofwa_dSjz-cwM2+N=57A@mail.gmail.com>
 <49e8725f29ab4ecda6d669e9216bca29@AcuMS.aculab.com>
In-Reply-To: <49e8725f29ab4ecda6d669e9216bca29@AcuMS.aculab.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Mar 2021 16:31:41 +0100
Message-ID: <CACRpkdYM3x6pJU3Vi+EEHtC3wD1DkrtVbGDd3PFHWL0fxjSA9g@mail.gmail.com>
Subject: Re: [PATCH v4] ARM: Implement SLS mitigation
To:     David Laight <David.Laight@aculab.com>
Cc:     Will Deacon <will@kernel.org>, Jian Cai <jiancai@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Ingo Molnar <mingo@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        James Morse <james.morse@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 4:29 PM David Laight <David.Laight@aculab.com> wrote:
> > On Tue, Feb 23, 2021 at 11:05 AM Will Deacon <will@kernel.org> wrote:

> > I wrote some suggestions on follow-ups in my reply, and I can
> > help out doing some of the patches, I think.
> >
> > Since ARM32 RET is mov pc, <>
> > git grep 'mov.*pc,' | wc -l gives 93 sites in arch/arm.
> > I suppose these need to come out:
> >
> > mov pc, lr
> > dsb(nsh);
> > isb();
>
> Won't that go horribly wrong for conditional returns?

It will so I would not insert it after those. It has to be
on a case-by-base basis, I am not planning any
search and replace operations.

Yours,
Linus Walleij
