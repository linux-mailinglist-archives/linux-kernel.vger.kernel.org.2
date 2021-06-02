Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5C73983F6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 10:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbhFBIUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 04:20:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:37180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232437AbhFBIUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 04:20:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED463613CA;
        Wed,  2 Jun 2021 08:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622621933;
        bh=NIYhNZ3lq0gLH456sCAhQIBe2NS15yV6wh66f39yazQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RAXshY48Q2UYuZqtb8H2PSB5HFH9pPC0R685aUDcjRqzN84Ss6P+blPh2GK01MVR0
         L1GFiVMW4O54WpqtbgmrEOVC4yTrbz8tVW8vDmV/4wJXoFHIYnmuqePVy2Pw5xRlfE
         5ay0srqu7lKOlFSPbXs71e5JZxy+E43ubJ1XRdAPLOfSPAWkROp3DbuTT6nknMfWIM
         OVmq/znJZBDlxkd7hRmss9Uvi35raQL3CxzqrzPTQ8sFcYBg/nuUA62eHmTNYKn1py
         bmjrf+4zj7tsl7uEBvFCdpcJb6fzhayxdLzSsFEmnvOAPGbDULH+JuEx1XJcIFjvhW
         D9TxD8/OSKDxA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Devin Moore <devinmoore@google.com>
Subject: [PATCH v4 1/6] tools/bootconfig: Fix a build error accroding to undefined fallthrough
Date:   Wed,  2 Jun 2021 17:18:50 +0900
Message-Id: <162262192986.264090.4181938468540696580.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162262192121.264090.6540508908529705156.stgit@devnote2>
References: <162262192121.264090.6540508908529705156.stgit@devnote2>
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

