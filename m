Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE223EF2C7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 21:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbhHQTnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 15:43:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233217AbhHQTni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 15:43:38 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E551861052;
        Tue, 17 Aug 2021 19:43:04 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mG4zH-004TOO-R5; Tue, 17 Aug 2021 15:43:03 -0400
Message-ID: <20210817194303.677688614@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 17 Aug 2021 15:42:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [for-next][PATCH 06/19] tracing: Simplify the Kconfig dependency of FTRACE
References: <20210817194207.947725935@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>

The entire FTRACE block is surrounded by 'if TRACING_SUPPORT' ...
'endif'.

Using 'depends on' is a simpler way to guard FTRACE.

Link: https://lkml.kernel.org/r/20210731052233.4703-1-masahiroy@kernel.org

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/Kconfig | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 3ee23f4d437f..420ff4bc67fd 100644
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
@@ -1037,6 +1036,3 @@ config HIST_TRIGGERS_DEBUG
           If unsure, say N.
 
 endif # FTRACE
-
-endif # TRACING_SUPPORT
-
-- 
2.30.2
