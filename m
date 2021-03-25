Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6363491B0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 13:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhCYMOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 08:14:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54657 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhCYMN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 08:13:29 -0400
Received: from 1-171-92-165.dynamic-ip.hinet.net ([1.171.92.165] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lPOrG-00017f-6f; Thu, 25 Mar 2021 12:13:02 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Chris Chiu <chiu@endlessm.com>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Tom Yan <tom.ty89@gmail.com>, Joe Perches <joe@perches.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] ALSA: usb-audio: Check connector value on resume
Date:   Thu, 25 Mar 2021 20:12:48 +0800
Message-Id: <20210325121250.133009-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210325121250.133009-1-kai.heng.feng@canonical.com>
References: <20210325121250.133009-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rear Mic on Lenovo P620 cannot record after S3, despite that there's no
error and the other two functions of the USB audio, Line In and Line
Out, work just fine.

The mic starts to work again after running userspace app like "alsactl
store". Following the lead, the evidence shows that as soon as connector
status is queried, the mic can work again.

So also check connector value on resume to "wake up" the USB audio to
make it functional.

This can be device specific, however I think this generic approach may
benefit more than one device.

While at it, also remove reset-resume path to consolidate mixer resume
path.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 - Remove reset-resume.
 - Fold the connector checking to the mixer resume callback.

 sound/usb/card.c  | 16 +++-------------
 sound/usb/mixer.c | 27 +++++++++++++++------------
 sound/usb/mixer.h |  2 +-
 3 files changed, 19 insertions(+), 26 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 0826a437f8fc..552a57c00799 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -1014,7 +1014,7 @@ static int usb_audio_suspend(struct usb_interface *intf, pm_message_t message)
 	return 0;
 }
 
-static int __usb_audio_resume(struct usb_interface *intf, bool reset_resume)
+static int usb_audio_resume(struct usb_interface *intf)
 {
 	struct snd_usb_audio *chip = usb_get_intfdata(intf);
 	struct snd_usb_stream *as;
@@ -1040,7 +1040,7 @@ static int __usb_audio_resume(struct usb_interface *intf, bool reset_resume)
 	 * we just notify and restart the mixers
 	 */
 	list_for_each_entry(mixer, &chip->mixer_list, list) {
-		err = snd_usb_mixer_resume(mixer, reset_resume);
+		err = snd_usb_mixer_resume(mixer);
 		if (err < 0)
 			goto err_out;
 	}
@@ -1060,16 +1060,6 @@ static int __usb_audio_resume(struct usb_interface *intf, bool reset_resume)
 	atomic_dec(&chip->active); /* allow autopm after this point */
 	return err;
 }
-
-static int usb_audio_resume(struct usb_interface *intf)
-{
-	return __usb_audio_resume(intf, false);
-}
-
-static int usb_audio_reset_resume(struct usb_interface *intf)
-{
-	return __usb_audio_resume(intf, true);
-}
 #else
 #define usb_audio_suspend	NULL
 #define usb_audio_resume	NULL
@@ -1095,7 +1085,7 @@ static struct usb_driver usb_audio_driver = {
 	.disconnect =	usb_audio_disconnect,
 	.suspend =	usb_audio_suspend,
 	.resume =	usb_audio_resume,
-	.reset_resume =	usb_audio_reset_resume,
+	.reset_resume =	usb_audio_resume,
 	.id_table =	usb_audio_ids,
 	.supports_autosuspend = 1,
 };
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 5a2d9a768f70..7468c8d2b158 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -3601,11 +3601,16 @@ int snd_usb_mixer_suspend(struct usb_mixer_interface *mixer)
 	return 0;
 }
 
-static int restore_mixer_value(struct usb_mixer_elem_list *list)
+static int resume_mixer(struct usb_mixer_elem_list *list)
 {
 	struct usb_mixer_elem_info *cval = mixer_elem_list_to_info(list);
 	int c, err, idx;
 
+	/* get connector value to "wake up" the USB audio */
+	if (cval->val_type == USB_MIXER_BOOLEAN && cval->channels == 1)
+		get_connector_value(cval, NULL, NULL);
+
+	/* restore other mixer value */
 	if (cval->cmask) {
 		idx = 0;
 		for (c = 0; c < MAX_CHANNELS; c++) {
@@ -3631,20 +3636,18 @@ static int restore_mixer_value(struct usb_mixer_elem_list *list)
 	return 0;
 }
 
-int snd_usb_mixer_resume(struct usb_mixer_interface *mixer, bool reset_resume)
+int snd_usb_mixer_resume(struct usb_mixer_interface *mixer)
 {
 	struct usb_mixer_elem_list *list;
 	int id, err;
 
-	if (reset_resume) {
-		/* restore cached mixer values */
-		for (id = 0; id < MAX_ID_ELEMS; id++) {
-			for_each_mixer_elem(list, mixer, id) {
-				if (list->resume) {
-					err = list->resume(list);
-					if (err < 0)
-						return err;
-				}
+	/* restore cached mixer values */
+	for (id = 0; id < MAX_ID_ELEMS; id++) {
+		for_each_mixer_elem(list, mixer, id) {
+			if (list->resume) {
+				err = list->resume(list);
+				if (err < 0)
+					return err;
 			}
 		}
 	}
@@ -3663,6 +3666,6 @@ void snd_usb_mixer_elem_init_std(struct usb_mixer_elem_list *list,
 	list->id = unitid;
 	list->dump = snd_usb_mixer_dump_cval;
 #ifdef CONFIG_PM
-	list->resume = restore_mixer_value;
+	list->resume = resume_mixer;
 #endif
 }
diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
index c29e27ac43a7..7584c4762823 100644
--- a/sound/usb/mixer.h
+++ b/sound/usb/mixer.h
@@ -120,7 +120,7 @@ int snd_usb_mixer_vol_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 
 #ifdef CONFIG_PM
 int snd_usb_mixer_suspend(struct usb_mixer_interface *mixer);
-int snd_usb_mixer_resume(struct usb_mixer_interface *mixer, bool reset_resume);
+int snd_usb_mixer_resume(struct usb_mixer_interface *mixer);
 #endif
 
 int snd_usb_set_cur_mix_value(struct usb_mixer_elem_info *cval, int channel,
-- 
2.30.2

