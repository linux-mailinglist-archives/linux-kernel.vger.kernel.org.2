Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048053A939C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 09:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhFPHTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 03:19:14 -0400
Received: from mail.loongson.cn ([114.242.206.163]:46802 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231239AbhFPHTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 03:19:13 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxiuBtpclgNFkSAA--.27863S2;
        Wed, 16 Jun 2021 15:17:01 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: [RFC PATCH] umh: Check if sub_info->path is exist in call_usermodehelper_setup()
Date:   Wed, 16 Jun 2021 15:17:00 +0800
Message-Id: <1623827820-21248-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9AxiuBtpclgNFkSAA--.27863S2
X-Coremail-Antispam: 1UD129KBjvJXoW7GFWUtrWxKFyfXF47uFW8Xrb_yoW8JF1xpF
        W3Xr1ayr4rJFn2kas7A3Z5ur15Ar1kGF13XFZ7Z395A34kur1DXr48Ga409FW5KrWSkFW2
        yr1Fvr4S9F1UGFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4x
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JU4UDLUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In call_usermodehelper_setup(), if strlen(sub_info->path) is not 0,
but in fact there is no such file, in this case, there is no need to
execute it, set sub_info->path as empty string to avoid meaningless
operations in call_usermodehelper_exec().

Here is an example:
init/do_mounts_initrd.c
static void __init handle_initrd(void)
{
	[...]
	info = call_usermodehelper_setup("/linuxrc", argv, envp_init,
					 GFP_KERNEL, init_linuxrc, NULL, NULL);
	if (!info)
		return;
	call_usermodehelper_exec(info, UMH_WAIT_PROC);
	[...]
}

$ ls /linuxrc
ls: cannot access '/linuxrc': No such file or directory

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 kernel/umh.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/umh.c b/kernel/umh.c
index 36c1233..2312cc0 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -373,6 +373,17 @@ struct subprocess_info *call_usermodehelper_setup(const char *path, char **argv,
 #else
 	sub_info->path = path;
 #endif
+	if (strlen(sub_info->path) != 0) {
+		struct file *fp;
+
+		fp = filp_open(sub_info->path, O_RDONLY, 0);
+		if (IS_ERR(fp)) {
+			sub_info->path = "";
+			return sub_info;
+		}
+		filp_close(fp, NULL);
+	}
+
 	sub_info->argv = argv;
 	sub_info->envp = envp;
 
-- 
2.1.0

