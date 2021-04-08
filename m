Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D5C357CAF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 08:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhDHGlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 02:41:11 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:19138 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229745AbhDHGlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 02:41:09 -0400
Received: from localhost.localdomain (unknown [10.192.24.118])
        by mail-app4 (Coremail) with SMTP id cS_KCgBn+kVkpW5g2xebAA--.11207S4;
        Thu, 08 Apr 2021 14:40:40 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] ASoC: codecs: Fix runtime PM imbalance in tas2552_probe
Date:   Thu,  8 Apr 2021 14:40:34 +0800
Message-Id: <20210408064036.6691-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cS_KCgBn+kVkpW5g2xebAA--.11207S4
X-Coremail-Antispam: 1UD129KBjvdXoW7XF1kKrWfWry7uFWfZrWDArb_yoWDZwcEgw
        4rW3yru34rZr47KryUu3y5Za93Zrs5Cr1UGr9YqF1UJr1UAa1kGr1DXrn7uF45ur4xAa1f
        JFnIgF12y3ySkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbVxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2
        jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
        x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWU
        XwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
        8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY
        0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjfUF9a9DUUUU
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAg0JBlZdtTTcOQAAsv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a rumtime PM imbalance between the error handling path
after devm_snd_soc_register_component() and all other error
handling paths. Add a PM runtime increment to balance refcount.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---

Changelog:

v2: - Add a PM runtime increment to fix it instead of moving
      the PM related operations after the registration.
---
 sound/soc/codecs/tas2552.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index bd00c35116cd..700baa6314aa 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -730,8 +730,10 @@ static int tas2552_probe(struct i2c_client *client,
 	ret = devm_snd_soc_register_component(&client->dev,
 				      &soc_component_dev_tas2552,
 				      tas2552_dai, ARRAY_SIZE(tas2552_dai));
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(&client->dev, "Failed to register component: %d\n", ret);
+		pm_runtime_get_noresume(&client->dev);
+	}
 
 	return ret;
 }
-- 
2.17.1

