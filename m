Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726D2421A22
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 00:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236506AbhJDWey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 18:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236328AbhJDWeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 18:34:50 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E3CC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 15:33:01 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id n8so22212197lfk.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 15:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tikr9EZMT945WPgYWh9Nfqx3BfJVYbeGQaW2V2Yhcjc=;
        b=hbn40zV29ZqI9m3bYnmFea9qlG+KWcRoGwl3SuBlw6vqWg0UPWZ3abCwH+w6z8lAKQ
         VDX1qYxE9VcxhK5XkvllwPHKqg/rgeJM43WOWxp7BUZ/7wk8tPuguFVbIDX4sOXFNaoO
         Ko3QC3IHurqaKD9oKx3F1e5r5GPxax2Pwuj3MzUObZky1UrH7j6oKLHYOvftTKoKNnRY
         TfStbxzA4f9EP5+rPpKfmUg3yBvCwbBAe+isbb0+AG7bALsQatIrUQVG+r5p7vVwKpwj
         Y0EM+2rfxZKnf81+ttcBw8R3yFk4tYHPlOMxnjH2pdXYnZYbfgUjo/c72W5vnlyU8ryz
         vofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tikr9EZMT945WPgYWh9Nfqx3BfJVYbeGQaW2V2Yhcjc=;
        b=MYhGdr36i0of/QBgY+lETKovGt3wn/t+hcdpO0Upu+RMJ/A6cclRkldnHdPiB1ASGz
         LpIFiybfd0bQOY+Xu0RvT9RcAMPF2XDbaZPZQgOJQbFoMSGzgukZY2No+E5tR3Rg1z9s
         EHWIj824J5CWGAr8YfFPjhKbosp4QIjM1M/fZ1gYmmsCB8HxJjqCGGwPHEH86O0T2UPm
         2XMr3xXTPC2DBjmS2SMHYJeanjFWUBEWM65BrJuoV2XKWDkeHZnrvMOMZpWCs/+3y79v
         z2eLyLq71DGpNb9oJhgVTLQTayWNb5RhNf+GQ8oOZ9fFP6SOe//zPcUhJa8xQVO2sUld
         Ui9g==
X-Gm-Message-State: AOAM530vT6hIXau/CvGVFwznL67uuerHp5uIFUnwpHeNFX4gdc1Q31Fd
        V8zo8X3zZaiWKOwfZMt4U63Aju7hn1o=
X-Google-Smtp-Source: ABdhPJyl1lB1gU6D9sYaeLTA2kEb1dZvr0LkhbFsLyqv308ce6J8EhrkdCkJUkJ0pJSZ+yXLEIH4/Q==
X-Received: by 2002:a2e:bd02:: with SMTP id n2mr15081247ljq.40.1633386779597;
        Mon, 04 Oct 2021 15:32:59 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se. [98.128.228.193])
        by smtp.gmail.com with ESMTPSA id d27sm1749729ljo.119.2021.10.04.15.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 15:32:59 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] ASoC: qcom: apq8096: Constify static snd_soc_ops
Date:   Tue,  5 Oct 2021 00:32:55 +0200
Message-Id: <20211004223255.5634-1-rikard.falkeborn@gmail.com>
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

