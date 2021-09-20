Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0E241155B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 15:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239230AbhITNQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 09:16:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239244AbhITNQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 09:16:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66E9F60F26;
        Mon, 20 Sep 2021 13:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632143721;
        bh=tDLzFfH6Yq/XVj4j/zz0dnMNwzyfSYQKvLBxZYD55Y4=;
        h=From:To:Cc:Subject:Date:From;
        b=XXWrqFQSBiRJtcifoRG22Om0R7HJS7GCokO2Zu7DEdXIyjQFmgjI/u44cAcxDYThz
         8wCIjA4bZwkbZga//uO0BCS21gK82EFzHhr05CfE3dHz7EvuSfWrhKRI6HlAyOfh9d
         4lKhj1ILwu9dUSCBNttF66/j4bMBr1S8qekWjyFEw5Oqz2U0SiVoHo+mMy4rFJs8xF
         L6YHsuf7dnTRNjD/PXoPdU4OMxl888PEnNRUQqhD1GVDJdJX8HWi1kV+ChlUpi+7he
         Gb3Fv7sL1OD9lBnNcOtFof4R0NhloEOj+n1PjE/8i5cU/X8S6mmLD6vQJipl+oT+LW
         D5I/JnBqnnYVA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [RFC] blk-iocost stringop-overread warning workaround
Date:   Mon, 20 Sep 2021 15:15:00 +0200
Message-Id: <20210920131516.2437790-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

In some randconfig builds with gcc-11, I get a warning from
the fortified string helpers:

In function 'memcpy',
    inlined from 'ioc_cost_model_write' at block/blk-iocost.c:3345:2:
include/linux/fortify-string.h:20:33: error: '__builtin_memcpy' reading 48 bytes from a region of size 0 [-Werror=stringop-overread]
   20 | #define __underlying_memcpy     __builtin_memcpy
      |                                 ^
include/linux/fortify-string.h:191:16: note: in expansion of macro '__underlying_memcpy'
  191 |         return __underlying_memcpy(p, q, size);
      |                ^~~~~~~~~~~~~~~~~~~

I don't see anything wrong in the code itself, so I suspect it's
gcc doing something weird again. The only way I could find to make
this warning go away is to hide the object using the RELOC_HIDE()
macro, but this is really ugly and I hope someone has a better
idea.

Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 block/blk-iocost.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index b3880e4ba22a..51f641840ed9 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3173,6 +3173,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 		ioc = q_to_ioc(bdev->bd_disk->queue);
 	}
 
+	ioc = RELOC_HIDE(ioc, 0);
 	spin_lock_irq(&ioc->lock);
 	memcpy(qos, ioc->params.qos, sizeof(qos));
 	enable = ioc->enabled;
@@ -3340,6 +3341,7 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 		ioc = q_to_ioc(bdev->bd_disk->queue);
 	}
 
+	ioc = RELOC_HIDE(ioc, 0);
 	spin_lock_irq(&ioc->lock);
 	memcpy(u, ioc->params.i_lcoefs, sizeof(u));
 	user = ioc->user_cost_model;
-- 
2.29.2

