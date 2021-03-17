Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1C133EA4B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 07:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhCQGze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 02:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhCQGyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 02:54:46 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F0DC061762
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 23:54:35 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id z9so507304ilb.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 23:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kqAXu675v6OnL5XbW/0TGkcABN28nbaEWPcSSWuZUk0=;
        b=pvFtTNt77jT7+Xg5Dz/4DDGNbA/sz20l5elMGAQH84sgyId9pkFqefN095kTIopis6
         +ARvIkkhZKhYncquuJT3R+e2fvVpp4CROn7gnDTh3PaZrGHcCXj5sJ250Y98zulj7j41
         4hDe0S7bwKpW/1pjBcNwBG4eps9benyhknFHmy6tvSHt3ZPByEWhcG+XR5znSkbFQ/Pm
         x9Z+fP9V8O4MiiD7vREC/Kqj1IOgJLbdyJGosJbqj3yK5ZpOvnnI2Wtp+jsIeZTSn9te
         2sJpjVjc2oFwlZLq8x9ohwWcMuzyw/W6edciDkVbccUXZC4zh1VVG6YmVhCfB/thz1gI
         vdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kqAXu675v6OnL5XbW/0TGkcABN28nbaEWPcSSWuZUk0=;
        b=i+HnY6uRsmnlfr6E14QL7BDN3akCqMj+fcyV2jP9TbmPqQ2Fh/8+4iBNgkv+5OolSR
         cE6dYE8zLM+Pjjz/tuOzfdJgHzQ6NebMF+mYDmZzCxW8XTu0OrciHOtk2aybIq6zAyVJ
         yyFmaVxhtV2BsVdXGg+6kKhTrhkt/mCW7fuZUIlUyRTsTDPg/PGooqF11fXZwuYfRcYX
         gzGsA2HuVwJLu0dHPS8q2ap8DQUhtGyJJlXPOFJSPU2tlyyfV+krYEH4devkh1XuMlu3
         EdENn+4ysYPnIpzI/TFJDhXVnSinlOoWfr4utb+A+rtLcw1P2R8afQ66OMJXauH31Uhb
         iynQ==
X-Gm-Message-State: AOAM532z2FeQ3xIeTTM6bb3rdjWP1aWW4VoYqYtB5B4aqeSPG+5pnXh7
        OPZ5jnihIfW+yErLFhqtfhyj3AwZru3akA==
X-Google-Smtp-Source: ABdhPJzc8J5BpKavkdNnOtRbUuOQLnjU/5fMi8Dy3Rp52lzcV5mMO+yewwqRbNVvX2oHVq+ZKF/rnA==
X-Received: by 2002:a92:540d:: with SMTP id i13mr6560423ilb.8.1615964075491;
        Tue, 16 Mar 2021 23:54:35 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id w13sm10583057ilg.48.2021.03.16.23.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 23:54:34 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v4 16/19] dyndbg: prevent build bugs via -DNO_DYNAMIC_DEBUG_TABLE
Date:   Wed, 17 Mar 2021 00:54:09 -0600
Message-Id: <20210317065412.2890414-17-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210317065412.2890414-1-jim.cromie@gmail.com>
References: <20210317065412.2890414-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The next patch adds DEFINE_DYNAMIC_DEBUG_TABLE(), which breaks some
subtrees with special compile constraints (efi etc).

Avoid this by adding a define to suppress the *remote declaration*
done by DEFINE_DYNAMIC_DEBUG_TABLE(), automatically, on behalf of all
possible users of pr_debug.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 arch/x86/boot/compressed/Makefile     | 1 +
 arch/x86/entry/vdso/Makefile          | 3 +++
 arch/x86/purgatory/Makefile           | 1 +
 drivers/firmware/efi/libstub/Makefile | 3 ++-
 4 files changed, 7 insertions(+), 1 deletion(-)

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
2.29.2

