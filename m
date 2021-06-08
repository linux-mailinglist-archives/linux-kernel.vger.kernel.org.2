Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B01A39ED2D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 05:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhFHDzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 23:55:22 -0400
Received: from m32-153.88.com ([43.250.32.153]:9664 "EHLO email.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230261AbhFHDzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 23:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=From:To:Date; bh=NlWT4yL/LK+JimZ7Sa7wYhg6k/kls9whN7r2S
        r3psFI=; b=WClRMC3WNJaep2GVNej3MbH0Mur8fDsHOFgpGD0jVeYU8BZZKsJVx
        Po71KmbUfgfd6JV6+DLZrgA2F6m/tb2OgQle8szwDBIeDQXfA8vf1YNFtwp7QOj3
        0ZfxOycCTfisNQ7Ypml0HhIyJtmHjk6NrkanQrsNIMlfkUXAWuUwpA=
Received: from localhost.localdomain (unknown [113.251.8.115])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgD3zfyz6b5g0uMEAA--.17697S2;
        Tue, 08 Jun 2021 11:53:24 +0800 (CST)
From:   Hu Haowen <src.res@email.cn>
To:     bobwxc@email.cn, alexs@kernel.org, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] docs/zh_CN: add a translation for index
Date:   Tue,  8 Jun 2021 11:53:23 +0800
Message-Id: <20210608035323.63728-1-src.res@email.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GiKnCgD3zfyz6b5g0uMEAA--.17697S2
X-Coremail-Antispam: 1UD129KBjvJXoWrZFWUuw1xJw1xXw45tFW7XFb_yoW8JF1kpF
        nrKryxK3Z5A3W3Cr92ga47WF4UJ3Z7Ca13GrW2qwnagrs8A39Fgrsxtr9Yqa4xXrWfAa98
        JF4a9FWrGa4ayrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgE1xkIjI8I6I8E6xAIw20EY4v20xvaj40_JFC_Wr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26F4UJr1UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67
        AK6r48MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Cr1UJr1l4I8I3I0E4IkC
        6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
        C2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_
        JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
        WUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
        CTnIWIevJa73UjIFyTuYvjfUxIJPDUUUU
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
 Documentation/translations/zh_CN/index.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
index 1f953d3439a5..cb8595c0364c 100644
--- a/Documentation/translations/zh_CN/index.rst
+++ b/Documentation/translations/zh_CN/index.rst
@@ -17,6 +17,13 @@
    **翻译计划:**
    内核中文文档欢迎任何翻译投稿，特别是关于内核用户和管理员指南部分。
 
+这是中文内核文档树的顶级目录。内核文档，就像内核本身一样，在很大程度上是一
+项正在进行的工作；当我们努力将许多分散的文件整合成一个连贯的整体时尤其如此。
+另外，随时欢迎您对内核文档进行改进；如果您想提供帮助，请加入vger.kernel.org
+上的linux-doc邮件列表。
+
+.. include:: ./disclaimer-zh_CN.rst
+
 许可证文档
 ----------
 
-- 
2.25.1

