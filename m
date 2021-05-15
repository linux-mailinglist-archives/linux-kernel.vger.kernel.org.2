Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C113815B1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 06:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbhEOEQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 00:16:47 -0400
Received: from mail.loongson.cn ([114.242.206.163]:38808 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229441AbhEOEQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 00:16:47 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxncjkSp9gC7YWAA--.29652S2;
        Sat, 15 May 2021 12:15:32 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] checkpatch: Print some info if no filenames are given
Date:   Sat, 15 May 2021 12:15:31 +0800
Message-Id: <1621052131-16309-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9AxncjkSp9gC7YWAA--.29652S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw4Dtw4xXF1ftFWDJFy7ZFb_yoW3KrbEkF
        Zxtr95WF9rJw4rA3Wxtr45WF1jv34DZw4rW3WrAryDu34rC398uFW7JrZ7JF18A3yIkF90
        k39xXFWkCrnxZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2kYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8XwCF04k2
        0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8W7K3UUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 45107ff6d526 ("checkpatch: if no filenames then read stdin"),
if no filenames are given, it will read patch from stdin rather than exit
directly, it is better to print some info about what to do next, otherwise
it is a bit confusing whether the script hangs.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 scripts/checkpatch.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 23697a6..d84d4fb 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -361,6 +361,8 @@ if ($^V && $^V lt $minimum_perl_version) {
 
 #if no filenames are given, push '-' to read patch from stdin
 if ($#ARGV < 0) {
+	print "$P: missing patchfile or -f file\n";
+	print "Use --help if necessary or read patch from stdin\n";
 	push(@ARGV, '-');
 }
 
-- 
2.1.0

