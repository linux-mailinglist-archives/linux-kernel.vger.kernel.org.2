Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9747E32FA5E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 12:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhCFLza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 06:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhCFLyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 06:54:53 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC5EC06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 03:54:53 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id f124so4736070qkj.5
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 03:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+D7wE8hqhj+u3/A4MDh5ToEYR7A6GBul6TjtK8PAwFg=;
        b=kOYYCzuvIpWfcsFVA+Vm5gphdzTeiTaxbM9nNUaJsO0fQfT9zrxlGxw8tqJ8bFLOie
         LUGiKgiSqW5Rav/ZgTcGH9FU3Gy5b77DFrs4WwUVTNLJXNaAErPOYbMR+eyVhi5nkedQ
         yEYJBq/3GkR92zT9uiigNb+WTGur1UqbvQzt+CF8HO2XtO0YCzN4C3LUkRZk5Kz2HJnE
         iMDZbb1V7CMcaFzwHWB9cUtkTVkldLd3AIjY1pOP82N8L/0+QKa5ATIPqgd/qDYhjAdR
         ntmTZmoKI7tx1eBG+acn/+nNKASYCnm0rIo2LgQ7dWcwnEvwecxmqYOfVU3NbkHnsoFH
         LSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+D7wE8hqhj+u3/A4MDh5ToEYR7A6GBul6TjtK8PAwFg=;
        b=SPi3RIruoFxnQilDNmlT2uyAIqe3YibntB2t5ojyEwUSD3zkd16Aep+T64rZNwfxa7
         Y0KsUU2S2XFeKtl13D6Rc6oCS8bY2N+ICFnt5Ukx+jBN4v9YvfBwUFOjuqftx8DHGAwC
         AJwYYgLWJ5qQzP65/HeQaZwDSZxO82Zs51Tanj17n+8K1stga3FlQlXk0eDnKo+YfdwG
         MLbf6j7hPVKfDu20wvC78Kb/EEbeqDzg1xwYUCcbaXf23Z1eMFWHQqLhx8QdZ5OFTkPR
         0O5yXU43OrB0/OsZpOwjCjnWFRrcb4zWpgwA+Wz6t6pajunFlNuDwO6FVmA4BSVmBf+i
         m9DA==
X-Gm-Message-State: AOAM533O3gx+YIUDp+HEfQag9xwnAxFvlgb2Lb6c2F22Agwv48/zywP2
        Zd0QyrnmK/NoBcRjzx+jpDk=
X-Google-Smtp-Source: ABdhPJxQqsn1DCr5BflNfEfvSuiQWgWDFs9zXst6srNskXXUuRSVBA/Kbpl3ACGwInOSqdV1enXiyQ==
X-Received: by 2002:a37:9e56:: with SMTP id h83mr13445402qke.38.1615031692557;
        Sat, 06 Mar 2021 03:54:52 -0800 (PST)
Received: from localhost.localdomain ([143.244.44.230])
        by smtp.gmail.com with ESMTPSA id v4sm683186qte.18.2021.03.06.03.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 03:54:51 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, kuninori.morimoto.gx@renesas.com,
        gustavoars@kernel.org, ckeepax@opensource.cirrus.com,
        peter.ujfalusi@ti.com, unixbhaskar@gmail.com,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] sound: soc: codecs: Fix a spello in the file wm8955.c
Date:   Sat,  6 Mar 2021 17:21:51 +0530
Message-Id: <20210306115151.31759-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/sortd/sorted/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 sound/soc/codecs/wm8955.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8955.c b/sound/soc/codecs/wm8955.c
index 513df47bd87d..538bb8b0db39 100644
--- a/sound/soc/codecs/wm8955.c
+++ b/sound/soc/codecs/wm8955.c
@@ -151,7 +151,7 @@ static int wm8955_pll_factors(struct device *dev,
 	/* The oscilator should run at should be 90-100MHz, and
 	 * there's a divide by 4 plus an optional divide by 2 in the
 	 * output path to generate the system clock.  The clock table
-	 * is sortd so we should always generate a suitable target. */
+	 * is sorted so we should always generate a suitable target. */
 	target = Fout * 4;
 	if (target < 90000000) {
 		pll->outdiv = 1;
--
2.26.2

