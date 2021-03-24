Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1152347F11
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 18:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbhCXRPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 13:15:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51344 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237151AbhCXROo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:14:44 -0400
Received: from 1-171-92-165.dynamic-ip.hinet.net ([1.171.92.165] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lP75D-0002q7-UY; Wed, 24 Mar 2021 17:14:16 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Chris Chiu <chiu@endlessm.com>,
        Mark Brown <broonie@kernel.org>, Joe Perches <joe@perches.com>,
        Tom Yan <tom.ty89@gmail.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] ALSA: usb-audio: Carve out connector value checking into a helper
Date:   Thu, 25 Mar 2021 01:14:07 +0800
Message-Id: <20210324171410.285848-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is preparation for next patch, no functional change intended.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/usb/mixer.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index b004b2e63a5d..98f5417a70e4 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1446,13 +1446,11 @@ static int mixer_ctl_master_bool_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-/* get the connectors status and report it as boolean type */
-static int mixer_ctl_connector_get(struct snd_kcontrol *kcontrol,
-				   struct snd_ctl_elem_value *ucontrol)
+static int get_connector_value(struct usb_mixer_elem_info *cval,
+			       char *name, int *val)
 {
-	struct usb_mixer_elem_info *cval = kcontrol->private_data;
 	struct snd_usb_audio *chip = cval->head.mixer->chip;
-	int idx = 0, validx, ret, val;
+	int idx = 0, validx, ret;
 
 	validx = cval->control << 8 | 0;
 
@@ -1467,21 +1465,24 @@ static int mixer_ctl_connector_get(struct snd_kcontrol *kcontrol,
 		ret = snd_usb_ctl_msg(chip->dev, usb_rcvctrlpipe(chip->dev, 0), UAC2_CS_CUR,
 				      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
 				      validx, idx, &uac2_conn, sizeof(uac2_conn));
-		val = !!uac2_conn.bNrChannels;
+		if (val)
+			*val = !!uac2_conn.bNrChannels;
 	} else { /* UAC_VERSION_3 */
 		struct uac3_insertion_ctl_blk uac3_conn;
 
 		ret = snd_usb_ctl_msg(chip->dev, usb_rcvctrlpipe(chip->dev, 0), UAC2_CS_CUR,
 				      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
 				      validx, idx, &uac3_conn, sizeof(uac3_conn));
-		val = !!uac3_conn.bmConInserted;
+		if (val)
+			*val = !!uac3_conn.bmConInserted;
 	}
 
 	snd_usb_unlock_shutdown(chip);
 
 	if (ret < 0) {
-		if (strstr(kcontrol->id.name, "Speaker")) {
-			ucontrol->value.integer.value[0] = 1;
+		if (name && strstr(name, "Speaker")) {
+			if (val)
+				*val = 1;
 			return 0;
 		}
 error:
@@ -1491,6 +1492,21 @@ static int mixer_ctl_connector_get(struct snd_kcontrol *kcontrol,
 		return filter_error(cval, ret);
 	}
 
+	return ret;
+}
+
+/* get the connectors status and report it as boolean type */
+static int mixer_ctl_connector_get(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *cval = kcontrol->private_data;
+	int ret, val;
+
+	ret = get_connector_value(cval, kcontrol->id.name, &val);
+
+	if (ret)
+		return ret;
+
 	ucontrol->value.integer.value[0] = val;
 	return 0;
 }
-- 
2.30.2

