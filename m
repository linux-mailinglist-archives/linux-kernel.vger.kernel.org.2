Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7648386F1B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 03:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245580AbhERB0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 21:26:30 -0400
Received: from mail.loongson.cn ([114.242.206.163]:53202 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233202AbhERB02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 21:26:28 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9CxecluF6Ng858YAA--.34801S2;
        Tue, 18 May 2021 09:25:02 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] checkpatch: add help info if no filenames are given
Date:   Tue, 18 May 2021 09:25:01 +0800
Message-Id: <1621301101-10650-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9CxecluF6Ng858YAA--.34801S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw4Dtw4xXF1Utw4xuFW7urg_yoWDtwcEvr
        W7t3s5WF97JrWakFsYvr4rur10v343ZrW8ZasYyr9rZ34Yk395XFZ7Gr92yr15C3y0kF9a
        k3y3XFZ8Crs3JjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb28YjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVWkMxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
        IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jY_M3UUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 45107ff6d526 ("checkpatch: if no filenames then read stdin"),
if no filenames are given, it will read patch from stdin rather than exit
directly. This means the script waits for input indefinitely, which
confuses new checkpatch users at first.

Add some help info on this behaviour of checkpatch to lower the confusion.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 scripts/checkpatch.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 23697a6..825eb00 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -80,6 +80,8 @@ sub help {
 Usage: $P [OPTION]... [FILE]...
 Version: $V
 
+When FILE is -, or absent, checkpatch reads from standard input.
+
 Options:
   -q, --quiet                quiet
   -v, --verbose              verbose mode
@@ -138,8 +140,6 @@ Options:
   --kconfig-prefix=WORD      use WORD as a prefix for Kconfig symbols (default
                              ${CONFIG_})
   -h, --help, --version      display this help and exit
-
-When FILE is - read standard input.
 EOM
 
 	exit($exitcode);
-- 
2.1.0

