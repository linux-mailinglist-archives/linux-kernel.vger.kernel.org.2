Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2FBB3D47C5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 15:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbhGXMZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 08:25:49 -0400
Received: from [43.250.32.171] ([43.250.32.171]:50054 "EHLO email.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S230513AbhGXMZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 08:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=From:To:Date; bh=BfxjFKgldRTwp6U2+NjWck8bpA4qfxRY7GzPT
        tF5wFg=; b=OWylNKl0aCj+1wO3Jhi/FNpJygE6Vd5x2Icpkf6wTzZXfgUtMHZhm
        kcD3qtYpP+vbCnm8hd4bfAiWzkfQGc3m/H18gnnJ4P1dEntZENrQWkO00EGL1zww
        Uif4uSiA0hJP+p74MjWONBZqeUr7qMZnBPqN3ZJUNkMBwTlKqCjdHk=
Received: from localhost.localdomain (unknown [113.251.15.54])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgCXpQRDEPxgF10EAA--.16972S2;
        Sat, 24 Jul 2021 21:06:12 +0800 (CST)
From:   Hu Haowen <src.res@email.cn>
To:     alexs@kernel.org, corbet@lwn.net
Cc:     bobwxc@email.cn, sterlingteng@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] docs/zh_CN: reformat zh_CN/dev-tools/testing-overview
Date:   Sat, 24 Jul 2021 21:06:11 +0800
Message-Id: <20210724130611.4231-1-src.res@email.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210723060328.16581-1-src.res@email.cn>
References: <20210723060328.16581-1-src.res@email.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LCKnCgCXpQRDEPxgF10EAA--.16972S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF4DXFy3AF18tryDJFWxCrg_yoW5Jr1Dpr
        s2kr92q3W8C345A3y09FyUtF48Cr97Gw4UKa1xt347ZryvkrsYkrZrtF90qFW3CryIvF90
        vF4rGFWq9340yFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgG1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28E
        F7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VWxJr1UJwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwV
        W5GwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26F4UJr1UMxC20s026xCaFVCj
        c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
        CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
        MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
        4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnI
        WIevJa73UjIFyTuYvjfUx38nUUUUU
X-Originating-IP: [113.251.15.54]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorganise several long lines in order to satisfy the kernel coding
style.

Signed-off-by: Hu Haowen <src.res@email.cn>
Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
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

