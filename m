Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06AB320B8C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 16:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhBUPtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 10:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhBUPtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 10:49:07 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14865C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 07:48:27 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id t9so1897763pjl.5
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 07:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gBYFtcJZcZKb20Kar3p64aL77O4EaWVVtcrsH+u69Zk=;
        b=d9obCbkDJqa0v5MTYG5Xa7DJ2NSf8UNLgwiBAVjWXeMk3zNqjmClrKWhHK1yWvKh31
         ojcSkxB+YtsZL3g5fbJqSn4+aD+TRY9dP+48eebDMiFa6ZaQC/d6/Up2u3gBIQwpkXzD
         PNu7z2ibulKv61xotsawidIrMPmgUHApPJfAnP24PKfKCaSBYdf05CN++D4jaxBQhRQk
         cMwb8z2EogZ8Vcvyy49wFG0c8735uNRZP17CZRiOl47MQEXNJZs2OfnX2ZMB4m+WWz82
         byzsp4hmKI8P7VNA76z+RsQzybFIxkvbbOKgl095go+7odtJrTBEq4DvUx5yyQ08hgUa
         3K9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gBYFtcJZcZKb20Kar3p64aL77O4EaWVVtcrsH+u69Zk=;
        b=ZSJF1C/CNJ4d98WKr7PLDhi/iMh6yQdLs96U+vYO8ykfjbhY/9MIl6KINGAJ1imCaG
         oc5yYgL8Q3cqKziXlJrUEG0i+yDd2zp0ilMAlUdY82KaAo4Hia0G6cDe3dVDguqnlS1/
         yf86xhVJ6NFAhlz9G9eOmOEodu8+zr9odhOmDxIlL5lJEI1Ns1IEXhfILiVzI14FHlk9
         JkNjPlotfeF0AHAl2lFxqE0jdrrsu7QItO+R7P04g5dGJVOQlMf5u40JA8kyeNmG/Yj+
         lDolzzJlTzVJIdowcQSyAdaNb5x473MB1A6tDT+3CPCX6GP2VIrDkXoZe2t7KG1SObNk
         ICEg==
X-Gm-Message-State: AOAM533/fgi6d2vNrLh0GqSSvCc8KQLlHsMxgkm0qY1ZoOh5Ws09eVgg
        HeL3K4BL1l7kvBKFStZoy3Y=
X-Google-Smtp-Source: ABdhPJzyhpN4aJWn5k3wG1M156iVDl7M+1WgaPnz4rv4lodb6j2hFwdo7OnY2CNOmUk5f9UgG6ZeiQ==
X-Received: by 2002:a17:90a:a08a:: with SMTP id r10mr18719275pjp.133.1613922506409;
        Sun, 21 Feb 2021 07:48:26 -0800 (PST)
Received: from localhost ([2402:3a80:11da:dffe:a2a4:c5ff:fe20:7222])
        by smtp.gmail.com with ESMTPSA id i2sm8348052pgs.82.2021.02.21.07.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 07:48:26 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        greybus-dev@lists.linaro.org
Subject: [PATCH] staging/greybus: eliminate use of NAME_SIZE for strings
Date:   Sun, 21 Feb 2021 21:12:59 +0530
Message-Id: <20210221154258.119503-1-memxor@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <b565bdae-10a9-9b6c-ae60-dcee88f7dedd@ieee.org>
References: <b565bdae-10a9-9b6c-ae60-dcee88f7dedd@ieee.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead, depend on the size of the destination buffer for easier
refactoring.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
Hopefully, this is more thorough. The only cases left now are where the
destination string is represented by a pointer, otherwise all call sites with a
fixed sized buffer have been changed.
---
 drivers/staging/greybus/audio_module.c   |  4 ++--
 drivers/staging/greybus/audio_topology.c | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/greybus/audio_module.c b/drivers/staging/greybus/audio_module.c
index 0f9fdc077..12c376c47 100644
--- a/drivers/staging/greybus/audio_module.c
+++ b/drivers/staging/greybus/audio_module.c
@@ -260,7 +260,7 @@ static int gb_audio_probe(struct gb_bundle *bundle,
 	INIT_LIST_HEAD(&gbmodule->widget_ctl_list);
 	INIT_LIST_HEAD(&gbmodule->jack_list);
 	gbmodule->dev = dev;
-	snprintf(gbmodule->name, NAME_SIZE, "%s.%s", dev->driver->name,
+	snprintf(gbmodule->name, sizeof(gbmodule->name), "%s.%s", dev->driver->name,
 		 dev_name(dev));
 	greybus_set_drvdata(bundle, gbmodule);
 
@@ -342,7 +342,7 @@ static int gb_audio_probe(struct gb_bundle *bundle,
 	/* inform above layer for uevent */
 	dev_dbg(dev, "Inform set_event:%d to above layer\n", 1);
 	/* prepare for the audio manager */
-	strscpy(desc.name, gbmodule->name, GB_AUDIO_MANAGER_MODULE_NAME_LEN);
+	strscpy(desc.name, gbmodule->name, sizeof(desc.name));
 	desc.vid = 2; /* todo */
 	desc.pid = 3; /* todo */
 	desc.intf_id = gbmodule->dev_id;
diff --git a/drivers/staging/greybus/audio_topology.c b/drivers/staging/greybus/audio_topology.c
index e816e4db5..1fc7727ab 100644
--- a/drivers/staging/greybus/audio_topology.c
+++ b/drivers/staging/greybus/audio_topology.c
@@ -200,7 +200,7 @@ static int gbcodec_mixer_ctl_info(struct snd_kcontrol *kcontrol,
 			return -EINVAL;
 		name = gbaudio_map_controlid(module, data->ctl_id,
 					     uinfo->value.enumerated.item);
-		strscpy(uinfo->value.enumerated.name, name, NAME_SIZE);
+		strscpy(uinfo->value.enumerated.name, name, sizeof(uinfo->value.enumerated.name));
 		break;
 	default:
 		dev_err(comp->dev, "Invalid type: %d for %s:kcontrol\n",
@@ -363,7 +363,7 @@ static int gbcodec_mixer_dapm_ctl_info(struct snd_kcontrol *kcontrol,
 	platform_min = le32_to_cpu(info->value.integer.min);
 
 	if (platform_max == 1 &&
-	    !strnstr(kcontrol->id.name, " Volume", NAME_SIZE))
+	    !strnstr(kcontrol->id.name, " Volume", sizeof(kcontrol->id.name)))
 		uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
 	else
 		uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
@@ -1047,8 +1047,8 @@ static int gbaudio_tplg_create_widget(struct gbaudio_module_info *module,
 	}
 
 	/* Prefix dev_id to widget control_name */
-	strscpy(temp_name, w->name, NAME_SIZE);
-	snprintf(w->name, NAME_SIZE, "GB %d %s", module->dev_id, temp_name);
+	strscpy(temp_name, w->name, sizeof(temp_name));
+	snprintf(w->name, sizeof(w->name), "GB %d %s", module->dev_id, temp_name);
 
 	switch (w->type) {
 	case snd_soc_dapm_spk:
@@ -1169,8 +1169,8 @@ static int gbaudio_tplg_process_kcontrols(struct gbaudio_module_info *module,
 		}
 		control->id = curr->id;
 		/* Prefix dev_id to widget_name */
-		strscpy(temp_name, curr->name, NAME_SIZE);
-		snprintf(curr->name, NAME_SIZE, "GB %d %s", module->dev_id,
+		strscpy(temp_name, curr->name, sizeof(temp_name));
+		snprintf(curr->name, sizeof(curr->name), "GB %d %s", module->dev_id,
 			 temp_name);
 		control->name = curr->name;
 		if (curr->info.type == GB_AUDIO_CTL_ELEM_TYPE_ENUMERATED) {
-- 
2.29.2

