Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9A13BA8F2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 16:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhGCOe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 10:34:26 -0400
Received: from m32-153.88.com ([43.250.32.153]:40470 "EHLO email.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229741AbhGCOeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 10:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=From:To:Date; bh=+BeNgP8EzhWzYHXB9iAv+1JoLdrS5XFdc3ZqH
        4o5170=; b=f+1UmA1b9/3WqS+tcZ+pcyDEVdW4QPFDrM1L0FbQ/nCLA6vEjvqAn
        lMZO0O8JnGiEosfj4azq02VBB8tlOvbeL7qMZJeaRTWxp481PxwcdM7H3FUZ6FBV
        m9OmhHo03krJl/5QIOlwwWnoLEHVDD2c88RCzLIxm/1IxgB16Uc8dw=
Received: from localhost.localdomain (unknown [113.251.11.229])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgDHnv3CdOBgiXM8AA--.16451S5;
        Sat, 03 Jul 2021 22:31:41 +0800 (CST)
From:   Hu Haowen <src.res@email.cn>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] docs/zh_TW: add SPDX-License-Identifiers for translations in zh_TW/process
Date:   Sat,  3 Jul 2021 22:31:30 +0800
Message-Id: <20210703143130.18349-4-src.res@email.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210703143130.18349-1-src.res@email.cn>
References: <20210703143130.18349-1-src.res@email.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GiKnCgDHnv3CdOBgiXM8AA--.16451S5
X-Coremail-Antispam: 1UD129KBjvAXoW3KFW5GFyUGw4UKFWrXr4ktFb_yoW8ArWxXo
        Wayw4UCr9rCr1DX3W5Cw4UCr45Gr13CFs3Ar42yw4q93sFg3W8Ca4Svw1YywsI9r1rWa93
        J34xX3yrXFyUCasrn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUU5-7k0a2IF6w4xM7kC6x804xWl1xkIjI8I6I8E6xAIw20EY4v2
        0xvaj40_Wr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7
        IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vE
        x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4
        CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26F4U
        Jr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrw
        CF04k20xvE74AGY7Cv6cx26F4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
        rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAw
        CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
        67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
        0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUUOz
        VUUUUUU==
X-Originating-IP: [113.251.11.229]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SPDX-License-Identifiers for several translations in order that the
compiler won't output errors.

Signed-off-by: Hu Haowen <src.res@email.cn>
---
 Documentation/translations/zh_TW/process/1.Intro.rst          | 2 ++
 Documentation/translations/zh_TW/process/2.Process.rst        | 2 ++
 Documentation/translations/zh_TW/process/3.Early-stage.rst    | 2 ++
 Documentation/translations/zh_TW/process/4.Coding.rst         | 2 ++
 Documentation/translations/zh_TW/process/5.Posting.rst        | 2 ++
 Documentation/translations/zh_TW/process/6.Followthrough.rst  | 2 ++
 Documentation/translations/zh_TW/process/7.AdvancedTopics.rst | 2 ++
 Documentation/translations/zh_TW/process/8.Conclusion.rst     | 2 ++
 .../zh_TW/process/code-of-conduct-interpretation.rst          | 2 ++
 Documentation/translations/zh_TW/process/code-of-conduct.rst  | 2 ++
 Documentation/translations/zh_TW/process/coding-style.rst     | 2 ++
 .../translations/zh_TW/process/development-process.rst        | 2 ++
 Documentation/translations/zh_TW/process/email-clients.rst    | 4 +++-
 .../translations/zh_TW/process/embargoed-hardware-issues.rst  | 2 ++
 Documentation/translations/zh_TW/process/howto.rst            | 4 +++-
 Documentation/translations/zh_TW/process/index.rst            | 2 ++
 .../translations/zh_TW/process/kernel-driver-statement.rst    | 2 ++
 .../zh_TW/process/kernel-enforcement-statement.rst            | 2 ++
 Documentation/translations/zh_TW/process/license-rules.rst    | 2 ++
 Documentation/translations/zh_TW/process/magic-number.rst     | 2 ++
 Documentation/translations/zh_TW/process/management-style.rst | 2 ++
 .../translations/zh_TW/process/programming-language.rst       | 2 ++
 .../translations/zh_TW/process/stable-api-nonsense.rst        | 2 ++
 .../translations/zh_TW/process/stable-kernel-rules.rst        | 2 ++
 Documentation/translations/zh_TW/process/submit-checklist.rst | 2 ++
 .../translations/zh_TW/process/submitting-drivers.rst         | 4 +++-
 .../translations/zh_TW/process/submitting-patches.rst         | 2 ++
 .../zh_TW/process/volatile-considered-harmful.rst             | 2 ++
 28 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/Documentation/translations/zh_TW/process/1.Intro.rst b/Documentation/translations/zh_TW/process/1.Intro.rst
index a1207ef153d7..ca2b931be6c5 100644
--- a/Documentation/translations/zh_TW/process/1.Intro.rst
+++ b/Documentation/translations/zh_TW/process/1.Intro.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 .. include:: ../disclaimer-zh_TW.rst
 
 :Original: :ref:`Documentation/process/1.Intro.rst <development_process_intro>`
diff --git a/Documentation/translations/zh_TW/process/2.Process.rst b/Documentation/translations/zh_TW/process/2.Process.rst
index b71629cdc11a..b01cdd3a39ae 100644
--- a/Documentation/translations/zh_TW/process/2.Process.rst
+++ b/Documentation/translations/zh_TW/process/2.Process.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 .. include:: ../disclaimer-zh_TW.rst
 
 :Original: :ref:`Documentation/process/2.Process.rst <development_process>`
diff --git a/Documentation/translations/zh_TW/process/3.Early-stage.rst b/Documentation/translations/zh_TW/process/3.Early-stage.rst
index ce85990fc98e..ab2a45fd65a4 100644
--- a/Documentation/translations/zh_TW/process/3.Early-stage.rst
+++ b/Documentation/translations/zh_TW/process/3.Early-stage.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 .. include:: ../disclaimer-zh_TW.rst
 
 :Original: :ref:`Documentation/process/3.Early-stage.rst <development_early_stage>`
diff --git a/Documentation/translations/zh_TW/process/4.Coding.rst b/Documentation/translations/zh_TW/process/4.Coding.rst
index 106b41c97223..ccc3946227a0 100644
--- a/Documentation/translations/zh_TW/process/4.Coding.rst
+++ b/Documentation/translations/zh_TW/process/4.Coding.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 .. include:: ../disclaimer-zh_TW.rst
 
 :Original: :ref:`Documentation/process/4.Coding.rst <development_coding>`
diff --git a/Documentation/translations/zh_TW/process/5.Posting.rst b/Documentation/translations/zh_TW/process/5.Posting.rst
index 3e09da2f3056..5578bca403e6 100644
--- a/Documentation/translations/zh_TW/process/5.Posting.rst
+++ b/Documentation/translations/zh_TW/process/5.Posting.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 .. include:: ../disclaimer-zh_TW.rst
 
 :Original: :ref:`Documentation/process/5.Posting.rst <development_posting>`
diff --git a/Documentation/translations/zh_TW/process/6.Followthrough.rst b/Documentation/translations/zh_TW/process/6.Followthrough.rst
index 233115bfff95..4af782742db3 100644
--- a/Documentation/translations/zh_TW/process/6.Followthrough.rst
+++ b/Documentation/translations/zh_TW/process/6.Followthrough.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 .. include:: ../disclaimer-zh_TW.rst
 
 :Original: :ref:`Documentation/process/6.Followthrough.rst <development_followthrough>`
diff --git a/Documentation/translations/zh_TW/process/7.AdvancedTopics.rst b/Documentation/translations/zh_TW/process/7.AdvancedTopics.rst
index 8d121a8c6535..3de093d0f170 100644
--- a/Documentation/translations/zh_TW/process/7.AdvancedTopics.rst
+++ b/Documentation/translations/zh_TW/process/7.AdvancedTopics.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 .. include:: ../disclaimer-zh_TW.rst
 
 :Original: :ref:`Documentation/process/7.AdvancedTopics.rst <development_advancedtopics>`
diff --git a/Documentation/translations/zh_TW/process/8.Conclusion.rst b/Documentation/translations/zh_TW/process/8.Conclusion.rst
index e35074f31f35..7572b17667d9 100644
--- a/Documentation/translations/zh_TW/process/8.Conclusion.rst
+++ b/Documentation/translations/zh_TW/process/8.Conclusion.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 .. include:: ../disclaimer-zh_TW.rst
 
 :Original: :ref:`Documentation/process/8.Conclusion.rst <development_conclusion>`
diff --git a/Documentation/translations/zh_TW/process/code-of-conduct-interpretation.rst b/Documentation/translations/zh_TW/process/code-of-conduct-interpretation.rst
index 457ae49ba4d4..949d831aaf6c 100644
--- a/Documentation/translations/zh_TW/process/code-of-conduct-interpretation.rst
+++ b/Documentation/translations/zh_TW/process/code-of-conduct-interpretation.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 .. include:: ../disclaimer-zh_TW.rst
 
 :Original: :ref:`Documentation/process/code-of-conduct-interpretation.rst <code_of_conduct_interpretation>`
diff --git a/Documentation/translations/zh_TW/process/code-of-conduct.rst b/Documentation/translations/zh_TW/process/code-of-conduct.rst
index b44fea4e167a..716e5843b6e9 100644
--- a/Documentation/translations/zh_TW/process/code-of-conduct.rst
+++ b/Documentation/translations/zh_TW/process/code-of-conduct.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 .. include:: ../disclaimer-zh_TW.rst
 
 :Original: :ref:`Documentation/process/code-of-conduct.rst <code_of_conduct>`
diff --git a/Documentation/translations/zh_TW/process/coding-style.rst b/Documentation/translations/zh_TW/process/coding-style.rst
index 21a9fe298c86..61e614aad6a7 100644
--- a/Documentation/translations/zh_TW/process/coding-style.rst
+++ b/Documentation/translations/zh_TW/process/coding-style.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 .. include:: ../disclaimer-zh_TW.rst
 
 :Original: :ref:`Documentation/process/coding-style.rst <codingstyle>`
diff --git a/Documentation/translations/zh_TW/process/development-process.rst b/Documentation/translations/zh_TW/process/development-process.rst
index cc25c554854e..45e6385647cd 100644
--- a/Documentation/translations/zh_TW/process/development-process.rst
+++ b/Documentation/translations/zh_TW/process/development-process.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 .. include:: ../disclaimer-zh_TW.rst
 
 :Original: :ref:`Documentation/process/development-process.rst <development_process_main>`
diff --git a/Documentation/translations/zh_TW/process/email-clients.rst b/Documentation/translations/zh_TW/process/email-clients.rst
index 9b7c1acf0a87..4ba543d06f3b 100644
--- a/Documentation/translations/zh_TW/process/email-clients.rst
+++ b/Documentation/translations/zh_TW/process/email-clients.rst
@@ -1,4 +1,6 @@
-﻿.. _tw_email_clients:
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _tw_email_clients:
 
 .. include:: ../disclaimer-zh_TW.rst
 
diff --git a/Documentation/translations/zh_TW/process/embargoed-hardware-issues.rst b/Documentation/translations/zh_TW/process/embargoed-hardware-issues.rst
index 2cd100412655..d676cef16646 100644
--- a/Documentation/translations/zh_TW/process/embargoed-hardware-issues.rst
+++ b/Documentation/translations/zh_TW/process/embargoed-hardware-issues.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 .. include:: ../disclaimer-zh_TW.rst
 
 :Original: :ref:`Documentation/process/embargoed-hardware-issues.rst <embargoed_hardware_issues>`
diff --git a/Documentation/translations/zh_TW/process/howto.rst b/Documentation/translations/zh_TW/process/howto.rst
index d1e3df96450a..2043691b92e3 100644
--- a/Documentation/translations/zh_TW/process/howto.rst
+++ b/Documentation/translations/zh_TW/process/howto.rst
@@ -1,4 +1,6 @@
-﻿.. _tw_process_howto:
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _tw_process_howto:
 
 .. include:: ../disclaimer-zh_TW.rst
 
diff --git a/Documentation/translations/zh_TW/process/index.rst b/Documentation/translations/zh_TW/process/index.rst
index 2f6ecb6515f6..ec7ad14bfd13 100644
--- a/Documentation/translations/zh_TW/process/index.rst
+++ b/Documentation/translations/zh_TW/process/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 .. raw:: latex
 
 	\renewcommand\thesection*
diff --git a/Documentation/translations/zh_TW/process/kernel-driver-statement.rst b/Documentation/translations/zh_TW/process/kernel-driver-statement.rst
index f833c1bf81d2..8f225379b12c 100644
--- a/Documentation/translations/zh_TW/process/kernel-driver-statement.rst
+++ b/Documentation/translations/zh_TW/process/kernel-driver-statement.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 .. _zh_process_statement_driver:
 
 .. include:: ../disclaimer-zh_TW.rst
diff --git a/Documentation/translations/zh_TW/process/kernel-enforcement-statement.rst b/Documentation/translations/zh_TW/process/kernel-enforcement-statement.rst
index 5e792edcd868..99e21d22800d 100644
--- a/Documentation/translations/zh_TW/process/kernel-enforcement-statement.rst
+++ b/Documentation/translations/zh_TW/process/kernel-enforcement-statement.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ﻿.. _tw_process_statement_kernel:
 
 .. include:: ../disclaimer-zh_TW.rst
diff --git a/Documentation/translations/zh_TW/process/license-rules.rst b/Documentation/translations/zh_TW/process/license-rules.rst
index d48f2f605068..ad2b80f97123 100644
--- a/Documentation/translations/zh_TW/process/license-rules.rst
+++ b/Documentation/translations/zh_TW/process/license-rules.rst
@@ -1,5 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
+.. SPDX-License-Identifier: GPL-2.0
+
 .. include:: ../disclaimer-zh_TW.rst
 
 :Original: :ref:`Documentation/process/license-rules.rst <kernel_licensing>`
diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Documentation/translations/zh_TW/process/magic-number.rst
index 491459ea792f..ae321a9aaece 100644
--- a/Documentation/translations/zh_TW/process/magic-number.rst
+++ b/Documentation/translations/zh_TW/process/magic-number.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 .. _tw_magicnumbers:
 
 .. include:: ../disclaimer-zh_TW.rst
diff --git a/Documentation/translations/zh_TW/process/management-style.rst b/Documentation/translations/zh_TW/process/management-style.rst
index 0fddb0115a4c..dce248470063 100644
--- a/Documentation/translations/zh_TW/process/management-style.rst
+++ b/Documentation/translations/zh_TW/process/management-style.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 .. include:: ../disclaimer-zh_TW.rst
 
 :Original: :ref:`Documentation/process/management-style.rst <managementstyle>`
diff --git a/Documentation/translations/zh_TW/process/programming-language.rst b/Documentation/translations/zh_TW/process/programming-language.rst
index 0e4081c58b98..54e3699eadf8 100644
--- a/Documentation/translations/zh_TW/process/programming-language.rst
+++ b/Documentation/translations/zh_TW/process/programming-language.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 .. include:: ../disclaimer-zh_TW.rst
 
 :Original: :ref:`Documentation/process/programming-language.rst <programming_language>`
diff --git a/Documentation/translations/zh_TW/process/stable-api-nonsense.rst b/Documentation/translations/zh_TW/process/stable-api-nonsense.rst
index 344f3d3dc793..22caa5b8d422 100644
--- a/Documentation/translations/zh_TW/process/stable-api-nonsense.rst
+++ b/Documentation/translations/zh_TW/process/stable-api-nonsense.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 .. _tw_stable_api_nonsense:
 
 .. include:: ../disclaimer-zh_TW.rst
diff --git a/Documentation/translations/zh_TW/process/stable-kernel-rules.rst b/Documentation/translations/zh_TW/process/stable-kernel-rules.rst
index d66306fa6dc8..9bb0d9b4f3ac 100644
--- a/Documentation/translations/zh_TW/process/stable-kernel-rules.rst
+++ b/Documentation/translations/zh_TW/process/stable-kernel-rules.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 .. _tw_stable_kernel_rules:
 
 .. include:: ../disclaimer-zh_TW.rst
diff --git a/Documentation/translations/zh_TW/process/submit-checklist.rst b/Documentation/translations/zh_TW/process/submit-checklist.rst
index 52d435814da1..ff2f89cba83f 100644
--- a/Documentation/translations/zh_TW/process/submit-checklist.rst
+++ b/Documentation/translations/zh_TW/process/submit-checklist.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 .. include:: ../disclaimer-zh_TW.rst
 
 :Original: :ref:`Documentation/process/submit-checklist.rst <submitchecklist>`
diff --git a/Documentation/translations/zh_TW/process/submitting-drivers.rst b/Documentation/translations/zh_TW/process/submitting-drivers.rst
index 9727d27c362b..2fdd742318ba 100644
--- a/Documentation/translations/zh_TW/process/submitting-drivers.rst
+++ b/Documentation/translations/zh_TW/process/submitting-drivers.rst
@@ -1,4 +1,6 @@
-﻿.. _tw_submittingdrivers:
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _tw_submittingdrivers:
 
 .. include:: ../disclaimer-zh_TW.rst
 
diff --git a/Documentation/translations/zh_TW/process/submitting-patches.rst b/Documentation/translations/zh_TW/process/submitting-patches.rst
index 3b7dd4c73e0b..cdf0b52e4a98 100644
--- a/Documentation/translations/zh_TW/process/submitting-patches.rst
+++ b/Documentation/translations/zh_TW/process/submitting-patches.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 .. _tw_submittingpatches:
 
 .. include:: ../disclaimer-zh_TW.rst
diff --git a/Documentation/translations/zh_TW/process/volatile-considered-harmful.rst b/Documentation/translations/zh_TW/process/volatile-considered-harmful.rst
index 5bf923489d05..097fe80352cb 100644
--- a/Documentation/translations/zh_TW/process/volatile-considered-harmful.rst
+++ b/Documentation/translations/zh_TW/process/volatile-considered-harmful.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 .. _tw_volatile_considered_harmful:
 
 .. include:: ../disclaimer-zh_TW.rst
-- 
2.25.1

