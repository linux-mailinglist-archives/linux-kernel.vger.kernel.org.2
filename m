Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23BF630D31D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 06:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhBCFhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 00:37:22 -0500
Received: from mail.loongson.cn ([114.242.206.163]:56716 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229650AbhBCFhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 00:37:20 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx3_NdNhpgHncCAA--.3007S2;
        Wed, 03 Feb 2021 13:36:29 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     davem@davemloft.net
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sparc: Replace test_ti_thread_flag() with test_tsk_thread_flag()
Date:   Wed,  3 Feb 2021 13:36:28 +0800
Message-Id: <1612330588-7026-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dx3_NdNhpgHncCAA--.3007S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw1ftryUGrWxXr4xZry3XFb_yoWDJrb_uw
        47G3Z3Gr4Syrnaqwn8Ww4fZF1jyw4Y9FWrZrWv9r90yFW8Kry5XFZ5Z3WDXF9xurWvkrnI
        va4DGFyqyw10kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb28YjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_GrWl42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jYoGQUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use test_tsk_thread_flag() directly instead of test_ti_thread_flag() to
improve readability when the argument type is struct task_struct, it is
similar with commit 5afc78551bf5 ("arm64: Use test_tsk_thread_flag() for
checking TIF_SINGLESTEP").

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/sparc/kernel/process_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index a023637..7649b14 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -183,7 +183,7 @@ void exit_thread(struct task_struct *tsk)
 #ifndef CONFIG_SMP
 	if (last_task_used_math == tsk) {
 #else
-	if (test_ti_thread_flag(task_thread_info(tsk), TIF_USEDFPU)) {
+	if (test_tsk_thread_flag(tsk, TIF_USEDFPU)) {
 #endif
 		/* Keep process from leaving FPU in a bogon state. */
 		put_psr(get_psr() | PSR_EF);
-- 
2.1.0

