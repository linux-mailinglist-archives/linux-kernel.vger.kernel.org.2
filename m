Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A222234B3AB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 03:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhC0CCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 22:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhC0CCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 22:02:23 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12D2C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 19:02:22 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id p12so1132493pgj.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 19:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gt3rGVbt95xHgiVZfuo2ZHvuR0GdcJNVGwvzFLdbOmw=;
        b=hXPVNoF8Qa7JlwXjxr68EEkYM3KAND26C94dvTsg/PsVS8BjsEL0BMASYn2Pi17n9n
         /cl0X6unqYYkRYzkTnFp1oK9ou/GGvr4C4hLVvYwMeHgsZGv802MuaXTNBugpcLqcZRU
         g6nV7KR9+v7v7JPkqHLXDfa06eBctIlNi+WNaOHnm+cpLu6RHqvenC29xJStjs7o8ZWx
         6CVC1VxTF1HA3v4CXeMsYwn5rDrVRe7B12la0st/cn0ODkGXQTbdpRFwIo0npFXTuiW8
         NgiN3ELfc43GrmHoWgEU+A6+McU9ygStAYKZw+FXiGaMiM6jymrqzEm2bNRWwo6Us1mn
         BYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gt3rGVbt95xHgiVZfuo2ZHvuR0GdcJNVGwvzFLdbOmw=;
        b=aj9XjMVvsT3HbXFd2GKzd2bGXvO51KBV6T/Yvv3aU1UFlf4bj3VhG3BpcBuvMRXzCB
         Q+HJDccKRoZWk3DArSSp4hhq405UIcvhI2YFKb68ExO7TtJnLCzxbiyb/NzJQaFz+eaa
         TLJdc9RLq1JfW9ygcsZRGzEcpOd2Imsu0AZ4kF1GNGZfvrb+nBCI7TQhjWI8TWxVl6qt
         +1lBtdwp+QP1AVawIgNtcMFaZa5gsy0X9fK7JpPIEvfWm9w7PRuDIPHKqpzaEFIQK8yN
         luwdK4E5Pq6Rg1GC7X4yiCbWq6VIA2gcYaV6bYOyViBMKFfo6c1o5Ro3nLxdW46+LpPP
         /vzA==
X-Gm-Message-State: AOAM532zEy1G/e1ilGBN/23MUwPmVBSvq+F/NOOcPxRwEG3gxbUNgUat
        YPFm8yfBEVvya2hog7zixsZLig==
X-Google-Smtp-Source: ABdhPJyiBjE/yzEeI4dBbEosD2V3cGtPPLV8m1JGUTPk5x8VPYoZgrPu/I4UfwZbh1AB98/uI7oAHg==
X-Received: by 2002:a65:6a45:: with SMTP id o5mr14575953pgu.89.1616810541856;
        Fri, 26 Mar 2021 19:02:21 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:5dbf:19de:725b:1861])
        by smtp.gmail.com with ESMTPSA id i1sm9550651pfo.160.2021.03.26.19.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 19:02:21 -0700 (PDT)
Date:   Fri, 26 Mar 2021 19:02:16 -0700
From:   Fangrui Song <maskray@google.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] riscv: Use $(LD) instead of $(CC) to link vDSO
Message-ID: <20210327020216.63ayp7uul3ymhlor@google.com>
References: <20210325215156.1986901-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210325215156.1986901-1-nathan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021-03-25, Nathan Chancellor wrote:
>Currently, the VDSO is being linked through $(CC). This does not match
>how the rest of the kernel links objects, which is through the $(LD)
>variable.
>
>When linking with clang, there are a couple of warnings about flags that
>will not be used during the link:
>
>clang-12: warning: argument unused during compilation: '-no-pie' [-Wunused-command-line-argument]
>clang-12: warning: argument unused during compilation: '-pg' [-Wunused-command-line-argument]
>
>'-no-pie' was added in commit 85602bea297f ("RISC-V: build vdso-dummy.o
>with -no-pie") to override '-pie' getting added to the ld command from
>distribution versions of GCC that enable PIE by default. It is
>technically no longer needed after commit c2c81bb2f691 ("RISC-V: Fix the
>VDSO symbol generaton for binutils-2.35+"), which removed vdso-dummy.o
>in favor of generating vdso-syms.S from vdso.so with $(NM) but this also
>resolves the issue in case it ever comes back due to having full control
>over the $(LD) command. '-pg' is for function tracing, it is not used
>during linking as clang states.

Looks good.

-pg affects the link action: it changes crt1.o to gcrt1.o.
Since the Makefile uses -nostdlib, crt1.o is suppressed, so -pg
is entirely unneeded.
(-nostdlib implies -nostartfiles so the previous usage has a redundant
option.)

>These flags could be removed/filtered to fix the warnings but it is
>easier to just match the rest of the kernel and use $(LD) directly for
>linking. See commits
>
>  fe00e50b2db8 ("ARM: 8858/1: vdso: use $(LD) instead of $(CC) to link VDSO")
>  691efbedc60d ("arm64: vdso: use $(LD) instead of $(CC) to link VDSO")
>  2ff906994b6c ("MIPS: VDSO: Use $(LD) instead of $(CC) to link VDSO")
>  2b2a25845d53 ("s390/vdso: Use $(LD) instead of $(CC) to link vDSO")
>
>for more information.
>
>The flags are converted to linker flags and '--eh-frame-hdr' is added to
>match what is added by GCC implicitly, which can be seen by adding '-v'
>to GCC's invocation.

Another minor change which may be shipped together: --hash-style=both
can be --hash-style=gnu. We don't need sysv .hash . The glibc/musl
support for .gnu.hash has been there for years. .gnu.hash is often
smaller than .hash .

Reviewed-by: Fangrui Song <maskray@google.com>

>Additionally, since this area is being modified, use the $(OBJCOPY)
>variable instead of an open coded $(CROSS_COMPILE)objcopy so that the
>user's choice of objcopy binary is respected.
>
>Link: https://github.com/ClangBuiltLinux/linux/issues/803
>Link: https://github.com/ClangBuiltLinux/linux/issues/970
>Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>---
> arch/riscv/kernel/vdso/Makefile | 12 ++++--------
> 1 file changed, 4 insertions(+), 8 deletions(-)
>
>diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
>index 71a315e73cbe..ca2b40dfd24b 100644
>--- a/arch/riscv/kernel/vdso/Makefile
>+++ b/arch/riscv/kernel/vdso/Makefile
>@@ -41,11 +41,10 @@ KASAN_SANITIZE := n
> $(obj)/vdso.o: $(obj)/vdso.so
>
> # link rule for the .so file, .lds has to be first
>-SYSCFLAGS_vdso.so.dbg = $(c_flags)
> $(obj)/vdso.so.dbg: $(src)/vdso.lds $(obj-vdso) FORCE
> 	$(call if_changed,vdsold)
>-SYSCFLAGS_vdso.so.dbg = -shared -s -Wl,-soname=linux-vdso.so.1 \
>-	-Wl,--build-id=sha1 -Wl,--hash-style=both
>+LDFLAGS_vdso.so.dbg = -shared -s -soname=linux-vdso.so.1 \
>+	--build-id=sha1 --hash-style=both --eh-frame-hdr
>
> # We also create a special relocatable object that should mirror the symbol
> # table and layout of the linked DSO. With ld --just-symbols we can then
>@@ -60,13 +59,10 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
>
> # actual build commands
> # The DSO images are built using a special linker script
>-# Add -lgcc so rv32 gets static muldi3 and lshrdi3 definitions.
> # Make sure only to export the intended __vdso_xxx symbol offsets.
> quiet_cmd_vdsold = VDSOLD  $@
>-      cmd_vdsold = $(CC) $(KBUILD_CFLAGS) $(call cc-option, -no-pie) -nostdlib -nostartfiles $(SYSCFLAGS_$(@F)) \
>-                           -Wl,-T,$(filter-out FORCE,$^) -o $@.tmp && \
>-                   $(CROSS_COMPILE)objcopy \
>-                           $(patsubst %, -G __vdso_%, $(vdso-syms)) $@.tmp $@ && \
>+      cmd_vdsold = $(LD) $(ld_flags) -T $(filter-out FORCE,$^) -o $@.tmp && \
>+                   $(OBJCOPY) $(patsubst %, -G __vdso_%, $(vdso-syms)) $@.tmp $@ && \
>                    rm $@.tmp
>
> # Extracts symbol offsets from the VDSO, converting them into an assembly file
>-- 
>2.31.0
>
>-- 
>You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
>To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
>To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20210325215156.1986901-1-nathan%40kernel.org.
