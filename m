Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2721E3E3206
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 01:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244612AbhHFXGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 19:06:33 -0400
Received: from mx.aristanetworks.com ([162.210.129.12]:44314 "EHLO
        smtp.aristanetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhHFXGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 19:06:32 -0400
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Aug 2021 19:06:32 EDT
Received: from chmeee (unknown [10.95.67.60])
        by smtp.aristanetworks.com (Postfix) with ESMTPS id CF8BE403117;
        Fri,  6 Aug 2021 16:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1628290811;
        bh=tTVi5osPfnzULsaNftV23QWiBHXTin4W8NqEHYDV3+8=;
        h=From:To:Cc:Subject:Date:From;
        b=U44C4xv/Gh0BmLgml+GE6fAZxfxaGv0vDNJOzCHgHwCwl3n2Z8K62XG0Ny87QRtQZ
         qnYIGO7wNNo5ggYRVYhekdCSzIg3BMe3d863dou+ede1+Zk975KM6aXLqBfGhq68Z0
         ijj03XPqyiu3TepnyUab9/gZdrCwo05LtCBEIwX//kBfToh3dE7x6QMgOH9iFPphT7
         EzrybWmmzCoLiCsPA6X0ehxRb7OwMjDTCgX87qy+4LLlTV6TOMTWsLiZvooahrxizT
         iV+psAAz33QKSa2kd/iMWKjj/geWiUZ1sCzgq8LLf4Qu8KZOj67hPDqwtB5tOZO+wd
         D93A4u8hGn/yA==
Received: from kevmitch by chmeee with local (Exim 4.94.2)
        (envelope-from <kevmitch@chmeee>)
        id 1mC8p0-001kfX-7A; Fri, 06 Aug 2021 16:00:10 -0700
From:   Kevin Mitchell <kevmitch@arista.com>
Cc:     Kevin Mitchell <kevmitch@arista.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lkdtm: move SCSI_DISPATCH_CMD to scsi_queue_rq
Date:   Fri,  6 Aug 2021 15:59:05 -0700
Message-Id: <20210806225905.417649-1-kevmitch@arista.com>
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When scsi_dispatch_cmd was moved to scsi_lib.c and made static, some
compilers (i.e., at least gcc 8.4.0) decided to compile this
inline. This is a problem for lkdtm.ko, which needs to insert a kprobe
on this function for the SCSI_DISPATCH_CMD crashpoint.

Move this crashpoint one function up the call chain to
scsi_queue_rq. Though this is also a static function, it should never be
inlined because it is assigned as a structure entry. Therefore,
kprobe_register should always be able to find it. Since there is already
precedent for crashpoint names not exactly matching their probed
functions, keep the name of the crashpoint the same for backwards
compatibility.

Fixes: 82042a2cdb55 ("scsi: move scsi_dispatch_cmd to scsi_lib.c")
Signed-off-by: Kevin Mitchell <kevmitch@arista.com>
---
 drivers/misc/lkdtm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index 97803f213..2612f214d 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -81,7 +81,7 @@ static struct crashpoint crashpoints[] = {
 	CRASHPOINT("FS_DEVRW",		 "ll_rw_block"),
 	CRASHPOINT("MEM_SWAPOUT",	 "shrink_inactive_list"),
 	CRASHPOINT("TIMERADD",		 "hrtimer_start"),
-	CRASHPOINT("SCSI_DISPATCH_CMD",	 "scsi_dispatch_cmd"),
+	CRASHPOINT("SCSI_DISPATCH_CMD",	 "scsi_queue_rq"),
 	CRASHPOINT("IDE_CORE_CP",	 "generic_ide_ioctl"),
 #endif
 };
-- 
2.32.0

