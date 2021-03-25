Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB80348BA5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 09:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhCYIhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 04:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhCYIgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 04:36:49 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FC8C06174A;
        Thu, 25 Mar 2021 01:36:49 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j7so1411730wrd.1;
        Thu, 25 Mar 2021 01:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=wLwX43sqMguThpcBykUYgc+AsOMBNPl22fadIMTuvtM=;
        b=Y++QGZqVYNYn7ssoMZMclCbA5pPVrSfJTkftRwlqfj82YrQ2qTjKTBMbpOvh+IkIum
         XV2bk+HVHkWcjhDqxdPpD9BEm9o1B1E+yyOArhd6YkE374byePBA0WMOYSUSGjW/Hmrk
         6i06MoqUdiYaiCa7Avc8KPKlk06dwkMWHr/2MmODVkOfIKLEd11oRHagCJwrqJqjSGfS
         vgG4ITYq+LiZYFb/mjX5hD0Psz9NDrqThEd05zRaLBKkZkO3zgOr9VGXvrRiY6gmZv6A
         VLlxVURNVNRfUtC+0dhZwXALp+D+iR2FAs0L9qngdm6GvfvwYs5PlC5jkoWbBPOgYKo9
         w3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=wLwX43sqMguThpcBykUYgc+AsOMBNPl22fadIMTuvtM=;
        b=IyNsK8ntcE8lEIxy6sbaIUJAovCLvaQyn48UArJ7BQ88swoi8aJErXkCFCR+u5t/24
         Y2bbAPDlPrKomxQl9JjBmjrcXu70aIjwLAzCP66WbVGeALCzh9MVm5F/letcFBWk214g
         ZiS2hCVh3iWx7pUhWmwSaXM4RSgsQ6FV/Mz+oGqJMQpj5NNw/pakhvdcVuY75kohXtwf
         AMar/a03NXsyVp7zD3JJhmFINT0Vf9XY14dW0l36yhH5t+WIe43v6jQWBOLV4tSFeAFe
         GCpMyhrf139DP0QouXYpSkUztR0CuHORrbh0FxBQk3kHH4xgkWpzFuhRQJAKnDQxa7EM
         hX0w==
X-Gm-Message-State: AOAM5328tVb3CdPgcuKrOxlVM8ZvK5CWie0sc6BLvZcIRMEgmuNynvgi
        f1nUaDC53koJvCc5SrbhFTs=
X-Google-Smtp-Source: ABdhPJyWUVZENNN58hChrtwyEfvCgyUEsQpBYbWURoHNC4hTzQXVW3cFg1Km9x1s6i0QcYb/TlZsrg==
X-Received: by 2002:adf:c40b:: with SMTP id v11mr7482901wrf.320.1616661407792;
        Thu, 25 Mar 2021 01:36:47 -0700 (PDT)
Received: from LEGION ([39.46.39.200])
        by smtp.gmail.com with ESMTPSA id u17sm5369687wmq.3.2021.03.25.01.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 01:36:47 -0700 (PDT)
Date:   Thu, 25 Mar 2021 13:36:41 +0500
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, colin.king@canonical.com,
        dan.carpenter@oracle.com
Cc:     musamaanjum@gmail.com
Subject: [PATCH] ALSA: usb-audio: Don't store returned value and check for
 errors
Message-ID: <20210325083641.GA644957@LEGION>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The returned value by create_autodetect_quirk isn't being used other
than in the success check on next line. Remove the return value
assignement. Check for error values instead of success check.

Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
---
 sound/usb/quirks.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 9e5e37eff10e..5ce5f4ecb9d0 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -425,9 +425,9 @@ static int create_autodetect_quirks(struct snd_usb_audio *chip,
 							USB_CLASS_VENDOR_SPEC)
 			continue;
 
-		err = create_autodetect_quirk(chip, iface, driver);
-		if (err >= 0)
-			usb_driver_claim_interface(driver, iface, (void *)-1L);
+		if (create_autodetect_quirk(chip, iface, driver) < 0)
+			continue;
+		usb_driver_claim_interface(driver, iface, (void *)-1L);
 	}
 
 	return 0;
-- 
2.25.1

