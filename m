Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6643AEA4C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 15:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhFUNro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 09:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbhFUNrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 09:47:41 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8982C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 06:45:24 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o39-20020a05600c5127b02901d23584fd9bso11144149wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 06:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8W5nhl+E1Jscrd29RdD//tmI8j2cQzzETvUZPc9CaL0=;
        b=RWVK1iYzzle9AEz+xodpd8RcSevaWoL296o9oBGwPtEOLzygAjgg2AtnDFl0yH/f91
         /SZWyENY/SSJv9yUAirokw3cJIF1kJQ0w5R9f9HU8wWGOomeVoZz5x5Yi548NkqYpuJA
         Ds2y26JuXlCxrMI/UJ5EfbkFDOiV8PZOw8NA63hAw9OQ/GyryE8XjPWp86utBZgQsBJj
         E1Za9IdK+OKfvtLVBbXPPtBjqW8+Bh1sQK9bUZ8IHwSrvKBUMRCl8lxoSah6AGS82+lD
         YQJM57WjNWUb5rki2tDJKnyydogA9+dSNeJ1chXMY1Bvzv0IFoMtwlZPVns7BZbbdPTp
         M8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8W5nhl+E1Jscrd29RdD//tmI8j2cQzzETvUZPc9CaL0=;
        b=QI6jRwHhycZ7dqdxMKCRa9P9HOZIzGyqrPaj8roN1kwji+qhjvXSgpWr1/1bpDi9oi
         yVVwSAI0GiogIw+N2v3J2X2u7ioZ0TWvHYzg3wVguCUqdv6ZXIwtTNFiTIs0A6zMah4r
         pyoP/azhcTekb9u5Y6HW2fij/L/6eMAX9n8LnK1hvGaldYl51abNDvT7QCtfbKW4s9mb
         jrUbkl3SSknpcqTBPnGbAjkDt8KcP6Uoc0diCkR4453fNbIk2YACG/UR8oTaBDND6z7M
         RioYRk+v4Q5j272qF4lgnW6GyH6EPLXHSmxJcVuQ2qENP1SWF30912fMebrevctCPfRM
         vR4Q==
X-Gm-Message-State: AOAM530WKQG8YfBlTROiwQSjJwFjhnzvOn+EDgwEKK/EvadzUcTfpHqd
        vz8wHGp6ZOQ1vhbXNIhHDXNZzhS9DOqvXA==
X-Google-Smtp-Source: ABdhPJywfntwqCOwSS9wjiSUCUjFC/d0VtmUvA0ChK9E9Ep7JTEfxh5L3ggLCOOTT89F61RxASAYfQ==
X-Received: by 2002:a1c:3dc2:: with SMTP id k185mr27324248wma.15.1624283123343;
        Mon, 21 Jun 2021 06:45:23 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id e38sm12848741wmp.4.2021.06.21.06.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 06:45:22 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] ASoC: codecs: wcd938x: fix unused variable warning
Date:   Mon, 21 Jun 2021 14:45:01 +0100
Message-Id: <20210621134502.19537-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below

	warning: unused variable wcd938x_dt_match

by placing device match table under CONFIG_OF

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd938x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 4be61122b0b5..427f51fade37 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -3714,12 +3714,14 @@ static int wcd938x_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#if defined(CONFIG_OF)
 static const struct of_device_id wcd938x_dt_match[] = {
 	{ .compatible = "qcom,wcd9380-codec" },
 	{ .compatible = "qcom,wcd9385-codec" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, wcd938x_dt_match);
+#endif
 
 static struct platform_driver wcd938x_codec_driver = {
 	.probe = wcd938x_probe,
-- 
2.21.0

