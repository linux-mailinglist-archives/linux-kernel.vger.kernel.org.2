Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753A5453131
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 12:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbhKPLvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 06:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235497AbhKPLuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 06:50:40 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0082C061766
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 03:47:42 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 133so16686636wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 03:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=biB/sXM9QU4j7AYqjNTVI0o7ubAWrta294zCKzowIlM=;
        b=GBEllUfeXSKGvgLZgtvEpFW1lCj20RF86OaUyZ2G0yaFv9ShRS4UZxTU49tN/Ys2w0
         mdZ2f73mVaPgsntZ//EVSf49hT73zym0SHbrq96HcyAC/3YV9WT5XGQP5K///oNL/ucn
         hmSE8ZA57FH6T3cf3XVlyxUyRGJnRk5tIF5Z8UnN3zOqco7VHQDQdTA15V/iwJWHGMxq
         PeMl/+ZJ5yNE4XcHVlObZFL3KACW6c1WOtSbXzLAoAOgUknL5qGR806ITeD/RNjxg/WF
         E+f29CsNOnBAaL7ZPGVtkvj4utI5JehG6TgyIQW7f6FTbese7LD4G2b+W3gSO5TleA6D
         Phng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=biB/sXM9QU4j7AYqjNTVI0o7ubAWrta294zCKzowIlM=;
        b=dH1rH34TuZN1NlGVSvmGabgippo3lFZFbEPCC0K7P2NVfz6yV/ACnDsPmK+UxoYXAc
         Rrp4WC5jTmayA3sgk8c1m8MymFpgjYnLymmpUKt7xmnj8bEieDGCjktYEK7WCVa/Y5Ci
         8FIKlwp0LsYRe68BAqyEr7M/s07a1qG+WmgulSim2Cyj8xJ1QGBWyBq7rSIc2va8WWne
         LjhBLdvGFdPqifa71PBl7jVinm5PS9/bsJyM/NaduqzF9fo85FpAOpqqsVBmA7EVla74
         vvyBZMjjhsgNJFv4cV36LMRX41XW4kpjwDjdcnETcm/kV8HFJkdZa+fB2CItHio0WMXo
         M+Qw==
X-Gm-Message-State: AOAM530jbXe7RnjMPNynIW/p0gAvAjwJ1QYaOzvcD7TuKDtLfZ8t6D5I
        Mtjjk1LlzSd2l2Fnq+IhxI/jIA==
X-Google-Smtp-Source: ABdhPJy+JE/sEtbYpvECM1A9bpdg0aE/Oqp6bfw9L7PwgG9xUoNMJJperol2eb5BiLci2wEnEEsJ6g==
X-Received: by 2002:a05:600c:4ed2:: with SMTP id g18mr70566688wmq.122.1637063261572;
        Tue, 16 Nov 2021 03:47:41 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id l8sm2260523wmc.40.2021.11.16.03.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 03:47:41 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/5] ASoC: qdsp6: q6routing: Conditionally reset FrontEnd Mixer
Date:   Tue, 16 Nov 2021 11:47:18 +0000
Message-Id: <20211116114721.12517-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20211116114721.12517-1-srinivas.kandagatla@linaro.org>
References: <20211116114721.12517-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stream IDs are reused across multiple BackEnd mixers, do not reset the
stream mixers if they are not already set for that particular FrontEnd.

Ex:
amixer cset iface=MIXER,name='SLIMBUS_0_RX Audio Mixer MultiMedia1' 1

would set the MultiMedia1 steam for SLIMBUS_0_RX, however doing below
command will reset previously setup MultiMedia1 stream, because both of them
are using MultiMedia1 PCM stream.

amixer cset iface=MIXER,name='SLIMBUS_2_RX Audio Mixer MultiMedia1' 0

reset the FrontEnd Mixers conditionally to fix this issue.

This is more noticeable in desktop setup, where in alsactl tries to restore
the alsa state and overwriting the previous mixer settings.

Fixes: e3a33673e845 ("ASoC: qdsp6: q6routing: Add q6routing driver")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6routing.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index 3390ebef9549..243b8179e59d 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -495,7 +495,11 @@ static int msm_routing_put_audio_mixer(struct snd_kcontrol *kcontrol,
 		session->port_id = be_id;
 		snd_soc_dapm_mixer_update_power(dapm, kcontrol, 1, update);
 	} else {
-		session->port_id = -1;
+		if (session->port_id == be_id) {
+			session->port_id = -1;
+			return 0;
+		}
+
 		snd_soc_dapm_mixer_update_power(dapm, kcontrol, 0, update);
 	}
 
-- 
2.21.0

