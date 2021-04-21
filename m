Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62A8366A6C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 14:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239639AbhDUMGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 08:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239569AbhDUMGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 08:06:16 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE8FC06138D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 05:05:41 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id s15so49076306edd.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 05:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mjz+dO0g52LTTWXvSkIafdv3wxVfZ3PM2K0TUZQe8w8=;
        b=qOhB6Bn4fdio6Oa+hCIyEtIzF/fPU1n900yfQN1KRUOmt0VxoAXNItjh4iktYz1nFF
         txn7A0NZdiBTN/SeMc+MDLdsvD0dTlB9+bVCvSjWVm9JTiKHTqOLQRM4X60LqC6QfgDu
         gCD6ek/S3BQCAozMyvXPVavOf0CNfgcn5b++PicQrqh6Q0nBwkEIfF8GF1ssNiYrIAbV
         PYUbypf1GVSjexslHQOaf3gRO73TPzn6PY0qIYX1IbLGDYcqY7uYmvr5JXPdZnx0DfZP
         kXqVGpArZJub0qyfEZkrpe89DBxVvFNegS0bci4vYbotJ+IO9cSymdI4ojNR28q3l/J/
         uOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mjz+dO0g52LTTWXvSkIafdv3wxVfZ3PM2K0TUZQe8w8=;
        b=aCyu1fSYMZXfQavie/j94w5qrtC8l/IM5I7K4g8Fa/Rhh69I+nGpBtM6h9aT7Rklp0
         mMvoDFYYn6Le1DB5bYf7V+NpMCGtwdFlR1+ol9NSbmzz6m1hqKTdN16E2HHK9QINlSK2
         aZAg9SR90xF961sVhNXEOQd3PbxUuI23kPSXOfiaJlN2yEDlepTaK+M92Qv37fIESrq6
         bZi4ejCn+hEIrTTehxj9Z4c4rw4EZMIvpYn2Oaq1gsntn5sZxmPoQcJvV1AFmi4xgaTq
         mR+wBfENVOuvMF3fcXVKjZmcn+zfIOiU8Jki06lUFirqONKFa4uxqdMeFmh+3fYqcNSq
         OJbg==
X-Gm-Message-State: AOAM531MTtGGjjg+afCw985HBl/qw9/COAJxaiCKz5PPVZ+CwZJ3rCvP
        U3sokZG6Ofzd7dhuiFitXfF7MQ==
X-Google-Smtp-Source: ABdhPJxxLKeeLIx0fL7Nswahk3sJ8ZZX4hGBA1vUHi5Y9fX7pUBLtrsEO39L5a3O2YsxRJ32QemvTA==
X-Received: by 2002:aa7:cd83:: with SMTP id x3mr37696169edv.373.1619006740670;
        Wed, 21 Apr 2021 05:05:40 -0700 (PDT)
Received: from localhost.localdomain (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id n2sm3151431edi.32.2021.04.21.05.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 05:05:40 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v2 5/5] ASoC: da7219: properly get clk from the provider
Date:   Wed, 21 Apr 2021 14:05:12 +0200
Message-Id: <20210421120512.413057-6-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421120512.413057-1-jbrunet@baylibre.com>
References: <20210421120512.413057-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using the clk embedded in the clk_hw (which is meant to go
away), a clock provider which need to interact with its own clock should
request clk reference through the clock provider API.

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/da7219.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 13009d08b09a..bd3c523a8617 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -2181,7 +2181,10 @@ static int da7219_register_dai_clks(struct snd_soc_component *component)
 				 ret);
 			goto err;
 		}
-		da7219->dai_clks[i] = dai_clk_hw->clk;
+
+		da7219->dai_clks[i] = devm_clk_hw_get_clk(dev, dai_clk_hw, NULL);
+		if (IS_ERR(da7219->dai_clks[i]))
+			return PTR_ERR(da7219->dai_clks[i]);
 
 		/* For DT setup onecell data, otherwise create lookup */
 		if (np) {
-- 
2.31.1

