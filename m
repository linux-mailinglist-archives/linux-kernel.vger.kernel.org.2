Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33DB398113
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 08:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhFBG0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 02:26:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231202AbhFBG0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 02:26:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C930460FDC;
        Wed,  2 Jun 2021 06:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622615075;
        bh=NIYhNZ3lq0gLH456sCAhQIBe2NS15yV6wh66f39yazQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cN0g2zXp0DLR2mCvTqSNGmNpClQhVfTF+uzqBFeOFcgGAwYcaGboTjd5wpuBpN3qM
         +rwrUR0HJ0Wo710y5YhWjPIbhPIPj6o9fT3Hcf/CLdHjj/qXcqeHwb6iC5MWv9ioDd
         G/G1iPlb9Pq3KwDC+Rqm3t8LIThGFQnbkRKCCwWCbq5X7+CvxJVSpp48WbznD7wl+f
         WyDeaNlZkh2+GZWoqzHfV4uEFTrP0dPiFJCoy684ZrACGAG1MaJwwU+e4vJwLYnF+j
         q9wPHKTqIYaLOP2WKGxPqpM5XL6/lWT5TwfJVyA9ASqBBPduVmatitUo8TwlGT8uvi
         UfvOQutF68lPw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Devin Moore <devinmoore@google.com>
Subject: [PATCH v3 1/6] tools/bootconfig: Fix a build error accroding to undefined fallthrough
Date:   Wed,  2 Jun 2021 15:24:31 +0900
Message-Id: <162261507163.255316.17455428633028156891.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162261506232.255316.12147562546699211199.stgit@devnote2>
References: <162261506232.255316.12147562546699211199.stgit@devnote2>
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

