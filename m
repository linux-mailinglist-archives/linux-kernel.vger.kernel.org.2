Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFDE331A36
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 23:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhCHWbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 17:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbhCHWbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 17:31:08 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CFEC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 14:31:08 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id p21so23629820lfu.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 14:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mgVtVDJ4J9ZfP2mfzS736WoTsMup5fvgpbnXS5Fe3a8=;
        b=M+wVnP/KB8I6w466Y9xFPc5hUX+YdtfnLVnYCpM9Kp7Cw6dUrl6pRvJhajm5PjYBxT
         SfeJj6wvAM0tR+tYPY6aqBtQ9MxgQZHO5ph34MNOveLyXa+aSY2yvVB8XBLGg95SJdmI
         iVyIZB5ajJ/CNZkE8Pcvcv8bSsk8vtURxkpCGi7DFoKCcB54czUnVA3+sIAKdxQkWjR/
         FBewIzUOuhD98dNY9UMPnWC4aCfcIGj+krz6tT7KLwvwsMAnUd1halJIn32yvhAHPRqd
         UvNETUESRmdktnLcZkEHNZ2SShn+E4gmRb5M/TJ9OEA+FUWmqBG+x+UqoV2q07fcnxVR
         /UeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mgVtVDJ4J9ZfP2mfzS736WoTsMup5fvgpbnXS5Fe3a8=;
        b=kfDzXov4+BsZOHPvuP47LlJqS0vup9xg4y5mZIvqhazUSpOzLPmedSYgIlXoAGJUzn
         4AQCy4FRy0f8GXmHFMPQc2ONCP/0ck7nqbw2QdeZ1j+w0MqIE1PJ0mW+kvQtqpzd/aVp
         +Y+/y4xFDBR++7yo9ONEe+tjJbCC00TimKphr7zK+ocjWn6lnBzXykUdYnuGa8SVUN+w
         tsVlY2i+q17covKxubf5S5IDL9xk2l1zdHnnjlasPI4IlFfTimq7HfCoHr7hPHPy2Z9z
         b3IWuFh54zSYPnnfvPanLM/M0EYtqNR3bJo9RuEMNIB0AK/u10YO99tnB+iOTI26hAgk
         RN/g==
X-Gm-Message-State: AOAM532ap+XESjhDI7jrfpBDEu8UYQJuvaxUiGVdS13OMdRslPikw6Ur
        QLYZfTiYwEk+GQAw4njld40=
X-Google-Smtp-Source: ABdhPJyI2CGVBw+yoGGPeeq2F338VAm8dTNAgH2Rp77EGChXVrzx4AfEj/iTJrw9Uv3K00xIkYVeMA==
X-Received: by 2002:a19:ef02:: with SMTP id n2mr14976923lfh.141.1615242666898;
        Mon, 08 Mar 2021 14:31:06 -0800 (PST)
Received: from localhost.localdomain ([94.103.235.167])
        by smtp.gmail.com with ESMTPSA id p13sm1653426ljg.116.2021.03.08.14.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 14:31:06 -0800 (PST)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, kai.heng.feng@canonical.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH next 2/2] sound: usb: fix use after free in usb_audio_disconnect
Date:   Tue,  9 Mar 2021 01:30:57 +0300
Message-Id: <16da19126ff461e5e64a9aec648cce28fb8ed73e.1615242183.git.paskripkin@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1615242183.git.paskripkin@gmail.com>
References: <cover.1615242183.git.paskripkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The problem was in wrong "if" placement. chip->quirk_type is freed
in snd_card_free_when_closed(), but inside if statement it's accesed.

Fixes: 9799110825db ("ALSA: usb-audio: Disable USB autosuspend properly in setup_disable_autosuspend()"
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 sound/usb/card.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 3fd1743513b5..b6f4c0848e66 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -907,6 +907,9 @@ static void usb_audio_disconnect(struct usb_interface *intf)
 		}
 	}
 
+	if (chip->quirk_type & QUIRK_SETUP_DISABLE_AUTOSUSPEND)
+		usb_enable_autosuspend(interface_to_usbdev(intf));
+
 	chip->num_interfaces--;
 	if (chip->num_interfaces <= 0) {
 		usb_chip[chip->index] = NULL;
@@ -915,9 +918,6 @@ static void usb_audio_disconnect(struct usb_interface *intf)
 	} else {
 		mutex_unlock(&register_mutex);
 	}
-
-	if (chip->quirk_type & QUIRK_SETUP_DISABLE_AUTOSUSPEND)
-		usb_enable_autosuspend(interface_to_usbdev(intf));
 }
 
 /* lock the shutdown (disconnect) task and autoresume */
-- 
2.25.1

