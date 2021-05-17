Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBA2382666
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 10:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbhEQIN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 04:13:59 -0400
Received: from mail.loongson.cn ([114.242.206.163]:56512 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230507AbhEQIN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 04:13:59 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxH+93JaJgzDYYAA--.19893S2;
        Mon, 17 May 2021 16:12:40 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Documentation: checkpatch: add description if no filenames are given
Date:   Mon, 17 May 2021 16:12:39 +0800
Message-Id: <1621239159-21139-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9DxH+93JaJgzDYYAA--.19893S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw4Dtw4xXryUtry7JryxZrb_yoWkGwcEkr
        45tFs5WryxJrWUt3Z0yF4rXrW2vw45Zw18Awn5ZryDZ34F9a98XFZ7Kr9Fyr1UCrW29Fnx
        Cw45Za90yFs7AjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2AYjsxI4VWkCwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8ZwCF04k2
        0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j2WlgUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 45107ff6d526 ("checkpatch: if no filenames then read stdin"),
if no filenames are given, it will read patch from stdin rather than exit
directly, it is a bit confusing whether the script hangs, I do not quite
know what to do next until I understood the code logic.

It is unnecessary to print some info if no filenames are given, because it
is like trying to make cat without command line arguments emit something,
just add description for somebody that actually reads the available kernel
documentation on checkpatch.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
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

