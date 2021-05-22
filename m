Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D6338D45B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 10:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhEVIDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 04:03:51 -0400
Received: from m32-153.88.com ([43.250.32.153]:33783 "EHLO email.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230000AbhEVIDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 04:03:50 -0400
X-Greylist: delayed 18355 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 May 2021 04:03:49 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=From:To:Date; bh=hmNgrgPBhr7LhurXuqhMudBbTKWzo/FsN2E5v
        l3sG/U=; b=MTVhAQI0tophUwrlDGiLkM6EMntqPCiAykvvHTFtlRR2uvoL2L/H3
        GA6fILesPpbwz78g2KHR0J8ZGKae8T8jth7GOGjDRB+7lndxqounwRwDa2V6EJ7d
        zLyHtrStooSQoRxAExNZU0uTAzgzjmqp2MWHpV+fFV49pdI0O1xDx8=
Received: from localhost.localdomain (unknown [113.251.13.109])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgDXJViIuqhg13hBAA--.9385S2;
        Sat, 22 May 2021 16:02:17 +0800 (CST)
From:   Hu Haowen <src.res@email.cn>
To:     alexs@kernel.org, corbet@lwn.net, siyanteng@loongson.cn,
        bobwxc@email.cn, jaixun.yang@flygoat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hu Haowen <src.res@email.cn>
Subject: [PATCH] docs/zh_CN: Add Chinese translations for new contents
Date:   Sat, 22 May 2021 16:02:14 +0800
Message-Id: <20210522080214.88050-1-src.res@email.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GiKnCgDXJViIuqhg13hBAA--.9385S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1rZr4kKw1fKr15Xw1kKrg_yoW8AF4fp3
        Wa9r9rKanrCrnFvrn7KryUZF15CFWxua4UJ3s7ZF95ZF1rAryvyFsrKryrWr95Wry8ta4r
        tFsxtryDXrWjywUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgE1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Jr0_Jr4l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26F4UJr1UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67
        AK6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Cr1UJr1l4I8I3I0E4IkC
        6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
        C2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_
        JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
        WUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
        CTnIWIevJa73UjIFyTuYvjfUxZjjDUUUU
X-Originating-IP: [113.251.13.109]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A document updated in commit 1c31f0b67cfa6d4cd41d ("module: add printk
formats to add module build ID to stacktraces"), hence add Chinese
translations for it.

Signed-off-by: Hu Haowen <src.res@email.cn>
---
 .../translations/zh_CN/core-api/printk-formats.rst       | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/translations/zh_CN/core-api/printk-formats.rst b/Documentation/translations/zh_CN/core-api/printk-formats.rst
index 624a090e6ee5..116abc046bfe 100644
--- a/Documentation/translations/zh_CN/core-api/printk-formats.rst
+++ b/Documentation/translations/zh_CN/core-api/printk-formats.rst
@@ -122,6 +122,15 @@ seq_printf()，而不是printk()）由用户空间进程读取，使用下面描
 ``B`` 占位符的结果是带有偏移量的符号名，在打印堆栈回溯时应该使用。占位符将考虑编译器优化
 的影响，当使用尾部调用并使用noreturn GCC属性标记时，可能会发生这种优化。
 
+如果占位符是在一个模块之中，可在占位符末尾添加 ``b`` 以在符号名后打印模块名称和可选构建ID。
+
+::
+        %pS     versatile_init+0x0/0x110 [module_name]
+        %pSb    versatile_init+0x0/0x110 [module_name ed5019fdf5e53be37cb1ba7899292d7e143b259e]
+        %pSRb   versatile_init+0x9/0x110 [module_name ed5019fdf5e53be37cb1ba7899292d7e143b259e]
+                (with __builtin_extract_return_addr() translation)
+        %pBb    prev_fn_of_versatile_init+0x88/0x88 [module_name ed5019fdf5e53be37cb1ba7899292d7e143b259e]
+
 来自BPF / tracing追踪的探查指针
 ----------------------------------
 
-- 
2.25.1

