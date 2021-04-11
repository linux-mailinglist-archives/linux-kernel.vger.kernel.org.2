Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCC235B6FD
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 23:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbhDKVUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 17:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbhDKVUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 17:20:31 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A40C061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 14:20:14 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id p12so7806477pgj.10
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 14:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=7HORmDFkFV0uVOag+MJUkAhWb7+U98LNc9qMttc1Fk0=;
        b=rmvtpQ0BoMCl/PBNwx40Ear9D5vhEadV06ELIt/174+qAbgUiRR/mYCIq1sDtNOdl4
         aCgodxSgZmUzRekhsnxl/yNM7AyEKR4Mt1CIwL/dIc8NYGpvxawrJ+GUIZojdcRD+imf
         bNmj/W9E4QD6aO38agd6qUYhrY9CPhVzReE/zFusPUin7jsKrQEQHC1xXMV945MfNRrv
         Nmg+i4jBwMvyH2bm/6Muuu3A2bgRSmUYhjG833I32smDqpAghaFmrnwDpHTt5jphOAi5
         FDC1l1RuMCTfQ+3KInIANQjEmZRae0SzVlEI/9C4kPael8l8BMIOvu47pZVXFewXwQgN
         ihFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=7HORmDFkFV0uVOag+MJUkAhWb7+U98LNc9qMttc1Fk0=;
        b=Y3gP/rIYeVzG5Dc0ZZPN2zqIrP4KJ5mCcgcOzmQjgkWwCMWwHRWuemi7p28BWsQie9
         JyzO4GZaMAx3A0lgPkrcxkirO6S+YmHnbMcRRAZqyZDwaL95ad/BwK9Q2Oys1xvOXPiO
         FzkxIzgzGwPFI6wpuEn4Lg0zOeOo4PNlQa227jMR9QCWzocjBv+wOaZdAWJtC+BavORF
         LPCL60MdCAQniEOyUHLguFWu4hXmoxrca4ti1wO4BY543lILC2FrBcRDHFQoHJ4NIBS3
         H7OapuQW+XNVEi5kvQWrZEutQ/3hWKjGutaNwAzRMH+hndlMHGB4Y4w0bTzIiOoqamTO
         h4EA==
X-Gm-Message-State: AOAM5335joDK/DsYsLeMhgE+LvbYac/K8RowDBRdG8s81VEjisDKd2NU
        NpU5G1r4/y3wcmGaBrrTrCsYIA==
X-Google-Smtp-Source: ABdhPJxZxPao1Kce4ZovCQiCxycS+kWi8jZjrAHWK87MN5OrHWXptmi4arfUWylnGV6V0DVSqNltMg==
X-Received: by 2002:a65:640d:: with SMTP id a13mr23133579pgv.272.1618176013615;
        Sun, 11 Apr 2021 14:20:13 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id a20sm6661204pfn.23.2021.04.11.14.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 14:20:13 -0700 (PDT)
Date:   Sun, 11 Apr 2021 14:20:13 -0700 (PDT)
X-Google-Original-Date: Sun, 11 Apr 2021 14:20:05 PDT (-0700)
Subject:     Re: [PATCH] riscv: Use $(LD) instead of $(CC) to link vDSO
In-Reply-To: <20210325215156.1986901-1-nathan@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, nathan@kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     nathan@kernel.org
Message-ID: <mhng-8efacd63-c6b5-469b-9c64-2b8092f0d3e3@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2021 14:51:56 PDT (-0700), nathan@kernel.org wrote:
> Currently, the VDSO is being linked through $(CC). This does not match
> how the rest of the kernel links objects, which is through the $(LD)
> variable.
>
> When linking with clang, there are a couple of warnings about flags that
> will not be used during the link:
>
> clang-12: warning: argument unused during compilation: '-no-pie' [-Wunused-command-line-argument]
> clang-12: warning: argument unused during compilation: '-pg' [-Wunused-command-line-argument]
>
> '-no-pie' was added in commit 85602bea297f ("RISC-V: build vdso-dummy.o
> with -no-pie") to override '-pie' getting added to the ld command from
> distribution versions of GCC that enable PIE by default. It is
> technically no longer needed after commit c2c81bb2f691 ("RISC-V: Fix the
> VDSO symbol generaton for binutils-2.35+"), which removed vdso-dummy.o
> in favor of generating vdso-syms.S from vdso.so with $(NM) but this also
> resolves the issue in case it ever comes back due to having full control
> over the $(LD) command. '-pg' is for function tracing, it is not used
> during linking as clang states.
>
> These flags could be removed/filtered to fix the warnings but it is
> easier to just match the rest of the kernel and use $(LD) directly for
> linking. See commits
>
>   fe00e50b2db8 ("ARM: 8858/1: vdso: use $(LD) instead of $(CC) to link VDSO")
>   691efbedc60d ("arm64: vdso: use $(LD) instead of $(CC) to link VDSO")
>   2ff906994b6c ("MIPS: VDSO: Use $(LD) instead of $(CC) to link VDSO")
>   2b2a25845d53 ("s390/vdso: Use $(LD) instead of $(CC) to link vDSO")
>
> for more information.
>
> The flags are converted to linker flags and '--eh-frame-hdr' is added to
> match what is added by GCC implicitly, which can be seen by adding '-v'
> to GCC's invocation.
>
> Additionally, since this area is being modified, use the $(OBJCOPY)
> variable instead of an open coded $(CROSS_COMPILE)objcopy so that the
> user's choice of objcopy binary is respected.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/803
> Link: https://github.com/ClangBuiltLinux/linux/issues/970
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/riscv/kernel/vdso/Makefile | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
> index 71a315e73cbe..ca2b40dfd24b 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -41,11 +41,10 @@ KASAN_SANITIZE := n
>  $(obj)/vdso.o: $(obj)/vdso.so
>
>  # link rule for the .so file, .lds has to be first
> -SYSCFLAGS_vdso.so.dbg = $(c_flags)
>  $(obj)/vdso.so.dbg: $(src)/vdso.lds $(obj-vdso) FORCE
>  	$(call if_changed,vdsold)
> -SYSCFLAGS_vdso.so.dbg = -shared -s -Wl,-soname=linux-vdso.so.1 \
> -	-Wl,--build-id=sha1 -Wl,--hash-style=both
> +LDFLAGS_vdso.so.dbg = -shared -s -soname=linux-vdso.so.1 \
> +	--build-id=sha1 --hash-style=both --eh-frame-hdr
>
>  # We also create a special relocatable object that should mirror the symbol
>  # table and layout of the linked DSO. With ld --just-symbols we can then
> @@ -60,13 +59,10 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
>
>  # actual build commands
>  # The DSO images are built using a special linker script
> -# Add -lgcc so rv32 gets static muldi3 and lshrdi3 definitions.
>  # Make sure only to export the intended __vdso_xxx symbol offsets.
>  quiet_cmd_vdsold = VDSOLD  $@
> -      cmd_vdsold = $(CC) $(KBUILD_CFLAGS) $(call cc-option, -no-pie) -nostdlib -nostartfiles $(SYSCFLAGS_$(@F)) \
> -                           -Wl,-T,$(filter-out FORCE,$^) -o $@.tmp && \
> -                   $(CROSS_COMPILE)objcopy \
> -                           $(patsubst %, -G __vdso_%, $(vdso-syms)) $@.tmp $@ && \
> +      cmd_vdsold = $(LD) $(ld_flags) -T $(filter-out FORCE,$^) -o $@.tmp && \
> +                   $(OBJCOPY) $(patsubst %, -G __vdso_%, $(vdso-syms)) $@.tmp $@ && \
>                     rm $@.tmp
>
>  # Extracts symbol offsets from the VDSO, converting them into an assembly file

Thanks, this is on for-next.
