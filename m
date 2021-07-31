Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4A33DC381
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 07:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbhGaFXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 01:23:41 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:28794 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhGaFXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 01:23:40 -0400
Received: from localhost.localdomain ([133.106.57.58]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 16V5MZEH012804;
        Sat, 31 Jul 2021 14:22:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 16V5MZEH012804
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1627708956;
        bh=Rb2s+bbFKWl9vdv+qc1BGZT64bxntUFlwVRO5TgojSQ=;
        h=From:To:Cc:Subject:Date:From;
        b=LLVCc19qSQ0IUzrSIi7DLIFjq8/03pilxZNBjvPRdhDUkD0qKmKLfVjU4Kn8Wj2MF
         LwgblzZ5ZFvDG1pS5uOnHw8SoVpXoyUghbwAGjoyQZloL/sFwo9wPWac+ZFD73KK50
         S6e8+ZP6CugYVTr3FcB8syyaz/36t5ImPHeNZp9WDFzj15t0fcc3lC8Cbt2OlB1xLh
         1jItWIF1ydKyg4fGaMWJGLkcBMWtLeWXf0tt9t5F+yYB95jNyp62crWYKwmImk/jnf
         hN6Rc4xpeT2FAU5wTisPwRVkCW2Sb/rTxLRQoU3R/eo2XuCA2hzXV5e6uWAduNVzuy
         mYqNlpsnrXqpg==
X-Nifty-SrcIP: [133.106.57.58]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ftrace: simplify the Kconfig dependency of FTRACE
Date:   Sat, 31 Jul 2021 14:22:31 +0900
Message-Id: <20210731052233.4703-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The entire FTRACE block is surrounded by 'if TRACING_SUPPORT' ...
'endif'.

Using 'depends on' is a simpler way to guard FTRACE.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 kernel/trace/Kconfig | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index d567b1717c4c..9d3f918b5867 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -135,10 +135,9 @@ config TRACING_SUPPORT
 	depends on STACKTRACE_SUPPORT
 	default y
 
-if TRACING_SUPPORT
-
 menuconfig FTRACE
 	bool "Tracers"
+	depends on TRACING_SUPPORT
 	default y if DEBUG_KERNEL
 	help
 	  Enable the kernel tracing infrastructure.
@@ -1032,6 +1031,3 @@ config HIST_TRIGGERS_DEBUG
           If unsure, say N.
 
 endif # FTRACE
-
-endif # TRACING_SUPPORT
-
-- 
2.27.0

