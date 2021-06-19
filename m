Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E749F3ADADB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 18:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbhFSQYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 12:24:55 -0400
Received: from [43.250.32.171] ([43.250.32.171]:45213 "EHLO email.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S232640AbhFSQYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 12:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=From:To:Date; bh=GKlF5EB7mGKaD81zQzs2lJshK1lmZDvSaejdz
        KZHWQw=; b=j36DGc4bRuRL3t9UyhVzad/Zgb04ItD/fQgPJ+30iDh/60nGkhlQv
        mC0OYlLnHYQxyGbeHGNhZHFraNOeMzU1F1/GSuD/43afGOSbVpItLjj92TaMsRYA
        azEOYObC6oyV4c2j3rEloz+FDdPceu/IR+3+UUW5jxVbr3HB3jQoCE=
Received: from localhost.localdomain (unknown [113.251.9.208])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgA30jXPGc5gjs8ZAA--.42881S2;
        Sun, 20 Jun 2021 00:22:39 +0800 (CST)
From:   Hu Haowen <src.res@email.cn>
To:     alexs@kernel.org, corbet@lwn.net
Cc:     bobwxc@email.cn, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs/zh_CN: add a missing space character
Date:   Sun, 20 Jun 2021 00:22:38 +0800
Message-Id: <20210619162238.12665-1-src.res@email.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LCKnCgA30jXPGc5gjs8ZAA--.42881S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw4rtr4UXr4DtFyfZr1kZrb_yoW8GF4rp3
        y29r97Ka48Cw1Y93yxGr4IgFWfGF97uay7GFnFy34qgr1kCw1vvrZrKryDKr9xWryrZayU
        Zr40kFy3WryIvFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgm1xkIjI8I6I8E6xAIw20EY4v20xvaj40_JFC_Wr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28E
        F7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
        xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26F4UJr1UMcvjeVCFs4IE7xkEbVWU
        JVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r
        1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VWxJr1UJwCFx2IqxVCFs4IE7xkE
        bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
        AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
        42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
        IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
        KfnxnUUI43ZEXa7VU86Hq7UUUUU==
X-Originating-IP: [113.251.9.208]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"LinusTorvalds" is not pretty. Replace it with "Linus Torvalds".

Signed-off-by: Hu Haowen <src.res@email.cn>
---
 Documentation/translations/zh_CN/process/2.Process.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/process/2.Process.rst b/Documentation/translations/zh_CN/process/2.Process.rst
index 229629e305ca..0e69737e9889 100644
--- a/Documentation/translations/zh_CN/process/2.Process.rst
+++ b/Documentation/translations/zh_CN/process/2.Process.rst
@@ -47,7 +47,7 @@
 （顺便说一句，值得注意的是，合并窗口期间集成的更改并不是凭空产生的；它们是经
 提前收集、测试和分级的。稍后将详细描述该过程的工作方式。）
 
-合并窗口持续大约两周。在这段时间结束时，LinusTorvalds将声明窗口已关闭，并
+合并窗口持续大约两周。在这段时间结束时，Linus Torvalds将声明窗口已关闭，并
 释放第一个“rc”内核。例如，对于目标为5.6的内核，在合并窗口结束时发生的释放
 将被称为5.6-rc1。-rc1 版本是一个信号，表示合并新特性的时间已经过去，稳定下一
 个内核的时间已经到来。
-- 
2.25.1

