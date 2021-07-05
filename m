Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDCE3BB7FA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 09:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhGEHk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 03:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhGEHk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 03:40:28 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CC5C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 00:37:50 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id s13so6695378plg.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 00:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uIYkWEg6ddHgyeOZ+TasZ9tt9xSrdpyE5MFOa1Fdx4E=;
        b=RURpQEkiG89CAuGiDuimdVkL4MKD3H9WowmHt3ZTKdEgfEvqvKYljuU/SaSeHinBW0
         5oaa9s8J1UodnyjLvOk6QdBTFD/f3Q9+iuCHs/Whnqqlwlw4pZh0qX+BV3q1ZR5Hz5Yk
         oGDaoh7BmvRTZAxwX0BT9bthVDqALGu8zmam5HL/fgQGdXyg+5z7RtJQvWN08uMjv5jC
         Mldc3udVmwc+SXCNTgIY7zqM60rWf9xAYwfq/5LS3PAMmrXb9WIEYMs3sw1D/fkO/ApB
         TlnrXf9nHPMDmWrFW9hRhyIj9CMZWMVemHpIpyxbj3JuDYqkWXpzxkdaiyBIphB6O7bk
         KCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uIYkWEg6ddHgyeOZ+TasZ9tt9xSrdpyE5MFOa1Fdx4E=;
        b=nD/qArdq0jtbl4P+qCvuO3y8usa2nPTn9BCeWMReh5/Mp8CThWRnOWy+ccVby1MYm0
         UuKGv9OaZXKyNB83vWrqpWooVvRQty/SqIWwZmGB79+aAafimS7in9NXExXxU7SlW5+w
         MoauBRECQknUiuRk5tA0ZzZiguIFHc8yi3AqXIgl7mReZcg0/a6S6iL4vXBszjS9U6H/
         lThhykRd8jLASYEVA8wKC/jPopxWSZNYwjDYGXgrz6LdNUdF+VuIxhppCPTHNcKt2skf
         hn6+ZTc77+yxpSH9+N77NA43VVa2LZ0RwHVCCG2e0IkAN3VP+eKdLgYoERHeLB9B3UOn
         yXCA==
X-Gm-Message-State: AOAM530slNA5WwfnZT8A/D1YnbhZNnW5d19YPY9zc3ziwtJtfw3a9xdU
        iZ9LEd5xrREwBEugNB4C47geX/gY77NbBg==
X-Google-Smtp-Source: ABdhPJxwk9VAwLAt6zdodDdK4aaJMDRuD9OasQ3YaXQSuVpnBPtwDVw+vAGCokaehZ/TR5Zp/RZ10Q==
X-Received: by 2002:a17:90b:1403:: with SMTP id jo3mr14330309pjb.160.1625470670034;
        Mon, 05 Jul 2021 00:37:50 -0700 (PDT)
Received: from ubuntu.localdomain ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id g4sm2694975pfo.44.2021.07.05.00.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 00:37:49 -0700 (PDT)
From:   gushengxian <gushengxian507419@gmail.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gushengxian <gushengxian@yulong.com>
Subject: [PATCH] sound: x86: fix spelling mistakes
Date:   Mon,  5 Jul 2021 00:37:36 -0700
Message-Id: <20210705073736.662875-1-gushengxian507419@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: gushengxian <gushengxian@yulong.com>

Fix some spelling mistakes as follows:
regiter ==> register
confgiuration ==> configuration
playabck ==> playback
platoform ==> platform

Signed-off-by: gushengxian <gushengxian@yulong.com>
---
 sound/x86/intel_hdmi_audio.c | 6 +++---
 sound/x86/intel_hdmi_audio.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 33b12aa67cf5..a34d7d9c2a57 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -236,7 +236,7 @@ static void had_write_register(struct snd_intelhad *ctx, u32 reg, u32 val)
  * updating AUD_CONFIG register.
  * This is because:
  * Bit6 of AUD_CONFIG register is writeonly due to a silicon bug on VLV2
- * HDMI IP. As a result a read-modify of AUD_CONFIG regiter will always
+ * HDMI IP. As a result a read-modify of AUD_CONFIG register will always
  * clear bit6. AUD_CONFIG[6:4] represents the "channels" field of the
  * register. This field should be 1xy binary for configuration with 6 or
  * more channels. Read-modify of AUD_CONFIG (Eg. for enabling audio)
@@ -342,7 +342,7 @@ static int had_prog_status_reg(struct snd_pcm_substream *substream,
 
 /*
  * function to initialize audio
- * registers and buffer confgiuration registers
+ * registers and buffer configuration registers
  * This function is called in the prepare callback
  */
 static int had_init_audio_ctrl(struct snd_pcm_substream *substream,
@@ -1790,7 +1790,7 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 		pcm->private_data = ctx;
 		pcm->info_flags = 0;
 		strscpy(pcm->name, card->shortname, strlen(card->shortname));
-		/* setup the ops for playabck */
+		/* setup the ops for playback */
 		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &had_pcm_ops);
 
 		/* allocate dma pages;
diff --git a/sound/x86/intel_hdmi_audio.h b/sound/x86/intel_hdmi_audio.h
index 0d91bb5dbab7..bb3853195922 100644
--- a/sound/x86/intel_hdmi_audio.h
+++ b/sound/x86/intel_hdmi_audio.h
@@ -96,7 +96,7 @@ struct pcm_stream_info {
  * @had_spinlock: driver lock
  * @aes_bits: IEC958 status bits
  * @buff_done: id of current buffer done intr
- * @dev: platoform device handle
+ * @dev: platform device handle
  * @chmap: holds channel map info
  */
 struct snd_intelhad {
-- 
2.25.1

