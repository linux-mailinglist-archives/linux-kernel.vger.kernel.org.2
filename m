Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD6738F2D3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 20:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbhEXSTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 14:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbhEXSSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 14:18:54 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263E5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 11:17:25 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id o10so24808351ilm.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 11:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cx7Q03KErO3Qcjdme6iFJ07EvyWiwtMpo7D7QaMiHZY=;
        b=A9tpYhcO7hkSPF1iOdFkg5OyIo9vA6+I0m06vKNr0mH/VsITvJqporMxuT0SoXZMdk
         FD6bsMX+xGAxjNP2LCQnpHUuqM+u+B/OrnTYocHDAvz2csKycyL6iTzY/xM4LyHegfyU
         HqYxtq2gyEaEt0MfD+UceHtegMknIH7wcIUzxJebpGVCN06G8a59pJt3/m/mckidaRvb
         a4FS2+GwgQAju+KJo/rYWmdXEhpWrMUeqsTa4YNuDhs995OoE927b0E/dOiFoFJ7G3fN
         zr2xIBDrOrH/PhBYXNc0QzeWXxR0Cgajjal/3Go/wUwVa07+S/u2yy6FRKtKUOJBsLGL
         cunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cx7Q03KErO3Qcjdme6iFJ07EvyWiwtMpo7D7QaMiHZY=;
        b=aAwiU/JvzBctVJKdBjGnS3DQuD/NLwdfgkXJWQQClEm9S89BcbxEtRdjuObgvcrkvK
         D5gso124HLN8msioZngD3E7TYQN8x9rtZ9NOOtp1ieMhi3WGWaZqFWElPkFS5LFsQrJ9
         Rl3Oxdg2F/bI6b/dvJQELYQFfmLxOt9YNgc5joBCAGNEo6L/NklNxY83zqGFKkhKZPS6
         eW8YUX2Ol6G0SPcPJtIiU6NIe3tpMS6j2PN5dQuG038aCLaO4K14xo5Awye/ENCfgCKt
         fUiX17vWSgq0mxwR4oDZ4Dr4VYrJQ+3ZjliQSnPg/L0hSFndONBFno8VzPY63n7DfZLS
         e4Xg==
X-Gm-Message-State: AOAM532kiwKs6xFifT0VSuGKWjJCAg+JlrzaL7EUulvGzwfYqVA0EK+K
        /4IECWEl0ZWj7cEoRjbow/pixMd6Sw==
X-Google-Smtp-Source: ABdhPJymzotG4+QeHjmiXGXGaoSTdI8jUv/wDnvvGDK+Yu0xX0CCO6RN0T68gHkwN2kgTdNE4O/9Qg==
X-Received: by 2002:a92:ddd1:: with SMTP id d17mr14359217ilr.46.1621880244376;
        Mon, 24 May 2021 11:17:24 -0700 (PDT)
Received: from citadel.. (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id p5sm11863673ilg.33.2021.05.24.11.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 11:17:24 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 3/3] x86/syscalls: Don't sdjust CFLAGS for syscall tables
Date:   Mon, 24 May 2021 14:17:07 -0400
Message-Id: <20210524181707.132844-4-brgerst@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210524181707.132844-1-brgerst@gmail.com>
References: <20210524181707.132844-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The syscall_*.c files only contain data (the syscall tables).  There
is no need to adjust CFLAGS for tracing and stack protector since they
contain no code.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/entry/Makefile | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
index 94d2843ce80c..7fec5dcf6438 100644
--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -8,14 +8,8 @@ UBSAN_SANITIZE := n
 KCOV_INSTRUMENT := n
 
 CFLAGS_REMOVE_common.o		= $(CC_FLAGS_FTRACE)
-CFLAGS_REMOVE_syscall_64.o	= $(CC_FLAGS_FTRACE)
-CFLAGS_REMOVE_syscall_32.o	= $(CC_FLAGS_FTRACE)
-CFLAGS_REMOVE_syscall_x32.o	= $(CC_FLAGS_FTRACE)
 
 CFLAGS_common.o			+= -fno-stack-protector
-CFLAGS_syscall_64.o		+= -fno-stack-protector
-CFLAGS_syscall_32.o		+= -fno-stack-protector
-CFLAGS_syscall_x32.o		+= -fno-stack-protector
 
 obj-y				:= entry_$(BITS).o thunk_$(BITS).o syscall_$(BITS).o
 obj-y				+= common.o
-- 
2.31.1

