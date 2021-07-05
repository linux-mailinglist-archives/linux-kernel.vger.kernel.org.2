Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6E03BBA3B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 11:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhGEJhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 05:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbhGEJhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 05:37:14 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2311C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 02:34:36 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id f20so8317724pfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 02:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1aD07N63usXYTFojXcF0wDROE3H1jpeyApc0ltbPbKs=;
        b=RRqIDXLQbHRYtRG8tm92vuAETozyAxX4ZohUwmjo+h3GTwExA5yVINLWpuO5kmh/l5
         kIzZ7jFdCcud6RtkRbSsW7oKnuDL8CfYWpRLZuGpz6M0vhwm8hZKv8g3DnEWFTE50g99
         72CFGMiBNYVPItC7vqVzGngGGk0fZS4FtegLFiQxLvK/UosZa4nYW30TiR7O7Xto7wf2
         BcgTfvbNn3Y8PrBHaml03BWlI2SuNtGzOgwlGq6P6m93vzR3QdLEQ7HnnJxgrEUKUTKp
         a5CAojgd0lWl6BCtpZMx9MRXTC7n3WdwwsxpuXL/7XORKgeJrGpJNbVLpboNLTaAPQbi
         pReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1aD07N63usXYTFojXcF0wDROE3H1jpeyApc0ltbPbKs=;
        b=BnLX2uD90zCJDFAe3dQ2EvRDQW42KAMD/jbdNRdH536PWxSQ8vRo3K1cHN0yeQ0qCx
         B5QUkMJ+HCv0QlvUMCUl5JfkiyVPWoM9RMWpl+H+iIObLEF6QrivJV03GMBET+XpVSoe
         e9eU+AjGrbCR8MyXGF2M0SR5bYKaLZgSZ4jJfvWP7f6Uwz1uKxCTaH+wrslIK2Wima9t
         9Yfk/KhCk2g8u6b3chjzjkfkp0g+uSdgYk6AjZRegZgw2IeZdy2WC8y4/8xiGlqzG2Cs
         GCrBYM95zK5sXGr4Ywj4ujERQmlYGSdATpIPEAHa/6gjwh7KvzIs/koENf7to16u6Qxp
         bhzA==
X-Gm-Message-State: AOAM533U6JWkOFNibCsWxdM7RUx8DmXVHD3cyLbF+5stuZ836j2CS/nK
        +02/pfasVVhPnn8M1hcWjiw0yjnvjT4xmQ==
X-Google-Smtp-Source: ABdhPJwZATJ3l6n/mEpAMBGR7nuBEXrYanTEFN9zlhYSGJQ/sPISx5/HwTFACQM7nCXbgADNlkZEfw==
X-Received: by 2002:a63:5d52:: with SMTP id o18mr14896205pgm.440.1625477676475;
        Mon, 05 Jul 2021 02:34:36 -0700 (PDT)
Received: from ubuntu.localdomain ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id c74sm12773742pfc.175.2021.07.05.02.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 02:34:36 -0700 (PDT)
From:   gushengxian <gushengxian507419@gmail.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, gushengxian <gushengxian@yulong.com>
Subject: [PATCH] ALSA: usx2y: fix spelling mistakes
Date:   Mon,  5 Jul 2021 02:34:19 -0700
Message-Id: <20210705093419.664366-1-gushengxian507419@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: gushengxian <gushengxian@yulong.com>

Fix some spelling mistakes as follows:
wroong ==> wrong
evrything ==> everything

Signed-off-by: gushengxian <gushengxian@yulong.com>
---
 sound/usb/usx2y/usbusx2yaudio.c | 2 +-
 sound/usb/usx2y/usx2yhwdeppcm.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/usx2y/usbusx2yaudio.c b/sound/usb/usx2y/usbusx2yaudio.c
index 6154662d3097..c39cc6851e2d 100644
--- a/sound/usb/usx2y/usbusx2yaudio.c
+++ b/sound/usb/usx2y/usbusx2yaudio.c
@@ -526,7 +526,7 @@ static int usx2y_urbs_start(struct snd_usx2y_substream *subs)
  cleanup:
 	if (err) {
 		usx2y_subs_startup_finish(usx2y);
-		usx2y_clients_stop(usx2y);		// something is completely wroong > stop evrything
+		usx2y_clients_stop(usx2y);	// something is completely wrong > stop everything
 	}
 	return err;
 }
diff --git a/sound/usb/usx2y/usx2yhwdeppcm.c b/sound/usb/usx2y/usx2yhwdeppcm.c
index da643c2dbb12..db83522c1b49 100644
--- a/sound/usb/usx2y/usx2yhwdeppcm.c
+++ b/sound/usb/usx2y/usx2yhwdeppcm.c
@@ -480,7 +480,7 @@ static int usx2y_usbpcm_urbs_start(struct snd_usx2y_substream *subs)
  cleanup:
 	if (err) {
 		usx2y_subs_startup_finish(usx2y);	// Call it now
-		usx2y_clients_stop(usx2y);		// something is completely wroong > stop evrything
+		usx2y_clients_stop(usx2y);	// something is completely wrong > stop everything
 	}
 	return err;
 }
-- 
2.25.1

