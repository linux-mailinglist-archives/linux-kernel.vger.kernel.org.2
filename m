Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A2634A226
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 07:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhCZGpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 02:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhCZGpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 02:45:08 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3136BC0613AA
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 23:45:08 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id x16so2455140qvk.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 23:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7bLoqfBiZVQk0YIeIKhgPKBtJ507LhBAmlJ/A5xeilw=;
        b=FFkb7IcZ05aM6s5rziT8HAuHISXf5fGUGlz5QF5iHFqcrZ2riRz6i1o9Om5SofPLt+
         5/sM1WNetUR3dozt7vsUwv0cFmAaTGeosZmnESSMMw8ncfwpVh6eOiGIxm0I+x1R+moN
         6PA3YyOUl5ttzJvKrS8dAjwEogBUgO1hcs+giQZkpIw7UiWVl+VDV+pIzW1l/Zmj1ZpQ
         SOorvKNLa2zICFJ6N1XANaZgxi/lzU3cZfs0rxpmUMpLCJgQdup15tC3k2BnxSNJRfkD
         Paz1//jmolGZxVgXfkK9nPcO8RwBnzAVvJwjCTxA2qodD5pdMu5GPy4XCa3qwDLBUES5
         EWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7bLoqfBiZVQk0YIeIKhgPKBtJ507LhBAmlJ/A5xeilw=;
        b=nDdN3asDGUIcceGvsYQe11QVh3j2epjBXYButljhqn7wAGsC+HxRTVal8cFyHHJHH7
         nzFnEJ4VIo+jXYbhcUGxcBYVLwCo7kBnc9bWgcU2rrcuQwZNyTE97sM6QhEO88CCnWmQ
         t5Gdvfh9r61eDMXoQS3l4HtJyabG7fc5sT7T2ViH50nZ9NRDRiBAJ7abLZaEJHUdoScw
         lgXSZiLdHgUSDPBClXuiitzHSXZQSLrdDqNW5k5cP4NbgD07Q1/9jveJg4mQmKiFBtRq
         BPvsEV91ykANDrEc3y6ymsAnWIemIzg2UzQbhD+jFjJLYWlOut33hrcibpLQGOWz/fCu
         WELA==
X-Gm-Message-State: AOAM533ly0xdZzhUS4X7rkG1k2eBMBHw2QrH6ugwCyJ9/dbG9VMXgDtc
        R+DSLUqBLKXM2jaMPWEuQjg=
X-Google-Smtp-Source: ABdhPJyEOv5nlQlCy87iUnxGvRQ2JRfM21w3HIYPDsa93cn6J9KXQrXRp5KsUhdMsnByc3LR8XTOFA==
X-Received: by 2002:ad4:4ab0:: with SMTP id i16mr11854813qvx.1.1616741107529;
        Thu, 25 Mar 2021 23:45:07 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.107])
        by smtp.gmail.com with ESMTPSA id b12sm5316693qti.43.2021.03.25.23.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 23:45:06 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, unixbhaskar@gmail.com,
        mirq-linux@rere.qmqm.pl, broonie@kernel.org, gustavoars@kernel.org,
        viro@zeniv.linux.org.uk, joe@perches.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH V4] ALSA: pcm:  Fix couple of typos
Date:   Fri, 26 Mar 2021 12:12:11 +0530
Message-Id: <20210326064211.6509-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/unconditonally/unconditionally/
s/succesful/successful/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Changes from V3:
  Yet another try to make it work

 sound/core/pcm_native.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 17a85f4815d5..8dbe86cf2e4f 100644
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
  */
 int snd_pcm_drain_done(struct snd_pcm_substream *substream)
 {
--
2.26.2

