Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0627245312A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 12:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbhKPLuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 06:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235111AbhKPLti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 06:49:38 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E083C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 03:46:41 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id f7-20020a1c1f07000000b0032ee11917ceso2183833wmf.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 03:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t7SqZxtta+mFLRYTDvdmuGnMtffgbWCF/KOCCvJj+EA=;
        b=jjxHofpHAKBd0KHns0B1Gry9ElbrUXFC1jp7j94izHFvYPTk0lRL/PU8Wyy7XJIuTG
         h/gsZH0mtINoyfoFW5dou62IzP4dP5F3kXlJpUk+Bqu7Gf7Hd21U8WOBQNhjK/MnJ4vn
         kzQIBUzp1g03B+ZgEiR/6Kxj7bqp3W7Z9BSMV5ip9Lm9Ee/rgEbh78ERAFKQEtFADves
         RkIdzggXJNT1G42ngFVQMyI1uUEJRCH1PT91ObDmouyQwkxmnaJOzBhG7eOnyChPXnqi
         jC8Upmz+MKR+shhNP8yyGm1dzS5Ye/w56KStFeke3k2E1vYF7ySvmgFvsOGypX8kc8ZL
         iG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t7SqZxtta+mFLRYTDvdmuGnMtffgbWCF/KOCCvJj+EA=;
        b=S6qEGlu2k/5Ye2KdF1vC5BmwF4aI8GSWw/nZxJ6LBqFaJWB3c/V5JV19EFmWPR9upd
         zsJJk83a7lh4FfF7ViZbRdVYckeJ0RJOhPkSfWY6XguI2PdtS2r1pacKChfrhix7p4fa
         yWQGK+34tzn2Xb+JkFFReSaq38q0jqESoB5xB7YnamNoYak5X1YZ1zqrxPB+OQzas00K
         BhpyaoUso0gWw9nC4NJlc8dVPOh6nNWibBLdoKVgbu94aHPtWhaOkITS7VNUKoyWyoRG
         MIjjk4I+IICBRqDQZWCNnFQwrBd5XuLTrDsQhRyGarvthQsuz/aNUuxVYWe9cJCrajJe
         qhyg==
X-Gm-Message-State: AOAM531uox3znL9fCST4UuCwcoqk6P+uvNPwFqcf9Z0L9X/MrGluq5dP
        x7QMirswU60rRFEvFQxVor09fA==
X-Google-Smtp-Source: ABdhPJxc/BBjcLSYDlxo9++43Rv4L1uBuM0AajhwiPP2EDZv6VCN+s2RVJhXAa/UGahI9gvifaNVTA==
X-Received: by 2002:a05:600c:5125:: with SMTP id o37mr6988822wms.81.1637063199925;
        Tue, 16 Nov 2021 03:46:39 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id z11sm16934698wrt.58.2021.11.16.03.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 03:46:39 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/3] ASoC: codecs: lpass-rx-macro: fix HPHR setting CLSH mask
Date:   Tue, 16 Nov 2021 11:46:23 +0000
Message-Id: <20211116114623.11891-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20211116114623.11891-1-srinivas.kandagatla@linaro.org>
References: <20211116114623.11891-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason we ended up using snd_soc_component_write_field
for HPHL and snd_soc_component_update_bits for HPHR, so fix this.

Fixes: af3d54b99764 ("ASoC: codecs: lpass-rx-macro: add support for lpass rx macro")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-rx-macro.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index 2bed5cf229be..aec5127260fd 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -2188,7 +2188,7 @@ static int rx_macro_config_classh(struct snd_soc_component *component,
 		snd_soc_component_update_bits(component,
 				CDC_RX_CLSH_DECAY_CTRL,
 				CDC_RX_CLSH_DECAY_RATE_MASK, 0x0);
-		snd_soc_component_update_bits(component,
+		snd_soc_component_write_field(component,
 				CDC_RX_RX1_RX_PATH_CFG0,
 				CDC_RX_RXn_CLSH_EN_MASK, 0x1);
 		break;
-- 
2.21.0

