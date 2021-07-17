Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306C03CC27D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 12:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbhGQKVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 06:21:11 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:36253
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S233065AbhGQKUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 06:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=SnnB84HTJybRqGX8XSBko+YwUlD/NAywFxZKJPyBXn4=; b=j
        ISXk25aV8lELnsKRcYczXBbBjv2dcwVf0GrUBszgFu1Ly4lKBEmrqptXxeOIP1VL
        5hLzDcfq2r+U4udNmtUPi+s4cvpmEaoQ0pXVJJz9XHbA9Ibi8wm51iXo7ORsvvva
        GTOUlfpvQ9hsir9kE7tdXcLY/ucsMsTo9P/L9oJYeQ=
Received: from localhost.localdomain (unknown [39.144.44.130])
        by app1 (Coremail) with SMTP id XAUFCgAnCWo0rvJgjV58AA--.31928S3;
        Sat, 17 Jul 2021 18:17:25 +0800 (CST)
From:   Xiyu Yang <xiyuyang19@fudan.edu.cn>
To:     Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH] misc: sgi-gru: Convert from atomic_t to refcount_t on gru_thread_state->ts_refcnt
Date:   Sat, 17 Jul 2021 18:17:22 +0800
Message-Id: <1626517043-42696-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XAUFCgAnCWo0rvJgjV58AA--.31928S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Wry3tF17ZF47WFWxWw4rXwb_yoW5Jr1DpF
        4j93y0yrZYyF4DJFnrta1kuFW3Ja4kXry5ur9rC34rWr43Jw4Y9w1kJa45JrykZFW2qF1Y
        vr4Ygwn0ka1qqaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
        rcIFxwCY02Avz4vE14v_Gw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW8JVW3JwCI42IY6I8E
        87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
        IFyTuYvjfUosqXDUUUU
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

refcount_t type and corresponding API can protect refcounters from
accidental underflow and overflow and further use-after-free situations.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 drivers/misc/sgi-gru/grumain.c   | 6 +++---
 drivers/misc/sgi-gru/grutables.h | 3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/sgi-gru/grumain.c b/drivers/misc/sgi-gru/grumain.c
index 40ac59dd018c..9afda47efbf2 100644
--- a/drivers/misc/sgi-gru/grumain.c
+++ b/drivers/misc/sgi-gru/grumain.c
@@ -282,7 +282,7 @@ static void gru_unload_mm_tracker(struct gru_state *gru,
  */
 void gts_drop(struct gru_thread_state *gts)
 {
-	if (gts && atomic_dec_return(&gts->ts_refcnt) == 0) {
+	if (gts && refcount_dec_and_test(&gts->ts_refcnt)) {
 		if (gts->ts_gms)
 			gru_drop_mmu_notifier(gts->ts_gms);
 		kfree(gts);
@@ -323,7 +323,7 @@ struct gru_thread_state *gru_alloc_gts(struct vm_area_struct *vma,
 
 	STAT(gts_alloc);
 	memset(gts, 0, sizeof(struct gru_thread_state)); /* zero out header */
-	atomic_set(&gts->ts_refcnt, 1);
+	refcount_set(&gts->ts_refcnt, 1);
 	mutex_init(&gts->ts_ctxlock);
 	gts->ts_cbr_au_count = cbr_au_count;
 	gts->ts_dsr_au_count = dsr_au_count;
@@ -888,7 +888,7 @@ struct gru_state *gru_assign_gru_context(struct gru_thread_state *gts)
 		gts->ts_gru = gru;
 		gts->ts_blade = gru->gs_blade_id;
 		gts->ts_ctxnum = gru_assign_context_number(gru);
-		atomic_inc(&gts->ts_refcnt);
+		refcount_inc(&gts->ts_refcnt);
 		gru->gs_gts[gts->ts_ctxnum] = gts;
 		spin_unlock(&gru->gs_lock);
 
diff --git a/drivers/misc/sgi-gru/grutables.h b/drivers/misc/sgi-gru/grutables.h
index 5ce8f3081e96..e4c067c61251 100644
--- a/drivers/misc/sgi-gru/grutables.h
+++ b/drivers/misc/sgi-gru/grutables.h
@@ -129,6 +129,7 @@
  *
  */
 
+#include <linux/refcount.h>
 #include <linux/rmap.h>
 #include <linux/interrupt.h>
 #include <linux/mutex.h>
@@ -358,7 +359,7 @@ struct gru_thread_state {
 						     enabled */
 	int			ts_ctxnum;	/* context number where the
 						   context is loaded */
-	atomic_t		ts_refcnt;	/* reference count GTS */
+	refcount_t		ts_refcnt;	/* reference count GTS */
 	unsigned char		ts_dsr_au_count;/* Number of DSR resources
 						   required for contest */
 	unsigned char		ts_cbr_au_count;/* Number of CBR resources
-- 
2.7.4

