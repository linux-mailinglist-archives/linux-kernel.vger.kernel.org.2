Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A47332878
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 15:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhCIOWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 09:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhCIOWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 09:22:00 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF04C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 06:21:48 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id l12so15932714wry.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 06:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A31MLzcUUZxKNDle59AEPrSG341kwaYtutGOJhEp5Bs=;
        b=y/cECAfOj4w96o3lr+rxNHByHgL4Y/E3/hC0XHEYqmIJ+EtP0tisupHMmSg85yUGwN
         S7CcPEVF04MX7yL6ukMSkNfzwahiIWZIwKHbuqEU7ZbakNAj41M1jGrdY6iLIWv2rdAy
         oR9gU4ttqGc+lkmP22J1JN96yBO6AH356D1HZtL83nWHGVTSc/ZEYYSMZ5BgFzoco4Rc
         d5gwKdPT8kt2D4tehKAyVKm1PO3SgHkAqlc0SgeciESjIKNrYUKMumT9zGO3Zreksqtc
         0jnrrErVSyBBeJsDzYx87orupogyKfC2V48wb6SXmCkT6urKJyCGU6gsLUqmSHBHVba9
         ptWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A31MLzcUUZxKNDle59AEPrSG341kwaYtutGOJhEp5Bs=;
        b=SlV1xC0kksXsdxmF7jvVo73/poCX1HEJak7FxPDcftPH2vnjTnFSZ2JiQ42FRl5UJ5
         q/p6EVr4Iy3grRTIb4AZrQmS5uDf1OYk5byhUPViMCiE/0AGo6WzSYWEvwJppi9g+WaX
         NF2sv/kHhb+9R7ZzVbZDJkpHjd/7aMkhN2GdPzmhuBMS1M+0tFDfEfRv3gAWBVW0Gpxf
         OtncSfFmzOdXKC7Jz+ohdcXnpgTqgXwO1iV1Zcbii1YOxBI0o0iA+n4HH5ga/LxrX0NZ
         8Ng21H8Sm/bQGQO1bZC13OAsh3qsHSTySvn3SG1P7uDmkADZGfy9ZU0qH+3qLgo6dlht
         c1Ig==
X-Gm-Message-State: AOAM530wR8A0HimBCWTFGVR5WiKEHkUvEKjslRcbmiAfVjeF95RVHvDw
        5Hd7j8rRE/zXwmLd0GR5IP9bjA==
X-Google-Smtp-Source: ABdhPJy042LtlHEfuJfKqiOVGQ92boBU4NMnlk4/3C8Cz9Q9MRZON0Jy5Qj1AMRfbJmQDqmxFdLsxw==
X-Received: by 2002:a5d:6406:: with SMTP id z6mr16698147wru.264.1615299707516;
        Tue, 09 Mar 2021 06:21:47 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id j14sm22265123wrw.69.2021.03.09.06.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 06:21:47 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        john.stultz@linaro.org, amit.pundir@linaro.org,
        bjorn.andersson@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 3/3] ASoC: codecs: wcd934x: add a sanity check in set channel map
Date:   Tue,  9 Mar 2021 14:21:29 +0000
Message-Id: <20210309142129.14182-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210309142129.14182-1-srinivas.kandagatla@linaro.org>
References: <20210309142129.14182-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set channel map can be passed with a channel maps, however if
the number of channels that are passed are more than the actual
supported channels then we would be accessing array out of bounds.

So add a sanity check to validate these numbers!

Fixes: a61f3b4f476e ("ASoC: wcd934x: add support to wcd9340/wcd9341 codec")
Reported-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Changes since v1:
	- make sure the wcd is not de-referenced without intialization

 sound/soc/codecs/wcd934x.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 40f682f5dab8..d18ae5e3ee80 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -1873,6 +1873,12 @@ static int wcd934x_set_channel_map(struct snd_soc_dai *dai,
 
 	wcd = snd_soc_component_get_drvdata(dai->component);
 
+	if (tx_num > WCD934X_TX_MAX || rx_num > WCD934X_RX_MAX) {
+		dev_err(wcd->dev, "Invalid tx %d or rx %d channel count\n",
+			tx_num, rx_num);
+		return -EINVAL;
+	}
+
 	if (!tx_slot || !rx_slot) {
 		dev_err(wcd->dev, "Invalid tx_slot=%p, rx_slot=%p\n",
 			tx_slot, rx_slot);
-- 
2.21.0

