Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF81D350542
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 19:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbhCaRNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 13:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbhCaRMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 13:12:43 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CD4C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 10:12:42 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x21so23177634eds.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 10:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yZeTraQg96mWBG55tgm5XLzk3EVPKVrM7pzYHtn9HsI=;
        b=yB7vEk14tJJavgjrhDI+c+nWWE/oiegDH6ngg99vcKoJg6Z6lClBU5r+jAxenMxH1N
         3gkvVNk2DeIw+kc/kjXtkgVxF3Sm+nD7O5+7isCNwatg3Mj++3Je/R2cDYZ2DgEKv2l/
         PGWs5ef//ypjodYS7crvhqh3SE3btVymrLXAVRootEzc2uRhmbTsym/XQVwJickubO+8
         CNiDw+0SZmx+LE8X5I5DbRWSl10l+yHUFDUuzBDB/r+LXH7EKRH8DRnOE1IjfZnfPNw5
         Idpa4wFu/fb+LeYx9NnKo11KzXaJrBtUaUHb1iStwARAXbtsHfqbu4VGjuC5B+QIDzTn
         jDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yZeTraQg96mWBG55tgm5XLzk3EVPKVrM7pzYHtn9HsI=;
        b=gqy6bSNM6iYkNgkwqNkPFXGmh99LHaTyVCvCtyL2QC79IhUp6yN1+YXiL+CiiTd4R0
         vQOGOBeUvunLQ2EPFTf1ymcUsHCutu3/8xPzmL5RqXA/iP1vsxXO14wwsB2dVDQ19K3Y
         LMz9EU5W2YjQOKG7AeQsMN5yvzfh1UtJBhOCRTEvA05JEv/tJ6LNazDBq7wq972GHfbk
         9R8PV2Vb2ogZUeMC6Ak0bNGd6I2zYe+OySbFlXLeaxI83rFyWBHiMrHr9oN4QPVK8mrz
         w4TA5+H7RNe25lgCk+CF0s6WQydqWOkzyAw4k+xI6ThEZqI9TpU9xeV6a4Trg+pAVK4f
         xANQ==
X-Gm-Message-State: AOAM531MBTQeI0c5b7wmqSvTwE1Fx2UG3WMCnqrdbRFNpO9BS0+3b0zj
        rXa4rW2SNcdnNgXqH+VJpZy91g==
X-Google-Smtp-Source: ABdhPJzRgKF/hq6jj3rkvC0PDwvrgKrsNHIkdzpQol74pXIUWyZrpq2OIt1phYc6qdLYf3kxknYzXw==
X-Received: by 2002:aa7:c804:: with SMTP id a4mr4883683edt.251.1617210761692;
        Wed, 31 Mar 2021 10:12:41 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id h24sm1554131ejl.9.2021.03.31.10.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 10:12:41 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/2] ASoC: codecs: lpass-rx-macro: set npl clock rate correctly
Date:   Wed, 31 Mar 2021 18:12:35 +0100
Message-Id: <20210331171235.24824-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210331171235.24824-1-srinivas.kandagatla@linaro.org>
References: <20210331171235.24824-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NPL clock rate is twice the MCLK rate, so set this correctly to
avoid soundwire timeouts.

Fixes: af3d54b99764 ("ASoC: codecs: lpass-rx-macro: add support for lpass rx macro")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-rx-macro.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index 8c04b3b2c907..7878da89d8e0 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -3551,7 +3551,7 @@ static int rx_macro_probe(struct platform_device *pdev)
 
 	/* set MCLK and NPL rates */
 	clk_set_rate(rx->clks[2].clk, MCLK_FREQ);
-	clk_set_rate(rx->clks[3].clk, MCLK_FREQ);
+	clk_set_rate(rx->clks[3].clk, 2 * MCLK_FREQ);
 
 	ret = clk_bulk_prepare_enable(RX_NUM_CLKS_MAX, rx->clks);
 	if (ret)
-- 
2.21.0

