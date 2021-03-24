Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A29347688
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 11:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbhCXKwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 06:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbhCXKv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 06:51:59 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A666C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 03:51:59 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id c204so17029107pfc.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 03:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RHAm+76/M2ERnBpqBJ8Unh6sng0ndd/2/ck/dYLnYiM=;
        b=ho/mqtW7Z41cxn8EjFhy44T0xgx2WYhKkJ9tk4gjM8c1lXyncVdPmLmZGfrKkRBSFm
         lCrI/5g/00U4MI1yx3U+rr+ooTZJxqciHZMM9iA6pgnJUgYhOeXMoAQzMtPTH9umJNzD
         joX8SumJ+wMTE1hkUodlJw8RUJ/AQNYTnfaLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RHAm+76/M2ERnBpqBJ8Unh6sng0ndd/2/ck/dYLnYiM=;
        b=cR5CxZhUofEvA/GVKk7XiwzviKdKffw6xrzFbHuV7QB0h4Gs8VqpDdD1k1ae/aN3vd
         hkeM8UDQ9NbGHoH/ioiorNMWUvADE4aEDoOP5N3yWlGHh7SV0M4OJDCldFwpnemQxjaD
         vER6uxiBeAHYIAyBDMr172kK74PsmW1EehILDpL5sS0g5q7p8FjkHaGllq0feAK2SWR7
         eRMA1cMstYpHETIfmmoG/M2yFc3JtHXouqHSp4Rn6EPDmYN8WtUUFGPl+LzV/TcBYD2x
         q8s9Kv2XyH61OwDL4EfYxvsGwl8QxlGG/yGaQH+W8e77dT+MR//6n6/ZVYaej7BMBylg
         Z0gg==
X-Gm-Message-State: AOAM533dEvqQVQPhpci7HtkBUGPOhBVYMh5oI9fXVyB2pfHNIxOHFto0
        qNF8ZPM2UTkdvKsfXsGE5kyYrQ==
X-Google-Smtp-Source: ABdhPJw7V/f4oA9bNMIjIGhevVeob1pCiQHINzu/+yEXvfZBK2PFTdAsJCoe5M+5Y9r3sMqaK2BSxg==
X-Received: by 2002:a63:d309:: with SMTP id b9mr2454981pgg.96.1616583118899;
        Wed, 24 Mar 2021 03:51:58 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:b:5820:ad58:4021:85])
        by smtp.gmail.com with ESMTPSA id w4sm2107371pjk.55.2021.03.24.03.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 03:51:58 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Olivia Mackintosh <livvy@base.nu>, linux-usb@vger.kernel.org,
        Dmitry Panchenko <dmitry@d-systems.ee>,
        Dylan Robinson <dylan_robinson@motu.com>,
        Joakim Tjernlund <joakim.tjernlund@infinera.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Alexander Tsoy <alexander@tsoy.me>, linux-kernel@vger.kernel,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gregor Pintar <grpintar@gmail.com>,
        Ikjoon Jang <ikjn@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: Apply sample rate quirk to Logitech Connect
Date:   Wed, 24 Mar 2021 18:51:52 +0800
Message-Id: <20210324105153.2322881-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Logitech ConferenceCam Connect is a compound USB device with UVC and
UAC. Not 100% reproducible but sometimes it keeps responding STALL to
every control transfer once it receives get_freq request.

This patch adds 046d:0x084c to a snd_usb_get_sample_rate_quirk list.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=203419
Signed-off-by: Ikjoon Jang <ikjn@chromium.org>

---

 sound/usb/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index d3001fb18141..176437a441e6 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1521,6 +1521,7 @@ bool snd_usb_get_sample_rate_quirk(struct snd_usb_audio *chip)
 	case USB_ID(0x21b4, 0x0081): /* AudioQuest DragonFly */
 	case USB_ID(0x2912, 0x30c8): /* Audioengine D1 */
 	case USB_ID(0x413c, 0xa506): /* Dell AE515 sound bar */
+	case USB_ID(0x046d, 0x084c): /* Logitech ConferenceCam Connect */
 		return true;
 	}
 
-- 
2.31.0.291.g576ba9dcdaf-goog

