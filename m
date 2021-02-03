Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D8330D9AD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbhBCMUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbhBCMUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:20:19 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FE9C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 04:19:38 -0800 (PST)
Received: from zn.tnic (p200300ec2f0c84005017455b058bf408.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:8400:5017:455b:58b:f408])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 35AC91EC047F;
        Wed,  3 Feb 2021 13:19:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1612354777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nj2ilHOLZKWctzV9AdEGYD+lgbpOZAlL7qxf96POKHE=;
        b=Hnv7ulWZLBwNx1QGEuQob+JDDNev4A5bkqRQKtXOYq+sXalhniywh/YQdkj8x1KFaFpc7K
        +h7I18QVnXdFFeDlDpEau431GbsmCkfVdqspNWZDWOgPCSxhSr9EgjJf40uRUNmJnC+XTu
        e+aacKqKwDtnhweC0AHbqKf4I9d23Yk=
Date:   Wed, 3 Feb 2021 13:19:34 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     John Millikin <jmillikin@gmail.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        John Millikin <john@john-millikin.com>
Subject: Re: [PATCH v2] arch/x86: Propagate $(CLANG_FLAGS) to
 $(REALMODE_FLAGS)
Message-ID: <20210203121934.GC13819@zn.tnic>
References: <cceb074c-861c-d716-5e19-834a8492f245@gmail.com>
 <37DE7046-5096-4C0C-A96D-FD168A849DFD@zytor.com>
 <20201226075347.GA1977841@ubuntu-m3-large-x86>
 <3b793c42-8983-4502-1f9e-729cc0ebec47@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b793c42-8983-4502-1f9e-729cc0ebec47@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 26, 2020 at 05:41:25PM +0900, John Millikin wrote:
> When cross-compiling with Clang, the `$(CLANG_FLAGS)' variable
> contains additional flags needed to build C and assembly sources
> for the target platform. Normally this variable is automatically
> included in `$(KBUILD_CFLAGS)' by via the top-level Makefile.
> 
> The x86 real-mode makefile builds `$(REALMODE_CFLAGS)' from a
> plain assignment and therefore drops the Clang flags. This causes
> Clang to not recognize x86-specific assembler directives:
> 
>   arch/x86/realmode/rm/header.S:36:1: error: unknown directive
>   .type real_mode_header STT_OBJECT ; .size real_mode_header, .-real_mode_header
>   ^
> 
> Explicit propagation of `$(CLANG_FLAGS)' to `$(REALMODE_CFLAGS)',
> which is inherited by real-mode make rules, fixes cross-compilation
> with Clang for x86 targets.
> 
> Relevant flags:
> 
> * `--target' sets the target architecture when cross-compiling. This
>   flag must be set for both compilation and assembly (`KBUILD_AFLAGS')
>   to support architecture-specific assembler directives.
> 
> * `-no-integrated-as' tells clang to assemble with GNU Assembler
>   instead of its built-in LLVM assembler. This flag is set by default
>   unless `LLVM_IAS=1' is set, because the LLVM assembler can't yet
>   parse certain GNU extensions.
> 
> Signed-off-by: John Millikin <john@john-millikin.com>
> ---
> Changes in v2:
>   - Reworded the commit message to highlight that this is for
>     cross-compilation.
>   - Removed the `ifdef CONFIG_CC_IS_CLANG' guard.
> 
>  arch/x86/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 7116da3980be..412b849063ec 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -33,6 +33,7 @@ REALMODE_CFLAGS += -ffreestanding
>  REALMODE_CFLAGS += -fno-stack-protector

This one too:

checking file arch/x86/Makefile
patch: **** malformed patch at line 62:  REALMODE_CFLAGS += -fno-stack-protector

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
