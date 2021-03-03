Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2AE32C403
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbhCDAKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:10:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:55028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1447101AbhCCWnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 17:43:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6EDB64EE8;
        Wed,  3 Mar 2021 22:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614810635;
        bh=VPQwx3sor/TCgX60CVSoExl3xENFzxKbvl1j0xJpfmE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZTEgqxAng43aFtKbvdt/CgzdHu0Lm1LFqOJ+kb1vD/Lff3ndhhwO+u1Q4AuUaf8Q9
         BrqgFphdwF227povSJdR0ppsDgvUK/9TbqNxIB1iL5DstvQkR3T0SXKQaQvMh9pbj+
         pqmAbD6tScgGo1I0gX+Tz7f+jKHKku+3khlmrh5+U0wh7/F2J3OL1A3faVYHn5UgSR
         3hYlTuOgLuDIFm6ehKkXfXSkTF7FqwH/LMRY5bH9uf4UhtvfCTcfHSqdscMHZjIqhR
         4j0o3K5rb1f94eUMCdB3ofXbQsfmm1CwcaILthZlYCCquR1WwDJz/giE/uk079t2ol
         kMWf7sSROk7Cw==
Received: by mail-ed1-f49.google.com with SMTP id t1so2247278eds.7;
        Wed, 03 Mar 2021 14:30:34 -0800 (PST)
X-Gm-Message-State: AOAM531Zbtjb02Pa6JD/YgUO+N8Pp92bQDoZenZBZXr0xsw2xcnAJmCK
        hYSnVrwuO+qHPwXtFU/cHwlWMuf1gnKHWyLhBQ==
X-Google-Smtp-Source: ABdhPJzdnSQHtIkFoRAA6tp17ByRcvWRAvqK05hvaWnLVKg/QVIOX7pSYUMfZdhov5dDhCK5CjeVVCc8G3PTDeTKA8I=
X-Received: by 2002:a05:6402:c0f:: with SMTP id co15mr1253926edb.373.1614810633488;
 Wed, 03 Mar 2021 14:30:33 -0800 (PST)
MIME-Version: 1.0
References: <20210303134927.18975-1-will@kernel.org> <20210303134927.18975-2-will@kernel.org>
In-Reply-To: <20210303134927.18975-2-will@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 3 Mar 2021 16:30:21 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLengGX9S0fMUWPR=q6Ng5=JmJXENNqi8Jamv+w0E58bg@mail.gmail.com>
Message-ID: <CAL_JsqLengGX9S0fMUWPR=q6Ng5=JmJXENNqi8Jamv+w0E58bg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: cpufeatures: Fix handling of CONFIG_CMDLINE
 for idreg overrides
To:     Will Deacon <will@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Max Uvarov <muvarov@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Android Kernel Team <kernel-team@android.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 7:50 AM Will Deacon <will@kernel.org> wrote:
>
> The built-in kernel commandline (CONFIG_CMDLINE) can be configured in
> three different ways:
>
>   1. CMDLINE_FORCE: Use CONFIG_CMDLINE instead of any bootloader args
>   2. CMDLINE_EXTEND: Append the bootloader args to CONFIG_CMDLINE
>   3. CMDLINE_FROM_BOOTLOADER: Only use CONFIG_CMDLINE if there aren't
>      any bootloader args.
>
> The early cmdline parsing to detect idreg overrides gets (2) and (3)
> slightly wrong: in the case of (2) the bootloader args are parsed first
> and in the case of (3) the CMDLINE is always parsed.
>
> Fix these issues by moving the bootargs parsing out into a helper
> function and following the same logic as that used by the EFI stub.
>
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> Fixes: 33200303553d ("arm64: cpufeature: Add an early command-line cpufeature override facility")
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/kernel/idreg-override.c | 44 +++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 19 deletions(-)

It bothers me a bit having command line handling here. It means how
the command line is assembled in 2 places. I guess if we get rid of
ambiguous 'extend' then it's better, but perhaps a better
implementation would be an api get a specific command line parameter.
The main downside would be searching the DT again for each parameter
if we can't store any data in between calls, but there's ways around
that. PowerPC also needs similar functionality in
disabled_on_cmdline().

Anyways, that's all beyond the scope of this.

Rob
