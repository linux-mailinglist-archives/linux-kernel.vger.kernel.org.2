Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934EA324F14
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 12:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbhBYLXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 06:23:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:57014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232761AbhBYLXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 06:23:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACF0D64EF5;
        Thu, 25 Feb 2021 11:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614252173;
        bh=w3lFoBmZGV0JolDdok8pmUKTBwyTrMqbAEwOcp9fciQ=;
        h=From:To:Cc:Subject:Date:From;
        b=i00dPO7Ynk8yYw1D/jh9ecE5Ep9egfDB7vjAuSCPX/EF3uZxh3IKPjgpB4A/Vdlhi
         sXKtt5U/5IlfPJEhjo/6GZ0glDxDW9MyYGcTlNiWSWdrpLwz3CPhvw+HC9VyjtivAK
         PjdwKX8jsX0/QTzR2WRaeRSLM8jgrHI8Hr3ZR8R+QGDWFARTcPYXGBQL9XJBiAVeKt
         BLldNF2QiUWPlP+eYhtRznrrqX93YM9zu2EIrwWK+uiOuMp+ecI0Ur+tPH+cOWTtUo
         NZV9RUH9ybO0FS1FkWjPENy96rs0EALx7R3HEOMzttwglPyT2uL6TgygPaqwTPlo3A
         3WYIfrcvzzTMg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] x86: mark some mpspec inline functions as __init
Date:   Thu, 25 Feb 2021 12:22:41 +0100
Message-Id: <20210225112247.2240389-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

clang-13 sometimes decides to not inline early_get_smp_config(),
which leads to a link-time warning:

WARNING: modpost: vmlinux.o(.text+0x838cc): Section mismatch in reference from the function early_get_smp_config() to the variable .init.data:x86_init
The function early_get_smp_config() references
the variable __initdata x86_init.
This is often because early_get_smp_config lacks a __initdata
annotation or the annotation of x86_init is wrong.

There are two other functions which may run into the same issue,
so mark all three as __init.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/include/asm/mpspec.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mpspec.h
index e90ac7e9ae2c..b41066dbf5c2 100644
--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -49,17 +49,17 @@ extern int smp_found_config;
 # define smp_found_config 0
 #endif
 
-static inline void get_smp_config(void)
+static inline __init void get_smp_config(void)
 {
 	x86_init.mpparse.get_smp_config(0);
 }
 
-static inline void early_get_smp_config(void)
+static inline __init void early_get_smp_config(void)
 {
 	x86_init.mpparse.get_smp_config(1);
 }
 
-static inline void find_smp_config(void)
+static inline __init void find_smp_config(void)
 {
 	x86_init.mpparse.find_smp_config();
 }
-- 
2.29.2

