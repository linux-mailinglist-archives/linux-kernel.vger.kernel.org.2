Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A94341235
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 02:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhCSBjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 21:39:21 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:42580 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhCSBjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 21:39:18 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 12FF4CCD98;
        Fri, 19 Mar 2021 09:38:56 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [113.57.152.160])
        by smtp.263.net (postfix) whith ESMTP id P24306T139684564936448S1616117934878107_;
        Fri, 19 Mar 2021 09:38:56 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <8cbaed4f43e2e12c294ac281d62bc47a>
X-RL-SENDER: huangjianghui@uniontech.com
X-SENDER: huangjianghui@uniontech.com
X-LOGIN-NAME: huangjianghui@uniontech.com
X-FST-TO: perex@perex.cz
X-SENDER-IP: 113.57.152.160
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   huangjianghui <huangjianghui@uniontech.com>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     Takashi Iwai <tiwai@suse.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Sameer Pujar <spujar@nvidia.com>,
        Mohan Kumar <mkumard@nvidia.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda: Fix spelling mistakes
Date:   Fri, 19 Mar 2021 09:38:54 +0800
Message-Id: <20210319013854.48830-1-huangjianghui@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: huangjianghui <huangjianghui@uniontech.com>
---
 sound/hda/hdac_stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index a6ed3dc35f7e..1eb8563db2df 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -618,7 +618,7 @@ void snd_hdac_stream_sync_trigger(struct hdac_stream *azx_dev, bool set,
 EXPORT_SYMBOL_GPL(snd_hdac_stream_sync_trigger);
 
 /**
- * snd_hdac_stream_sync - sync with start/strop trigger operation
+ * snd_hdac_stream_sync - sync with start/stop trigger operation
  * @azx_dev: HD-audio core stream (master stream)
  * @start: true = start, false = stop
  * @streams: bit flags of streams to sync
-- 
2.20.1



