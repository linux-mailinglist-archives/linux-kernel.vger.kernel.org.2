Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B0C3BD705
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 14:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238169AbhGFMus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 08:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240767AbhGFMs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 08:48:56 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532ECC08EBAF
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 05:44:50 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id x12-20020a05620a448cb02903b3dabbe857so16558636qkp.15
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 05:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=W5WGGuw9mY9cDhR3LIq+HgKfjZfrhsSy4zPxklG3/y4=;
        b=EQU42SklHQrQl7lnVUDrNZLaovJjv8Z7V7jBtK+lwezdrBXs7OsWVleySoh+SHope4
         FfzlmD1BqKIvBfLRcjKmIRE/OnQO2P4TWjjA/IcgTEcx2etAEcmpcz+ELTcRer3gTUjG
         4ji0EMks2knMHOiPyk0GRjNZ5IVaDcEPlHC4Czu3Qot9takA3DmcgHhfouDhSdOkz7yZ
         DOeNH1GVRq7WFfHiYlFfFIDezihAePz4FIkgrxmxqp5JFzoRQtY2xASa/5tU74+/LN2g
         rJPoCwZ//EndvQb/EfYd74lxCo4lX6GDN01CoD0Tq1efTtK+0lU02i1MDTAbBDAU4z/s
         ZHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=W5WGGuw9mY9cDhR3LIq+HgKfjZfrhsSy4zPxklG3/y4=;
        b=Fy01pVgC6auWtQ2p7ECbxxRA0h6F4Kr24mfWo8JoErP6LHfB1uqdhHTuOU/F24PCSt
         Zn0OV2cjpiIsWNcdjI9ITGpRhQeS2DV4KJl24zFeah/SrTrCL6af11aBvXECpgIohLxS
         43dnzbfL9aJxXriWYXzmKDE0kENQrfUN62fqiIZh1o/FkjLBGUHYe7IDI5d53yDHjCv2
         Z0hfZSsPtSFpEMOb9+3YR3AHiGdZHMcxx0r+/wQ2PGzVcZZUIHvMQ52Ehz2p2HZnVrCc
         UhbD8DNqYcgiQB6uGASr05Byan2U3taaa4yVBSL85VIWn2v9iTzs9MtHFX/ofvby0wSH
         XlwQ==
X-Gm-Message-State: AOAM533mWJT6pqK9jik8lpaLm94+bpCMdXCuBWpeA3ua7WXKeQx9uTsJ
        Dc3dZ9wCDKfVBnqnD6zQm0l2lXmNRGqO
X-Google-Smtp-Source: ABdhPJxyBXA+rOueMg9oLrtfXHHTafUJJ35UOWa3x4KFwlyFK6zIz9RkGjzLMyfyKfBxnyw6oU6IV0QIWw8cpA==
X-Received: from lerobert.c.googlers.com ([fda3:e722:ac3:cc00:12:b22d:c0a8:2e6])
 (user=lerobert job=sendgmr) by 2002:ad4:59cf:: with SMTP id
 el15mr13422561qvb.55.1625575489452; Tue, 06 Jul 2021 05:44:49 -0700 (PDT)
Date:   Tue,  6 Jul 2021 12:44:40 +0000
Message-Id: <20210706124440.3247283-1-lerobert@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH] ALSA: compress: allow to leave draining state when pausing in draining
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
 sound/core/compress_offload.c   |  7 ++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

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
index 21ce4c056a92..9c7bd4db6ecd 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -719,8 +719,13 @@ static int snd_compr_pause(struct snd_compr_stream *stream)
 		if (!stream->device->use_pause_in_draining)
 			return -EPERM;
 		retval = stream->ops->trigger(stream, SNDRV_PCM_TRIGGER_PAUSE_PUSH);
-		if (!retval)
+		if (!retval) {
 			stream->pause_in_draining = true;
+			if (stream->device->leave_draining_in_pause) {
+				stream->runtime->state = SNDRV_PCM_STATE_PAUSED;
+				wake_up(&stream->runtime->sleep);
+			}
+		}
 		break;
 	default:
 		return -EPERM;
-- 
2.32.0.93.g670b81a890-goog

