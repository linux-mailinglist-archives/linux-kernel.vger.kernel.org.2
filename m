Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93AA5356490
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 08:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345949AbhDGGyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 02:54:39 -0400
Received: from mail.zju.edu.cn ([61.164.42.155]:48462 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229778AbhDGGyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 02:54:37 -0400
Received: from localhost.localdomain (unknown [10.192.24.118])
        by mail-app3 (Coremail) with SMTP id cC_KCgBnn9QKV21g7hvcAA--.15055S4;
        Wed, 07 Apr 2021 14:54:06 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rob Herring <robh@kernel.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: codecs: Fix rumtime PM imbalance in tas2552_probe
Date:   Wed,  7 Apr 2021 14:54:00 +0800
Message-Id: <20210407065402.17729-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgBnn9QKV21g7hvcAA--.15055S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Cry5Xw4kXF18ZFy5Ar15CFg_yoW8Xw4rp3
        y8XFZ5KF4UJryxC3yqya1kXF9Y9Fy3Wr4UA34DK3WUA3WkJ3WkKF4UKry2qF4IqrykuFyD
        WryUtFWayF1Yyw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvG1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
        c2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjfU5sjjDUUUU
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgoGBlZdtTQGhAAdsd
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a rumtime PM imbalance between the error handling path
after devm_snd_soc_register_component() and all other error
handling paths. Fix this by moving PM runtime decrement to the
end of the function.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 sound/soc/codecs/tas2552.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index bd00c35116cd..52de6f7b4227 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -718,13 +718,6 @@ static int tas2552_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	pm_runtime_set_active(&client->dev);
-	pm_runtime_set_autosuspend_delay(&client->dev, 1000);
-	pm_runtime_use_autosuspend(&client->dev);
-	pm_runtime_enable(&client->dev);
-	pm_runtime_mark_last_busy(&client->dev);
-	pm_runtime_put_sync_autosuspend(&client->dev);
-
 	dev_set_drvdata(&client->dev, data);
 
 	ret = devm_snd_soc_register_component(&client->dev,
@@ -733,6 +726,13 @@ static int tas2552_probe(struct i2c_client *client,
 	if (ret < 0)
 		dev_err(&client->dev, "Failed to register component: %d\n", ret);
 
+	pm_runtime_set_active(&client->dev);
+	pm_runtime_set_autosuspend_delay(&client->dev, 1000);
+	pm_runtime_use_autosuspend(&client->dev);
+	pm_runtime_enable(&client->dev);
+	pm_runtime_mark_last_busy(&client->dev);
+	pm_runtime_put_sync_autosuspend(&client->dev);
+
 	return ret;
 }
 
-- 
2.17.1

