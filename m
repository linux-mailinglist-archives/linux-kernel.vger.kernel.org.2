Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9F3427235
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 22:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242810AbhJHU2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 16:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242366AbhJHU2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 16:28:06 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5556C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 13:26:10 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id t9so42691903lfd.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 13:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3JRsd2+QOd6FjI2etkPN+8NW1rvg7nW8l/Yu1fBl2JQ=;
        b=bM9y67omMTUVGhAfDEpfUJJGhYF2MTS/5j06GPIUsOH0tcb2Pf2hwW/tvUyZns3e7T
         6AEGHP7kudrikucEkq+2tefCcZd/2ed8wfPX3xXR6DhdugS17wCFchk+S9JI1bIufiG1
         wfeewC+giLpyUkFDRxDBy9HwOwGvTI5K0I27M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3JRsd2+QOd6FjI2etkPN+8NW1rvg7nW8l/Yu1fBl2JQ=;
        b=5nW/6lvkr6L3gKDXYHwCKYjfwVtxsn4eL134PGAH1uUIPMgibls8up8ddX4S1jhElZ
         iHi0CT4n1PLmKgvdatDsShvcOXplmbtMKrPYV6XOUHFExtZkONUCwBCjo3cCyLKSVNZ0
         ULJRVK5+ox0fRxoi70kKiAhxzmEOs4alyw1FWVCxiWGK2QNKM2W/K6SgTshJDkGc2nAC
         eX1oOnVZeb4ta0ijf0C79iRbG6I+att3LwIIA14QbZvv5E7dsfY7DPiYDTFwDfWwDxFx
         SWuXT5EC/mnY0wycpxjsCZjMpreo+Li6AOcdNN0n5ng515Yzw2839sdi0W0Wa9rBZmJR
         AbeA==
X-Gm-Message-State: AOAM533JulTbI5tYHXVvBBxGbaQeT4Y0dEhELxZp1xdFFO+kTCQimfp8
        kQXG+OoT9VqJiTRBmFgvB+RhtkblSNnOC51m
X-Google-Smtp-Source: ABdhPJyE0PtDIBnfyQ1lqm1WS4OmjVWOLRXhlKXJgz5EPEfax2vE7qu5A6jfy9yqC6K9WNEdlQgIOw==
X-Received: by 2002:a2e:6f12:: with SMTP id k18mr5584097ljc.378.1633724768760;
        Fri, 08 Oct 2021 13:26:08 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id t192sm26282lff.174.2021.10.08.13.26.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 13:26:07 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id z11so35279101lfj.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 13:26:07 -0700 (PDT)
X-Received: by 2002:a05:6512:3d26:: with SMTP id d38mr11933742lfv.474.1633724767417;
 Fri, 08 Oct 2021 13:26:07 -0700 (PDT)
MIME-Version: 1.0
References: <YWCPyK+xotTgUMy/@arm.com>
In-Reply-To: <YWCPyK+xotTgUMy/@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Oct 2021 13:25:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=whWZ4OxfKQwKVrRc-E9=w-ygKdVFn_HcAMW-DW8SgranQ@mail.gmail.com>
Message-ID: <CAHk-=whWZ4OxfKQwKVrRc-E9=w-ygKdVFn_HcAMW-DW8SgranQ@mail.gmail.com>
Subject: Re: [GIT PULL] arm64 fixes for 5.15-rc5
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 8, 2021 at 11:37 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> Pingfan Liu (2):
>       kernel/irq: make irq_{enter,exit}() in handle_domain_irq() arch optional
>       arm64: entry: avoid double-accounting IRQ RCU entry

Ugh. This is *really* ugly. And it seems to be going exactly the wrong way.

I read the commit descriptions, and it still doesn't answer the
fundamental question of why arm64 needs to do the accounting in
arch-specific code, and disable the generic code.

It says

    To fix this, we must perform all the accounting from the architecture
    code. We prevent the IRQ domain code from performing any accounting by
    selecting HAVE_ARCH_IRQENTRY, and must call irq_enter_rcu() and
    irq_exit_rcu() around invoking the root IRQ handler.

but at no point does it actually explain *why* all the accounting
needs to be done by the architecture code.

Yes, yes, I read the previous paragraph. But why isn't the fix to just
stop doing the double accounting in the arm64 specific code?

Instead it doubles down on that "let's do this non-arch-specific
accounting in arch-specific code", making the common code uglier and
weaker.

I initially pulled this, and then I just unpulled in disgust.

Please explain why arm64 does this bad thing, and why the fix isn't
"fix arm64", but instead "make the generic code uglier and harder to
maintain and follow".

Really, from all the explanations those commits give, the natural
thing to do would be "just fix arm64".

So if that really isn't the answer, then the explanations are clearly lacking.

                   Linus
