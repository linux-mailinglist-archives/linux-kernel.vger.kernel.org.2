Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7894B446FEF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 19:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbhKFS6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 14:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhKFS6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 14:58:40 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27ACCC061570
        for <linux-kernel@vger.kernel.org>; Sat,  6 Nov 2021 11:55:55 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:91c6:551:e507:741f])
        by andre.telenet-ops.be with bizsmtp
        id F6vr2600C4BJ5g4016vrgE; Sat, 06 Nov 2021 19:55:54 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mjQr1-00AdOS-Fg; Sat, 06 Nov 2021 19:55:51 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mjQr0-006cdY-Si; Sat, 06 Nov 2021 19:55:50 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Jens Axboe <axboe@kernel.dk>, Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        noreply@ellerman.id.au
Subject: [PATCH -next] ataflop: Add missing semicolon to return statement
Date:   Sat,  6 Nov 2021 19:55:49 +0100
Message-Id: <20211106185549.1578444-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    drivers/block/ataflop.c: In function ‘ataflop_probe’:
    drivers/block/ataflop.c:2023:2: error: expected expression before ‘if’
     2023 |  if (ataflop_alloc_disk(drive, type))
	  |  ^~
    drivers/block/ataflop.c:2023:2: error: ‘return’ with a value, in function returning void [-Werror=return-type]
    drivers/block/ataflop.c:2011:13: note: declared here
     2011 | static void ataflop_probe(dev_t dev)
	  |             ^~~~~~~~~~~~~

Fixes: 46a7db492e7a2740 ("ataflop: address add_disk() error handling on probe")
Reported-by: noreply@ellerman.id.au
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Feel free to fold into the commit that introduced the issue.
---
 drivers/block/ataflop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index de8c3785899a5de3..bf769e6e32fef92b 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -2019,7 +2019,7 @@ static void ataflop_probe(dev_t dev)
 	if (drive >= FD_MAX_UNITS || type >= NUM_DISK_MINORS)
 		return;
 	if (unit[drive].disk[type])
-		return
+		return;
 	if (ataflop_alloc_disk(drive, type))
 		return;
 	if (add_disk(unit[drive].disk[type]))
-- 
2.25.1

