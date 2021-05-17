Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD43B382856
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236051AbhEQJbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:31:24 -0400
Received: from mail.loongson.cn ([114.242.206.163]:49086 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236004AbhEQJbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:31:21 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxv++aN6JgBEUYAA--.3368S2;
        Mon, 17 May 2021 17:30:02 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] Documentation: checkpatch: add description if no filenames are given
Date:   Mon, 17 May 2021 17:30:00 +0800
Message-Id: <1621243800-27702-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dxv++aN6JgBEUYAA--.3368S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw4Dtw4xXF1Utw4xuFW7urg_yoWDJFgEyr
        4UJF98WF97Jry5tFn0yr4rXr12v3y5Zr18Awn8Ar98A34Yk398XFZrKr9rAr1UCrWj9F9x
        Cw4UZFZ8Ars2yjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2xYjsxI4VWkCwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r4fMxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
        IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxT5dDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 45107ff6d526 ("checkpatch: if no filenames then read stdin"),
if no filenames are given, it will read patch from stdin rather than exit
directly. This means the script waits for input indefinitely, which
confuses new checkpatch users at first.

Add some basic documentation on this behaviour of checkpatch to lower
the confusion.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---

v3: Update the commit message, thank you Lukas.

 Documentation/dev-tools/checkpatch.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index 51fed1b..3eb9ead 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -22,6 +22,8 @@ Usage::
 
   ./scripts/checkpatch.pl [OPTION]... [FILE]...
 
+When FILE is -, or absent, checkpatch reads from standard input.
+
 Available options:
 
  - -q,  --quiet
-- 
2.1.0

