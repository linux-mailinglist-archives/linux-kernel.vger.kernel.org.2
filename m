Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C17B39EFF2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 09:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFHHyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 03:54:04 -0400
Received: from m32-153.88.com ([43.250.32.153]:32152 "EHLO email.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229512AbhFHHyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 03:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=From:To:Date; bh=obSUpHE3AQHJarDjc+mjGrHRBOYrDevXHI5sB
        95Wt0g=; b=IQ0nIIGwZtUElmgtqyEVJzmndmLe2l4QFcDlyOFuAi9lg4UESF5Zc
        rJXfytmZT1GUYHL1p2qWNslNvyRxzp/2T9H3ZVvrr4S7xERcSuVz1yx8yKqOkXcx
        3UpRKqgtJVXCpKed/3wVi6CMWra8az6caGLcSZP8nHpiihd1TxoEOw=
Received: from localhost.localdomain (unknown [113.251.8.115])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgBHHv2nIb9gqkMFAA--.19285S2;
        Tue, 08 Jun 2021 15:52:07 +0800 (CST)
From:   Hu Haowen <src.res@email.cn>
To:     alexs@kernel.org, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] docs/zh_CN: add a translation for index
Date:   Tue,  8 Jun 2021 15:52:07 +0800
Message-Id: <20210608075207.77812-1-src.res@email.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GiKnCgBHHv2nIb9gqkMFAA--.19285S2
X-Coremail-Antispam: 1UD129KBjvJXoWrZFWUuw1xJw1xXw45uryrXrb_yoW8Jr45pF
        nFkryxK3Z8A3W5Cr1vga47GF4UJ3Z7Ca13Gr4jqwnaqrs8A392grsxtr95ta4xXrWfAFZ8
        XF4SvFW8Ga4ay3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgmb7Iv0xC_tr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWUuVWrJwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2
        z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0x
        vYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_
        Cr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8Cw
        CF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26F4UJr1UMxC20s026xCaFVCjc4AY
        6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
        CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
        0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
        AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
        KfnxnUUI43ZEXa7IUUa9aPUUUUU==
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
index 1f953d3439a5..e0d51a167032 100644
--- a/Documentation/translations/zh_CN/index.rst
+++ b/Documentation/translations/zh_CN/index.rst
@@ -17,6 +17,11 @@
    **翻译计划:**
    内核中文文档欢迎任何翻译投稿，特别是关于内核用户和管理员指南部分。
 
+这是中文内核文档树的顶级目录。内核文档，就像内核本身一样，在很大程度上是一
+项正在进行的工作；当我们努力将许多分散的文件整合成一个连贯的整体时尤其如此。
+另外，随时欢迎您对内核文档进行改进；如果您想提供帮助，请加入vger.kernel.org
+上的linux-doc邮件列表。
+
 许可证文档
 ----------
 
-- 
2.25.1

