Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38AD433CCF7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbhCPFJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbhCPFIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:08:34 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A41C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:08:34 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id f20so35809572ioo.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kqAXu675v6OnL5XbW/0TGkcABN28nbaEWPcSSWuZUk0=;
        b=dUBRBXBNpf+Btudd9Q2psknj/2lm2pPKFQZDChY0CK+oCT7sCePXrLskUn5CFokdo6
         gk5L+eokVTKuJ4o5dU5ppn/NzU0qN5qpXU9rpigpAo6iucFxnav4DGxN4lkxDu/sDjxh
         Ra4Lbp2UsNaQQxWelS9ZxH+j8a49doMiOhxGmX3oFX+aPsqv380icA59AuuE7IU2dZJu
         tkhamvzZnI06oXEfw/ZpCd96V8cIWemL46KyJpb/J1Xwh1ldlKxRH4e/CJHmC9gPpyE0
         nhSNFhhrkWTG5S237FcseBQwItnWNz2EiYEpgAeB51RwGI98Bbc8QLJ1sJ0ML2asUgfT
         Z01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kqAXu675v6OnL5XbW/0TGkcABN28nbaEWPcSSWuZUk0=;
        b=hwsncSCpaRodtgva/i3zd3+5fTI+YQj9d/k2RzUWZhqCpBb4xVS5uRBnL6glFg+CYQ
         525bINE/N/Ol4P1CHblYIelXaKeqeAID0VBs/rR1goT7Tv83ez3W+FsYlShyaONB9eQF
         XNnGDEEJY9dAiziLaNXp13ceMcrlQNmbAA3SAMbIVgay1VFpi+xeZ0Z1wE14RY7umXxy
         I+7wSsjslHRzVZOplriZUdj3hMSTOGqNt5ow/HofZYiWKWzBYs6HAT2/AUMr+adMFKTZ
         AowEEFDdkMBKNAl7NbONUJ4rC4CVQZ7S7Pk2zU6vSHWyEfeMoX2ULrJNEHKzN/qSitX4
         lPkQ==
X-Gm-Message-State: AOAM532hsuy0Qe/e9hMdfuxh8XECWs439OGDai8mCdcQeW3ZUa2A0BYU
        195PzZa1N9IfXO1ehPj6ovY=
X-Google-Smtp-Source: ABdhPJw6Eq6u1F4UWA/uu/+bbiq8EH5H8EbwYBjONxHY3f0+q5riujl9vIwE2e6zxgBzDteyZNSxoQ==
X-Received: by 2002:a6b:f909:: with SMTP id j9mr2128887iog.138.1615871314076;
        Mon, 15 Mar 2021 22:08:34 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y9sm8587469ill.15.2021.03.15.22.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 22:08:33 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v3 16/18] dyndbg: prevent build bugs via -DNO_DYNAMIC_DEBUG_TABLE
Date:   Mon, 15 Mar 2021 23:07:59 -0600
Message-Id: <20210316050801.2446401-17-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210316050801.2446401-1-jim.cromie@gmail.com>
References: <20210316050801.2446401-1-jim.cromie@gmail.com>
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

