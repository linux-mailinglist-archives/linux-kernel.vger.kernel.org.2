Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBB132394B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 10:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbhBXJSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 04:18:12 -0500
Received: from m12-14.163.com ([220.181.12.14]:42784 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234512AbhBXJSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 04:18:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=cQIIy
        A026Smy/5bkFC5TNpl130WLwuskncZWiZurTAU=; b=J6ApnJxaW6KFXkLMiuQpp
        Lx+dg+uHP9LAn96qxIg9SqPA1eD1l5xMWEOiSDxGx58kd02xauCJIDPBbKFzVie2
        DLIJNJtYfgsv94hgobWKLGelRTvJ9qrZxgHBPlgwDC0fvj4H+lHZiiNRVj+Qn/yH
        1EoBcAD+K+w+Dp4hg8ZwpQ=
Received: from COOL-20201222LC.ccdomain.com (unknown [218.94.48.178])
        by smtp10 (Coremail) with SMTP id DsCowAA3xkJGFDZg3SRTmQ--.51774S2;
        Wed, 24 Feb 2021 16:54:31 +0800 (CST)
From:   dingsenjie@163.com
To:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        dingsenjie <dingsenjie@yulong.com>
Subject: [PATCH] sound: soc/uniphier: Simplify the return expression of uniphier_aio_startup
Date:   Wed, 24 Feb 2021 16:54:07 +0800
Message-Id: <20210224085407.22120-1-dingsenjie@163.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowAA3xkJGFDZg3SRTmQ--.51774S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw4UXrykCw4UJry8ZFyftFb_yoWfZFc_G3
        4Fvws8WFWjkr4YqrZFvws7Zr9xt3929w1DGw1aqrsxCr13Ar4rAw17CrZ3Gay8Wr4fJa4D
        uFs5KF47tFy2qjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0DCztUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5glqw25hqmxvi6rwjhhfrp/1tbipQlDyFUMceCRMAACsM
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dingsenjie <dingsenjie@yulong.com>

Simplify the return expression in the aio-cpu.c.

Signed-off-by: dingsenjie <dingsenjie@yulong.com>
---
 sound/soc/uniphier/aio-cpu.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/soc/uniphier/aio-cpu.c b/sound/soc/uniphier/aio-cpu.c
index 25c40c2..cf98141 100644
--- a/sound/soc/uniphier/aio-cpu.c
+++ b/sound/soc/uniphier/aio-cpu.c
@@ -256,17 +256,12 @@ static int uniphier_aio_startup(struct snd_pcm_substream *substream,
 {
 	struct uniphier_aio *aio = uniphier_priv(dai);
 	struct uniphier_aio_sub *sub = &aio->sub[substream->stream];
-	int ret;
 
 	sub->substream = substream;
 	sub->pass_through = 0;
 	sub->use_mmap = true;
 
-	ret = aio_init(sub);
-	if (ret)
-		return ret;
-
-	return 0;
+	return aio_init(sub);
 }
 
 static void uniphier_aio_shutdown(struct snd_pcm_substream *substream,
-- 
1.9.1


