Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C82407E37
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 17:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbhILQA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 12:00:28 -0400
Received: from exmail.andestech.com ([60.248.187.195]:44369 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbhILQAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 12:00:22 -0400
X-Greylist: delayed 453 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Sep 2021 12:00:21 EDT
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id 18CFpVxs066046;
        Sun, 12 Sep 2021 23:51:31 +0800 (GMT-8)
        (envelope-from ycliang@andestech.com)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id 18CFoth5065966;
        Sun, 12 Sep 2021 23:50:55 +0800 (GMT-8)
        (envelope-from ycliang@andestech.com)
Received: from ubuntu01.andestech.com (192.168.21.16) by
 ATCPCS16.andestech.com (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0;
 Sun, 12 Sep 2021 23:50:57 +0800
From:   Leo Yu-Chi Liang <ycliang@andestech.com>
To:     <corbet@lwn.net>, <src.res@email.cn>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-doc-tw-discuss@lists.sourceforge.net>
CC:     <ycliang@cs.nctu.edu.tw>, <ycliang@andestech.com>
Subject: [PATCH 1/1] docs/zh_TW: Add translation for riscv/boot-image-header
Date:   Sun, 12 Sep 2021 15:50:49 +0000
Message-ID: <20210912155049.129774-1-ycliang@andestech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.21.16]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com 18CFpVxs066046
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yu-Chi Liang <ycliang@cs.nctu.edu.tw>

Add Traditional Chinese for Documentation/riscv/boot-image-header.rst

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 .../zh_TW/riscv/boot-image-header.rst         | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/translations/zh_TW/riscv/boot-image-header.rst

diff --git a/Documentation/translations/zh_TW/riscv/boot-image-header.rst b/Documentation/translations/zh_TW/riscv/boot-image-header.rst
new file mode 100644
index 000000000000..86519d3c4f3b
--- /dev/null
+++ b/Documentation/translations/zh_TW/riscv/boot-image-header.rst
@@ -0,0 +1,67 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_TW.rst
+
+:Original: Documentation/riscv/patch-acceptance.rst
+
+:譯者:
+
+ 梁育齊 Liang YuChi <ycliang@cs.nctu.edu.tw>
+
+=============================
+RISC-V Linux 的啟動影像檔標頭
+=============================
+
+:Author: Atish Patra <atish.patra@wdc.com>
+:Date:   20 May 2019
+
+這份文件僅描述 RISC-V Linux 啟動影像檔標頭的詳細訊息。
+
+待完成:
+    寫一份完整的啟動流程指南。
+    
+解壓縮後的 Linux 核心影像檔中會含有以下 64 位元組的標頭::
+
+        u32 code0;                /* 可執行程式碼 */
+        u32 code1;                /* 可執行程式碼 */
+        u64 text_offset;          /* 載入影像的偏移量  */
+        u64 image_size;           /* 有效影像大小，小端序 */
+        u64 flags;                /* 核心旗標，小端序 */
+        u32 version;              /* 標頭版本 */
+        u32 res1 = 0;             /* 保留 */
+        u64 res2 = 0;             /* 保留 */
+        u64 magic = 0x5643534952; /* 魔術數字，小端序，"RISCV" */
+        u32 magic2 = 0x05435352;  /* 魔術數字 2，小端序，"RSC\x05" */
+        u32 res3;                 /* 保留 PE COFF 的偏移量 */
+
+這種標頭格式是深受 ARM64 標頭的影響並且相容於 PE/COFF 標頭。
+因此，將來可以將 ARM64 和 RISC-V 標頭合併為一個通用標頭。
+
+註
+==
+- 將來，這個標頭還可用來支援 RISC-V 的 EFI 模擬實作。 
+  EFI 規範需要核心影像開頭的 PE/COFF 影像標頭，以便將其視作 EFI 應用程式來運行。
+  為了支援 EFI 模擬，code0 應替換為 "MZ" 魔術字串，res3（偏移量 0x3c）應指向 PE/COFF 標頭的其餘部分。
+
+- 版本欄位標示的是版本號
+
+        ==========  ======
+        位元 0:15   小版號
+        位元 16:31  大版號
+        ==========  ======
+
+   這樣可以保證新、舊版本間的相容性。
+   目前的版本被定義為 0.2。
+
+- 自 0.2 版後，"magic" 欄位已不適用。
+  在未來的版本中，它可能會被刪除。
+  這本來應該和 ARM64 標頭 "magic" 欄位相符，但不幸的是沒有。 
+  "magic 2" 欄位是用來替換 "magic" 的，並且與 ARM64 標頭相符。
+
+- 在目前的標頭中，旗標欄位僅只有一個欄位。
+
+        ======  ===================================================
+        位元 0  核心的位元組順序。 小端序，則為 1；大端序，則為 0。
+        ======  ===================================================
+
+- 啟動載入程式會需要核心影像檔案的大小資訊，否則啟動程序將會失敗。
-- 
2.25.1

