Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3C936D73D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 14:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbhD1M13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 08:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbhD1M12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 08:27:28 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356B2C061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 05:26:43 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h4so53792160wrt.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 05:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mq5mQkRS1/Si/vDDQIIoPNxNsDItueuxM0NFUO8KGvU=;
        b=GbiOuP+Zfq0WtKT1Gz3U2J6/6JGvZlhycSoIe1ZtjST8VNRC7IwMCQL19wOWNL00xw
         3fmmNd5BdiXaV8rbd5o5AhO+ROk48RkMVvEIu519KsTE8CZMUhwNLuWdxCqyBIDp5bsZ
         qScvt8dEhNhwQ5vECkvzV56z5J81kp40NSrrqSuk9/0C6YlgTvhutDYLirayNbTSwhgm
         xZckvnh0rfOhVGpL2ah1lZnETsI194xRMxTxW3YXhCkUN2ur8F3dQQDtcQlcZ7hoHdJK
         IFVxFte0FRzTlKTEAYrmWud/Xr0Dh8BvHfm9yhRDlGEAyiBGBYAo5sNSugG3Ed4kF8wG
         +krA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mq5mQkRS1/Si/vDDQIIoPNxNsDItueuxM0NFUO8KGvU=;
        b=I0KD9HS5oCi7UgVP48cQp8qs8Lq0aZADkn45gDAivibycxRq7oNFfqt6mwxSxs0UPz
         HLswJT3k/q4W2/7jDw5MXhwl0HvNYO8FKEy5i6iUS9EPutL17FcM6G0Jsi/HQA3v14aB
         VePSNZOxCVPknI8i6zqaOeLpbR6GvqSrJfMjgR45RTOBf8Ex9grRXdb0tmmKaIS8ygMb
         kjBSGB/B6nhTSdCx0yECv0xuiwR7bVShmO9QN3cZqK0FaUd3zCOaV/r8OTbm90+fay/z
         lhYTmoRt8CPn+KCEnLbQ6OIYjnv6kO3WZwLERInjudL143/h6ScCVZEX3f622CmRUDZd
         QaQw==
X-Gm-Message-State: AOAM530IYek8qs0Thz2+N5IXmeVh7uz/wyE7ZUAFVW37uskbW0FFpDU+
        ZxRRuN/rlXYdHeH6SV9c95Ebig==
X-Google-Smtp-Source: ABdhPJyA65vTcGjZeG06k0Wrhp8jdCphSvGpg9OIl6uZPja/c30vy8MbqaTSisAtX2IBFwB8ZE09Sw==
X-Received: by 2002:adf:e2cc:: with SMTP id d12mr35729479wrj.90.1619612801917;
        Wed, 28 Apr 2021 05:26:41 -0700 (PDT)
Received: from localhost.localdomain (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id 6sm7872021wmg.9.2021.04.28.05.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 05:26:41 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 1/2] ASoC: stm32: do not request a new clock consummer reference
Date:   Wed, 28 Apr 2021 14:26:31 +0200
Message-Id: <20210428122632.46244-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210428122632.46244-1-jbrunet@baylibre.com>
References: <20210428122632.46244-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 65d1cce726d4912793d0a84c55ecdb0ef5832130.

There is problem with clk_hw_get_hw(). Using it pins the clock provider to
itself, making it impossible to remove the module.

Revert commit 65d1cce726d4 ("ASoC: stm32: properly get clk from the
provider") until this gets sorted out.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/stm/stm32_sai_sub.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index c1561237ee24..3aa1cf262402 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -484,10 +484,7 @@ static int stm32_sai_add_mclk_provider(struct stm32_sai_sub_data *sai)
 		dev_err(dev, "mclk register returned %d\n", ret);
 		return ret;
 	}
-
-	sai->sai_mclk = devm_clk_hw_get_clk(dev, hw, NULL);
-	if (IS_ERR(sai->sai_mclk))
-		return PTR_ERR(sai->sai_mclk);
+	sai->sai_mclk = hw->clk;
 
 	/* register mclk provider */
 	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, hw);
-- 
2.31.1

