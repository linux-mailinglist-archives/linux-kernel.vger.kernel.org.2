Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72BF7332599
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 13:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhCIMkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 07:40:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:37172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhCIMjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 07:39:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0F5165274
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 12:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615293588;
        bh=pwMguO9Q1vd5NbKDPpSQnYbWyabGZ1kPQE2NN5ezZGQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WeKxuO6yVrmWja4085fcv0wYsLWN6sDohVC3sZEvDxsNsbjH/taYp2JWxiRnaJRff
         +/zEfm8J47P2WmJN6+YBo9fV4vQVGXS8xe6+aszk/m6v7nK7bKKCv5EdxQuBV2X1HO
         GJfcz7SU8+uKNmj4lbGJwVZMLms4+YTjCeo+UyxKJX/2GQM9EmNxkTd31G9b1Dpi0W
         gkSDvN6qLSmhD+oDHBbmVS1kxHvHNtWIb5N+MVVhKQlkAoWFQ8hXJap8/YkK3qfwBS
         Zrfr6GJE1ESjVjGFtCYfxzLjIvmHrP28Xyu22Ar8SbCfxV3q2jbUVEsoiZFxgdrF/T
         EW0mS8l+e/P5g==
Received: by mail-oi1-f180.google.com with SMTP id z126so14743736oiz.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 04:39:47 -0800 (PST)
X-Gm-Message-State: AOAM533Awqg10Qojy9cbODxvnPF4nihqxiQOjKhKsVUcM+mlN1xmEHg0
        SPdM4o+GGXxvPrWdbevK3KxW4lInwzK17zUM/UM=
X-Google-Smtp-Source: ABdhPJyMOElJotc+ybmUr9uW1bQxFpuMOrYGhV+eh1ttdw9hq91bQxmDGkKQsgSDU8aBdYCTfJZisbpilekU65evJAM=
X-Received: by 2002:aca:538c:: with SMTP id h134mr2802823oib.174.1615293587253;
 Tue, 09 Mar 2021 04:39:47 -0800 (PST)
MIME-Version: 1.0
References: <20210309123544.14040-1-msuchanek@suse.de>
In-Reply-To: <20210309123544.14040-1-msuchanek@suse.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 9 Mar 2021 13:39:36 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGkWj09Jm8VnEJKG3rWXZkJNZR5ROYqs87akKkdM14Hwg@mail.gmail.com>
Message-ID: <CAMj1kXGkWj09Jm8VnEJKG3rWXZkJNZR5ROYqs87akKkdM14Hwg@mail.gmail.com>
Subject: Re: [PATCH] arm64: make STACKPROTECTOR_PER_TASK configurable.
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Mar 2021 at 13:37, Michal Suchanek <msuchanek@suse.de> wrote:
>
> When using dummy-tools STACKPROTECTOR_PER_TASK is unconditionally
> selected. This defeats the purpose of the all-enabled tool.
>

What is dummy-tools and why should we care about it?

> Description copied from arm
>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  arch/arm64/Kconfig | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index a8ff7cd5f096..f59d391e31a4 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1549,9 +1549,20 @@ config RANDOMIZE_MODULE_REGION_FULL
>  config CC_HAVE_STACKPROTECTOR_SYSREG
>         def_bool $(cc-option,-mstack-protector-guard=sysreg -mstack-protector-guard-reg=sp_el0 -mstack-protector-guard-offset=0)
>
> +
>  config STACKPROTECTOR_PER_TASK
> -       def_bool y
> +       bool "Use a unique stack canary value for each task"
>         depends on STACKPROTECTOR && CC_HAVE_STACKPROTECTOR_SYSREG
> +       default y
> +       help
> +         Due to the fact that GCC uses an ordinary symbol reference from
> +         which to load the value of the stack canary, this value can only
> +         change at reboot time on SMP systems, and all tasks running in the
> +         kernel's address space are forced to use the same canary value for
> +         the entire duration that the system is up.
> +
> +         Enable this option to switch to a different method that uses a
> +         different canary value for each task.
>
>  endmenu
>
> --
> 2.26.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
