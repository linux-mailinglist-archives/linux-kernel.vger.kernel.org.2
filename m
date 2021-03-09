Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441EF331DA8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 04:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhCIDmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 22:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhCIDmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 22:42:20 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E774DC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 19:42:19 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id z190so11727806qka.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 19:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NRIR/a0C1V1jNUDE4eh6VW0ZR5TCiGNivYoTBlNwZBA=;
        b=e/GoyzyGmxj3MRvhVrxP4KrFQao8FHckNvqLjHpSr47hqL9ORyMuc4n7WraBctiMIZ
         79elQOK98E7SqRO2jUcVa+HwLrM0xE0i5M52cagruT8zjC6Zr2VXWLDHTRQUvpy0SD7f
         XyQO6Sa5igc4CmRgZskzJRdDV+7ClJIloRTi+xj7ictCnHxoCGpZc6Van6x2g/+4rxfE
         f1+u8VkGPAJl6Rgix6uZWZBUwX0UDfbjF4OGG1dp3s3si8guKi3YB/ep9jIt+Fpqe3Wb
         /HEZbVUBXfuMvVqIcfkLAI3bQs6flPrTAXukDLMxUseB9ywQvcZVlNxihOpIQrzUjTl+
         U+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NRIR/a0C1V1jNUDE4eh6VW0ZR5TCiGNivYoTBlNwZBA=;
        b=W5E6eSH6pKkxR+WCjh2dypfaH6KhZ4v/+frxn0VT/XI8cHHTdMaFKxe9M0opNwzyBq
         Im+eyT3JRHOPnG0Hy9afMYpe1Dc8ob9rbZj9ZHGzDdpzUutlc/PD2c1pv3ZDTIkNFQ/a
         PMWQsoToQw9qqh34OoCfFHegytYdzIA3+Pk6v/24SgsbAsyNS5e1+wNqh+z/DTuNc8uA
         I1/y3vnXGBFkAzo/VOY71AD5XaxxokvJBUTJTDjBTmfz6K/mZC/qmVWHCbwjERA5KZBR
         /l0NkWe4PsWRkkGASv9aI7EgQqx0kgezbPBwEEEt5t78vGfVpvTSAy8Wbmy/D4Tx435B
         btvg==
X-Gm-Message-State: AOAM532YKF3GpMZRY/R0BSZq47UCdOh1cnavLIHNOEzjySSBJb6QLhSP
        qtQdRY8NgT3QMCi8MBapz2nqiBZ7pBt0tDZV
X-Google-Smtp-Source: ABdhPJy3tA9omZRpSuDljE56Hb0S4UPrz1LDfQ3ISwZlhppD/ksmDBQuP7i7op8fXWOvL2CyaL5KYg==
X-Received: by 2002:a05:620a:1369:: with SMTP id d9mr24312950qkl.378.1615261339234;
        Mon, 08 Mar 2021 19:42:19 -0800 (PST)
Received: from localhost.localdomain ([156.146.37.204])
        by smtp.gmail.com with ESMTPSA id t21sm8745617qtw.51.2021.03.08.19.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 19:42:18 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, keescook@chromium.org, jpoimboe@redhat.com,
        jroedel@suse.de, hjl.tools@gmail.com, nivedita@alum.mit.edu,
        unixbhaskar@gmail.com, inglorion@google.com,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] arch: x86: kernel: Adjust the words to suit sentences in the file vmlinux.lds.S
Date:   Tue,  9 Mar 2021 09:11:44 +0530
Message-Id: <20210309034144.3283899-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



s/percpu/per CPU/
s/baremetal/bare metal/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/x86/kernel/vmlinux.lds.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index efd9e9ea17f2..592a44ad13b1 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -217,7 +217,7 @@ SECTIONS

 #if defined(CONFIG_X86_64) && defined(CONFIG_SMP)
 	/*
-	 * percpu offsets are zero-based on SMP.  PERCPU_VADDR() changes the
+	 * per CPU offsets are zero-based on SMP.  PERCPU_VADDR() changes the
 	 * output PHDR, so the next output section - .init.text - should
 	 * start another segment - init.
 	 */
@@ -262,7 +262,7 @@ SECTIONS
 	/*
 	 * start address and size of operations which during runtime
 	 * can be patched with virtualization friendly instructions or
-	 * baremetal native ones. Think page table operations.
+	 * bare metal native ones. Think page table operations.
 	 * Details in paravirt_types.h
 	 */
 	. = ALIGN(8);
--
2.30.1

