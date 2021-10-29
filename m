Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9C643FC7A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 14:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbhJ2MrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 08:47:01 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53652 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbhJ2MrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 08:47:00 -0400
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id D4CF31F458B9;
        Fri, 29 Oct 2021 13:44:30 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] samples: fanotify: add CC_CAN_LINK dependency
Organization: Collabora
References: <20211029113403.848239-1-arnd@kernel.org>
Date:   Fri, 29 Oct 2021 09:44:25 -0300
In-Reply-To: <20211029113403.848239-1-arnd@kernel.org> (Arnd Bergmann's
        message of "Fri, 29 Oct 2021 13:33:35 +0200")
Message-ID: <87tuh09f12.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> When using a cross tools that only works for kernels, the
> newn sample can end up with a link failure such as:
>
> /usr/bin/ld: unrecognised emulation mode: aarch64linux
> Supported emulations: elf_x86_64 elf32_x86_64 elf_i386 elf_iamcu elf_l1om elf_k1om i386pep i386pe
> clang: error: linker command failed with exit code 1 (use -v to see invocation)
> make[5]: *** [/git/arm-soc/scripts/Makefile.userprogs:28: samples/fanotify/fs-monitor] Error 1
>
> Add a Kconfig dependency, similar to the one we use for
> other samples.
>
> Fixes: 5451093081db ("samples: Add fs error monitoring example")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


Hi Arnd,

This was reported by Guenter Roeck yesterday, I sent a patch for it
here:

https://lore.kernel.org/linux-fsdevel/87fsslasgz.fsf@collabora.com/


> ---
>  samples/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/samples/Kconfig b/samples/Kconfig
> index 147a16dafaf8..83f12c1e9ca6 100644
> --- a/samples/Kconfig
> +++ b/samples/Kconfig
> @@ -122,7 +122,7 @@ config SAMPLE_CONNECTOR
>  
>  config SAMPLE_FANOTIFY_ERROR
>  	bool "Build fanotify error monitoring sample"
> -	depends on FANOTIFY
> +	depends on CC_CAN_LINK && FANOTIFY
>  	help
>  	  When enabled, this builds an example code that uses the
>  	  FAN_FS_ERROR fanotify mechanism to monitor filesystem

-- 
Gabriel Krisman Bertazi
