Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F283B70CD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 12:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbhF2Kjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 06:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhF2Kje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 06:39:34 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39959C061574
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 03:37:06 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:7d95:f75f:5ece:4663])
        by andre.telenet-ops.be with bizsmtp
        id Nyd22500E4F6zkK01yd2d6; Tue, 29 Jun 2021 12:37:02 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lyB6z-004qjN-Qv; Tue, 29 Jun 2021 12:37:01 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lyB6z-0087TX-Cy; Tue, 29 Jun 2021 12:37:01 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] pstore/blk: Use "%lu" to format unsigned long
Date:   Tue, 29 Jun 2021 12:37:00 +0200
Message-Id: <20210629103700.1935012-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 32-bit:

    fs/pstore/blk.c: In function ‘__best_effort_init’:
    include/linux/kern_levels.h:5:18: warning: format ‘%zu’ expects argument of type ‘size_t’, but argument 3 has type ‘long unsigned int’ [-Wformat=]
	5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
	  |                  ^~~~~~
    include/linux/kern_levels.h:14:19: note: in expansion of macro ‘KERN_SOH’
       14 | #define KERN_INFO KERN_SOH "6" /* informational */
	  |                   ^~~~~~~~
    include/linux/printk.h:373:9: note: in expansion of macro ‘KERN_INFO’
      373 |  printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
	  |         ^~~~~~~~~
    fs/pstore/blk.c:314:3: note: in expansion of macro ‘pr_info’
      314 |   pr_info("attached %s (%zu) (no dedicated panic_write!)\n",
	  |   ^~~~~~~

Fixes: 7bb9557b48fcabaa ("pstore/blk: Use the normal block device I/O path")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 fs/pstore/blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index 04ce58c939a0ba15..6093088de49fd161 100644
--- a/fs/pstore/blk.c
+++ b/fs/pstore/blk.c
@@ -311,7 +311,7 @@ static int __init __best_effort_init(void)
 	if (ret)
 		kfree(best_effort_dev);
 	else
-		pr_info("attached %s (%zu) (no dedicated panic_write!)\n",
+		pr_info("attached %s (%lu) (no dedicated panic_write!)\n",
 			blkdev, best_effort_dev->zone.total_size);
 
 	return ret;
-- 
2.25.1

