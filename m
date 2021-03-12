Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61523388CC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbhCLJhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:37:18 -0500
Received: from smtp23.cstnet.cn ([159.226.251.23]:33826 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232686AbhCLJgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:36:52 -0500
Received: from localhost.localdomain (unknown [124.16.141.241])
        by APP-03 (Coremail) with SMTP id rQCowAA3Pw8bNktgUYoCAA--.13288S2;
        Fri, 12 Mar 2021 17:36:28 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     tiwai@suse.com, perex@perex.cz, joe@perches.com, jgg@ziepe.ca,
        chao@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: sb: Remove extra brackets
Date:   Fri, 12 Mar 2021 09:36:25 +0000
Message-Id: <20210312093625.65650-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: rQCowAA3Pw8bNktgUYoCAA--.13288S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XF48ZFy5WF43tF47JF48tFb_yoWxZrgEya
        1fXF4IgF4DXa9Iv3W5Ja4Fqr4qkFykZFs2gr1xKr47GrykJF13Zw4UJrnrWrs8urZ5CFy2
        gw1DZay8CasFqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2kYjsxI4VWkCwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4UJVWxJr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8uwCF04k2
        0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8tku7UUUUU==
X-Originating-IP: [124.16.141.241]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCwcSA1z4j4xQ2AACsw
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove extra brackets.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 sound/isa/sb/sb16_csp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/isa/sb/sb16_csp.c b/sound/isa/sb/sb16_csp.c
index 8635a2b6b36b..2c292bf0f5ae 100644
--- a/sound/isa/sb/sb16_csp.c
+++ b/sound/isa/sb/sb16_csp.c
@@ -769,7 +769,7 @@ static int snd_sb_csp_autoload(struct snd_sb_csp * p, snd_pcm_format_t pcm_sfmt,
 
 			p->running = 0;				/* clear autoloaded flag */
 			p->mode = 0;
-			return (err);
+			return err;
 		} else {
 			p->running = SNDRV_SB_CSP_ST_AUTO;	/* set autoloaded flag */
 			p->acc_width = SNDRV_SB_CSP_SAMPLE_16BIT;	/* only 16 bit data */
-- 
2.17.1

