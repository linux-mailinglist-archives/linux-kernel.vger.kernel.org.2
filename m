Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A68377077
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 09:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhEHHw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 03:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhEHHwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 03:52:54 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E03C061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 May 2021 00:51:53 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id b21so6431833plz.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 00:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pxp734UlOkRRxunoHCpwvTPDDo/epCxir06qlJaIU9c=;
        b=A+qUdMSv0ZBpGuTwDxnlbJCY5Q35JWOwTnBzzuyRxwceC6c7WBDKIpmWtjrKyikp+1
         Ea/HwhjKjM8Tdlm5XEoQn8i38S6Ow7jM+PmnNK2XvTV81bybiUeXl8HnqIHcghgi6gmk
         wNPkPDMJFEGkmekhT8+aoQP4ylGIdkZ2ieC0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pxp734UlOkRRxunoHCpwvTPDDo/epCxir06qlJaIU9c=;
        b=ftmwPxGDmGxbujDfqJpAGVtNzzWIhe+TuIXgv8y161UGuDEbZv28PLTJ4QJYhSyBQI
         vlsvVKYAjTQhLvocbaDrXk2kyfQwvrs9BtTvByk7om6aucjG+nUE6PRdCHKTot7kOl6U
         /xqdxSOdcJ5QFQREtmlBJTpLFN4kdJe3vEvBl0o47uurXIt/dobiVq2TwO7CMQHsZYx0
         L7bj7uk97dGj9renZTKwWLt0XRZ/jKw5SET0DJDm8gqzOnxlTwRKwbc/YOh1Ci3NTWWQ
         k2lS1IZm6xqfmoL6Hsl2V/vm0fYhKLj98KItRVSi+07AOoFgmcBBvALf6KAzsHaphs2w
         Z6zA==
X-Gm-Message-State: AOAM531xeTnywSLFxq4AtGsoGyYz6vU35Vgaz62IbBI5vkEt3IyKcLkz
        vnS4d/bjkSEkGmIFX2FDxtvlCQ==
X-Google-Smtp-Source: ABdhPJxaBMAzmyl39VfTVwVMp2YZpbT/F0pm0xyG8G2PQRr5Psju/7ZCbR7aahhd7NmJJu1e4pdzQA==
X-Received: by 2002:a17:90a:f694:: with SMTP id cl20mr14962788pjb.67.1620460313121;
        Sat, 08 May 2021 00:51:53 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:ab8b:4a3d:46ab:361c])
        by smtp.gmail.com with ESMTPSA id b65sm6345091pga.83.2021.05.08.00.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 00:51:52 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Jairaj Arava <jairaj.arava@intel.com>,
        Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@intel.com>,
        Shuming Fan <shumingf@realtek.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: [PATCH 1/2] ASoC: rt5682: Disable irq on shutdown
Date:   Sat,  8 May 2021 00:51:50 -0700
Message-Id: <20210508075151.1626903-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We cancel the work queues, and reset the device on shutdown, but the irq
isn't disabled so the work queues could be queued again. Let's disable
the irq during shutdown so that we don't have to worry about this device
trying to do anything anymore. This fixes a problem seen where the i2c
bus is shutdown at reboot but this device irq still comes in and tries
to make another i2c transaction when the bus doesn't work.

Cc: Jairaj Arava <jairaj.arava@intel.com>
Cc: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
Cc: Shuming Fan <shumingf@realtek.com>
Cc: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Fixes: 45a2702ce109 ("ASoC: rt5682: Fix panic in rt5682_jack_detect_handler happening during system shutdown")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 sound/soc/codecs/rt5682-i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5682-i2c.c b/sound/soc/codecs/rt5682-i2c.c
index 93c1603b42f1..8265b537ff4f 100644
--- a/sound/soc/codecs/rt5682-i2c.c
+++ b/sound/soc/codecs/rt5682-i2c.c
@@ -273,6 +273,7 @@ static void rt5682_i2c_shutdown(struct i2c_client *client)
 {
 	struct rt5682_priv *rt5682 = i2c_get_clientdata(client);
 
+	disable_irq(client->irq);
 	cancel_delayed_work_sync(&rt5682->jack_detect_work);
 	cancel_delayed_work_sync(&rt5682->jd_check_work);
 

base-commit: 9f4ad9e425a1d3b6a34617b8ea226d56a119a717
-- 
https://chromeos.dev

