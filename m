Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13FC453129
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 12:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbhKPLuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 06:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbhKPLth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 06:49:37 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2098EC061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 03:46:40 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 133so16683928wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 03:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vU5yaEpd/Y0DZa1Q/uJoC95gJS14ZCBm7xrXmd2b678=;
        b=q6wAjGaeA6r4rXyycstm1UqubMBDnj8KkmEe3inUHwr7tTisgEBUt4wXQAgESktp7h
         D2ayhCAY74WbLD+9BtrTnKNLwOxlPFGJW9p19LMaR+9oBoEmcWxswLwo9wdzBcu2U/XP
         M9BHY8eOjDy0kdd2cfO87vmHlyGdNIxLVaUl9H9+bkFfhBR40JieNFh+eDaj2jlOfMq1
         7QAwTQd3gwD2QXxgOv8YgaL9bCHBEBcSAKkn3b0C8ijP1DYxyVSnLl9M0aeT/Jd9/xJl
         FjIitTuv8lsGPvh0+906Y23QM+O+LSzufDTZWFoVktxJgGjSBwmLrF4Pmp3UcBMQLBQ5
         V1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vU5yaEpd/Y0DZa1Q/uJoC95gJS14ZCBm7xrXmd2b678=;
        b=Zaqmz02CvKpy92Jyl2hxwKYQRrC8X/FgVBFNUwDf0H0zAXm+ufKN6WcReKrWYDR580
         MZjlzktj9Z4WjORRqvKWgGAGfxHB8aWIE0KFXw1+85BbmU5fhNg8ropu9JJgMWo534EQ
         74KHVfcMVfqg1h9CW44qTFD6CfgXQe886DlrgDE1y/GFZuRuGMNn7KbDutDFuBXaYMWb
         RopWplEgW0KiXprbyff4KIRTj7t3gYHv1WA2vicwB2V8YxBojZB8XaghLhwDD4ElLGgq
         U+LtVlkEwEjK/W2eRyvYezTPdAS+64Au81MVZ99ggiAepoAoZoWW61blf6/Pva3TwXrh
         AwJw==
X-Gm-Message-State: AOAM532YvmIfY7EhnnD+i22C9VJZL5dbF0binL7UIC7fZjJRf683/5IX
        NxnB/gNQJJjOvDOPGewS5endWQ==
X-Google-Smtp-Source: ABdhPJwXjeDLbMbYVW6fYTxzvgg2sf1oxHDUYlwcNvj2ok4/I9+uItght9lMpiSzEu5pFYc3mBrOGw==
X-Received: by 2002:a05:600c:1c13:: with SMTP id j19mr68615165wms.175.1637063198772;
        Tue, 16 Nov 2021 03:46:38 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id z11sm16934698wrt.58.2021.11.16.03.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 03:46:38 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/3] ASoC: codecs: wcd934x: return error code correctly from hw_params
Date:   Tue, 16 Nov 2021 11:46:22 +0000
Message-Id: <20211116114623.11891-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20211116114623.11891-1-srinivas.kandagatla@linaro.org>
References: <20211116114623.11891-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Error returned from wcd934x_slim_set_hw_params() are not passed to upper layer,
this could be misleading to the user which can start sending stream leading
to unnecessary errors.

Fix this by properly returning the errors.

Fixes: a61f3b4f476e ("ASoC: wcd934x: add support to wcd9340/wcd9341 codec")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd934x.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index c496b359f2f4..4f568abd59e2 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -1896,9 +1896,8 @@ static int wcd934x_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	wcd->dai[dai->id].sconfig.rate = params_rate(params);
-	wcd934x_slim_set_hw_params(wcd, &wcd->dai[dai->id], substream->stream);
 
-	return 0;
+	return wcd934x_slim_set_hw_params(wcd, &wcd->dai[dai->id], substream->stream);
 }
 
 static int wcd934x_hw_free(struct snd_pcm_substream *substream,
-- 
2.21.0

