Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8B234D590
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 18:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbhC2Qxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 12:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhC2Qxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 12:53:38 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99F5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 09:53:37 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id q26so13058379qkm.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 09:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZRSWFn6sDTnWj31Ge7dRmuXWY5dPnlyjzxRDAOMtyF8=;
        b=WygmQm1qMDmfY/dti7lonDd2AkzmSsz95cmmN4EA838MXM8wIdMZhzVOyyLhzAY/w1
         nIw0EAj4d2QZKTFe6bLzWAkPIfTuu6K9yfjg4bwTPoQuHPbnYPgLKbOa80x9irMuDmgg
         cAr+0cC12bw3Vbjyrw/fS6+L0XQEIN13UlU1NzgS+UB7dbgmTvccF4BNYgp/uLRGCfh4
         PmqrURDMZ9gT+F+S/NjxmXsCKiCHCWGu4anYJLOXWMzAtjokdWBuILL0LbQuyYplMFlc
         985TS4hQFVh5GcvQeBgbxTgGHE7NcPcBrEK6cX6jyfsh4aY0Of1pOL497Lup+TgkT12h
         3oyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ZRSWFn6sDTnWj31Ge7dRmuXWY5dPnlyjzxRDAOMtyF8=;
        b=qJYWQzEoexRb6jKeFj5lcWLM/GN3w0uqYbXIQL8G0kQKACtTzTMfbYZUW7AetkFz0D
         cNGSGCGc5rvWb8FZKOm9HmZe9PAc3iZjMx84JSI07ASb84l5jFjKJTi67vx+937bO1L0
         EIFDIqMzSVch68e2Lxf5bnG2p7y8tjfM0Of0AV2humgq9CbNmx+l44LOX8pYkfg0CJgG
         J2q4u3ZE5LM1ZJ8B1fXCPMbyLETwoFVUUyBMunOnuT4MYQA+BZNrh2GKpo9w5uzuA0WG
         DnrccFv10MdgIB5NqrR7/8hQx467b8AtE7KI62ZHSqDw2agQSB3++1yJamp5vjNc5X1l
         lNXA==
X-Gm-Message-State: AOAM533WzfmlidGoitinWy1gXWRpMmlnKVhmy1Uto5BYM7KaZ9UP8A6T
        rrRT66x0bwPzWP2O1pPV/MA=
X-Google-Smtp-Source: ABdhPJwBGESAAZnjMxS4JMwOOjjnfqtZJ5Ln7gMJ3AXgQHLh3PMxfP4mzO0xqz9mn5cQWjzQTdaEqg==
X-Received: by 2002:a05:620a:525:: with SMTP id h5mr26509611qkh.100.1617036816735;
        Mon, 29 Mar 2021 09:53:36 -0700 (PDT)
Received: from kde-neon-desktop.orld.fl.wtsky.net ([208.64.158.251])
        by smtp.gmail.com with ESMTPSA id j3sm13967483qki.84.2021.03.29.09.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 09:53:36 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     akpm@linux-foundation.org
Cc:     schwab@linux-m68k.org, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org, fazilyildiran@gmail.com
Subject: [PATCH v3] lib: fix kconfig dependency on ARCH_WANT_FRAME_POINTERS
Date:   Mon, 29 Mar 2021 12:53:29 -0400
Message-Id: <20210329165329.27994-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When LATENCYTOP, LOCKDEP, or FAULT_INJECTION_STACKTRACE_FILTER
is enabled and ARCH_WANT_FRAME_POINTERS
is disabled, Kbuild gives a warning such as:

WARNING: unmet direct dependencies detected for FRAME_POINTER
  Depends on [n]: DEBUG_KERNEL [=y] && (M68K || UML || SUPERH) || ARCH_WANT_FRAME_POINTERS [=n] || MCOUNT [=n]
  Selected by [y]:
  - LATENCYTOP [=y] && DEBUG_KERNEL [=y] && STACKTRACE_SUPPORT [=y] && PROC_FS [=y] && !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86

Depending on ARCH_WANT_FRAME_POINTERS causes a
recursive dependency error.
ARCH_WANT_FRAME_POINTERS is to be selected by the architecture,
and is not supposed to be overridden by other config options.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 lib/Kconfig.debug | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2779c29d9981..417c3d3e521b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1363,7 +1363,7 @@ config LOCKDEP
 	bool
 	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
 	select STACKTRACE
-	select FRAME_POINTER if !MIPS && !PPC && !ARM && !S390 && !MICROBLAZE && !ARC && !X86
+	depends on FRAME_POINTER || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86
 	select KALLSYMS
 	select KALLSYMS_ALL
 
@@ -1665,7 +1665,7 @@ config LATENCYTOP
 	depends on DEBUG_KERNEL
 	depends on STACKTRACE_SUPPORT
 	depends on PROC_FS
-	select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86
+	depends on FRAME_POINTER || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86
 	select KALLSYMS
 	select KALLSYMS_ALL
 	select STACKTRACE
@@ -1918,7 +1918,7 @@ config FAULT_INJECTION_STACKTRACE_FILTER
 	depends on FAULT_INJECTION_DEBUG_FS && STACKTRACE_SUPPORT
 	depends on !X86_64
 	select STACKTRACE
-	select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86
+	depends on FRAME_POINTER || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86
 	help
 	  Provide stacktrace filter for fault-injection capabilities
 
-- 
2.25.1

