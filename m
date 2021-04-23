Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53F1368B5B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 05:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236847AbhDWDBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 23:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhDWDA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 23:00:57 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A75EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 20:00:20 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id d10so34231951pgf.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 20:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Yuz8rImO9QvcmswnwQEKGjBpNkKgF5UoZuyapY7pMSc=;
        b=b3AHnJGemTwQxl90/kbu1StYrivLmy7YgLjPLYqYUyHyNE9mXeoisIEmEQdWQ5ndfA
         mpiNkHtTPv5jvWfiUf3UlRD8T4AiixsVkCCizRSoco4HQimffuJvQ4wB7OsFna9iM352
         AclMWn7I2lveN5gZqs9d3SoS9g3YHyUrskDv2nQOjWEbpCzl7F7jo/3KvoQZOExZU1Qw
         rYTUE9yfIBLHKJ1JjwUh4KQMyu0DAAJJ0wybvIJGDjYyIgHDE0FvbNufxpkomxQUYZp0
         UJrm2hR+b6Mst+lzsncgj7lsXZiYSmTNc7Lcgaqz+bNYd0hgOPxgrTFNQHR01LuGHaB8
         6Jmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Yuz8rImO9QvcmswnwQEKGjBpNkKgF5UoZuyapY7pMSc=;
        b=ERJuU0cj9zmVcJ5BDs1qqNGzcjF4hNkOa07zIcESzCl6hZAOxKk4jtopoDx8/Ba8i1
         LSaImkEkS8BuLA+ndjJFVwr6EaPg31Cv4c6IsNn7XdDzjRXcK8wfwgzOkskVbIbevNi+
         78X5+l7vOqCRnLjDfx+wyE85JMHca7cbSaabiU/7HbAWQds5Gwoyfq+MGufUke1kBr8V
         3V4OVrTFIN+m/RXzUS8DeM5QvIMeCByeRYxPjuxNE9wYngJPSsIFLYYbdOZj4/6zN/4F
         zXNT8CbdEVsqqjbR2GmY50qwRq0M1jvu9sN4MKPc+I3DFne+SvkivomTvzNuNS+MClvS
         Y7jA==
X-Gm-Message-State: AOAM531xRRyUkns6S1r4kCCy/BQAoH5Y3jENK57w/mnICMtwWjSKvcSD
        aHSmGpUU7Sd4isSBYAxU8BMqcw==
X-Google-Smtp-Source: ABdhPJw1ENnnLu4yx6yCfd1Fz7CLQQpvpo5VQtb6awr85h0hE19vPBHdzSI44tEwI6Qi/BorPWD4zA==
X-Received: by 2002:a05:6a00:1c54:b029:261:fc0f:15f7 with SMTP id s20-20020a056a001c54b0290261fc0f15f7mr1728960pfw.30.1619146819902;
        Thu, 22 Apr 2021 20:00:19 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id f135sm3120048pfa.102.2021.04.22.20.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 20:00:19 -0700 (PDT)
Date:   Thu, 22 Apr 2021 20:00:19 -0700 (PDT)
X-Google-Original-Date: Thu, 22 Apr 2021 20:00:14 PDT (-0700)
Subject:     Re: [PATCH] riscv: vdso: fix and clean-up Makefile
In-Reply-To: <20210402212908.6f9b9686@xhacker>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        masahiroy@kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang3@mail.ustc.edu.cn
Message-ID: <mhng-847a8bb0-7c9a-446a-971c-ede38543cf56@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Apr 2021 06:29:08 PDT (-0700), jszhang3@mail.ustc.edu.cn wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
>
> Running "make" on an already compiled kernel tree will rebuild the
> kernel even without any modifications:
>
>   CALL    linux/scripts/checksyscalls.sh
>   CALL    linux/scripts/atomic/check-atomics.sh
>   CHK     include/generated/compile.h
>   SO2S    arch/riscv/kernel/vdso/vdso-syms.S
>   AS      arch/riscv/kernel/vdso/vdso-syms.o
>   AR      arch/riscv/kernel/vdso/built-in.a
>   AR      arch/riscv/kernel/built-in.a
>   AR      arch/riscv/built-in.a
>   GEN     .version
>   CHK     include/generated/compile.h
>   UPD     include/generated/compile.h
>   CC      init/version.o
>   AR      init/built-in.a
>   LD      vmlinux.o
>
> The reason is "Any target that utilizes if_changed must be listed in
> $(targets), otherwise the command line check will fail, and the target
> will always be built" as explained by Documentation/kbuild/makefiles.rst
>
> Fix this build bug by adding vdso-syms.S to $(targets)
>
> At the same time, there are two trivial clean up modifications:
>
> - the vdso-dummy.o is not needed any more after so remove it.
>
> - vdso.lds is a generated file, so it should be prefixed with
>   $(obj)/ instead of $(src)/
>
> Fixes: c2c81bb2f691 ("RISC-V: Fix the VDSO symbol generaton for binutils-2.35+")
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/kernel/vdso/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
> index 71a315e73cbe..7b9f505ba82f 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -23,7 +23,7 @@ ifneq ($(c-gettimeofday-y),)
>  endif
>
>  # Build rules
> -targets := $(obj-vdso) vdso.so vdso.so.dbg vdso.lds vdso-dummy.o
> +targets := $(obj-vdso) vdso.so vdso.so.dbg vdso.lds vdso-syms.S
>  obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
>
>  obj-y += vdso.o vdso-syms.o
> @@ -42,7 +42,7 @@ $(obj)/vdso.o: $(obj)/vdso.so
>
>  # link rule for the .so file, .lds has to be first
>  SYSCFLAGS_vdso.so.dbg = $(c_flags)
> -$(obj)/vdso.so.dbg: $(src)/vdso.lds $(obj-vdso) FORCE
> +$(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
>  	$(call if_changed,vdsold)
>  SYSCFLAGS_vdso.so.dbg = -shared -s -Wl,-soname=linux-vdso.so.1 \
>  	-Wl,--build-id=sha1 -Wl,--hash-style=both

Thanks, this is on for-next.
