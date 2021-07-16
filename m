Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7DCC3CB678
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 12:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239624AbhGPLAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 07:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239388AbhGPLAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 07:00:18 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E47CC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 03:57:22 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r11so11580741wro.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 03:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KAhUCNsXSWfZRDY3ZqSKN/6QYUwLLIaCYrx90t45ADU=;
        b=IMpi2Q4ymqicNLeTDCRsArSTOQVqHhq01OkQ6W0l/RotBsxhCY40XXshW156HkHQ+h
         57saFGhRuA46UULo4Lz6TWMX3T1o7FX7BCmTMZuNt/8V0Whwk8uX5rH4kIIhSG6dY4Gc
         mlu4t5inig4r+W4fY6L/qIQbQnSq6JJBfn+snTUYrvOkdQKOvc6IhcT90OJ2IYBD4vC/
         PPpYrqNjw2Vepqiz3IgExKGjd/O2GdGmwHO+MXGj+xUElwJcfkAf9wfKJD4oaugocTGv
         EfXJVECThcbIchFE93a3yhPrIQ2kKayShQkRx1I10m29rZqNj5XZsygE6KorXdRoWZnB
         0G1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KAhUCNsXSWfZRDY3ZqSKN/6QYUwLLIaCYrx90t45ADU=;
        b=JUdbQc6lTTnLHq/PEJrTxLb7fkEGW7eXSjiVLBtTlqXExSVnx9aXtWll0slAQUYy4W
         rOaYCkI2CnwIXx0BRbaCB67SA3vw/upkY/Snft0Opl00BjlOY17bsTkwk8qEaj6pUbmG
         ep7evQ1J0woYiGMQBAU27kfzrPLGksM8dUJaC4FZ0UGBlDn5Y4cCjO6sFlqhRGZU4OnG
         4VkihTvGjZhr5Z8pzqBSUmJj4bhUEsiDTDE+5ORtLmlBVxhfSbmjtT8n+j2b+RxlP6ki
         tIVnKT7nDjIaDqjQajDawxjj+fmqEkcDK4W35M+C1szqHw4YELi8Rxi7ewrjw58lfIVW
         ZZlA==
X-Gm-Message-State: AOAM532vTxoJ5hQEUsYyH8Lp5YNDqyhpkiSymZqfG5N+BXrZX5KdQ+NO
        sUcSLzHpn9qImx4PGFqODnT+Ew==
X-Google-Smtp-Source: ABdhPJwYvCNuMOmUchd5HMGjwpesSEbSYa09zjLxtV/ThlZI7pel1TfR45CN7tGvT9Q3CnEvQmUoCg==
X-Received: by 2002:a5d:5141:: with SMTP id u1mr11580456wrt.193.1626433041099;
        Fri, 16 Jul 2021 03:57:21 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id q7sm7815782wmq.33.2021.07.16.03.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 03:57:20 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: codecs: wcd938x: remove unused port-map reference
Date:   Fri, 16 Jul 2021 11:56:12 +0100
Message-Id: <20210716105612.5284-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

port_map field was added prior to adding static port map support in soundwire.
This makes port_map array in struct wcd938x_sdw_priv redundant and unused,
so remove this.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd938x.c | 5 +----
 sound/soc/codecs/wcd938x.h | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index baa3ba99a48f..e32810902383 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -1360,7 +1360,6 @@ static int wcd938x_io_init(struct wcd938x_priv *wcd938x)
 
 static int wcd938x_sdw_connect_port(struct wcd938x_sdw_ch_info *ch_info,
 				    struct sdw_port_config *port_config,
-				    u32 mstr_port_num,
 				    u8 enable)
 {
 	u8 ch_mask, port_num;
@@ -1380,14 +1379,12 @@ static int wcd938x_sdw_connect_port(struct wcd938x_sdw_ch_info *ch_info,
 
 static int wcd938x_connect_port(struct wcd938x_sdw_priv *wcd, u8 ch_id, u8 enable)
 {
-	u8 port_num, mstr_port_num;
+	u8 port_num;
 
 	port_num = wcd->ch_info[ch_id].port_num;
-	mstr_port_num = wcd->port_map[port_num - 1];
 
 	return wcd938x_sdw_connect_port(&wcd->ch_info[ch_id],
 					&wcd->port_config[port_num],
-					mstr_port_num,
 					enable);
 }
 
diff --git a/sound/soc/codecs/wcd938x.h b/sound/soc/codecs/wcd938x.h
index 07b08de4cebf..ea82039e7843 100644
--- a/sound/soc/codecs/wcd938x.h
+++ b/sound/soc/codecs/wcd938x.h
@@ -658,7 +658,6 @@ struct wcd938x_sdw_priv {
 	struct sdw_port_config port_config[WCD938X_MAX_SWR_PORTS];
 	struct wcd938x_sdw_ch_info *ch_info;
 	bool port_enable[WCD938X_MAX_SWR_CH_IDS];
-	int port_map[WCD938X_MAX_SWR_PORTS];
 	int active_ports;
 	int num_ports;
 	bool is_tx;
-- 
2.21.0

