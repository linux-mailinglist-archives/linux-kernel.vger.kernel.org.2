Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99EC3415C47
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 12:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240459AbhIWKwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 06:52:32 -0400
Received: from lucky1.263xmail.com ([211.157.147.130]:54052 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240429AbhIWKwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 06:52:30 -0400
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id D2885D8002;
        Thu, 23 Sep 2021 18:50:53 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P30982T140487228909312S1632394252895090_;
        Thu, 23 Sep 2021 18:50:54 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: sugar.zhang@rock-chips.com
X-SENDER: zxg@rock-chips.com
X-LOGIN-NAME: sugar.zhang@rock-chips.com
X-FST-TO: broonie@kernel.org
X-RCPT-COUNT: 12
X-LOCAL-RCPT-COUNT: 1
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-UNIQUE-TAG: <0073ee5634e02cce322910e426978038>
X-System-Flag: 0
From:   Sugar Zhang <sugar.zhang@rock-chips.com>
To:     broonie@kernel.org, heiko@sntech.de
Cc:     linux-rockchip@lists.infradead.org,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dmaengine: Introduce module option prealloc_buffer_size_kbytes
Date:   Thu, 23 Sep 2021 18:50:46 +0800
Message-Id: <1632394246-59341-1-git-send-email-sugar.zhang@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, The fixed 512KB prealloc buffer size is too larger for
tiny memory kernel (such as 16MB memory). This patch adds the module
option "prealloc_buffer_size_kbytes" to specify prealloc buffer size.

It's suitable for cards which use the generic dmaengine pcm driver
with no config.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 Documentation/sound/alsa-configuration.rst | 9 +++++++++
 sound/soc/soc-generic-dmaengine-pcm.c      | 6 +++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/sound/alsa-configuration.rst b/Documentation/sound/alsa-configuration.rst
index 65f6169..34888d4 100644
--- a/Documentation/sound/alsa-configuration.rst
+++ b/Documentation/sound/alsa-configuration.rst
@@ -100,6 +100,15 @@ amidi_map
     MIDI device number maps assigned to the 2st OSS device;
     Default: 1
 
+Module snd-soc-core
+-------------------
+
+The soc core module. It is used by all ALSA card drivers.
+It takes the following options which have global effects.
+
+prealloc_buffer_size_kbytes
+    Specify prealloc buffer size in kbytes (default: 512).
+
 Common parameters for top sound card modules
 --------------------------------------------
 
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 4aa48c7..c54c8ca 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -15,6 +15,10 @@
 
 #include <sound/dmaengine_pcm.h>
 
+static unsigned int prealloc_buffer_size_kbytes = 512;
+module_param(prealloc_buffer_size_kbytes, uint, 0444);
+MODULE_PARM_DESC(prealloc_buffer_size_kbytes, "Preallocate DMA buffer size (KB).");
+
 /*
  * The platforms dmaengine driver does not support reporting the amount of
  * bytes that are still left to transfer.
@@ -237,7 +241,7 @@ static int dmaengine_pcm_new(struct snd_soc_component *component,
 		prealloc_buffer_size = config->prealloc_buffer_size;
 		max_buffer_size = config->pcm_hardware->buffer_bytes_max;
 	} else {
-		prealloc_buffer_size = 512 * 1024;
+		prealloc_buffer_size = prealloc_buffer_size_kbytes * 1024;
 		max_buffer_size = SIZE_MAX;
 	}
 
-- 
2.7.4



