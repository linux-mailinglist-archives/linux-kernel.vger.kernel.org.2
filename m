Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A1933D9A0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 17:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238784AbhCPQkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 12:40:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238769AbhCPQjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 12:39:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3AA265101
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 16:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615912785;
        bh=+bc8rjm6GvUDtegkcJ/U/ccnrf6/y7TQkn4U+QZVHoM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o+MZlll/oz7EPpc929HIHT4jdPJcciANrn1W5BByuJ/1XO5HX54JdbDeeifDOoTY8
         /zRRIPyaOmqJi5HyypjXWHX3Wf2F61o5hMwSN/hqiE6gfj/B9X6SQedALcprFx3PTu
         KiZ8DsHfkuyDLkglY4kCsy+mWTRNPYy7qOaz7h7FmZQDREO6JnTAxbfAUjandEBcij
         3aVC1YTIpas/Ii3O+h5tGbcDiMniS1ZjZhPFifrBpEj5Ot5FBLRfq1nMJzZxduFccy
         zh+59DB0+R/ty1SGEzf9EC+it7UWib2LmttFwkeMM4xtWeZwMoWY3vYjmWVNvF7QZo
         pHMvCaZxCCsTg==
Received: by mail-wr1-f52.google.com with SMTP id t9so7772980wrn.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 09:39:45 -0700 (PDT)
X-Gm-Message-State: AOAM531G9/0ius6t9TSlyiNVxizeKxPHJNRBdjkCtrpKMqo4NQckfFdN
        +SSYApOReTMQXAXBZymoO7X5SgawRnDyIwvorSU=
X-Google-Smtp-Source: ABdhPJzeAl41Jwi24YWqYpOc78h0qVKw/yZ/K8mi/08tddOj9P5fGtGAPcO4GEN+V6qGxAp16okTqikWJS8eK3u7p+E=
X-Received: by 2002:adf:c641:: with SMTP id u1mr5898155wrg.332.1615912784336;
 Tue, 16 Mar 2021 09:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210226140352.3477860-1-arnd@kernel.org> <202102261256.AF256702@keescook>
 <20210227043257.k3aernmnzsvitp7c@google.com> <20210316104530.GA7309@arm.com> <20210316162745.GA20565@arm.com>
In-Reply-To: <20210316162745.GA20565@arm.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 16 Mar 2021 17:39:27 +0100
X-Gmail-Original-Message-ID: <CAK8P3a07nPbbP095LJ84Z5hP3Ce53fb_+0Zav8PUA+7R_92gMw@mail.gmail.com>
Message-ID: <CAK8P3a07nPbbP095LJ84Z5hP3Ce53fb_+0Zav8PUA+7R_92gMw@mail.gmail.com>
Subject: Re: [PATCH] arm64: vmlinux.lds.S: keep .entry.tramp.text section
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Fangrui Song <maskray@google.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        David Brazdil <dbrazdil@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 5:27 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Tue, Mar 16, 2021 at 10:45:32AM +0000, Catalin Marinas wrote:
> > On Fri, Feb 26, 2021 at 08:32:57PM -0800, Fangrui Song wrote:
> > > On 2021-02-26, Kees Cook wrote:
> > > > On Fri, Feb 26, 2021 at 03:03:39PM +0100, Arnd Bergmann wrote:
> > > > > From: Arnd Bergmann <arnd@arndb.de>
> > > > >
> > > > > When building with CONFIG_LD_DEAD_CODE_DATA_ELIMINATION,
> > > > > I sometimes see an assertion
> > > > >
> > > > >  ld.lld: error: Entry trampoline text too big
> > > >
> > > > Heh, "too big" seems a weird report for having it discarded. :)
> > > >
> > > > Any idea on this Fangrui?
> > > >
> > > > ( I see this is https://github.com/ClangBuiltLinux/linux/issues/1311 )
> > >
> > > This diagnostic is from an ASSERT in arch/arm64/kernel/vmlinux.lds
> > >
> > >   ASSERT((__entry_tramp_text_end - __entry_tramp_text_start) == (1 << 16),
> > >    "Entry trampoline text too big")
> >
> > Can we not change the ASSERT to be <= PAGE_SIZE instead?
>
> Ah, that won't work as I suspect we still need the trampoline section.
>
> Arnd, do you know why this section disappears? I did a simple test with
> defconfig + LD_DEAD_CODE_DATA_ELIMINATION and the trampoline section is
> still around.

If I remember correctly, this showed up when CONFIG_ARM_SDE_INTERFACE
is disabled, which dropped the only reference into this section.
If that doesn't make sense, I can try digging through the old build logs to
reproduce the problem.

    Arnd
