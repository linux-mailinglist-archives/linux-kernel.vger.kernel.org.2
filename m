Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451293DE2B7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 00:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbhHBWx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 18:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhHBWxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 18:53:54 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F3FC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 15:53:43 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id c16so23185927wrp.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 15:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=f6XStbR+3/dZBpwh4Gq6VDFs804yZWcR+sdlfpTwgVg=;
        b=DB/uIBJxbYHzpEZKZgP6ZhrgdyPC3Hccy+ll+rrmSds7L65imoP40EcpAyDXUosmne
         MZuue7j8P8gqb17eElU6oSLukduvJWXPnfOXvUTZWmMXzwawxN9yVxw3WQ4Z4zIMnC31
         hI2yJe8iEi6ebrWTgPQtsU08knqS0CmNtfkm3ezBVnP2uL8GFUTRDQkC3ztv5adkFGCf
         aqB4yrh1a58HIzYJtUR+lA1VuBLAm/stpzBFDl32iAdABAaZC4Ah9qM7NSdPSomgmVks
         pGeoULAok6sqXYvQsAZEsMep/Ix1anjMGQWNx3TTxsMgA6PUh+xSv6KlEpG/Um/NRFCe
         Fq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=f6XStbR+3/dZBpwh4Gq6VDFs804yZWcR+sdlfpTwgVg=;
        b=KULJFOnkxukOcA1id+OzWhUt7hMujuTLrKyTMSY6d4iFjlL+eeGtciCndM9zcqqXiz
         m74P1uXOqsMuP+4PKXyspf1m815C3/pLNUFd3AG1K2HaNXShwAn7C/ED9/l7gNNaR9Nw
         s5MJ1WurSy0SPbJQGqyH3feFDCOgVLjUsCCPy8JaTiProysgAV86PZRkHX8hH6JkOa8P
         So1AxE2qfV8fq7b4kRKZfid5AoU/bQJhVCE/q5kSqsIRB6siLFFsgDsXXv+ALKCfzHJ0
         IarSADKiVsRAxxbuqYstGxBKJ7aTIBIJasDfLGuLHdtjdVeolJWNBKVqxUYCxWKzT1j7
         RYYQ==
X-Gm-Message-State: AOAM530Xa4j/+itRfvL0ZFBVFz6qSsRdVbhFJAxlJvDhHVBfQdWvyV7f
        Iv/lSxU6JndH53n1FoMW0iU=
X-Google-Smtp-Source: ABdhPJzFQ/L/4ZUaER8RmCQGH9ygBTjFjh2WilXQX9maipYmFA7RN7EDKhIQQ/rBmlXwTyJyPoiv0Q==
X-Received: by 2002:a05:6000:10d0:: with SMTP id b16mr20183524wrx.332.1627944822237;
        Mon, 02 Aug 2021 15:53:42 -0700 (PDT)
Received: from pc ([196.235.140.151])
        by smtp.gmail.com with ESMTPSA id q14sm12520389wrs.8.2021.08.02.15.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 15:53:41 -0700 (PDT)
Date:   Mon, 2 Aug 2021 23:53:39 +0100
From:   Salah Triki <salah.triki@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mark Brown <broonie@kernel.org>, Joe Perches <joe@perches.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sound: usb: get lock before calling  usb_enable_autosuspend()
Message-ID: <20210802225339.GA1461793@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the documentation of usb_enable_autosuspend(), the
caller must hold udev's device lock.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 sound/usb/card.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 2f6a62416c05..9290ba0acd5f 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -907,8 +907,13 @@ static void usb_audio_disconnect(struct usb_interface *intf)
 		}
 	}
 
-	if (chip->quirk_type & QUIRK_SETUP_DISABLE_AUTOSUSPEND)
-		usb_enable_autosuspend(interface_to_usbdev(intf));
+	if (chip->quirk_type & QUIRK_SETUP_DISABLE_AUTOSUSPEND) {
+		struct usb_device *udev = interface_to_usbdev(intf);
+
+		usb_lock_device(udev);
+		usb_enable_autosuspend(udev);
+		usb_unlock_device(udev);
+	}
 
 	chip->num_interfaces--;
 	if (chip->num_interfaces <= 0) {
-- 
2.25.1

