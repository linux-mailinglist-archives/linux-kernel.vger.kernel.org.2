Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5AC3256E4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 20:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbhBYTlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 14:41:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:43604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234385AbhBYTg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 14:36:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E15564EFA;
        Thu, 25 Feb 2021 19:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614281306;
        bh=NZsprQViWQsRTIswNmPSZs71LANb6NMOEfznvTt3hWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mlPvP0JbMs2L2x5vcRnitTBn8naWUTxUNoSRg+qVPGjlWAiuooPCJ4Ndk9LJxdn37
         rpDER4FEIVRNTyXGZ2qbFrtlYR0Gcw90vEiKnsanStm/FhWaaL4bcyiUpnnAK8Psh5
         DNzVeuMFTFvnZdWfeO+zbJEXc0mqN7v8VS5eaPyweVi+ut1wzX5X/0/qpThjkV+EHR
         1TYpercF8KE3gat6DfD3V+H3dDXtxuqB4dC2DEE5J0NpbgWVoGtyErFQPwI2BUJKsI
         B2S/DQR0yjO/HanFFHWYCWxFf1yIKLV0+mpKDvhUNFtfBraW2Rj3HqrceergzytBLU
         MbrEq3fc0Ifkw==
Date:   Thu, 25 Feb 2021 12:28:21 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        kernel test robot <lkp@intel.com>,
        Fangrui Song <maskray@google.com>
Subject: Re: [PATCH v3] vmlinux.lds.h: Define SANTIZER_DISCARDS with
 CONFIG_GCOV_KERNEL=y
Message-ID: <20210225192821.GA1975@MSI.localdomain>
References: <20210130002557.2681512-1-nathan@kernel.org>
 <20210130004650.2682422-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210130004650.2682422-1-nathan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 05:46:51PM -0700, Nathan Chancellor wrote:
> clang produces .eh_frame sections when CONFIG_GCOV_KERNEL is enabled,
> even when -fno-asynchronous-unwind-tables is in KBUILD_CFLAGS:
> 
> $ make CC=clang vmlinux
> ...
> ld: warning: orphan section `.eh_frame' from `init/main.o' being placed in section `.eh_frame'
> ld: warning: orphan section `.eh_frame' from `init/version.o' being placed in section `.eh_frame'
> ld: warning: orphan section `.eh_frame' from `init/do_mounts.o' being placed in section `.eh_frame'
> ld: warning: orphan section `.eh_frame' from `init/do_mounts_initrd.o' being placed in section `.eh_frame'
> ld: warning: orphan section `.eh_frame' from `init/initramfs.o' being placed in section `.eh_frame'
> ld: warning: orphan section `.eh_frame' from `init/calibrate.o' being placed in section `.eh_frame'
> ld: warning: orphan section `.eh_frame' from `init/init_task.o' being placed in section `.eh_frame'
> ...
> 
> $ rg "GCOV_KERNEL|GCOV_PROFILE_ALL" .config
> CONFIG_GCOV_KERNEL=y
> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
> CONFIG_GCOV_PROFILE_ALL=y
> 
> This was already handled for a couple of other options in
> commit d812db78288d ("vmlinux.lds.h: Avoid KASAN and KCSAN's unwanted
> sections") and there is an open LLVM bug for this issue. Take advantage
> of that section for this config as well so that there are no more orphan
> warnings.
> 
> Link: https://bugs.llvm.org/show_bug.cgi?id=46478
> Link: https://github.com/ClangBuiltLinux/linux/issues/1069
> Reported-by: kernel test robot <lkp@intel.com>
> Reviewed-by: Fangrui Song <maskray@google.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> 
> v2 -> v3:
> 
> * Fix double "unwanted" in comment section per Sedat.
> 
> v1 -> v2:
> 
> * Keep configs and flag names alphabetized.
> 
> * Drop mention of -ftest-coverage since it does not cause this issue per
>   Fangrui.
> 
> * Pick up review tags from Fangrui and Nick.
> 
>  include/asm-generic/vmlinux.lds.h | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index b2b3d81b1535..b61b537177fb 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -988,12 +988,13 @@
>  #endif
>  
>  /*
> - * Clang's -fsanitize=kernel-address and -fsanitize=thread produce
> - * unwanted sections (.eh_frame and .init_array.*), but
> - * CONFIG_CONSTRUCTORS wants to keep any .init_array.* sections.
> + * Clang's -fprofile-arcs, -fsanitize=kernel-address, and
> + * -fsanitize=thread produce unwanted sections (.eh_frame
> + * and .init_array.*), but CONFIG_CONSTRUCTORS wants to
> + * keep any .init_array.* sections.
>   * https://bugs.llvm.org/show_bug.cgi?id=46478
>   */
> -#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KCSAN)
> +#if defined(CONFIG_GCOV_KERNEL) || defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KCSAN)
>  # ifdef CONFIG_CONSTRUCTORS
>  #  define SANITIZER_DISCARDS						\
>  	*(.eh_frame)
> 
> base-commit: bec4c2968fce2f44ce62d05288a633cd99a722eb
> -- 
> 2.30.0
> 

Andrew, Arnd, or Kees:

Would one of you be able to pick this up and get it to Linus? I think
the 0day bot just tripped over this again:

https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/message/BXBY7OPVMOCCUZSCFEZXI7RG65RJWJ52/
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/message/QF62LWM6YSNWWNOM7AXYK4734AKH2SVT/

Cheers,
Nathan
