Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23A238F2CF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 20:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbhEXSS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 14:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbhEXSSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 14:18:53 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6233C061756
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 11:17:23 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e10so24159020ilu.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 11:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dUCACciykxuV53qIcn78Bgnehe/pz3xzFnGYcgXVfoA=;
        b=V5Zq2iJdpzuKn3IEmDentdAI9kOub3dTCx12b+p8Q0TwGtGCXavbjx+pcbH2WvWcLU
         Ydae5emhVO5h5iO2jyDk6aMhZLui32Ys1h4IySOFgH606SigMsI4zVaCF+HAz2RlW+Aa
         QFi+JzlutWqGM3fMTRHaMJREkSy+JRJ+cEDpV5y59JM4dnTU72jDq3XXc8UEB2fr1z0B
         EsmmG5Pyg0GGXWx63MC0fK6XOsojhgBHhCHAEYcrUh8uYlCuPHjYTEjlLEyOuL1OwDgG
         E9jhysfyKXvvkRtpqXw+DmRnL5XiI41vNPuODXpV4bLXPXZhJWST5+Y59UVLmXrGXQXZ
         ed7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dUCACciykxuV53qIcn78Bgnehe/pz3xzFnGYcgXVfoA=;
        b=RGy9rvMIXQHM6WeM1XgjDQDXbwU/UgrPhUOPH2enNh2daZ74xX0/GlKSsoJAFtlF7C
         QJB62WBmoBe4YTEw/EZEk5rJ+R4Uj5xPwpXQgEG8zjfIA/Y57yzjTbvPzcEroO5y2WyF
         1qytaJNoW0a1NmZNZnP4jMK2Dp+XpTYJiZxEBev7e5zezuVkM2wtlyPz6OJebt2BrPDI
         6c7mPYTgjOkb8leWq4M5wb/9cKZRtWBPG5YrWu7slFPsRZEPwlwZyX18oDXYK1adCILv
         aELWGPJR6ceQG4zOPMuQ0xJUMDCjl0MyXVSY13acIoh2f2sq5S8BXLLvi/39i5rdnt/t
         Lk2A==
X-Gm-Message-State: AOAM5307/vXkXSJsLE6aWKBaNDSVeSOITQWAg8+N37iyY+KO/KSgWWTM
        bGI07rJtO9SysNfTUCFrd2nr7QaOcg==
X-Google-Smtp-Source: ABdhPJyhQBqyUp8q6AUesRQwYi91Kh2fpsY5mqyDQcNpyldthaj53Q0OEnDwxDhHD5ngYcxFt54GIQ==
X-Received: by 2002:a92:c56a:: with SMTP id b10mr15218039ilj.17.1621880243221;
        Mon, 24 May 2021 11:17:23 -0700 (PDT)
Received: from citadel.. (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id p5sm11863673ilg.33.2021.05.24.11.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 11:17:23 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 1/3] x86/uml/syscalls: Remove array index from syscall initializers
Date:   Mon, 24 May 2021 14:17:05 -0400
Message-Id: <20210524181707.132844-2-brgerst@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210524181707.132844-1-brgerst@gmail.com>
References: <20210524181707.132844-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 44fe4895f47c ("Stop filling syscall arrays with *_sys_ni_syscall")
removed the index from the initializers for native x86 syscall tables, but
missed the UML syscall tables.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/um/sys_call_table_32.c | 2 +-
 arch/x86/um/sys_call_table_64.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/um/sys_call_table_32.c b/arch/x86/um/sys_call_table_32.c
index f8323104e353..0575decb5e54 100644
--- a/arch/x86/um/sys_call_table_32.c
+++ b/arch/x86/um/sys_call_table_32.c
@@ -31,7 +31,7 @@
 #include <asm/syscalls_32.h>
 
 #undef __SYSCALL
-#define __SYSCALL(nr, sym) [ nr ] = sym,
+#define __SYSCALL(nr, sym) sym,
 
 extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 
diff --git a/arch/x86/um/sys_call_table_64.c b/arch/x86/um/sys_call_table_64.c
index 5ed665dc785f..95725b5a41ac 100644
--- a/arch/x86/um/sys_call_table_64.c
+++ b/arch/x86/um/sys_call_table_64.c
@@ -39,7 +39,7 @@
 #include <asm/syscalls_64.h>
 
 #undef __SYSCALL
-#define __SYSCALL(nr, sym) [ nr ] = sym,
+#define __SYSCALL(nr, sym) sym,
 
 extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 
-- 
2.31.1

