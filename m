Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D220832CB6B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 05:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbhCDEfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 23:35:53 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58586 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbhCDEfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 23:35:21 -0500
Received: from 36-229-232-16.dynamic-ip.hinet.net ([36.229.232.16] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lHfgz-0007xv-3k; Thu, 04 Mar 2021 04:34:30 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Joe Perches <joe@perches.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Chris Wulff <crwulff@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alexander Tsoy <alexander@tsoy.me>,
        Joakim Tjernlund <joakim.tjernlund@infinera.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Panchenko <dmitry@d-systems.ee>,
        Olivia Mackintosh <livvy@base.nu>,
        Dylan Robinson <dylan_robinson@motu.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ALSA: usb-audio: Disable USB autosuspend properly in setup_disable_autosuspend()
Date:   Thu,  4 Mar 2021 12:34:16 +0800
Message-Id: <20210304043419.287191-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rear audio on Lenovo ThinkStation P620 stops working after commit
1965c4364bdd ("ALSA: usb-audio: Disable autosuspend for Lenovo
ThinkStation P620"):
[    6.013526] usbcore: registered new interface driver snd-usb-audio
[    6.023064] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x100, wIndex = 0x0, type = 1
[    6.023083] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x202, wIndex = 0x0, type = 4
[    6.023090] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x100, wIndex = 0x0, type = 1
[    6.023098] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x202, wIndex = 0x0, type = 4
[    6.023103] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x100, wIndex = 0x0, type = 1
[    6.023110] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x202, wIndex = 0x0, type = 4
[    6.045846] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x100, wIndex = 0x0, type = 1
[    6.045866] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x202, wIndex = 0x0, type = 4
[    6.045877] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x100, wIndex = 0x0, type = 1
[    6.045886] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x202, wIndex = 0x0, type = 4
[    6.045894] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x100, wIndex = 0x0, type = 1
[    6.045908] usb 3-6: cannot get ctl value: req = 0x81, wValue = 0x202, wIndex = 0x0, type = 4

I overlooked the issue because when I was working on the said commit,
only the front audio is tested. Apology for that.

Changing supports_autosuspend in driver is too late for disabling
autosuspend, because it was already used by USB probe routine, so it can
break the balance on the following code that depends on
supports_autosuspend.

Fix it by using usb_disable_autosuspend() helper, and balance the
suspend count in disconnect callback.

Fixes: 1965c4364bdd ("ALSA: usb-audio: Disable autosuspend for Lenovo ThinkStation P620")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/usb/card.c     | 5 +++++
 sound/usb/quirks.c   | 2 +-
 sound/usb/usbaudio.h | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 85ed8507e41a..08c794883299 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -830,6 +830,8 @@ static int usb_audio_probe(struct usb_interface *intf,
 		snd_media_device_create(chip, intf);
 	}
 
+	chip->quirk_type = quirk->type;
+
 	usb_chip[chip->index] = chip;
 	chip->intf[chip->num_interfaces] = intf;
 	chip->num_interfaces++;
@@ -912,6 +914,9 @@ static void usb_audio_disconnect(struct usb_interface *intf)
 	} else {
 		mutex_unlock(&register_mutex);
 	}
+
+	if (chip->quirk_type & QUIRK_SETUP_DISABLE_AUTOSUSPEND)
+		usb_enable_autosuspend(interface_to_usbdev(intf));
 }
 
 /* lock the shutdown (disconnect) task and autoresume */
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 9ba4682ebc48..ef5ee899db26 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -547,7 +547,7 @@ static int setup_disable_autosuspend(struct snd_usb_audio *chip,
 				       struct usb_driver *driver,
 				       const struct snd_usb_audio_quirk *quirk)
 {
-	driver->supports_autosuspend = 0;
+	usb_disable_autosuspend(interface_to_usbdev(iface));
 	return 1;	/* Continue with creating streams and mixer */
 }
 
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 215c1771dd57..60b9dd7df6bb 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -27,6 +27,7 @@ struct snd_usb_audio {
 	struct snd_card *card;
 	struct usb_interface *intf[MAX_CARD_INTERFACES];
 	u32 usb_id;
+	uint16_t quirk_type;
 	struct mutex mutex;
 	unsigned int system_suspend;
 	atomic_t active;
-- 
2.30.0

