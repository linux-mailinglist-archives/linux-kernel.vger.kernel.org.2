Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5635A327F06
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 14:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbhCANIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 08:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235398AbhCANHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 08:07:04 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB6FC061797;
        Mon,  1 Mar 2021 05:05:59 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id p21so25328482lfu.11;
        Mon, 01 Mar 2021 05:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FlwUrBAk0DE0NXbjLAsM/1ErLmQ43kMGz8vPo1VVO2c=;
        b=rljXG65hB/pX3h0NXiDVtE9GeWJ63/NB/SmNnc6Qa67RjTagBv/6Pz5tpbhvk2f74p
         ufBvV6oy3tHLzBrHttChvjSl4TbfUnOZenF9w2+dK5Ubz73HOe7Mj2ec1Bh1QZULViCZ
         umMXcKqo3u38t1xOhPmObU8yiKgP2Xgb6jAa8m1Rftk2/yLqXArvt/sMordoWoSAduU/
         iwRwAQzup0x681ek+zJeVfdLRfkXLtQXEL1LrdM//Q9ceyylmlQZ8Q8iH+QC4WGxv5Iy
         bBccQds4Rc0dI5+uTBvpz2tFk6m3+WYol8TQMcirGXex5BMJbzKSaAzbIsm+u6Tt5eb/
         JkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FlwUrBAk0DE0NXbjLAsM/1ErLmQ43kMGz8vPo1VVO2c=;
        b=H5BxTAb/pOi8X/aJmge0J2Gwy+A0yvTKpizXEURa9N8y0CFvk4RMsK4W+8y5ulLSGJ
         me/wZu+lx76cJYy4k2XXKWJf+HhjtzEe1sTGFxnGjTEbrvkNxMS5H+HO3+KANpiB0wxm
         2rCsKYdPS2U2aDb3Npr7j5Km0f+vrEQyBDzePHI1nB4h7ekNwvbn65R4b6r7U+0c0eg8
         dq8ZIO3ikXT7376TUVOBCCcwHE4DxyEHZDyXSKsoUJZLRM6SEVTW2VKjLZl8EwWWhQgc
         FpbFMBuym4dQzhMXZaT5C/Ozp/zEuFG1n06V5Jn9mW8LX7wfVMUr3zTkDsXFWrCU0Qdf
         AttA==
X-Gm-Message-State: AOAM533iYVUjQPzwWn1PV6kWWyoLFjpRXEP8bvYz2Ux7sSv1Y6s1UTOk
        Tj+0agl8MpPELzun5Cb8o9DaPKXK4nPmqXY1
X-Google-Smtp-Source: ABdhPJyJP6LZ/br+IpkD2zVoVXSFPghr85U0WlvY3We3WPAIHE7PZcFSIfzCmpYBa27esvJhQZM5Ow==
X-Received: by 2002:ac2:4d95:: with SMTP id g21mr9935336lfe.29.1614603957787;
        Mon, 01 Mar 2021 05:05:57 -0800 (PST)
Received: from localhost (crossness-hoof.volia.net. [93.72.107.198])
        by smtp.gmail.com with ESMTPSA id l18sm2292995lfg.294.2021.03.01.05.05.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 Mar 2021 05:05:56 -0800 (PST)
From:   Ruslan Bilovol <ruslan.bilovol@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     gschmottlach@gmail.com, linux-usb@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] usb: gadget: u_audio: add real feedback implementation
Date:   Mon,  1 Mar 2021 15:05:39 +0200
Message-Id: <1614603943-11668-5-git-send-email-ruslan.bilovol@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1614603943-11668-1-git-send-email-ruslan.bilovol@gmail.com>
References: <1614603943-11668-1-git-send-email-ruslan.bilovol@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds interface between userspace and feedback
endpoint to report real feedback frequency to the Host.

Current implementation adds new userspace interface
ALSA mixer control "PCM Feedback Frequency Hz" (similar
to aloop driver's "PCM Rate Shift 100000" mixer control)

We allow +/-20% deviation of nominal sampling frequency,
that usually is more than enough in real-world usecases

Usage of this new control is easy to implement in
existing userspace tools like alsaloop from alsa-utils.

Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
---
 drivers/usb/gadget/function/f_uac2.c  |  4 ++
 drivers/usb/gadget/function/u_audio.c | 93 +++++++++++++++++++++++++++++++++++
 drivers/usb/gadget/function/u_audio.h |  7 +++
 3 files changed, 104 insertions(+)

diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index 72b42f8..91b22fb 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -506,6 +506,10 @@ static int set_ep_max_packet_size(const struct f_uac2_opts *uac2_opts,
 
 	max_size_bw = num_channels(chmask) * ssize *
 		((srate / (factor / (1 << (ep_desc->bInterval - 1)))) + 1);
+
+	if (!is_playback && (uac2_opts->c_sync == USB_ENDPOINT_SYNC_ASYNC))
+		max_size_bw = max_size_bw * FBACK_FREQ_MAX / 100;
+
 	ep_desc->wMaxPacketSize = cpu_to_le16(min_t(u16, max_size_bw,
 						    max_size_ep));
 
diff --git a/drivers/usb/gadget/function/u_audio.c b/drivers/usb/gadget/function/u_audio.c
index 8e74b54..b434e70 100644
--- a/drivers/usb/gadget/function/u_audio.c
+++ b/drivers/usb/gadget/function/u_audio.c
@@ -16,6 +16,7 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
+#include <sound/control.h>
 
 #include "u_audio.h"
 
@@ -598,12 +599,87 @@ void u_audio_stop_playback(struct g_audio *audio_dev)
 }
 EXPORT_SYMBOL_GPL(u_audio_stop_playback);
 
+static int u_audio_rate_shift_info(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_info *uinfo)
+{
+	struct uac_rtd_params *prm = snd_kcontrol_chip(kcontrol);
+	struct snd_uac_chip *uac = prm->uac;
+	struct g_audio *audio_dev = uac->audio_dev;
+	struct uac_params *params = &audio_dev->params;
+	unsigned int ffback_min, ffback_max;
+
+	ffback_min = params->c_srate * FBACK_FREQ_MIN / 100;
+	ffback_max = params->c_srate * FBACK_FREQ_MAX / 100;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = ffback_min;
+	uinfo->value.integer.max = ffback_max;
+	uinfo->value.integer.step = 1;
+	return 0;
+}
+
+static int u_audio_rate_shift_get(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct uac_rtd_params *prm = snd_kcontrol_chip(kcontrol);
+	unsigned long flags;
+
+	spin_lock_irqsave(&prm->lock, flags);
+	ucontrol->value.integer.value[0] = prm->ffback;
+	spin_unlock_irqrestore(&prm->lock, flags);
+
+	return 0;
+}
+
+static int u_audio_rate_shift_put(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct uac_rtd_params *prm = snd_kcontrol_chip(kcontrol);
+	struct snd_uac_chip *uac = prm->uac;
+	struct g_audio *audio_dev = uac->audio_dev;
+	struct uac_params *params = &audio_dev->params;
+	unsigned int val;
+	unsigned int ffback_min, ffback_max;
+	unsigned long flags;
+	int change = 0;
+
+	ffback_min = params->c_srate * FBACK_FREQ_MIN / 100;
+	ffback_max = params->c_srate * FBACK_FREQ_MAX / 100;
+
+	val = ucontrol->value.integer.value[0];
+	if (val < ffback_min)
+		val = ffback_min;
+	if (val > ffback_max)
+		val = ffback_max;
+
+	spin_lock_irqsave(&prm->lock, flags);
+	if (prm->ffback != val) {
+		prm->ffback = val;
+		change = 1;
+	}
+	spin_unlock_irqrestore(&prm->lock, flags);
+
+	return change;
+}
+
+static const struct snd_kcontrol_new u_audio_controls[]  = {
+{
+	.iface =        SNDRV_CTL_ELEM_IFACE_PCM,
+	.name =         "PCM Feedback Frequency Hz",
+	.info =         u_audio_rate_shift_info,
+	.get =          u_audio_rate_shift_get,
+	.put =          u_audio_rate_shift_put,
+},
+};
+
 int g_audio_setup(struct g_audio *g_audio, const char *pcm_name,
 					const char *card_name)
 {
 	struct snd_uac_chip *uac;
 	struct snd_card *card;
 	struct snd_pcm *pcm;
+	struct snd_kcontrol *kctl;
 	struct uac_params *params;
 	int p_chmask, c_chmask;
 	int err;
@@ -693,6 +769,23 @@ int g_audio_setup(struct g_audio *g_audio, const char *pcm_name,
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &uac_pcm_ops);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &uac_pcm_ops);
 
+	if (c_chmask && g_audio->in_ep_fback) {
+		strscpy(card->mixername, card_name, sizeof(card->mixername));
+
+		kctl = snd_ctl_new1(&u_audio_controls[0], &uac->c_prm);
+		if (!kctl) {
+			err = -ENOMEM;
+			goto snd_fail;
+		}
+
+		kctl->id.device = pcm->device;
+		kctl->id.subdevice = 0;
+
+		err = snd_ctl_add(card, kctl);
+		if (err < 0)
+			goto snd_fail;
+	}
+
 	strscpy(card->driver, card_name, sizeof(card->driver));
 	strscpy(card->shortname, card_name, sizeof(card->shortname));
 	sprintf(card->longname, "%s %i", card_name, card->dev->id);
diff --git a/drivers/usb/gadget/function/u_audio.h b/drivers/usb/gadget/function/u_audio.h
index 53e6baf..fd70808 100644
--- a/drivers/usb/gadget/function/u_audio.h
+++ b/drivers/usb/gadget/function/u_audio.h
@@ -11,6 +11,13 @@
 
 #include <linux/usb/composite.h>
 
+/*
+ * Min/max percentage of nominal sampling frequency deviation
+ * reported through feedback endpoint to the host
+ */
+#define FBACK_FREQ_MIN	80
+#define FBACK_FREQ_MAX	120
+
 struct uac_params {
 	/* playback */
 	int p_chmask;	/* channel mask */
-- 
1.9.1

