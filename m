Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F15D33A227
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 02:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbhCNBTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 20:19:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:42352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231205AbhCNBSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 20:18:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F329664E62
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 01:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615684732;
        bh=k3lSEvG5L8w7S3VROoNto1+EQdiQn0y7S+T14iQSFAI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lfIqBM61hja+SRAPGbOvB1Td8qzfjPqcS+ez2umM02iunhhBHXtKMvwMnDbrJz+3o
         fjP1pxPnJZF6ao8Pq+7NKWQWSO4/sWZeGmQeAzVA420P799J2I9hldMg1CG+Ou0sqS
         bjcV23XuOqGK6j5RTPWkDel5lBlfZNeBL/Xb54mDII9QsG0N561uQN++stnRaT2pmZ
         2TVEF5ZPsNEDapHaHxfzDBd8OS6dcrOa6ozWEe9HZv0wGdnzRsqmuX/u4xItmPvPJW
         ouznZo37GwkWvYyKcccQCOXacYOOpad8tTBhshc4VNVlFYvlLC9rf8Bg8qYpdbrnKu
         QbDiA+npv1CZA==
Received: by mail-ej1-f43.google.com with SMTP id r17so60459537ejy.13
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 17:18:51 -0800 (PST)
X-Gm-Message-State: AOAM532RJNhWgRAsdprTluWzyov7/evGJKiIsFQD8+t6qz/ld0L66m/a
        OrWMQJTWgFNkLOOA9qLH+bmdAdim/Q/BeRChEom9UA==
X-Google-Smtp-Source: ABdhPJyNTCn0hF+JG3tgVmyJwYF5vYcZCoA/dtTmejcr4GosYjNQ6Y8OdITfa7kbLWjMDtbb1bss/3DWta/pgJeAGys=
X-Received: by 2002:a17:906:1494:: with SMTP id x20mr16325195ejc.101.1615684730514;
 Sat, 13 Mar 2021 17:18:50 -0800 (PST)
MIME-Version: 1.0
References: <cover.1614884673.git.luto@kernel.org> <e8ad39b0e268caec5cc9ff52371438badedd0737.1614884673.git.luto@kernel.org>
 <20210308100602.GC7951@C02TD0UTHF1T.local>
In-Reply-To: <20210308100602.GC7951@C02TD0UTHF1T.local>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 13 Mar 2021 17:18:39 -0800
X-Gmail-Original-Message-ID: <CALCETrUyQ1YYsODzJVc1=Rv-EZW0OSuedd2rXNY-MUdA10aOLg@mail.gmail.com>
Message-ID: <CALCETrUyQ1YYsODzJVc1=Rv-EZW0OSuedd2rXNY-MUdA10aOLg@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] kentry: Make entry/exit_to_user_mode() arm64-only
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 8, 2021 at 2:06 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Thu, Mar 04, 2021 at 11:06:00AM -0800, Andy Lutomirski wrote:
> > exit_to_user_mode() does part, but not all, of the exit-to-user-mode work.
> > It's used only by arm64, and arm64 should stop using it (hint, hint!).
> > Compile it out on other architectures to minimize the chance of error.
>
> For context, I do plan to move over, but there's a reasonable amount of
> preparatory work needed first (e.g. factoring out the remaining asm
> entry points, and reworking our pseudo-NMI management to play nicely
> with the common entry code).
>
> > enter_from_user_mode() is a legacy way to spell
> > kentry_enter_from_user_mode().  It's also only used by arm64.  Give it
> > the same treatment.
>
> I think you can remove these entirely, no ifdeferry necessary.
>
> Currently arm64 cannot select CONFIG_GENERIC_ENTRY, so we open-code
> copies of these in arch/arm64/kernel/entry-common.c, and doesn't use
> these common versions at all. When we move over to the common code we
> can move directly to the kentry_* versions. If we are relying on the
> prototypes anywhere, that's a bug as of itself.

I got faked out!  Fixed for the next version.
