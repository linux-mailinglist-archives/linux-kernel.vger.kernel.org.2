Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423093BF3BB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 04:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhGHCLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 22:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhGHCLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 22:11:33 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77762C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 19:08:51 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id j10-20020a056a00174ab029031e1e93e88dso2754185pfc.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 19:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=sFr66KLjhv/rtOyfoenixLkVIGJVX1U7+t9+pUXGRz0=;
        b=LbHRdYzxmNi4zsGMVsNIQbfL+yS/wSqxzq2llODEQcTC0bqKVd6mTee5yKzwDzICDi
         eeI6aMOvI8B3pyDv3r+bGMn0ODCBLI5tew7HrsmS5/L9dM3IJjLDNKtz1R5uMw5lpdtx
         JW+rqjhXgNuJUjI+aW5D/aKK+jseTpm3xQbbHx3ZBnsvfIlpeL2OP2myJIHzf0BZpkiK
         zF2JRy3rQepTT78sqYyizxtBW/bJqy6Kz0pLawmQRsyJ6VhYQd6WcjCKOckDPSKn29xh
         DJy0+3i4dbIzosBg5mmqg5C7Rlytz4tq+ezpYF1IPDUPUy6HYT1AvN7fTj367U7JdnH0
         kAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=sFr66KLjhv/rtOyfoenixLkVIGJVX1U7+t9+pUXGRz0=;
        b=EbyIiNRETqAGpzKBMAn5uTk62d/VM0t75hLVBl2hBwkkJy/laAjnE6SSD+B+mQxyrC
         Fgfg3j/dtzheFkarVpoqIc04O5H3vXEibK8A1YxUu6xQUs53MsvpeJceBX48CkDj3Ahx
         eWmgtSwxLJYP8KtuaLSXQAxquOF3ZRgfjT/lsrl1Vs858Ti3gqqRJCabZ1mN2ibr3iDq
         5Kj9KL990/9y/abSiTOw71UTL5nHizNPedqWdoU1fUxWt15E8KX+kbHM05z6kl+SHYmq
         RP93A7jCP13XMedUhPruzqbQjGC/ph1tfK5XM9SuNlnIaoxDkXp8jbUMWqDm9nDbkpaK
         pSew==
X-Gm-Message-State: AOAM532kQ0PDfVZnornY/E5z0QN8TW5ot0p16ejERXuK7N+4IzfPvZWj
        7LXQd2CxKEgr/jWYnlZ7PdwPELP1WFWW
X-Google-Smtp-Source: ABdhPJwCWGfLKtmRC+vmlAbMs8Msg0HcL7yuI6AzuNsH87AhMdMwY9t23Heh8N8CjIM8/JkTJXPvFhQpM+eTjg==
X-Received: from lerobert.c.googlers.com ([fda3:e722:ac3:cc00:12:b22d:c0a8:2e6])
 (user=lerobert job=sendgmr) by 2002:a17:903:304e:b029:11d:75ff:c304 with SMTP
 id u14-20020a170903304eb029011d75ffc304mr23576141pla.33.1625710130648; Wed,
 07 Jul 2021 19:08:50 -0700 (PDT)
Date:   Thu,  8 Jul 2021 02:08:15 +0000
Message-Id: <20210708020815.3489365-1-lerobert@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [Patch v2] ALSA: compress: allow to leave draining state when pausing
 in draining
From:   Robert Lee <lerobert@google.com>
To:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        carterhsu@google.com, zxinhui@google.com, bubblefang@google.com,
        Robert Lee <lerobert@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compress offload pauses in draining state, not all platforms
need to keep in draining state. Some platforms may call drain or
partial drain again when resume from pause in draining, so it needs
to wake up from snd_compress_wait_for_drain() in this case.

Call API snd_compr_leave_draining_in_pause(), if the platform
doesn't need to keep in draining state when pause in draining
state.

Signed-off-by: Robert Lee <lerobert@google.com>
---
 include/sound/compress_driver.h | 14 ++++++++++++++
 sound/core/compress_offload.c   |  8 +++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
index 277087f635f3..e16524a93a14 100644
--- a/include/sound/compress_driver.h
+++ b/include/sound/compress_driver.h
@@ -145,6 +145,7 @@ struct snd_compr_ops {
  * @lock: device lock
  * @device: device id
  * @use_pause_in_draining: allow pause in draining, true when set
+ * @leave_draining_in_pause: leave draining state when pausing in draining
  */
 struct snd_compr {
 	const char *name;
@@ -156,6 +157,7 @@ struct snd_compr {
 	struct mutex lock;
 	int device;
 	bool use_pause_in_draining;
+	bool leave_draining_in_pause;
 #ifdef CONFIG_SND_VERBOSE_PROCFS
 	/* private: */
 	char id[64];
@@ -182,6 +184,18 @@ static inline void snd_compr_use_pause_in_draining(struct snd_compr_stream *subs
 	substream->device->use_pause_in_draining = true;
 }
 
+/**
+ * snd_compr_leave_draining_in_pause - Leave draining state when pause in draining
+ * @substream: compress substream to set
+ *
+ * In some platform, we need to leave draining state when we use pause in draining.
+ * Add API to allow leave draining state.
+ */
+static inline void snd_compr_leave_draining_in_pause(struct snd_compr_stream *substream)
+{
+	substream->device->leave_draining_in_pause = true;
+}
+
 /* dsp driver callback apis
  * For playback: driver should call snd_compress_fragment_elapsed() to let the
  * framework know that a fragment has been consumed from the ring buffer
diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 21ce4c056a92..c6e5c8f072d7 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -719,8 +719,14 @@ static int snd_compr_pause(struct snd_compr_stream *stream)
 		if (!stream->device->use_pause_in_draining)
 			return -EPERM;
 		retval = stream->ops->trigger(stream, SNDRV_PCM_TRIGGER_PAUSE_PUSH);
-		if (!retval)
+		if (!retval) {
+			if (stream->device->leave_draining_in_pause) {
+				stream->runtime->state = SNDRV_PCM_STATE_PAUSED;
+				wake_up(&stream->runtime->sleep);
+				break;
+			}
 			stream->pause_in_draining = true;
+		}
 		break;
 	default:
 		return -EPERM;
-- 
2.32.0.93.g670b81a890-goog

