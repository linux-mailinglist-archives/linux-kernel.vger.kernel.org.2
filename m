Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5B832BF6C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835446AbhCCSDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345292AbhCCPTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:19:43 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1A0C061762
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 07:18:45 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id d3so37645740lfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 07:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c1EgmR4iNgHLIiSmovii//tHLOrgOuYElC0B+L466FE=;
        b=MeXdy5ELJ8KysVIcMymUJ6XoMIVkBzMk/q9/3VqZ9qXhae+QwDzQD6/d6JAYsLZiKg
         Im7F7MfmsqLrmn+e/eoDa/PWyQqlsSlWGOfe4WYjNTxocdmJA3Z9RDkOQVlReDlMdiIH
         zrDGzNjqqgB/3ihvoEhRlQMEV+3Q87FFBsqe2IuvBH95gSru/Lq/aexiN6BjshpEHRl2
         7P0qttdG7VTVNmtPtOR5baaYS1vZp7PAKYPWag4ascvIh4+NgjbGxVCFMckDz0nxvZqv
         cAbUfMr/ejIBgtC83hLMGHP5TfstRhDcjbRtdyDtRaFqEZ6vAevN2vgRDLDGM4Cifqyd
         ubYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c1EgmR4iNgHLIiSmovii//tHLOrgOuYElC0B+L466FE=;
        b=Sr9j1oUr6ej8S+kfmy/w00a9w8bamRXRNw8xC6zgl0U2Zoj8u/1FjGZfQeYl/CjI3W
         CpaO/jYUmbiI8LzpJL4LtpbRTFtmwl2WnX4r7LEqZGFz6UPlgGHWDZ2c5DA2fjDAAw3s
         ZEo45G7p39HCKHCXxcjNHffIjHrITcQ/C06eZOe5WR8IGwey2WxeZLmI6S4uokjRZL0o
         2BM+gyDJd8Bsz7TiBc4IbaJ/hoGTeDh+G8nosQymq0Wo11suhvLD7JMXZK3k6NIEtERe
         8kMHOcUgR+brQ2oNLTfQoUjQgciv9FA9Kcx0Eew+AR9C0WOKNe8J05hFAyy8dMdaemZl
         z0Ig==
X-Gm-Message-State: AOAM533rWDEzhOQnN3xDqy3OpUK/nih5wz9XTb5Ptf5Z1z2tqzVJel7o
        IxLR+JK5YnY9tgC06a9Ry0vfB9VV/V8jCho22ZA0Gw==
X-Google-Smtp-Source: ABdhPJxWs0EKhEU3+cXlcQKVKJwnoA45aO7AE9vyg48ZK4GwVXG4V6ruO9zr58sUevEavcdfJhR6bEvR0hrBBVCLWxw=
X-Received: by 2002:a19:548:: with SMTP id 69mr13152043lff.465.1614784724064;
 Wed, 03 Mar 2021 07:18:44 -0800 (PST)
MIME-Version: 1.0
References: <20210219201852.3213914-1-jiancai@google.com> <20210219230841.875875-1-jiancai@google.com>
 <20210222115816.GA8605@willie-the-truck> <CA+SOCLJVGJSn67VU24wPDdsOVeHhGe+KO5ekOCusano=bhn1Mg@mail.gmail.com>
 <20210223100453.GB10254@willie-the-truck>
In-Reply-To: <20210223100453.GB10254@willie-the-truck>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Mar 2021 16:18:32 +0100
Message-ID: <CACRpkdYaSEb8bAztR-s_K17K+Zqusiofwa_dSjz-cwM2+N=57A@mail.gmail.com>
Subject: Re: [PATCH v4] ARM: Implement SLS mitigation
To:     Will Deacon <will@kernel.org>
Cc:     Jian Cai <jiancai@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <nathan@kernel.org>,
        David Laight <David.Laight@aculab.com>,
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
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 11:05 AM Will Deacon <will@kernel.org> wrote:
> On Mon, Feb 22, 2021 at 01:50:06PM -0800, Jian Cai wrote:
> > I am not sure if there are any plans to protect assembly code and I
> > will leave it to the Arm folks since they know a whole lot better. But
> > even without that part, we should still have better protection,
> > especially when overhead does not look too bad: I did some preliminary
> > experiments on ChromeOS, code size of vmlinux increased 3%, and there
> > were no noticeable changes to run-time performance of the benchmarks I
> > used.
>
> If the mitigation is required, I'm not sure I see a lot of point in only
> doing a half-baked job of it. It feels a bit like a box-ticking exercise,
> in which case any overhead is too much.

I wrote some suggestions on follow-ups in my reply, and I can
help out doing some of the patches, I think.

Since ARM32 RET is mov pc, <>
git grep 'mov.*pc,' | wc -l gives 93 sites in arch/arm.
I suppose these need to come out:

mov pc, lr
dsb(nsh);
isb();

As ARM32 doesn't have sb my idea is to make a macro
"sb" that resolves to dsb/isb when this is enabled and then
we could start patching all the assembly users with that as
well. I need the Kconfig symbol from this patch though.

I also suggest selecting this mitigation as part of
HARDEN_BRANCH_PREDICTOR, by the token that either
you want all of them or none of them.

Yours,
Linus Walleij
