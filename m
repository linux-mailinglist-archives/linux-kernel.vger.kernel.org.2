Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299D63D3468
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 08:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbhGWFXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 01:23:23 -0400
Received: from m32-153.88.com ([43.250.32.153]:32951 "EHLO email.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233845AbhGWFXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 01:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=From:To:Date; bh=5lPj+a2pbsHvRn+Mac/RbixboMLKIuDU1ETpc
        1PjGe4=; b=kpFzOJnKpmlicHEKHz7S+zk5O6LDUUXa6uND38EYTE4pPavPguZIx
        hxtOTJIPC9xzhmQ4ObU+btKOLqcsfllQ7T4ouNNxwlOr2FzsRYZpY71GriO4+CmX
        7PW8YPIepUlHebDf4oXyyNlLM7b2Fi1wLhsEEpd/PFRrdRh0my8i50=
Received: from localhost.localdomain (unknown [119.103.21.236])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgA3t6fAW_pgBXQCAA--.9292S2;
        Fri, 23 Jul 2021 14:03:45 +0800 (CST)
From:   Hu Haowen <src.res@email.cn>
To:     alexs@kernel.org, corbet@lwn.net
Cc:     bobwxc@email.cn, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs/zh_CN: reformat zh_CN/dev-tools/testing-overview
Date:   Fri, 23 Jul 2021 14:03:28 +0800
Message-Id: <20210723060328.16581-1-src.res@email.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GiKnCgA3t6fAW_pgBXQCAA--.9292S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF4DurWfXw4kJw4xWF1fXrb_yoW8KFy7pr
        4vkr92q3W8C345A3yI9FyUtF4jkr97Gw4UKa1xt347AryqkrsYkrZrtF90qFW3CryIvF98
        ZF4rGFWq9340y3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgj1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2
        z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc
        02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_Cr1UJr1lOx8S6xCaFVCjc4AY
        6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x
        0EwIxGrwCF04k20xvE74AGY7Cv6cx26F4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I
        3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxV
        WUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8I
        cVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
        AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuY
        vjfUsvtCUUUUU
X-Originating-IP: [119.103.21.236]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorganise several long lines in order to satisfy the kernel coding
style.

Signed-off-by: Hu Haowen <src.res@email.cn>
---
 .../zh_CN/dev-tools/testing-overview.rst          | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/translations/zh_CN/dev-tools/testing-overview.rst b/Documentation/translations/zh_CN/dev-tools/testing-overview.rst
index 8206d5b477e2..b7a1d13da6c6 100644
--- a/Documentation/translations/zh_CN/dev-tools/testing-overview.rst
+++ b/Documentation/translations/zh_CN/dev-tools/testing-overview.rst
@@ -70,13 +70,14 @@ kselftest也因此非常适合于全部功能的测试，因为这些功能会
 确切函数或代码行。这有助于决定内核被测试了多少，或用来查找合适的测试
 中没有覆盖到的极端情况。
 
-Documentation/translations/zh_CN/dev-tools/gcov.rst 是GCC的覆盖率测试工具，能用于获取内核的全局或每个模块的
-覆盖率。与KCOV不同的是，这个工具不记录每个任务的覆盖率。覆盖率数据可
-以通过debugfs读取，并通过常规的gcov工具进行解释。
-
-Documentation/dev-tools/kcov.rst 是能够构建在内核之中，用于在每个任务的层面捕捉覆盖率的一
-个功能。因此，它对于模糊测试和关于代码执行期间信息的其它情况非常有用，
-比如在一个单一系统调用里使用它就很有用。
+Documentation/translations/zh_CN/dev-tools/gcov.rst 是GCC的覆盖率测试
+工具，能用于获取内核的全局或每个模块的覆盖率。与KCOV不同的是，这个工具
+不记录每个任务的覆盖率。覆盖率数据可以通过debugfs读取，并通过常规的
+gcov工具进行解释。
+
+Documentation/dev-tools/kcov.rst 是能够构建在内核之中，用于在每个任务
+的层面捕捉覆盖率的一个功能。因此，它对于模糊测试和关于代码执行期间信
+息的其它情况非常有用，比如在一个单一系统调用里使用它就很有用。
 
 动态分析工具
 ============
-- 
2.25.1

