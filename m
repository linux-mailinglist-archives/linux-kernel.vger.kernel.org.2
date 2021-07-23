Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4753D3531
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 09:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbhGWGnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 02:43:43 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56616 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhGWGnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 02:43:41 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 80F681FF56;
        Fri, 23 Jul 2021 07:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627025054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=+daORgY14Wt4jkEfHQiD6DsrfjAOi8Y5e+ZnSYFh77E=;
        b=NkqLqsWmXcHJ/A6wBr3wOG0bY6t6AADQCuKVPqloaHPCJiIbo8dIUnXEZRHI4U9rc4ZXdT
        cuOv9lnwXH6tH+05VXf/6OCzvbS0G5xSA9TG7uTzc06UJy+j461ZIyfWmrfBhqIFNZXGN6
        46DxrqeGbEuhF5tEDEzWij54jRGttW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627025054;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=+daORgY14Wt4jkEfHQiD6DsrfjAOi8Y5e+ZnSYFh77E=;
        b=VM3LzrMON8eQclhHptlymEzUHEzUNK6ZSt3YAD7o1Sfq1d9whXebHLFwyyN+GCrCh9svrw
        bX2vQ9ha0zAgMSCQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 654E513697;
        Fri, 23 Jul 2021 07:24:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id vLZ6GJ5u+mCaPgAAGKfGzw
        (envelope-from <iivanov@suse.de>); Fri, 23 Jul 2021 07:24:14 +0000
From:   "Ivan T. Ivanov" <iivanov@suse.de>
To:     David Airlie <airlied@linux.ie>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vc4: hdmi: Add debugfs prefix
Date:   Fri, 23 Jul 2021 09:24:14 +0200
Message-Id: <20210723072414.17590-1-iivanov@suse.de>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without prefix debugfs can't properly create component
debug information tree when driver register more than
one component per device, in this case two. Fix this.

debugfs: Directory 'fef00700.hdmi' with parent 'vc4-hdmi-0' already present!

Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index aab1b36ceb3c..62b057f88df5 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1523,6 +1523,9 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
 	struct snd_soc_dai_link *dai_link = &vc4_hdmi->audio.link;
 	struct snd_soc_card *card = &vc4_hdmi->audio.card;
 	struct device *dev = &vc4_hdmi->pdev->dev;
+#ifdef CONFIG_DEBUG_FS
+	struct snd_soc_component *comp;
+#endif
 	const __be32 *addr;
 	int index;
 	int ret;
@@ -1577,6 +1580,16 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
 		return ret;
 	}
 
+#ifdef CONFIG_DEBUG_FS
+	comp = snd_soc_lookup_component(dev, vc4_hdmi_audio_cpu_dai_comp.name);
+	if (comp)
+		comp->debugfs_prefix = "cpu";
+
+	comp = snd_soc_lookup_component(dev, vc4_hdmi_audio_component_drv.name);
+	if (comp)
+		comp->debugfs_prefix = "codec";
+#endif
+
 	dai_link->cpus		= &vc4_hdmi->audio.cpu;
 	dai_link->codecs	= &vc4_hdmi->audio.codec;
 	dai_link->platforms	= &vc4_hdmi->audio.platform;
-- 
2.32.0

