Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B8B3322CB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 11:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhCIKQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 05:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbhCIKQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 05:16:19 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9A4C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 02:16:19 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h98so14529914wrh.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 02:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k2f0tZenESZ9YncapAA9EaDdy6imStpc0DvcSxZrmo4=;
        b=pTzLXCk2Aedtr6NwVfE+2EGGtQA16W6Rv+sGF8jMvDqFt94ESMP/AUGZvVpAf7bZ3g
         JtkOokCwXibCkC+NEMj+29fpFsHV9Z2voqM4sT8GARnoZOYWjNlWgzRavmZvPGpm85oX
         rOMjt+ZWdmMmmSfq/LxUa/1MgkYUlaLxEx4+6RyNSzUWXDMr6B3ZvlkuWkUiHNgS9I7/
         +9A5fQi+jvfd93hADIQqfNSYG6LAY/YVqxRoWmcimPH/k/Gt96pR8wxtvsegKQKQPZCx
         CdeLpzHKpzuLweLG2kCx9LTSwgz/I0hW/4VuInPTTt4UDjbzVOxN/YgUeSIrBhcvNOMw
         Pd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k2f0tZenESZ9YncapAA9EaDdy6imStpc0DvcSxZrmo4=;
        b=Uytm5nsZoLY5b0sbk6Zkwz5fdHiWk1L0P8zjoN6ucVsqAu/Co3rD7FeJVzIPkstRx9
         iuAMMaMfoBtSD+ksvaOJdXpKzMkstxWghSo3v6OX3qGfSlTQWFBxfM6e1dlsteu/3eUs
         2we3q7ELe4t+VKxsBgE5Kwf5ggzP7f3AE8P5q8m1mTtp5fCRF6n5SJFNEJY3GE5iPvRi
         M1nGAfJx8aH9PbP6OTFvHYB3BayUjzJC8g3Dx8a8a/MdLBzJaU2lAgWbpaupTBUxiD9D
         tc4S8aT2maFlWKFWNQiupaJ393XuY23zQFLOnw4dlNUWW5yxUGHwG52lb8kQVBmFQuB4
         f+bA==
X-Gm-Message-State: AOAM531QZMbtZuyFwaHPrdKKv/luHnJf4YVXoAB8SY991u26Ddyv+O4y
        ETAmsavO6RzV4IsnVSpkipLKyQ==
X-Google-Smtp-Source: ABdhPJysCEn7R3n1S1UKNF5EIYYLunM/WXcDB9bEOK2WFJAcZFx+M2y9CWDMkpxp9pAyr/BdErrlKQ==
X-Received: by 2002:adf:fe09:: with SMTP id n9mr27607109wrr.104.1615284978392;
        Tue, 09 Mar 2021 02:16:18 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id r2sm22552248wrt.8.2021.03.09.02.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 02:16:18 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        john.stultz@linaro.org, amit.pundir@linaro.org,
        bjorn.andersson@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/3] ASoC: codecs: wcd934x: add a sanity check in set channel map
Date:   Tue,  9 Mar 2021 10:16:13 +0000
Message-Id: <20210309101613.25995-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210309101613.25995-1-srinivas.kandagatla@linaro.org>
References: <20210309101613.25995-1-srinivas.kandagatla@linaro.org>
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
 sound/soc/codecs/wcd934x.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 40f682f5dab8..1d27cdf5277d 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -1871,6 +1871,12 @@ static int wcd934x_set_channel_map(struct snd_soc_dai *dai,
 	struct wcd934x_codec *wcd;
 	int i;
 
+	if (tx_num > WCD934X_TX_MAX || rx_num > WCD934X_RX_MAX) {
+		dev_err(wcd->dev, "Invalid tx %d or rx %d channel count\n",
+			tx_num, rx_num);
+		return -EINVAL;
+	}
+
 	wcd = snd_soc_component_get_drvdata(dai->component);
 
 	if (!tx_slot || !rx_slot) {
-- 
2.21.0

