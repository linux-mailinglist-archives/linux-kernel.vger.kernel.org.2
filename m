Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCCA38D336
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 05:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhEVDNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 23:13:38 -0400
Received: from [43.250.32.171] ([43.250.32.171]:47208 "EHLO email.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S231149AbhEVDNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 23:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=From:To:Date; bh=7Uqze9l4G9ffUxBjcp9UV9Q4ZDdHg4pepFDGL
        C6FdIE=; b=NLMDEI1cDqd8JCd5U69HPKCpIOnkUMKYVD9gDVTzkNljk6B3J89yc
        8h5UwBZ6r9yVZBiaDSj7bHEzVd03LKp/a7YKmdBCgQ+lno8GFahQyQM2yU4iQUKh
        z18bLVqRY1tWgpncWtcZHvILzN+VI005zC73cC3tdx5rchl1z5HuWI=
Received: from localhost.localdomain (unknown [113.251.14.223])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgCnbkGHdqhgst83AA--.18562S2;
        Sat, 22 May 2021 11:12:07 +0800 (CST)
From:   Hu Haowen <src.res@email.cn>
To:     alexs@kernel.org, corbet@lwn.net, bobwxc@email.cn,
        maskray@google.com, bernard@vivo.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hu Haowen <src.res@email.cn>
Subject: [PATCH v2 3/3] docs/zh_CN: Correct a link in dev-tools/index
Date:   Sat, 22 May 2021 11:11:50 +0800
Message-Id: <20210522031150.57909-1-src.res@email.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LCKnCgCnbkGHdqhgst83AA--.18562S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JFW7WF1rtry3tw18ZryxZrb_yoWfGFc_Cw
        n5WF40yrW3Jry2qr4rAr1kAr1IvF4rKr18Arn0ya98J345W39rW3WDX3s5Zay3WF43urW3
        CrZ7uryYqrsFyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb5kFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWUJVWUGwA2ocxC64kI
        II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7
        xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2
        z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc
        02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_Cr1UJr1lOx8S6xCaFVCjc4AY
        6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x
        0EwIxGrwCF04k20xvE74AGY7Cv6cx26F4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I
        3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxV
        WUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8I
        cVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
        AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZE
        Xa7VU0mhF7UUUUU==
X-Originating-IP: [113.251.14.223]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The link directs to English version. Now it should be Chinese version
owing to the new Chinese translations.

Signed-off-by: Hu Haowen <src.res@email.cn>
---
 Documentation/translations/zh_CN/dev-tools/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/dev-tools/index.rst b/Documentation/translations/zh_CN/dev-tools/index.rst
index b6b6d3b09acc..049d00058187 100644
--- a/Documentation/translations/zh_CN/dev-tools/index.rst
+++ b/Documentation/translations/zh_CN/dev-tools/index.rst
@@ -12,7 +12,7 @@
 欢迎任何补丁。
 
 有关测试专用工具的简要概述，参见
-Documentation/dev-tools/testing-overview.rst
+Documentation/translations/zh_CN/dev-tools/testing-overview.rst
 
 .. class:: toc-title
 
-- 
2.25.1

