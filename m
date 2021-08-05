Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806873E15AD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 15:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238796AbhHENaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 09:30:46 -0400
Received: from mail.loongson.cn ([114.242.206.163]:45928 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232442AbhHENao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 09:30:44 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxL0Dw5wthzHIrAA--.32320S2;
        Thu, 05 Aug 2021 21:30:25 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: Kconfig: clean up config options about compression
Date:   Thu,  5 Aug 2021 21:30:24 +0800
Message-Id: <1628170224-13239-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9DxL0Dw5wthzHIrAA--.32320S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uryrAFW5XF4UKFyxJr1fWFg_yoW8ZFyrpw
        sYgry8GrZ3WF15KanYgrn8Kr47JryFga1UJr43Jw1UArWrGrn7WF95tFs5ZayUZFZxXFZ8
        uws0grW5Wr4avFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk2b7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6ry8MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
        IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUsUUUUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In fs/f2fs/Kconfig, F2FS_FS_LZ4HC depends on F2FS_FS_LZ4 and F2FS_FS_LZ4
depends on F2FS_FS_COMPRESSION, so no need to make F2FS_FS_LZ4HC depends
on F2FS_FS_COMPRESSION explicitly, remove the redudant "depends on", do
the similar thing for F2FS_FS_LZORLE.

At the same time, it is better to move F2FS_FS_LZORLE next to F2FS_FS_LZO,
it looks like a little more clear when make menuconfig, the location of
"LZO-RLE compression support" is under "LZO compression support" instead
of "F2FS compression feature".

Without this patch:

F2FS compression feature
  LZO compression support
  LZ4 compression support
    LZ4HC compression support
  ZSTD compression support
  LZO-RLE compression support

With this patch:

F2FS compression feature
  LZO compression support
    LZO-RLE compression support
  LZ4 compression support
    LZ4HC compression support
  ZSTD compression support

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 fs/f2fs/Kconfig | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
index 7669de7..2ac026f 100644
--- a/fs/f2fs/Kconfig
+++ b/fs/f2fs/Kconfig
@@ -105,6 +105,13 @@ config F2FS_FS_LZO
 	help
 	  Support LZO compress algorithm, if unsure, say Y.
 
+config F2FS_FS_LZORLE
+	bool "LZO-RLE compression support"
+	depends on F2FS_FS_LZO
+	default y
+	help
+	  Support LZO-RLE compress algorithm, if unsure, say Y.
+
 config F2FS_FS_LZ4
 	bool "LZ4 compression support"
 	depends on F2FS_FS_COMPRESSION
@@ -114,7 +121,6 @@ config F2FS_FS_LZ4
 
 config F2FS_FS_LZ4HC
 	bool "LZ4HC compression support"
-	depends on F2FS_FS_COMPRESSION
 	depends on F2FS_FS_LZ4
 	default y
 	help
@@ -127,11 +133,3 @@ config F2FS_FS_ZSTD
 	default y
 	help
 	  Support ZSTD compress algorithm, if unsure, say Y.
-
-config F2FS_FS_LZORLE
-	bool "LZO-RLE compression support"
-	depends on F2FS_FS_COMPRESSION
-	depends on F2FS_FS_LZO
-	default y
-	help
-	  Support LZO-RLE compress algorithm, if unsure, say Y.
-- 
2.1.0

