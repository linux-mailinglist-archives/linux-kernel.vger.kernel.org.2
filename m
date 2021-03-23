Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7074A345E7B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhCWMtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:49:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231252AbhCWMsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:48:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2AF4600CC;
        Tue, 23 Mar 2021 12:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616503731;
        bh=mpIZs+s3XKFYZG1MrNls+u4ZRfSEE5iE7XAllmK0kXs=;
        h=From:To:Cc:Subject:Date:From;
        b=muWzkwvnt9XPp8uZoFCK8YEs/z053yo2f4K6mtlHoXxk2MShaQ3IQq2JOJX17aaGL
         MNHuKxj57kYakYqfdURMfDt3E1lrHxhvAJtC4m6a7zNjjahfFZO+h9FYFVBCt2ccqK
         da7zF0WgwpFQnz8M6FPVas273ZMql2sX6X8EpkOphG5ZFLq1b9QIg9N92uERLsRus3
         Lvn/QF/NdSXFGuuDJVAbiotj398fpW5CCt1fXOJ1WddHYf9rX/qwDvDEpxCAupoW04
         vBfgTI1AtG5/bgNIjBMXe9YY5rXYUrL/SdkZ7Ie4jta+AQs5vQOsLcipytpsn8Xja/
         BrY73Gt5cOyYA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86: turn off -fcf-protection for realmode
Date:   Tue, 23 Mar 2021 13:48:36 +0100
Message-Id: <20210323124846.1584944-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The new Ubuntu gcc packages turn on -fcf-protection globally,
which causes a build failure in the x86 realmode code:

cc1: error: ‘-fcf-protection’ is not compatible with this target

Turn it off explicitly on compilers that understand this option.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 5689d799bd12..0a1278512cc9 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -27,7 +27,7 @@ endif
 REALMODE_CFLAGS	:= -m16 -Os -DDISABLE_BRANCH_PROFILING \
 		   -Wall -Wstrict-prototypes -march=i386 -mregparm=3 \
 		   -fno-strict-aliasing -fomit-frame-pointer -fno-pic \
-		   -mno-mmx -mno-sse
+		   -mno-mmx -mno-sse $(call cc-option,-fcf-protection=none)
 
 REALMODE_CFLAGS += -ffreestanding
 REALMODE_CFLAGS += -fno-stack-protector
-- 
2.29.2

