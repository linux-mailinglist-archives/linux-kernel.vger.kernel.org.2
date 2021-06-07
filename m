Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2010639D8F1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbhFGJiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 05:38:12 -0400
Received: from m34-101.88.com ([104.250.34.101]:52587 "EHLO 88.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230284AbhFGJiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=From:To:Date; bh=l0wKGJ2zoLHVTembanf89c4h1niJUqu/rSL9m
        cX+JDs=; b=FziX+dKlf7MSocefDSXQBjxiTIPXj/8jvT3rpe9258mW0KBPataKk
        xOlx0JrmfkSs4twaMCmweJX6SHe++Y6YJHl+xp+ambS8XzAnnKyKvoZJi1mDZCy1
        TncPJgDMlGCPYOjOslqwip1rVSEFferQQmhS/Xx5eDFkizfKli8rno=
Received: from localhost.localdomain (unknown [113.251.8.115])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgCnQzcs6L1gZe0CAA--.10613S2;
        Mon, 07 Jun 2021 17:34:37 +0800 (CST)
From:   Hu Haowen <src.res@email.cn>
To:     alexs@kernel.org, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hu Haowen <src.res@email.cn>
Subject: [PATCH] docs/zh_CN: add a translation for index
Date:   Mon,  7 Jun 2021 17:34:33 +0800
Message-Id: <20210607093433.39160-1-src.res@email.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LCKnCgCnQzcs6L1gZe0CAA--.10613S2
X-Coremail-Antispam: 1UD129KBjvJXoWrZFWUuw1xJw1xXw45uryrXrb_yoW8Jr13pF
        1qkryxK3Z8Aw15Cr1vga47GF4UJ3Z7Ga13GrWjqwnaqrs8ArZ2grsxtr95ta4xXrWfJF98
        XF4SvrWkGa4aywUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgK1xkIjI8I6I8E6xAIw20EY4v20xvaj40_JFC_Wr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26F4UJr1UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67
        AK6r4fMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Cr1UJr1l4I8I3I0E4IkC
        6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
        C2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_
        JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
        WUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBI
        daVFxhVjvjDU0xZFpf9x0Jj46wZUUUUU=
X-Originating-IP: [113.251.8.115]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original file has added a former intro in commit b51208d41c6a4e7fc2f0
("docs: Tweak the top-level Sphinx page") and hence update the Chinese
version for it.

Signed-off-by: Hu Haowen <src.res@email.cn>
---
 Documentation/translations/zh_CN/index.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
index 1f953d3439a5..003126abc0d6 100644
--- a/Documentation/translations/zh_CN/index.rst
+++ b/Documentation/translations/zh_CN/index.rst
@@ -17,6 +17,11 @@
    **翻译计划:**
    内核中文文档欢迎任何翻译投稿，特别是关于内核用户和管理员指南部分。
 
+这是内核文档树的顶级目录。内核文档，就像内核本身一样，在很大程度上是一项正
+在进行的工作；当我们努力将许多分散的文件整合成一个连贯的整体时尤其如此。另
+外，随时欢迎您对内核文档进行改进；如果您想提供帮助，请加入vger.kernel.org
+上的linux-doc邮件列表。
+
 许可证文档
 ----------
 
-- 
2.25.1

