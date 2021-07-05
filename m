Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D7E3BBC8F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 14:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhGEMDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 08:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhGEMDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 08:03:34 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F287C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 05:00:58 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id f5so8755145pgv.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 05:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lrrqS0BGhij8h/JiJ9F+6I712lbfC0k7jAcUxVWAAkA=;
        b=dxXF3TnchDzR/CQVpTsHV6p7EunPtiqH4Mhe6Nw2CJJTyZy+x23LLJIKpe9uMZ/584
         gLQEZH/Etn1FthdG04h/a5wt4X40guCaEZ/57VcsW7yUVuCyyr4hdfPyJ23ULxwuo2nx
         /6rZ+Ih9wS4RWYPfF80AXlyg7DXVZq1KMPGuGUwqRKuFIRtDOqXxlBwEEo8hYFnP4dLG
         fjSlqG2mYxAWt1ysU+hHx1j1roNQXmiWiAfzGyTi1q54AVzEAAkpppJaO3HNDTTIoxO+
         dUHPP0KwPhkKejicwACWSOKXFYyEVRUf4QBNl0UICUjTglUMlb9zwdPh+xzigz7o0hif
         0Zbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lrrqS0BGhij8h/JiJ9F+6I712lbfC0k7jAcUxVWAAkA=;
        b=bS3DWsoD6yHNW7CMu9AA2Pj2PR8r+7m4rYMPhwPpRPxYYaOJyMQwZvQTjSOohbKTsb
         o3ZhIapnf6vOLLymvyY1bzIclH9cdzZOG4da4y3P2tpDkgD1EPuU40x/hU1Odx+cJjZd
         RfdesYT9kiOZzheJr1xg7n2q/EJ7E6Yk4anGG4OwEZiGi6bEbze9OTjPbH+N+ryEB5iB
         tqxLZE0KQ5iEIiZrP6oY+akI0EZlWf2SQltxkxSbA95qFu68Rbkw1Sq56kJppyQIoUha
         K5Okg9t6pAmtWcjn8Ij/Do/irZ5uiao9d7KdoUXBnHQ8Zzd96dvshZI5QY4ZTRMQwA6I
         Ikiw==
X-Gm-Message-State: AOAM531hVUOtFzwvMrk42UDMXWwIqffCFFTV1ev/D1WDqB+bLDLcReyR
        54KmWUyUW3hgxw16ZtLoIf7kea1bYl8lMw==
X-Google-Smtp-Source: ABdhPJy4jQAUlV6HwyWtIyAU9T4zue7go0XsEaMgkaR7vaWziwQVT/4+E/3qtnTAqO2xbLYKQ4sBIQ==
X-Received: by 2002:a65:5c89:: with SMTP id a9mr15430518pgt.207.1625486457617;
        Mon, 05 Jul 2021 05:00:57 -0700 (PDT)
Received: from ubuntu.localdomain ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id p10sm12620310pfn.147.2021.07.05.05.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:00:57 -0700 (PDT)
From:   gushengxian <gushengxian507419@gmail.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, gushengxian <gushengxian@yulong.com>
Subject: [PATCH] ALSA: usb-audio: fix spelling mistakes
Date:   Mon,  5 Jul 2021 05:00:52 -0700
Message-Id: <20210705120052.665212-1-gushengxian507419@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: gushengxian <gushengxian@yulong.com>

Fix some spelling mistakes as follows:
altenate ==> alternate
compatbile ==> compatible
perfoms ==> performs
dont'register ==> don't register
periodicaly ==> periodically
arount ==> around

Signed-off-by: gushengxian <gushengxian@yulong.com>
---
 sound/usb/card.h           | 2 +-
 sound/usb/endpoint.c       | 4 ++--
 sound/usb/media.c          | 2 +-
 sound/usb/mixer_s1810c.c   | 2 +-
 sound/usb/mixer_scarlett.c | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/usb/card.h b/sound/usb/card.h
index 5577a776561b..f41dbdc31336 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -19,7 +19,7 @@ struct audioformat {
 	unsigned char iface;		/* interface number */
 	unsigned char altsetting;	/* corresponding alternate setting */
 	unsigned char ep_idx;		/* endpoint array index */
-	unsigned char altset_idx;	/* array index of altenate setting */
+	unsigned char altset_idx;	/* array index of alternate setting */
 	unsigned char attributes;	/* corresponding attributes of cs endpoint */
 	unsigned char endpoint;		/* endpoint */
 	unsigned char ep_attr;		/* endpoint attributes */
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index da649211bff3..4f856771216b 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -645,7 +645,7 @@ static bool endpoint_compatible(struct snd_usb_endpoint *ep,
 }
 
 /*
- * Check whether the given fp and hw params are compatbile with the current
+ * Check whether the given fp and hw params are compatible with the current
  * setup of the target EP for implicit feedback sync
  */
 bool snd_usb_endpoint_compatible(struct snd_usb_audio *chip,
@@ -1245,7 +1245,7 @@ static int snd_usb_endpoint_set_params(struct snd_usb_audio *chip,
  *
  * This function sets up the EP to be fully usable state.
  * It's called either from hw_params or prepare callback.
- * The function checks need_setup flag, and perfoms nothing unless needed,
+ * The function checks need_setup flag, and performs nothing unless needed,
  * so it's safe to call this multiple times.
  *
  * This returns zero if unchanged, 1 if the configuration has changed,
diff --git a/sound/usb/media.c b/sound/usb/media.c
index 812017eacbcf..840f42cb9272 100644
--- a/sound/usb/media.c
+++ b/sound/usb/media.c
@@ -285,7 +285,7 @@ int snd_media_device_create(struct snd_usb_audio *chip,
 			ret);
 
 	if (!media_devnode_is_registered(mdev->devnode)) {
-		/* dont'register if snd_media_mixer_init() failed */
+		/* don't register if snd_media_mixer_init() failed */
 		if (ret)
 			goto create_fail;
 
diff --git a/sound/usb/mixer_s1810c.c b/sound/usb/mixer_s1810c.c
index c53a9773f310..0255089c9efb 100644
--- a/sound/usb/mixer_s1810c.c
+++ b/sound/usb/mixer_s1810c.c
@@ -163,7 +163,7 @@ snd_s1810c_send_ctl_packet(struct usb_device *dev, u32 a,
 }
 
 /*
- * When opening Universal Control the program periodicaly
+ * When opening Universal Control the program periodically
  * sends and receives state packets for syncinc state between
  * the device and the host.
  *
diff --git a/sound/usb/mixer_scarlett.c b/sound/usb/mixer_scarlett.c
index 691b95466d0f..0d6e4f15bf77 100644
--- a/sound/usb/mixer_scarlett.c
+++ b/sound/usb/mixer_scarlett.c
@@ -21,7 +21,7 @@
  * Auto-detection via UAC2 is not feasible to properly discover the vast
  * majority of features. It's related to both Linux/ALSA's UAC2 as well as
  * Focusrite's implementation of it. Eventually quirks may be sufficient but
- * right now it's a major headache to work arount these things.
+ * right now it's a major headache to work around these things.
  *
  * NB. Neither the OSX nor the win driver provided by Focusrite performs
  * discovery, they seem to operate the same as this driver.
-- 
2.25.1

