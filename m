Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D567B419628
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 16:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbhI0OXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 10:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbhI0OXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:23:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298F0C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 07:22:06 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632752524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+PSZfJve0wnAY2vXm0/Xmq1ijbXytVRHE5Dl+T37nbI=;
        b=oxPBfFQ7m1lcUgahrGrit6DErtXaJaWR6H2bj14JFxNVNrqJZ8ta1qyaISgL5Wr4UQsEa0
        jSL9rsctpOSzQbQrfamaMB8lulcxmG4yZR/mrNspxY6Nlg2Rx8fV5DHxNxS/xtN12FwLPk
        dIN6hTOaYfH9O2x32sL00UUj3NgIMGyCx0kFUut41bFPLnQP1fMT7V+pGfWM2xYC3LbAKh
        h9EDskcOJTJQb8nELs0d8NxGEE3JPHuu30O7SFsQYr+BRPSxLkcHX7+Hml2tWs7N3RCDjS
        qeT6TsyTVAvgyYivVHqPBi+d5vxKspgJtGyoRrcx4KOkDeNHRfSH0+SC+GWWBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632752524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+PSZfJve0wnAY2vXm0/Xmq1ijbXytVRHE5Dl+T37nbI=;
        b=B0wGkm4IAZ3FVL9R8ITumzbWTAdEUAfqfJkVFglM8u6MXGOKM3G33IN011zmLm2ZJAoJiv
        npe5ki8SBiAkjiCg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH printk v1] printk: use gnu_printf format attribute for printk_sprint()
Date:   Mon, 27 Sep 2021 16:28:03 +0206
Message-Id: <20210927142203.124730-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following W=1 kernel build warning:

kernel/printk/printk.c: In function 'printk_sprint':
kernel/printk/printk.c:1913:9: warning: function 'printk_sprint' might be
a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 4d6dea5d7c1c..d617987f5785 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2066,6 +2066,7 @@ u16 printk_parse_prefix(const char *text, int *level,
 	return prefix_len;
 }
 
+__printf(5, 0)
 static u16 printk_sprint(char *text, u16 size, int facility,
 			 enum printk_info_flags *flags, const char *fmt,
 			 va_list args)

base-commit: 9980c4251f8ddfcf0617ed5724e4df5bd1f69c85
-- 
2.30.2

