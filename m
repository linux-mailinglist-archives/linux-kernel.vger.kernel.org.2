Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0759B41EC90
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 13:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhJALwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 07:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbhJALwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 07:52:21 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B533C061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 04:50:37 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z24so37800315lfu.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 04:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tikr9EZMT945WPgYWh9Nfqx3BfJVYbeGQaW2V2Yhcjc=;
        b=WTBuQ0rPJV/Ok7LCI1PrJ5Kfqf/f8P4JU0bXCUh8b+0fVB+ECaS+PnN6ERStQR/Qgr
         o490bxUOqMG9zVsqcsc/uS0JK/q8anPUCMONRy0F26ul+BBL1nKAOd625zXLpttdoUDO
         /dK6/2+JWkofULHsShHZs0UfKsD4DW5IB2QkXkDv3xw9Or3qkd6Inu7jpaPug9zUyzqS
         LkvOOr4i00ugU+lwpwcaPqyAn8yJE5FU0cr4J+G67Z/5PEpTMh4MCJn5a6b0Wb6SP6Ga
         2Di5bptMVEkg90mEgQWXg9nDavmQ62EhKEmzfGrdfg8xH8BsFl5L3O019Qn1IWQg+dJn
         uLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tikr9EZMT945WPgYWh9Nfqx3BfJVYbeGQaW2V2Yhcjc=;
        b=DKKPwN3vhgT6pM8e61kJxBqvR32gvsXJyTFCEIb6iqtiJJ0+3cpitixgkRSIOFnssj
         5DRNGHhz725H01HmXbQbpOSLQkmMTrkXrsqjgdmxzd2M0PC9gWV1+IhH3lc3mZfgq17D
         Sbn7gs+WDS4dT2guUn1/C8JYBYF34E6RtK/UFUv7kmek56CvahSoClrs9k6hlQo8qcPt
         o3NHdOWJEnYUqj0U2P+gVwm/bkJIkUZVfGVGlNn5Npj2BWTb4MykXlZVdSm9eFYUG5CX
         aJMZsmia/gAyo/dBOZ6AHOFHXxaiWtBNMcYv+K5x2r8Va7nuE/Xj/gVsNjGMXR/w7wT/
         PHtQ==
X-Gm-Message-State: AOAM530KAnB4IBZjdDuSjgLEgUaOoA+TKK6CBgaW6+tVY1N8D4Tbt0FD
        ITRAueWwB+Cu+JCk9lPP+1s=
X-Google-Smtp-Source: ABdhPJxJDmWHcrZik6HLvUlDJZz6hv3jM85md+Uns+Jp1F0snEfO/mWYcaJEPiAfhnFmZ3RcGB8RCw==
X-Received: by 2002:ac2:5c50:: with SMTP id s16mr5003776lfp.605.1633089035692;
        Fri, 01 Oct 2021 04:50:35 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se. [98.128.228.193])
        by smtp.gmail.com with ESMTPSA id j7sm346340lfh.23.2021.10.01.04.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 04:50:35 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] ASoC: qcom: apq8096: Constify static snd_soc_ops
Date:   Fri,  1 Oct 2021 13:50:30 +0200
Message-Id: <20211001115030.10402-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct iapq8096_ops is only assigned to the ops field in the
snd_soc_dai_link struct which is a pointer to const struct snd_soc_ops.
Make it const to allow the compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 sound/soc/qcom/apq8096.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
index 1a69baefc5ce..c7b7d0864d1a 100644
--- a/sound/soc/qcom/apq8096.c
+++ b/sound/soc/qcom/apq8096.c
@@ -60,7 +60,7 @@ static int msm_snd_hw_params(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static struct snd_soc_ops apq8096_ops = {
+static const struct snd_soc_ops apq8096_ops = {
 	.hw_params = msm_snd_hw_params,
 };
 
-- 
2.33.0

