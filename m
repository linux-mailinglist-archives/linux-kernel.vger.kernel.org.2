Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B0534977D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 18:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhCYRAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 13:00:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35540 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhCYRAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 13:00:15 -0400
Received: from 1-171-92-165.dynamic-ip.hinet.net ([1.171.92.165] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lPTKZ-0003Ut-Ua; Thu, 25 Mar 2021 16:59:36 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Joe Perches <joe@perches.com>, Mark Brown <broonie@kernel.org>,
        Chris Chiu <chiu@endlessm.com>, Tom Yan <tom.ty89@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Ebeling <penguins@bollie.de>,
        =?UTF-8?q?Franti=C5=A1ek=20Ku=C4=8Dera?= <franta-linux@frantovo.cz>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Olivia Mackintosh <livvy@base.nu>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/2] ALSA: usb-audio: Check connector value on resume
Date:   Fri, 26 Mar 2021 00:59:13 +0800
Message-Id: <20210325165918.22593-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210325165918.22593-1-kai.heng.feng@canonical.com>
References: <20210325165918.22593-1-kai.heng.feng@canonical.com>
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

Now the resume callback checks connector, and a new callback,
reset_resume, to also restore switches and volumes.

Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v3:
 - New callback to handle resume and reset-resume separately.

v2:
 - Remove reset-resume.
 - Fold the connector checking to the mixer resume callback.

 sound/usb/mixer.c        | 44 +++++++++++++++++++++++++++++++---------
 sound/usb/mixer.h        |  1 +
 sound/usb/mixer_quirks.c |  2 +-
 3 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 5a2d9a768f70..2faf5767c7f8 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -3631,20 +3631,43 @@ static int restore_mixer_value(struct usb_mixer_elem_list *list)
 	return 0;
 }
 
+static int default_mixer_resume(struct usb_mixer_elem_list *list)
+{
+	struct usb_mixer_elem_info *cval = mixer_elem_list_to_info(list);
+
+	/* get connector value to "wake up" the USB audio */
+	if (cval->val_type == USB_MIXER_BOOLEAN && cval->channels == 1)
+		get_connector_value(cval, NULL, NULL);
+
+	return 0;
+}
+
+static int default_mixer_reset_resume(struct usb_mixer_elem_list *list)
+{
+	int err = default_mixer_resume(list);
+
+	if (err < 0)
+		return err;
+	return restore_mixer_value(list);
+}
+
 int snd_usb_mixer_resume(struct usb_mixer_interface *mixer, bool reset_resume)
 {
 	struct usb_mixer_elem_list *list;
+	usb_mixer_elem_resume_func_t f;
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
+			if (reset_resume)
+				f = list->reset_resume;
+			else
+				f = list->resume;
+			if (f) {
+				err = f(list);
+				if (err < 0)
+					return err;
 			}
 		}
 	}
@@ -3663,6 +3686,7 @@ void snd_usb_mixer_elem_init_std(struct usb_mixer_elem_list *list,
 	list->id = unitid;
 	list->dump = snd_usb_mixer_dump_cval;
 #ifdef CONFIG_PM
-	list->resume = restore_mixer_value;
+	list->resume = default_mixer_resume;
+	list->reset_resume = default_mixer_reset_resume;
 #endif
 }
diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
index c29e27ac43a7..e5a01f17bf3c 100644
--- a/sound/usb/mixer.h
+++ b/sound/usb/mixer.h
@@ -69,6 +69,7 @@ struct usb_mixer_elem_list {
 	bool is_std_info;
 	usb_mixer_elem_dump_func_t dump;
 	usb_mixer_elem_resume_func_t resume;
+	usb_mixer_elem_resume_func_t reset_resume;
 };
 
 /* iterate over mixer element list of the given unit id */
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index ffd922327ae4..b7f9c2fded05 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -151,7 +151,7 @@ static int add_single_ctl_with_resume(struct usb_mixer_interface *mixer,
 		*listp = list;
 	list->mixer = mixer;
 	list->id = id;
-	list->resume = resume;
+	list->reset_resume = resume;
 	kctl = snd_ctl_new1(knew, list);
 	if (!kctl) {
 		kfree(list);
-- 
2.30.2

