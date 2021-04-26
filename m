Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A734C36B547
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 16:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbhDZO4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 10:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbhDZO4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 10:56:42 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E03DBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 07:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=A2FocN77VX
        MDjpadCXSomBmGUVlCTli6sa6q6oxFZho=; b=F4mm6NBCtoER2dRHbI4/I3z9F4
        atvrEruktMAdW1BQTigk4SlLAqRTWGxFToB1MwIz76c8QWRz5f4hGloGkXC4akaj
        2CzvmP0Q1O05RUKEX32Q8K349tYGmbgmoKp8xK5CfmRtg6s0t327RUY0SxtDZLzy
        2eIltAef9rWat/i10=
Received: from ubuntu.localdomain (unknown [202.38.69.14])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygD3_59v1IZgS4pLAA--.6373S4;
        Mon, 26 Apr 2021 22:55:43 +0800 (CST)
From:   Lv Yunlong <lyl2019@mail.ustc.edu.cn>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Subject: [PATCH] sound/isa/ib: Fix two use after free in snd_sb_qsound_build
Date:   Mon, 26 Apr 2021 07:55:41 -0700
Message-Id: <20210426145541.8070-1-lyl2019@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LkAmygD3_59v1IZgS4pLAA--.6373S4
X-Coremail-Antispam: 1UD129KBjvJXoW7CF15tryfJFyDAw1fAw1xAFb_yoW8Wr43pF
        95Zas7C348Ar1vka4aqr1UW340krWvyFy5Zw4UWa4fAr15Jrn3G348tw13Aw47uF1Sk3yU
        W347A3s5JasIyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
        648v4I1lc2xSY4AK67AK6ry5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
        nxnUUI43ZEXa7VUbSdgPUUUUU==
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In snd_sb_qsound_build, snd_ctl_add(..,p->qsound_switch...) and
snd_ctl_add(..,p->qsound_space..) are called. But the second
arguments of snd_ctl_add() could be freed via snd_ctl_add_replace()
->snd_ctl_free_one(). After the error code is returned,
snd_sb_qsound_destroy(p) is called in __error branch.

But in snd_sb_qsound_destroy(), the freed p->qsound_switch and
p->qsound_space are still used by snd_ctl_remove().

My patch set p->qsound_switch and p->qsound_space to NULL if
snd_ctl_add() failed to avoid the uaf bugs. But these codes need
to further be improved with the code style.

Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
---
 sound/isa/sb/sb16_csp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/isa/sb/sb16_csp.c b/sound/isa/sb/sb16_csp.c
index 8635a2b6b36b..4789345a8fdd 100644
--- a/sound/isa/sb/sb16_csp.c
+++ b/sound/isa/sb/sb16_csp.c
@@ -1045,10 +1045,14 @@ static int snd_sb_qsound_build(struct snd_sb_csp * p)
 
 	spin_lock_init(&p->q_lock);
 
-	if ((err = snd_ctl_add(card, p->qsound_switch = snd_ctl_new1(&snd_sb_qsound_switch, p))) < 0)
+	if ((err = snd_ctl_add(card, p->qsound_switch = snd_ctl_new1(&snd_sb_qsound_switch, p))) < 0) {
+		p->qsound_switch = NULL;
 		goto __error;
-	if ((err = snd_ctl_add(card, p->qsound_space = snd_ctl_new1(&snd_sb_qsound_space, p))) < 0)
+	}
+	if ((err = snd_ctl_add(card, p->qsound_space = snd_ctl_new1(&snd_sb_qsound_space, p))) < 0) {
+		p->qsound_space = NULL;
 		goto __error;
+	}
 
 	return 0;
 
-- 
2.25.1


