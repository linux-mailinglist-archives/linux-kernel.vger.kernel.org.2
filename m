Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABAB63AEA4B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 15:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhFUNrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 09:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhFUNrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 09:47:41 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F84C061756
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 06:45:25 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j2so9199953wrs.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 06:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pAIv5ocE40xJoNsZIv++9AOR0LE9aTCfg1rxh8nwgxg=;
        b=guTJc7On2LFjGZ8lVBDXOxGeqL73iRh1QfAJ4/zOF77kF1Vuv6T8g7+fXFso128+rP
         AFmyyKFZ+s8abFjozMOsjWke5t9c6dqWsIQigTCNAzDmJ96ioGg5W+Iu961Vb7dozbYA
         0Vop3UqBcs4Ymen7/ud9QmkaDXlr19OMJikECXQDPisLTFJ2iqP7Bv1hldki3gEwgbl3
         70VJZhSBSwE9LFe6jSQtSmcNSl+LqHORSNKoJWBDrg6hjO84P/86h0A/97QB+0Cm4cn7
         vHASX1tcgta7wWNcxebVYwkCaeJcCb8Jz97iZSIi5bOb5AA6nvbDDVqEc0yXkJcOY/I5
         kpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pAIv5ocE40xJoNsZIv++9AOR0LE9aTCfg1rxh8nwgxg=;
        b=P+JtNtL9vFPyiR3f0OXxc7gmy4bVyXYUvEnJU6Y6obDKpvGXCfSbsUhWu9LMg+XhOW
         /4lXHdY3pMUxjriukER7Hy4Co1VP1a1rLYdJe5CRuUly7VqN9ZTUPR4KBNeZiA/GCjJb
         MZn1vdeAHCLLdMhudRpNCuxkU0Pz406u6VgHBtQRZnZap2spAXDwG4o6EhdPDSLeaGVq
         /RG3q/czRtCmmq2r1InKHS6ZdI/AWv8ZDa8IPpXuGY6g8tYb8J7TwK2fcnLVCbQ46SZG
         VBGm/yV85yywI8YBO8E1JOtEWBr7+MDV8D5RRoYE18R3CaSaIwAf5NJju9FsKaQsEdou
         XOrA==
X-Gm-Message-State: AOAM533Z629MkaiNw5AY4RdesN1fVEbGU60ywen91Pbqj7vaT31J1R9I
        eRJLJCbfUhzVF63R3scMCRzfbayjJIqbcA==
X-Google-Smtp-Source: ABdhPJyCzCj448Bpy2dWzTq6/4ovn/wNNa/MVJP9R68doPFkJ0EIVoTaBHtXNlIatz+aS7V6a9CVOA==
X-Received: by 2002:adf:eace:: with SMTP id o14mr25889416wrn.159.1624283124401;
        Mon, 21 Jun 2021 06:45:24 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id e38sm12848741wmp.4.2021.06.21.06.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 06:45:23 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 2/2] ASoC: codecs: wcd938x: fix uninitialized symbol warnings
Date:   Mon, 21 Jun 2021 14:45:02 +0100
Message-Id: <20210621134502.19537-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210621134502.19537-1-srinivas.kandagatla@linaro.org>
References: <20210621134502.19537-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below two uninitialized symbol warnings

warning:
	sound/soc/codecs/wcd938x.c:2092 wcd938x_tx_swr_ctrl()
	error: uninitialized symbol 'rate'

	sound/soc/codecs/wcd938x.c:2189 wcd938x_tx_channel_config()
	error: uninitialized symbol 'reg'.

First one my brining in check to already existing if condition and
second one by adding a default switch case to avoid any access to reg.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd938x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 427f51fade37..11315262391e 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -2086,11 +2086,9 @@ static int wcd938x_tx_swr_ctrl(struct snd_soc_dapm_widget *w,
 			}
 			rate = wcd938x_get_clk_rate(i);
 			wcd938x_set_swr_clk_rate(component, rate, bank);
-		}
-
-		if (strnstr(w->name, "ADC", sizeof("ADC")))
 			/* Copy clk settings to active bank */
 			wcd938x_set_swr_clk_rate(component, rate, !bank);
+		}
 		break;
 	case SND_SOC_DAPM_POST_PMD:
 		if (strnstr(w->name, "ADC", sizeof("ADC"))) {
@@ -2185,6 +2183,8 @@ static void wcd938x_tx_channel_config(struct snd_soc_component *component,
 		reg = WCD938X_ANA_TX_CH4;
 		mask = WCD938X_HPF4_INIT_MASK;
 		break;
+	default:
+		return;
 	}
 
 	snd_soc_component_write_field(component, reg, mask, mode);
-- 
2.21.0

