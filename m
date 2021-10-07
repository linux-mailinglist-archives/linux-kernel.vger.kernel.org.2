Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEA8424E7C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 10:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240506AbhJGIEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 04:04:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233511AbhJGIEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 04:04:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6DD4C61053;
        Thu,  7 Oct 2021 08:02:05 +0000 (UTC)
Date:   Thu, 7 Oct 2021 09:02:02 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] elfcore: correct reference to CONFIG_UML
Message-ID: <YV6pejGzLy5ppEpt@arm.com>
References: <20211006082209.417-1-lukas.bulwahn@gmail.com>
 <CAKwvOd=X-ZFPraS2EL24ps1aKdT3bWhtASA0vUjXdzo655XGiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=X-ZFPraS2EL24ps1aKdT3bWhtASA0vUjXdzo655XGiQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 6, 2021 at 1:22 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> Commit 6e7b64b9dd6d ("elfcore: fix building with clang") introduces
> special handling for two architectures, ia64 and User Mode Linux.
> However, the wrong name, i.e., CONFIG_UM, for the intended Kconfig symbol
> for User-Mode Linux was used.
>
> Although the directory for User Mode Linux is ./arch/um; the Kconfig
> symbol for this architecture is called CONFIG_UML.
>
> Luckily, ./scripts/checkkconfigsymbols.py warns on non-existing configs:
>
> UM
> Referencing files: include/linux/elfcore.h
> Similar symbols: UML, NUMA
>
> Correct the name of the config to the intended one.
>
> Fixes: 6e7b64b9dd6d ("elfcore: fix building with clang")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> applies cleanly on next-20211005
>
> Arnd, please ack.
> Andrew, please pick this fix.
>
>  include/linux/elfcore.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/elfcore.h b/include/linux/elfcore.h
> index 2aaa15779d50..127716b58235 100644
> --- a/include/linux/elfcore.h
> +++ b/include/linux/elfcore.h
> @@ -109,7 +109,7 @@ static inline int elf_core_copy_task_fpregs(struct task_struct *t, struct pt_reg
>  #endif
>  }
>
> -#if defined(CONFIG_UM) || defined(CONFIG_IA64)
> +#if defined(CONFIG_UML) || defined(CONFIG_IA64)

This fails to build with 'make ARCH=um SUBARCH=x86_64' since
arch/x86/um/elfcore.c is only compiled for x86_32. You'd need another
check on CONFIG_X86_32 (as per my patch ;)).

Thanks.

-- 
Catalin
