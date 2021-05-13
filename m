Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670B437F187
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 05:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhEMDHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 23:07:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230186AbhEMDHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 23:07:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0672613DF;
        Thu, 13 May 2021 03:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620875196;
        bh=NIYhNZ3lq0gLH456sCAhQIBe2NS15yV6wh66f39yazQ=;
        h=From:To:Cc:Subject:Date:From;
        b=F0JRGABCMgnxAvijkm5S2bdINyuvDcsfegfN+21N7jRaZ5xq6VYlxorvQIWTzg2oq
         1OccpuPYG5NgDc1/BiOZ59/HUong8Nu88STT7Rq5SaIZlM3MprJ2v7ck0ql0mwbvkW
         TFpu4aNn/wRY8hZNtSG9GBfvAgQXUzS/v2U0DvsGV5di9aRdp4J24FUhcs9F94C1K+
         wrySke4PKoaHAGwKVSWwkFQruOFclp7tqgI5vkx7Y6kZCfTDIdaR1/3ZgCc1ynhZzi
         2OiuhkDTvJes0YmseX1r7pWWU/4ja3ySaKWbIp5co+3E24kBpv+RLH8f8oakkEc0iY
         oebetGKKC28DA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] tools/bootconfig: Fix a build error accroding to undefined fallthrough
Date:   Thu, 13 May 2021 12:06:33 +0900
Message-Id: <162087519356.442660.11385099982318160180.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the "fallthrough" is defined only in the kernel, building
lib/bootconfig.c as a part of user-space tools causes a build
error.

Add a dummy fallthrough to avoid the build error.

Cc: stable@vger.kernel.org
Fixes: 4c1ca831adb1 ("Revert "lib: Revert use of fallthrough pseudo-keyword in lib/"")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/bootconfig/include/linux/bootconfig.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/bootconfig/include/linux/bootconfig.h b/tools/bootconfig/include/linux/bootconfig.h
index 078cbd2ba651..de7f30f99af3 100644
--- a/tools/bootconfig/include/linux/bootconfig.h
+++ b/tools/bootconfig/include/linux/bootconfig.h
@@ -4,4 +4,8 @@
 
 #include "../../../../include/linux/bootconfig.h"
 
+#ifndef fallthrough
+# define fallthrough
+#endif
+
 #endif

