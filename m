Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83388338959
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbhCLJ4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbhCLJzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:55:49 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADBCC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:55:48 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id g14so3959134qvn.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:mime-version:date:message-id;
        bh=WD8sR2qQ2FGd9LryCvWh2EJSu2H3tjlxVjm2yprOu/o=;
        b=U+2l7nwkR7iEiWldFc7tBtdy70VCTqjQ+cqtMR/9AukMgbRwQ1qm+j8f1OPhue17ok
         Z7Hf/nscO48w/9JeE281Wg7Jmc2x9LchSQvbUN84d28axeWSIrB2zf8FR10hOE/svIx8
         XxXTxxMQ26aeol3yQ1WgDOR+XEXe9Fk2egVGIIn1aQ8sEs8W6zfqOZxTvMKlS1FfBpKF
         /3ol/ljWB+/u+rAqhaAv1nDd19fIVODfgpVpV54E/QnDtuH9exLPH2Q9ZD/aRhJurQCJ
         aIjcAiBIiyVSplj8eaPI47WBAMwywHTWE2e637NI536+NQ4UkEafKh5biEJhnM082+yL
         mMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=WD8sR2qQ2FGd9LryCvWh2EJSu2H3tjlxVjm2yprOu/o=;
        b=kJYMaeryEplKVLTNxePQBUSzj2s8u99vx/5c/aUAQSP9kLHsyB/c00wdh9pch4pxgV
         eO87GhbOpDLMfNnEtVfkupx6DzfFQA/AFIyer54xJKcBZpDv7CAGBvPMGk4vOotRBXRE
         nQMl7DFVWpEwkdldZSnFPYNIh72Urzo5IxQQNLtJhLwfb8e4pV1XNrpyVSvt+0Azdl2r
         DTbUvr8OTJ6yV3kYCTdIuWLdKeMSxs6gOrkMkmwFOXOPL2QNUmL+wvlH38SbRiBe4XN5
         Mefsrz0WRMo6m8KSPfVSOhlLS4YW9I7QGdcXCPsYxrwr1o8Wmeg014YIVvmpz1ECm+UY
         7QQg==
X-Gm-Message-State: AOAM533Bm8jBZ2vXpgOagYslQQSr6UUGLgr+PEbPOHUCzuIzG4dZMY3O
        9Bb5E+D7ReLw/tl97V09VcwUfw==
X-Google-Smtp-Source: ABdhPJz0TMeIw9oMkW/odwOY1oS5xc65r8v/HhBz0Y6YiLT1vO4cEsYvXAs3vG7rMT4Q0uGAYFOCJg==
X-Received: by 2002:a0c:cc8c:: with SMTP id f12mr11348749qvl.14.1615542948097;
        Fri, 12 Mar 2021 01:55:48 -0800 (PST)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id j6sm3291662qtx.14.2021.03.12.01.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:55:47 -0800 (PST)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: arm64: kernel/sys.c - silence initialization warnings.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Fri, 12 Mar 2021 04:55:46 -0500
Message-ID: <162859.1615542946@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building arch/arm64/kernel/sys.o with W=1 throws over 300 warnings:

/usr/src/linux-next/arch/arm64/kernel/sys.c:56:40: warning: initialized field overwritten [-Woverride-init]
   56 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
      |                                        ^~~~~~~~
/usr/src/linux-next/include/uapi/asm-generic/unistd.h:29:37: note: in expansion of macro '__SYSCALL'
   29 | #define __SC_COMP(_nr, _sys, _comp) __SYSCALL(_nr, _sys)
      |                                     ^~~~~~~~~
/usr/src/linux-next/include/uapi/asm-generic/unistd.h:34:1: note: in expansion of macro '__SC_COMP'
   34 | __SC_COMP(__NR_io_setup, sys_io_setup, compat_sys_io_setup)
      | ^~~~~~~~~

We know that's pretty much the file's purpose in life, so tell the
build system to not remind us.  This makes the 1 other warning a
lot more noticeable. 

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index ed65576ce710..916b21d2b35b 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -8,6 +8,7 @@ CFLAGS_armv8_deprecated.o := -I$(src)
 CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_insn.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_return_address.o = $(CC_FLAGS_FTRACE)
+CFLAGS_sys.o += $(call cc-disable-warning, override-init)
 
 # Object file lists.
 obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\

