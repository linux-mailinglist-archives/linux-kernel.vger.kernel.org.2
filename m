Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9657230E9F1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 03:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbhBDCGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 21:06:36 -0500
Received: from smtp23.cstnet.cn ([159.226.251.23]:37756 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232411AbhBDCGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 21:06:22 -0500
Received: from localhost.localdomain (unknown [124.16.141.241])
        by APP-03 (Coremail) with SMTP id rQCowADHZrhhVhtg3RA3AQ--.39496S2;
        Thu, 04 Feb 2021 10:05:21 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     perex@perex.cz, tiwai@suse.com, alexander@tsoy.me,
        e.burema@gmail.com, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: endpoint : remove redundant check before usb_free_coherent()
Date:   Thu,  4 Feb 2021 02:05:18 +0000
Message-Id: <20210204020518.76619-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: rQCowADHZrhhVhtg3RA3AQ--.39496S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKFWrZw4UGr47GFWDWF4UJwb_yoW3Kwb_Za
        ykCr4kWryDXwnIvryDGr4FyF4293yfZFn7WF4Iq398AFWUt3yYyr48Xr1kGF1rCan3tF95
        Jws3Kr4rKr18KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbVxYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ec7CjxVAajcxG14v26r
        1j6r4UMcIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI
        7VAKI48JMxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
        73UjIFyTuYvjxUcBHqUUUUU
X-Originating-IP: [124.16.141.241]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCgkCA1z4jWIVlAAAsI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb_free_coherent() is safe with NULL addr and this check is
not required.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 sound/usb/endpoint.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 8e568823c992..d5ed4ddfd451 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -82,10 +82,9 @@ static inline unsigned get_usb_high_speed_rate(unsigned int rate)
  */
 static void release_urb_ctx(struct snd_urb_ctx *u)
 {
-	if (u->buffer_size)
-		usb_free_coherent(u->ep->chip->dev, u->buffer_size,
-				  u->urb->transfer_buffer,
-				  u->urb->transfer_dma);
+	usb_free_coherent(u->ep->chip->dev, u->buffer_size,
+			  u->urb->transfer_buffer,
+			  u->urb->transfer_dma);
 	usb_free_urb(u->urb);
 	u->urb = NULL;
 }
-- 
2.17.1

