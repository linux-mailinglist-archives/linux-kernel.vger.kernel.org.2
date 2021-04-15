Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6046B36037F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 09:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhDOHjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 03:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbhDOHjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 03:39:01 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD450C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 00:38:36 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a85so15054613pfa.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 00:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6GHNy9nmTbGMe04/93664ci3I2+TW59tCe+/W5uRP0o=;
        b=LeHh8dIPPEH1uxk+ZfQX0XVqvC0FADJVR3NSCFf6Ay5cTWymnllDYhWv15xkha3PJr
         9Q2FiQcc2p2FkIFj7gn6vrtAVVCa7oXlwl2aNNGf6QHOxLM0xvn5D6QHsGeUvWZ1lU9E
         Xesan0sauohfnex+AZ3SXFcCfUK/PJwCZHD8Wc/AeyiK/VtSALILF2pay1x1hTXZRVjc
         sohVqKEhmw9KVb0kLcH+umLNZMNbAyYDTrUhLllTGm000/r/TPenLcyeXFxmG1o2nbFE
         vY6i4D2dzqIKi2TDu+G3cpl/IIXC2v8/GZMPmTs7YFjqcdV1tqk1+vwuurfudJ4gi+kZ
         4szA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6GHNy9nmTbGMe04/93664ci3I2+TW59tCe+/W5uRP0o=;
        b=YlchHV0xQyfrRNoZzPcAP8Gd3C7Awh+kWtn56Mo8Hl8fZ4fOHVj6fJ1h7DRSoemH1p
         V1LyDF15zvaOQZKlX/hpRgkpgEDUUWKsutrzTAgmDBdTizzOAAwsPrMhDblNZCKYH8nq
         MxQNpYLgcLVNHUELq1T/u0u4Yg1FBYGYnKyurhznK86xUkmfJVRoWk/uliifWecPTP0b
         wLoMXzJfdieRiDaz5bqNBg+RHE349ctYnFmk72NSgW2ezkbNPZjwJ+96z49ds776tCsp
         WaCEe4Vgrq6CCLWZsiWGvNlhefE1MeKb083M08HDhh+5flhSqUU2p7CyX8ItZHpAEXbW
         8v1w==
X-Gm-Message-State: AOAM5318bzWAYCXA2NmPSNrt92Harp5YqRFIYmqrYPCLk9tR467RiEXr
        TmAa9oHPNjTSG3Z6YCpE+IQ=
X-Google-Smtp-Source: ABdhPJyPyD+7YswXHYLAmeDKVHdJIuPH5kWEybfUXLVFNMKTQQqXG50b3/COIkx2AjOz5gH4WF34Vg==
X-Received: by 2002:a63:5508:: with SMTP id j8mr2334912pgb.36.1618472316398;
        Thu, 15 Apr 2021 00:38:36 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id 23sm1508138pgo.53.2021.04.15.00.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 00:38:36 -0700 (PDT)
From:   zhuguangqing83@gmail.com
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org,
        Guangqing Zhu <zhuguangqing83@gmail.com>
Subject: [PATCH] ASoC: codecs: wcd934x: Fix missing IRQF_ONESHOT as only threaded handler
Date:   Thu, 15 Apr 2021 15:38:29 +0800
Message-Id: <20210415073829.22750-1-zhuguangqing83@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guangqing Zhu <zhuguangqing83@gmail.com>

Coccinelle noticed:
  sound/soc/codecs/wcd934x.c:5041:7-32: ERROR: Threaded IRQ with no primary
handler requested without IRQF_ONESHOT

Signed-off-by: Guangqing Zhu <zhuguangqing83@gmail.com>
---
 sound/soc/codecs/wcd934x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 5fe403307b72..cddc49bbb7f6 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -5040,7 +5040,7 @@ static int wcd934x_codec_probe(struct platform_device *pdev)
 
 	ret = devm_request_threaded_irq(dev, irq, NULL,
 					wcd934x_slim_irq_handler,
-					IRQF_TRIGGER_RISING,
+					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 					"slim", wcd);
 	if (ret) {
 		dev_err(dev, "Failed to request slimbus irq\n");
-- 
2.17.1

