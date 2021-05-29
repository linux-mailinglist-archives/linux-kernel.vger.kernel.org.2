Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB514394E0D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 22:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhE2UEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 16:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhE2UEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 16:04:10 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C4FC0613ED
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:32 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id b25so8012147oic.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a/h54JdNC5kR17fX7/LoX7g8+9V1SkM6LPGM//jz9YE=;
        b=VmVrhUYzXNmN1CdZ2TImKKYCJUPeXX1q1hDG3iDyWWU4vUIcGSF5Dmz2MPXiGvvIRT
         d5q/SMM4bpp2wkdrPV57CkCeyTQJg2OksYKcuN71CAcO+tUdkvTr+lRZp/jm1lnR0+AA
         KeDxbgFyG6szVkb1n0/CPysY+pudk9MDUprYahlHpuucHMs3hIJf2UMA+SHSHMYVMEOQ
         b+avDdJoV/t5pckQzELfBnWFU9854V+BmkXJVPgIEKci2HLPpdCBlQx3tNNYsZ5xoWD8
         XX0SJcMmzI6Pb2TeOQU2H79fju2CfLeq1hy8XSZyN9xywW6/qXKBa5yoNkRxet2z7LXq
         8qxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a/h54JdNC5kR17fX7/LoX7g8+9V1SkM6LPGM//jz9YE=;
        b=M7u44H3/GlXX6VtjWmPBG99q3VD+XNfRzhyeQdKaA1+s8DoTdvzuWPxwBDYyza9PBT
         L5rH19cMDEw1SYMVmKUTPkw+SiNmw0J5rba1uU5G8jtQjn0NIf+yu0QVbZE9a29krqZP
         Z2ftfpxFi4I6mL4p4YugkeAKEceNbyA1XporSxROdkuMcsDoUMRxUM3CqCCzUV0w4AtW
         qWxJhDmRC5zM7eLlDye5dlmxGnPb13JmPWVqCJdDDNPtG2xS0sdDIfhPdwnsQ7oZnsG6
         yndGGHmxM9YJcBrc9/LA5ErIVDsAYtgsKWg7K6poEx0Y+L2Umogt5HcV9y/ZE2FWLXVB
         lVJQ==
X-Gm-Message-State: AOAM5321h6Yma48pRQWpK3lo0q1lWIL0xn8VCXVlkjdFei3jSoNyReay
        8XVKjrJwtfgjPJKuX+NiT/4=
X-Google-Smtp-Source: ABdhPJzL2D4DPtBSFijsfEp1thv8p/WeLkurUMOT/g+uQ5it52o8wnpLBIgrWrB17CuyzEm4LZTiUw==
X-Received: by 2002:a54:4594:: with SMTP id z20mr12924109oib.100.1622318552253;
        Sat, 29 May 2021 13:02:32 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t39sm1868064ooi.42.2021.05.29.13.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 13:02:31 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>, lkp@intel.com
Subject: [RFC PATCH v6 18/34] dyndbg: prevent build bugs via -DNO_DYNAMIC_DEBUG_TABLE
Date:   Sat, 29 May 2021 14:00:13 -0600
Message-Id: <20210529200029.205306-19-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210529200029.205306-1-jim.cromie@gmail.com>
References: <20210529200029.205306-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The next patch adds DEFINE_DYNAMIC_DEBUG_TABLE(), which broke several
subtrees, including efi, vdso, and some of arch/*/boot/compressed,
with various relocation errors, iirc.

Avoid those problems by adding a define to suppress the "transparent"
DEFINE_DYNAMIC_DEBUG_TABLE() invocation.  I found the x86 problems
myself, lkp@intel.com found arm & sparc problems, and may yet find
others.

Reported-by: <lkp@intel.com> # on [jimc:lkp-test/dyndbg-diet] recently
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 arch/arm/boot/compressed/Makefile     | 2 ++
 arch/sparc/vdso/Makefile              | 2 ++
 arch/x86/boot/compressed/Makefile     | 1 +
 arch/x86/entry/vdso/Makefile          | 3 +++
 arch/x86/purgatory/Makefile           | 1 +
 drivers/firmware/efi/libstub/Makefile | 3 ++-
 6 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index fd94e27ba4fa..72f056a00ad4 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -82,6 +82,8 @@ compress-$(CONFIG_KERNEL_LZMA) = lzma
 compress-$(CONFIG_KERNEL_XZ)   = xzkern
 compress-$(CONFIG_KERNEL_LZ4)  = lz4
 
+KBUILD_CFLAGS += -DNO_DYNAMIC_DEBUG_TABLE
+
 libfdt_objs := fdt_rw.o fdt_ro.o fdt_wip.o fdt.o
 
 ifeq ($(CONFIG_ARM_ATAG_DTB_COMPAT),y)
diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index c5e1545bc5cf..960ed0fb6804 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -30,6 +30,8 @@ obj-y += $(vdso_img_objs)
 targets += $(vdso_img_cfiles)
 targets += $(vdso_img_sodbg) $(vdso_img-y:%=vdso%.so)
 
+KBUILD_CFLAGS += -DNO_DYNAMIC_DEBUG_TABLE
+
 CPPFLAGS_vdso.lds += -P -C
 
 VDSO_LDFLAGS_vdso.lds = -m elf64_sparc -soname linux-vdso.so.1 --no-undefined \
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index e0bc3988c3fa..ada4eb960d95 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -31,6 +31,7 @@ targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
 KBUILD_CFLAGS := -m$(BITS) -O2
 KBUILD_CFLAGS += -fno-strict-aliasing -fPIE
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
+KBUILD_CFLAGS += -DNO_DYNAMIC_DEBUG_TABLE
 cflags-$(CONFIG_X86_32) := -march=i386
 cflags-$(CONFIG_X86_64) := -mcmodel=small -mno-red-zone
 KBUILD_CFLAGS += $(cflags-y)
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 05c4abc2fdfd..619878f2c427 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -29,6 +29,9 @@ vobjs32-y := vdso32/note.o vdso32/system_call.o vdso32/sigreturn.o
 vobjs32-y += vdso32/vclock_gettime.o
 vobjs-$(CONFIG_X86_SGX)	+= vsgx.o
 
+# avoid a x86_64_RELATIVE error
+KBUILD_CFLAGS += -DNO_DYNAMIC_DEBUG_TABLE
+
 # files to link into kernel
 obj-y				+= vma.o extable.o
 KASAN_SANITIZE_vma.o		:= y
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 95ea17a9d20c..95ba7b18410f 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -35,6 +35,7 @@ PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
 PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss -g0
 PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
 PURGATORY_CFLAGS += -fno-stack-protector
+PURGATORY_CFLAGS += -DNO_DYNAMIC_DEBUG_TABLE
 
 # Default KBUILD_CFLAGS can have -pg option set when FTRACE is enabled. That
 # in turn leaves some undefined symbols like __fentry__ in purgatory and not
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index c23466e05e60..def8febefbd3 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -13,7 +13,8 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ \
 				   -Wno-pointer-sign \
 				   $(call cc-disable-warning, address-of-packed-member) \
 				   $(call cc-disable-warning, gnu) \
-				   -fno-asynchronous-unwind-tables
+				   -fno-asynchronous-unwind-tables \
+				   -DNO_DYNAMIC_DEBUG_TABLE
 
 # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
 # disable the stackleak plugin
-- 
2.31.1

