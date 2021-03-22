Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE496343DF5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 11:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhCVKcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 06:32:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230369AbhCVKbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 06:31:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A02BF6198F;
        Mon, 22 Mar 2021 10:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616409091;
        bh=0gwjaGh2QNNtiYFZp+OcuO3B2CPc4ZEG93Au7ykg3Xw=;
        h=From:To:Cc:Subject:Date:From;
        b=GUjfLL2U3oXbElSPWKJcICyjNmRVGK2FtlGfiTlN8mAMgQ3x7YCJhNOm11PbjqAFm
         6L0D7bT8llSYRXlJZgRGKe77Bf/jfpb5g5jpkifS8gypR+oxd23jCiSYTvLkR9jKXh
         HNDKeLCDuS2She8u34z1SerJByUMaiaLnycbY6o4XF33MNj1+UfALXIlVnCglBkclI
         /oF4HXVBlW3C7vK2Ko6TFQiTltjWghwckuxiLW/i2mQHykj5zT04JGsIb1xRxsO5fI
         6Rq6DKUo0TxDLkcz8cIbt7tSRzQBSI27fOXod5Rm9znnvDbeJNBDaICRC71wofnEfX
         WsICWwOS2dpkA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: core: avoid -Wempty-body warnings
Date:   Mon, 22 Mar 2021 11:31:10 +0100
Message-Id: <20210322103128.547199-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Building with 'make W=1' shows some warnings about empty function-style
macros:

sound/core/pcm_memory.c: In function 'preallocate_pages':
sound/core/pcm_memory.c:236:49: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
  236 |                 preallocate_info_init(substream);

sound/core/seq_device.c: In function 'snd_seq_device_dev_register':
sound/core/seq_device.c:163:41: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
  163 |                 queue_autoload_drivers();

Change them to empty inline functions, which are more robust here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/core/oss/pcm_oss.c |  8 ++++++--
 sound/core/pcm_memory.c  |  4 +++-
 sound/core/seq_device.c  | 15 ++++++++++++---
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index 142fc751a847..86c39ee01aaa 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -3069,8 +3069,12 @@ static void snd_pcm_oss_proc_done(struct snd_pcm *pcm)
 	}
 }
 #else /* !CONFIG_SND_VERBOSE_PROCFS */
-#define snd_pcm_oss_proc_init(pcm)
-#define snd_pcm_oss_proc_done(pcm)
+static inline void snd_pcm_oss_proc_init(struct snd_pcm *pcm)
+{
+}
+static inline void snd_pcm_oss_proc_done(struct snd_pcm *pcm)
+{
+}
 #endif /* CONFIG_SND_VERBOSE_PROCFS */
 
 /*
diff --git a/sound/core/pcm_memory.c b/sound/core/pcm_memory.c
index 289dd1fd8fe7..c440f67b34a3 100644
--- a/sound/core/pcm_memory.c
+++ b/sound/core/pcm_memory.c
@@ -210,7 +210,9 @@ static inline void preallocate_info_init(struct snd_pcm_substream *substream)
 }
 
 #else /* !CONFIG_SND_VERBOSE_PROCFS */
-#define preallocate_info_init(s)
+static inline void preallocate_info_init(struct snd_pcm_substream *substream)
+{
+}
 #endif /* CONFIG_SND_VERBOSE_PROCFS */
 
 /*
diff --git a/sound/core/seq_device.c b/sound/core/seq_device.c
index 7ed13cb32ef8..382275c5b193 100644
--- a/sound/core/seq_device.c
+++ b/sound/core/seq_device.c
@@ -133,10 +133,19 @@ void snd_seq_device_load_drivers(void)
 	flush_work(&autoload_work);
 }
 EXPORT_SYMBOL(snd_seq_device_load_drivers);
-#define cancel_autoload_drivers()	cancel_work_sync(&autoload_work)
+
+static inline void cancel_autoload_drivers(void)
+{
+	cancel_work_sync(&autoload_work);
+}
 #else
-#define queue_autoload_drivers() /* NOP */
-#define cancel_autoload_drivers() /* NOP */
+static inline void queue_autoload_drivers(void)
+{
+}
+
+static inline void cancel_autoload_drivers(void)
+{
+}
 #endif
 
 /*
-- 
2.29.2

