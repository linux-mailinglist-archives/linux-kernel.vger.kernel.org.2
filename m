Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF8C3FD43A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 09:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242508AbhIAHKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 03:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242481AbhIAHKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 03:10:30 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E693FC061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 00:09:33 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:2193:279a:893d:20ae])
        by xavier.telenet-ops.be with bizsmtp
        id oX9X250041ZidPp01X9XkU; Wed, 01 Sep 2021 09:09:31 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mLKNG-0013Fi-OC; Wed, 01 Sep 2021 09:09:30 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mLKNG-002DXw-8E; Wed, 01 Sep 2021 09:09:30 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] init: Revert accidental changes to print irqs_disabled()
Date:   Wed,  1 Sep 2021 09:09:28 +0200
Message-Id: <20210901070928.528685-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f8ade8dddb167eec ("xsurf100: drop include of lib8390.c")
accidentally changed init/main.c.  Revert that part.

Fixes: f8ade8dddb167eec ("xsurf100: drop include of lib8390.c")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 init/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/init/main.c b/init/main.c
index daad6979f782216f..8d97aba78c3ad03d 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1226,7 +1226,7 @@ trace_initcall_start_cb(void *data, initcall_t fn)
 {
 	ktime_t *calltime = (ktime_t *)data;
 
-	printk(KERN_DEBUG "calling  %pS @ %i irqs_disabled() %d\n", fn, task_pid_nr(current), irqs_disabled());
+	printk(KERN_DEBUG "calling  %pS @ %i\n", fn, task_pid_nr(current));
 	*calltime = ktime_get();
 }
 
@@ -1240,8 +1240,8 @@ trace_initcall_finish_cb(void *data, initcall_t fn, int ret)
 	rettime = ktime_get();
 	delta = ktime_sub(rettime, *calltime);
 	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
-	printk(KERN_DEBUG "initcall %pS returned %d after %lld usecs, irqs_disabled() %d\n",
-		 fn, ret, duration, irqs_disabled());
+	printk(KERN_DEBUG "initcall %pS returned %d after %lld usecs\n",
+		 fn, ret, duration);
 }
 
 static ktime_t initcall_calltime;
-- 
2.25.1

