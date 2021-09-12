Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1057407E3B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 17:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbhILQAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 12:00:41 -0400
Received: from exmail.andestech.com ([60.248.187.195]:33700 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235850AbhILQAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 12:00:40 -0400
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id 18CFrdfQ066177;
        Sun, 12 Sep 2021 23:53:39 +0800 (GMT-8)
        (envelope-from ycliang@andestech.com)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id 18CFrNvJ066155;
        Sun, 12 Sep 2021 23:53:23 +0800 (GMT-8)
        (envelope-from ycliang@andestech.com)
Received: from ubuntu01.andestech.com (192.168.21.16) by
 ATCPCS16.andestech.com (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0;
 Sun, 12 Sep 2021 23:53:24 +0800
From:   Leo Yu-Chi Liang <ycliang@andestech.com>
To:     <corbet@lwn.net>, <src.res@email.cn>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-doc-tw-discuss@lists.sourceforge.net>
CC:     <ycliang@cs.nctu.edu.tw>, <ycliang@andestech.com>
Subject: [PATCH 2/2] docs/zh_TW: Add translation for riscv/vm-layout
Date:   Sun, 12 Sep 2021 15:53:19 +0000
Message-ID: <20210912155319.130461-1-ycliang@andestech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.21.16]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com 18CFrdfQ066177
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yu-Chi Liang <ycliang@cs.nctu.edu.tw>

Add Traditional Chinese for Documentation/riscv/vm-layout.rst

Signed-off-by: Leo Yu-Chi Liang <ycliang@cs.nctu.edu.tw>
---
 .../translations/zh_TW/riscv/vm-layout.rst    | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/translations/zh_TW/riscv/vm-layout.rst

diff --git a/Documentation/translations/zh_TW/riscv/vm-layout.rst b/Documentation/translations/zh_TW/riscv/vm-layout.rst
new file mode 100644
index 000000000000..628bba3f139d
--- /dev/null
+++ b/Documentation/translations/zh_TW/riscv/vm-layout.rst
@@ -0,0 +1,67 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_TW.rst
+
+:Original: Documentation/riscv/patch-acceptance.rst
+
+:譯者:
+
+  梁育齊 Liang YuChi <ycliang@cs.nctu.edu.tw>
+
+=============================
+RISC-V Linux 的虛擬記憶體佈局
+=============================
+
+:Author: Alexandre Ghiti <alex@ghiti.fr>
+:Date: 12 February 2021
+
+這份文件描述 RISC-V Linux 核心的虛擬記憶體佈局。
+
+32 位元 RISC-V Linux 核心
+=========================
+
+32 位元 RISC-V Linux 核心
+------------------------
+
+待完成
+
+64 位元 RISC-V Linux 核心
+=========================
+RISC-V 的特權架構文件描述 64 位元長度的位址
+"必須讓第 63-48 位都等於第 47 位，否則會發生分頁錯誤中斷。"
+而這表示有一個巨大的記憶體"孔洞"將虛擬記憶體空間分成兩半，
+下半部是使用者空間所在的位址，上半部則是 RISC-V Linux 核心所使用的位址。
+
+RISC-V Linux Kernel SV39
+------------------------
+
+::
+
+  ========================================================================================================================
+       起始位址     |   偏移量   |     終端位址     |  大小   | 虛擬記憶體區塊的描述
+  ========================================================================================================================
+                    |            |                  |         |
+   0000000000000000 |    0       | 0000003fffffffff |  256 GB | 使用者空間的虛擬記憶體，每個 mm 有各自的虛擬記憶體
+  __________________|____________|__________________|_________|___________________________________________________________
+                    |            |                  |         |
+   0000004000000000 | +256    GB | ffffffbfffffffff | ~16M TB | ... 非常大，大約是 64 位元寬的一塊非標準化的虛擬記憶體孔洞
+                    |            |                  |         |     ，從核心起始記憶體位址對映 -256 GB 偏移量的位址。
+  __________________|____________|__________________|_________|___________________________________________________________
+                                                              |
+                                                              | 核心空間的虛擬記憶體，被所有的程序所共享：
+  ____________________________________________________________|___________________________________________________________
+                    |            |                  |         |
+   ffffffc000000000 | -256    GB | ffffffc7ffffffff |   32 GB | kasan
+   ffffffcefee00000 | -196    GB | ffffffcefeffffff |    2 MB | fixmap
+   ffffffceff000000 | -196    GB | ffffffceffffffff |   16 MB | PCI io
+   ffffffcf00000000 | -196    GB | ffffffcfffffffff |    4 GB | vmemmap
+   ffffffd000000000 | -192    GB | ffffffdfffffffff |   64 GB | vmalloc/ioremap space
+   ffffffe000000000 | -128    GB | fffffffeffffffff |  124 GB | 所有實體記憶體的直接映射
+  __________________|____________|__________________|_________|____________________________________________________________
+                                                              |
+                                                              |
+  ____________________________________________________________|____________________________________________________________
+                    |            |                  |         |
+   ffffffff00000000 |   -4    GB | ffffffff7fffffff |    2 GB | 核心模組，BPF
+   ffffffff80000000 |   -2    GB | ffffffffffffffff |    2 GB | 核心
+  __________________|____________|__________________|_________|____________________________________________________________
-- 
2.25.1

