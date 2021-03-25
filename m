Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33426348C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 10:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhCYJHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 05:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhCYJG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 05:06:26 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7A1C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 02:06:24 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id x9so1110966qto.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 02:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1iQsxiYdCxGG35lUzN/bRMfo6zLxSuYNH36J3LPifEg=;
        b=R1Q7CsCvGvVokufbBExDBRunUscl/o0IH7tDK2xOA8M5KLzlVGIdiuJNMXYp3/LneJ
         vCsg1fu8x4V6GDycZpqL6Z+SW05YJR4v40fxJ+LeovKsn2jYY09PPrC+8DD8TjD060cm
         lK0va4m90Ni9Prn9RpkWVaXuVWPfmC7gs0LowBxWXBy8kikyTsuLAXP72a6ng9AwrfUt
         ugcRoCckiQ8t9oE5CLSRnIdTQbjfyIreAcR0r6GXXHPmof/uD4kJoJZuzLrO4bt2e+T7
         nmADafWBNsKEzusqxIMzyXGZNm+AGFN4uUJ2Fkxu1tdUjqXyxwHIrLvp4We0Ub58XcJX
         ygTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1iQsxiYdCxGG35lUzN/bRMfo6zLxSuYNH36J3LPifEg=;
        b=VXvPBekz42NJwKz23UYAWweNUKZOW+0g/dxw+LkD57vxpZXH3/NNIuHqugmb4wIVQh
         cImjkQqGkOSBe/+0e7ZxMdIghFfYNevB1lZjT8MO2l2+9DWooJ3HOI5hCff/NCSHprAv
         cAiPFuceSOo4rqMuh305B5Jbyfm46kl1RIBCDhkGtcDiF+i9uXualeiSZAy+IzcFyz5y
         puxzB3vKAC2p9tGTyxHWEGpc0A5XVOcDY3E6Nnjrh4zPyCzp8zJ43osQ7hKK+dE3YFxc
         RPOpPNJ/q1WTLjxJM3t6M+Hb3rEc7RYcZTI1ESb6bK4PF4YfRmBzcNtKkRONsrdKd9oo
         pVVA==
X-Gm-Message-State: AOAM530kW522wqH9i/bQrOyBPymbwze4ADqtp7oqk2Q94EgXj/uQx2Ns
        VzlImIawkcZppT439nnb8+WZ+x6FntCqd8RV
X-Google-Smtp-Source: ABdhPJxn+XGD1U+hviYeiWDtQH8F0XbnCOvTE8dAhQABDS9YoeVHFOe+IlQ3s4fPwjZUsJ8Pc/R2xA==
X-Received: by 2002:a05:622a:1194:: with SMTP id m20mr6616454qtk.164.1616663183811;
        Thu, 25 Mar 2021 02:06:23 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.54])
        by smtp.gmail.com with ESMTPSA id m13sm3610943qkm.103.2021.03.25.02.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 02:06:23 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, unixbhaskar@gmail.com,
        broonie@kernel.org, mirq-linux@rere.qmqm.pl, lars@metafoo.de,
        gustavoars@kernel.org, huawei@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH V3]  ALSA: pcm: Fix couple of typos
Date:   Thu, 25 Mar 2021 14:36:09 +0530
Message-Id: <20210325090609.10372-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/unconditonally/unconditionally/
s/succesful/successful/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Changes from V2:
 Takashi pointed out that the patch was not applicable due to some unwanted
 stuff get into it. Resending it with the new patch creation.

 sound/core/pcm_native.c | 82 ++++++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 17a85f4815d5..afb670d7fd53 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1425,7 +1425,7 @@ static int snd_pcm_do_stop(struct snd_pcm_substream *substream,
 		substream->ops->trigger(substream, SNDRV_PCM_TRIGGER_STOP);
 		substream->runtime->stop_operating = true;
 	}
-	return 0; /* unconditonally stop all substreams */
+	return 0; /* unconditionally stop all substreams */
 }

 static void snd_pcm_post_stop(struct snd_pcm_substream *substream,
@@ -1469,7 +1469,7 @@ EXPORT_SYMBOL(snd_pcm_stop);
  * After stopping, the state is changed to SETUP.
  * Unlike snd_pcm_stop(), this affects only the given stream.
  *
- * Return: Zero if succesful, or a negative error code.
+ * Return: Zero if successful, or a negative error code.
--
2.30.1

