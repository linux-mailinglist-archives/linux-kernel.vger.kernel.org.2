Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8624327F05
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 14:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbhCANIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 08:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbhCANHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 08:07:04 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4B7C0617A7;
        Mon,  1 Mar 2021 05:06:05 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id e2so12122507ljo.7;
        Mon, 01 Mar 2021 05:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WS9tmPTgSzWLTwnM4vmHTC0eLivRTI4KclbS5tbRu+Q=;
        b=M+7kzl+BVnhYpk7nFRYriI+3CIBa12Q59wAnjXQuGo3Dz7DA5h70DT9W+nT7jcVxaz
         bxYgxe1Ezb/JrSEBQHjOQ05dWwUlgkFsZCswLJ4tKoLnGfVktatzcVGXlnOVH2u7pFGY
         w5Zlqr7BBt3NY+Kbpn5AlNUvND/1Z6JzELbZwT6XLTyGUdDLKlDTAV80nK4YMYquzY0o
         iH6e4BCSIUFoRNNyhyE0pFg7lw8Teg0DXXyObY4+hSI+rhkedJM4JVHI60A1HZCdKkL0
         XPKe8VXC6QeDKdDYN1HQC0DyLH67SWWW3yPE5VXTJmG9OAJMfa+iNkG25MKGWVMK7xGv
         EpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WS9tmPTgSzWLTwnM4vmHTC0eLivRTI4KclbS5tbRu+Q=;
        b=rmYdGby3HMSK7MZhB4RBGyHO7sUPzxn1/oXRrk9z5risf4PJ+R+E/qrsxPa0JGKwO0
         azAewXxYtoaKPEOSV8R05N+UsA7K6nRV5OFJxm+0zR2yp1rIFmG32x8giFMqNLV8o2OJ
         j8ow0JB2d6tLSoSy8bFQaf+mDUAOdlhPZ3+ttRstcExo3LISJlJOZsuFPOdgsBtUstom
         EsaJk56GEG3r0HIQJqHXyiU+9xyCRneDTSRc3OqZ2/9vhloh+ceGPWfsf47ftrPhOq9b
         j/9y6BE+obH7b2iQEgG5D1gth0RQtHaHkgX6Jt8ybBTmWcsWTzT1wQa4rY6eOEdO7Kvo
         Rrkw==
X-Gm-Message-State: AOAM5333pmh3/j3MOnsOHrSB/INMityF5XHfAvnycuASrLvj2FlsMeeF
        fQ1EbhyfF8DWwtX28vQJO9s=
X-Google-Smtp-Source: ABdhPJxtaDN2UEvCul3zAFzV6/iS3KUtX+UbY2EJxLrrLME631Fo1L0b+0MG6g+4FY46WY0tGgKCOA==
X-Received: by 2002:a05:651c:548:: with SMTP id q8mr9117983ljp.256.1614603963786;
        Mon, 01 Mar 2021 05:06:03 -0800 (PST)
Received: from localhost (crossness-hoof.volia.net. [93.72.107.198])
        by smtp.gmail.com with ESMTPSA id a31sm2353978ljq.109.2021.03.01.05.06.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 Mar 2021 05:06:02 -0800 (PST)
From:   Ruslan Bilovol <ruslan.bilovol@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     gschmottlach@gmail.com, linux-usb@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] usb: gadget: u_audio: add bi-directional volume and mute support
Date:   Mon,  1 Mar 2021 15:05:41 +0200
Message-Id: <1614603943-11668-7-git-send-email-ruslan.bilovol@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1614603943-11668-1-git-send-email-ruslan.bilovol@gmail.com>
References: <1614603943-11668-1-git-send-email-ruslan.bilovol@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB Audio Class 1/2 have ability to change device's
volume and mute by USB Host through class-specific control
requests. Device also can notify Host about volume/mute
change on its side through optional interrupt endpoint.

This patch adds Volume and Mute ALSA controls which can be
used by user to send and receive notifications to/from
the USB Host about Volume and Mute change.

These params come from f_uac* so volume and mute controls
will be created only if the function support and enable
each explicitly

Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
---
 drivers/usb/gadget/function/u_audio.c | 360 +++++++++++++++++++++++++++++++++-
 drivers/usb/gadget/function/u_audio.h |  22 +++
 2 files changed, 372 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/function/u_audio.c b/drivers/usb/gadget/function/u_audio.c
index b434e70..f4b850b 100644
--- a/drivers/usb/gadget/function/u_audio.c
+++ b/drivers/usb/gadget/function/u_audio.c
@@ -12,11 +12,14 @@
  *    Jaswinder Singh (jaswinder.singh@linaro.org)
  */
 
+#include <linux/kernel.h>
 #include <linux/module.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/control.h>
+#include <sound/tlv.h>
+#include <linux/usb/audio.h>
 
 #include "u_audio.h"
 
@@ -24,6 +27,12 @@
 #define PRD_SIZE_MAX	PAGE_SIZE
 #define MIN_PERIODS	4
 
+enum {
+	UAC_FBACK_CTRL,
+	UAC_MUTE_CTRL,
+	UAC_VOLUME_CTRL,
+};
+
 /* Runtime data params for one stream */
 struct uac_rtd_params {
 	struct snd_uac_chip *uac; /* parent chip */
@@ -44,6 +53,14 @@ struct uac_rtd_params {
 	unsigned int ffback; /* Real frequency reported by feedback endpoint */
 	bool fb_ep_enabled; /* if the ep is enabled */
 
+	/* Volume/Mute controls and their state */
+	int fu_id; /* Feature Unit ID */
+	struct snd_kcontrol *snd_kctl_volume;
+	struct snd_kcontrol *snd_kctl_mute;
+	s16 volume_min, volume_max, volume_res;
+	s16 volume;
+	int mute;
+
 	spinlock_t lock; /* lock for feedback and control transfers */
 };
 
@@ -599,6 +616,102 @@ void u_audio_stop_playback(struct g_audio *audio_dev)
 }
 EXPORT_SYMBOL_GPL(u_audio_stop_playback);
 
+int u_audio_get_volume(struct g_audio *audio_dev, int playback, s16 *val)
+{
+	struct snd_uac_chip *uac = audio_dev->uac;
+	struct uac_rtd_params *prm;
+	unsigned long flags;
+
+	if (playback)
+		prm = &uac->p_prm;
+	else
+		prm = &uac->c_prm;
+
+	spin_lock_irqsave(&prm->lock, flags);
+	*val = prm->volume;
+	spin_unlock_irqrestore(&prm->lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(u_audio_get_volume);
+
+int u_audio_set_volume(struct g_audio *audio_dev, int playback, s16 val)
+{
+	struct snd_uac_chip *uac = audio_dev->uac;
+	struct uac_rtd_params *prm;
+	unsigned long flags;
+	int change = 0;
+
+	if (playback)
+		prm = &uac->p_prm;
+	else
+		prm = &uac->c_prm;
+
+	spin_lock_irqsave(&prm->lock, flags);
+	val = clamp(val, prm->volume_min, prm->volume_max);
+	if (prm->volume != val) {
+		prm->volume = val;
+		change = 1;
+	}
+	spin_unlock_irqrestore(&prm->lock, flags);
+
+	if (change)
+		snd_ctl_notify(uac->card, SNDRV_CTL_EVENT_MASK_VALUE,
+				&prm->snd_kctl_volume->id);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(u_audio_set_volume);
+
+int u_audio_get_mute(struct g_audio *audio_dev, int playback, int *val)
+{
+	struct snd_uac_chip *uac = audio_dev->uac;
+	struct uac_rtd_params *prm;
+	unsigned long flags;
+
+	if (playback)
+		prm = &uac->p_prm;
+	else
+		prm = &uac->c_prm;
+
+	spin_lock_irqsave(&prm->lock, flags);
+	*val = prm->mute;
+	spin_unlock_irqrestore(&prm->lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(u_audio_get_mute);
+
+int u_audio_set_mute(struct g_audio *audio_dev, int playback, int val)
+{
+	struct snd_uac_chip *uac = audio_dev->uac;
+	struct uac_rtd_params *prm;
+	unsigned long flags;
+	int change = 0;
+	int mute;
+
+	if (playback)
+		prm = &uac->p_prm;
+	else
+		prm = &uac->c_prm;
+
+	mute = val ? 1 : 0;
+
+	spin_lock_irqsave(&prm->lock, flags);
+	if (prm->mute != mute) {
+		prm->mute = mute;
+		change = 1;
+	}
+	spin_unlock_irqrestore(&prm->lock, flags);
+
+	if (change)
+		snd_ctl_notify(uac->card, SNDRV_CTL_EVENT_MASK_VALUE,
+			       &prm->snd_kctl_mute->id);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(u_audio_set_mute);
+
 static int u_audio_rate_shift_info(struct snd_kcontrol *kcontrol,
 				   struct snd_ctl_elem_info *uinfo)
 {
@@ -663,14 +776,157 @@ static int u_audio_rate_shift_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static const struct snd_kcontrol_new u_audio_controls[]  = {
+static int u_audio_mute_info(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	uinfo->value.integer.step = 1;
+
+	return 0;
+}
+
+static int u_audio_mute_get(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
 {
-	.iface =        SNDRV_CTL_ELEM_IFACE_PCM,
-	.name =         "PCM Feedback Frequency Hz",
-	.info =         u_audio_rate_shift_info,
-	.get =          u_audio_rate_shift_get,
-	.put =          u_audio_rate_shift_put,
-},
+	struct uac_rtd_params *prm = snd_kcontrol_chip(kcontrol);
+	unsigned long flags;
+
+	spin_lock_irqsave(&prm->lock, flags);
+	ucontrol->value.integer.value[0] = !prm->mute;
+	spin_unlock_irqrestore(&prm->lock, flags);
+
+	return 0;
+}
+
+static int u_audio_mute_put(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct uac_rtd_params *prm = snd_kcontrol_chip(kcontrol);
+	struct snd_uac_chip *uac = prm->uac;
+	struct g_audio *audio_dev = uac->audio_dev;
+	unsigned int val;
+	unsigned long flags;
+	int change = 0;
+
+	val = !ucontrol->value.integer.value[0];
+
+	spin_lock_irqsave(&prm->lock, flags);
+	if (val != prm->mute) {
+		prm->mute = val;
+		change = 1;
+	}
+	spin_unlock_irqrestore(&prm->lock, flags);
+
+	if (change && audio_dev->notify)
+		audio_dev->notify(audio_dev, prm->fu_id, UAC_FU_MUTE);
+
+	return change;
+}
+
+/*
+ * TLV callback for mixer volume controls
+ */
+static int u_audio_volume_tlv(struct snd_kcontrol *kcontrol, int op_flag,
+			 unsigned int size, unsigned int __user *_tlv)
+{
+	struct uac_rtd_params *prm = snd_kcontrol_chip(kcontrol);
+	DECLARE_TLV_DB_MINMAX(scale, 0, 0);
+
+	if (size < sizeof(scale))
+		return -ENOMEM;
+
+	/* UAC volume resolution is 1/256 dB, TLV is 1/100 dB */
+	scale[2] = (prm->volume_min * 100) / 256;
+	scale[3] = (prm->volume_max * 100) / 256;
+	if (copy_to_user(_tlv, scale, sizeof(scale)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int u_audio_volume_info(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_info *uinfo)
+{
+	struct uac_rtd_params *prm = snd_kcontrol_chip(kcontrol);
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max =
+		(prm->volume_max - prm->volume_min + prm->volume_res - 1)
+		/ prm->volume_res;
+	uinfo->value.integer.step = 1;
+
+	return 0;
+}
+
+static int u_audio_volume_get(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct uac_rtd_params *prm = snd_kcontrol_chip(kcontrol);
+	unsigned long flags;
+
+	spin_lock_irqsave(&prm->lock, flags);
+	ucontrol->value.integer.value[0] =
+			(prm->volume - prm->volume_min) / prm->volume_res;
+	spin_unlock_irqrestore(&prm->lock, flags);
+
+	return 0;
+}
+
+static int u_audio_volume_put(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct uac_rtd_params *prm = snd_kcontrol_chip(kcontrol);
+	struct snd_uac_chip *uac = prm->uac;
+	struct g_audio *audio_dev = uac->audio_dev;
+	unsigned int val;
+	s16 volume;
+	unsigned long flags;
+	int change = 0;
+
+	val = ucontrol->value.integer.value[0];
+
+	spin_lock_irqsave(&prm->lock, flags);
+	volume = (val * prm->volume_res) + prm->volume_min;
+	volume = clamp(volume, prm->volume_min, prm->volume_max);
+	if (volume != prm->volume) {
+		prm->volume = volume;
+		change = 1;
+	}
+	spin_unlock_irqrestore(&prm->lock, flags);
+
+	if (change && audio_dev->notify)
+		audio_dev->notify(audio_dev, prm->fu_id, UAC_FU_VOLUME);
+
+	return change;
+}
+
+static struct snd_kcontrol_new u_audio_controls[] = {
+	[UAC_FBACK_CTRL] {
+		.iface =        SNDRV_CTL_ELEM_IFACE_PCM,
+		.name =         "PCM Feedback Frequency Hz",
+		.info =         u_audio_rate_shift_info,
+		.get =          u_audio_rate_shift_get,
+		.put =          u_audio_rate_shift_put,
+	},
+	[UAC_MUTE_CTRL] {
+		.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name =		"", /* will be filled later */
+		.info =		u_audio_mute_info,
+		.get =		u_audio_mute_get,
+		.put =		u_audio_mute_put,
+	},
+	[UAC_VOLUME_CTRL] {
+		.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name =		"", /* will be filled later */
+		.info =		u_audio_volume_info,
+		.get =		u_audio_volume_get,
+		.put =		u_audio_volume_put,
+	},
 };
 
 int g_audio_setup(struct g_audio *g_audio, const char *pcm_name,
@@ -682,7 +938,7 @@ int g_audio_setup(struct g_audio *g_audio, const char *pcm_name,
 	struct snd_kcontrol *kctl;
 	struct uac_params *params;
 	int p_chmask, c_chmask;
-	int err;
+	int i, err;
 
 	if (!g_audio)
 		return -EINVAL;
@@ -769,10 +1025,18 @@ int g_audio_setup(struct g_audio *g_audio, const char *pcm_name,
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &uac_pcm_ops);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &uac_pcm_ops);
 
-	if (c_chmask && g_audio->in_ep_fback) {
+	/*
+	 * Create mixer and controls
+	 * Create only if it's required on USB side
+	 */
+	if ((c_chmask && g_audio->in_ep_fback)
+			|| (p_chmask && params->p_fu.id)
+			|| (c_chmask && params->c_fu.id))
 		strscpy(card->mixername, card_name, sizeof(card->mixername));
 
-		kctl = snd_ctl_new1(&u_audio_controls[0], &uac->c_prm);
+	if (c_chmask && g_audio->in_ep_fback) {
+		kctl = snd_ctl_new1(&u_audio_controls[UAC_FBACK_CTRL],
+				    &uac->c_prm);
 		if (!kctl) {
 			err = -ENOMEM;
 			goto snd_fail;
@@ -786,6 +1050,82 @@ int g_audio_setup(struct g_audio *g_audio, const char *pcm_name,
 			goto snd_fail;
 	}
 
+	for (i = 0; i <= SNDRV_PCM_STREAM_LAST; i++) {
+		struct uac_rtd_params *prm;
+		struct uac_fu_params *fu;
+		char ctrl_name[24];
+		char *direction;
+
+		if (!pcm->streams[i].substream_count)
+			continue;
+
+		if (i == SNDRV_PCM_STREAM_PLAYBACK) {
+			prm = &uac->p_prm;
+			fu = &params->p_fu;
+			direction = "Playback";
+		} else {
+			prm = &uac->c_prm;
+			fu = &params->c_fu;
+			direction = "Capture";
+		}
+
+		prm->fu_id = fu->id;
+
+		if (fu->mute_present) {
+			snprintf(ctrl_name, sizeof(ctrl_name),
+					"PCM %s Switch", direction);
+
+			u_audio_controls[UAC_MUTE_CTRL].name = ctrl_name;
+
+			kctl = snd_ctl_new1(&u_audio_controls[UAC_MUTE_CTRL],
+					    prm);
+			if (!kctl) {
+				err = -ENOMEM;
+				goto snd_fail;
+			}
+
+			kctl->id.device = pcm->device;
+			kctl->id.subdevice = i;
+
+			err = snd_ctl_add(card, kctl);
+			if (err < 0)
+				goto snd_fail;
+			prm->snd_kctl_mute = kctl;
+			prm->mute = 0;
+		}
+
+		if (fu->volume_present) {
+			snprintf(ctrl_name, sizeof(ctrl_name),
+					"PCM %s Volume", direction);
+
+			u_audio_controls[UAC_VOLUME_CTRL].name = ctrl_name;
+
+			kctl = snd_ctl_new1(&u_audio_controls[UAC_VOLUME_CTRL],
+					    prm);
+			if (!kctl) {
+				err = -ENOMEM;
+				goto snd_fail;
+			}
+
+			kctl->id.device = pcm->device;
+			kctl->id.subdevice = i;
+
+
+			kctl->tlv.c = u_audio_volume_tlv;
+			kctl->vd[0].access |= SNDRV_CTL_ELEM_ACCESS_TLV_READ |
+					SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK;
+
+			err = snd_ctl_add(card, kctl);
+			if (err < 0)
+				goto snd_fail;
+			prm->snd_kctl_volume = kctl;
+			prm->volume = fu->volume_max;
+			prm->volume_max = fu->volume_max;
+			prm->volume_min = fu->volume_min;
+			prm->volume_res = fu->volume_res;
+		}
+	}
+
 	strscpy(card->driver, card_name, sizeof(card->driver));
 	strscpy(card->shortname, card_name, sizeof(card->shortname));
 	sprintf(card->longname, "%s %i", card_name, card->dev->id);
diff --git a/drivers/usb/gadget/function/u_audio.h b/drivers/usb/gadget/function/u_audio.h
index fd70808..4f977f2 100644
--- a/drivers/usb/gadget/function/u_audio.h
+++ b/drivers/usb/gadget/function/u_audio.h
@@ -18,16 +18,30 @@
 #define FBACK_FREQ_MIN	80
 #define FBACK_FREQ_MAX	120
 
+/* Feature Unit parameters */
+struct uac_fu_params {
+	int id;			/* Feature Unit ID */
+
+	bool mute_present;	/* mute control enable */
+
+	bool volume_present;	/* volume control enable */
+	s16 volume_min;		/* min volume in 1/256 dB */
+	s16 volume_max;		/* max volume in 1/256 dB */
+	s16 volume_res;		/* volume resolution in 1/256 dB */
+};
+
 struct uac_params {
 	/* playback */
 	int p_chmask;	/* channel mask */
 	int p_srate;	/* rate in Hz */
 	int p_ssize;	/* sample size */
+	struct uac_fu_params p_fu;	/* Feature Unit parameters */
 
 	/* capture */
 	int c_chmask;	/* channel mask */
 	int c_srate;	/* rate in Hz */
 	int c_ssize;	/* sample size */
+	struct uac_fu_params c_fu;	/* Feature Unit parameters */
 
 	int req_number; /* number of preallocated requests */
 };
@@ -47,6 +61,9 @@ struct g_audio {
 	/* Max packet size for all out_ep possible speeds */
 	unsigned int out_ep_maxpsize;
 
+	/* Notify UAC driver about control change */
+	int (*notify)(struct g_audio *g_audio, int unit_id, int cs);
+
 	/* The ALSA Sound Card it represents on the USB-Client side */
 	struct snd_uac_chip *uac;
 
@@ -92,4 +109,9 @@ int g_audio_setup(struct g_audio *g_audio, const char *pcm_name,
 int u_audio_start_playback(struct g_audio *g_audio);
 void u_audio_stop_playback(struct g_audio *g_audio);
 
+int u_audio_get_volume(struct g_audio *g_audio, int playback, s16 *val);
+int u_audio_set_volume(struct g_audio *g_audio, int playback, s16 val);
+int u_audio_get_mute(struct g_audio *g_audio, int playback, int *val);
+int u_audio_set_mute(struct g_audio *g_audio, int playback, int val);
+
 #endif /* __U_AUDIO_H */
-- 
1.9.1

