Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705FA3ADC38
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 03:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhFTBHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 21:07:00 -0400
Received: from [43.250.32.171] ([43.250.32.171]:25290 "EHLO email.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S229591AbhFTBG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 21:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=From:To:Date; bh=KtH/dvBs0L7AQkPMCxghEPlRbnXcCTRIcdfcS
        L6B7S0=; b=DdRQnMbc5Guy6UBf5zy2kcrQwnTFYsAfsfjatLZe2zhg7goOWKj7z
        8G5cJsg3IvtcOUAzapAyNwRtH4TiV+KFw49YdoO/gqjwxOPc/shGfA7qIXNz+soV
        3HeyHOxZy3fR0yRKuQvq/BO9lrnqblGte1kDIV70fFUhVvMG2ZmALQ=
Received: from localhost.localdomain (unknown [113.251.9.208])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgA30jUslM5gcn4aAA--.45760S2;
        Sun, 20 Jun 2021 09:04:45 +0800 (CST)
From:   Hu Haowen <src.res@email.cn>
To:     alexs@kernel.org, corbet@lwn.net
Cc:     bobwxc@email.cn, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] docs/zh_CN: add a missing space character
Date:   Sun, 20 Jun 2021 09:04:44 +0800
Message-Id: <20210620010444.24813-1-src.res@email.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LCKnCgA30jUslM5gcn4aAA--.45760S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1ktFW3tFWkKFW8Wr1fCrg_yoW8tr43pa
        y29F93Ka48Cwn09rWfKr48WFWfJas7Cay7GFn7A3srWr1vkrWDZry3Kry5Kry3WryxAayk
        XF40kFy3C34Iv3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgK1xkIjI8I6I8E6xAIw20EY4v20xvaj40_JFC_Wr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26F4UJr1UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67
        AK6w4l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VWxJr1UJwCFx2IqxVCFs4IE
        7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
        8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
        CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
        1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
        daVFxhVjvjDU0xZFpf9x0JjaKZXUUUUU=
X-Originating-IP: [113.251.9.208]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"LinusTorvalds" is not pretty. Replace it with "Linus Torvalds".

Signed-off-by: Hu Haowen <src.res@email.cn>
---
 Documentation/translations/zh_CN/process/2.Process.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/translations/zh_CN/process/2.Process.rst b/Documentation/translations/zh_CN/process/2.Process.rst
index 229629e305ca..4a6ed0219494 100644
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
@@ -168,7 +168,7 @@ Greg Kroah-Hartman领导。稳定团队将使用5.x.y编号方案不定期地发
 补丁如何进入内核
 ----------------
 
-只有一个人可以将补丁合并到主线内核存储库中：LinusTorvalds。但是，在进入
+只有一个人可以将补丁合并到主线内核存储库中：Linus Torvalds。但是，在进入
 2.6.38内核的9500多个补丁中，只有112个（大约1.3%）是由Linus自己直接选择的。
 内核项目已经发展到一个没有一个开发人员可以在没有支持的情况下检查和选择每个
 补丁的规模。内核开发人员处理这种增长的方式是使用围绕信任链构建的助理系统。
-- 
2.25.1

