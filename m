Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2DE45FD94
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 10:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353416AbhK0J0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 04:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244272AbhK0JYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 04:24:13 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5668EC06174A
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 01:20:03 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id u3so30131169lfl.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 01:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9CVjzfYPDceDBXmW9CFOxQhvY2AD/vo1bVX7QojZu30=;
        b=d9ijPY1Vc7Y5ROoNnm4XMRAgMwJ4EKvCQceea7CUeIN0h7egU0pGRRJgGa4v11YvPs
         Gnr7or+QKknle615+BATi1e1lF/FtP3dcRm8B2wr9l/nBld6hTl2/7zTUzHtS0s2Pba1
         d/fIHGvvTc7nbzK6u3wAx0yS9RhP35bquHtiW1jLZPCiMQ71XeTjsweEn/Ojl6kE7Ctb
         gWyeN4Mn/1ASc2qpayqZDRA/Us+7cvQJ5ioVnAsEUMj6YVTr4l7COBvM9Tb78WvcA9hZ
         aReXq5jsS7ary1yHrOZQsrTqEABiTWl794YAkLU5Blx84t6X0l5q2DnSZQhIM1l2x7+Z
         byig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9CVjzfYPDceDBXmW9CFOxQhvY2AD/vo1bVX7QojZu30=;
        b=EF/uhg1wjTl3T6Cisyv2lCXetOIjT3JY9Ndn5wmyV4E1EO0E2P/tsI4RqI6IjUpa5K
         l/pBRNjsuePyhfRPait69Hv3kXHZhdAJZ4p2/uyU31fOIwSfCvGdQakWRDPbru6jtiRD
         k9twCQx9MaGqrDL2MpG7v3DPjwZRlMQcLvowTfdPaAzyQroV1YXpUBegNIugTghyjndd
         M42VaBqna5rv+CUvAs1aCRaLlutVEIOehJ3CEhIRm/mmYH/3oIM2FbCLcd7TSqYKIwr4
         Ylvn5ZD26WF2wgfhwqPJ0NqSQRA7q6ZlZHvVvscNKA8WYeAoJYuchiZALR3nRQ5Q5U13
         2zXA==
X-Gm-Message-State: AOAM530NX8bCh1n+poBsfrzxJ+S9J8UJz4UqEzAt2SjZimjnzRIint+M
        K8GhcRp78DBE42rfKhzOYiM=
X-Google-Smtp-Source: ABdhPJxYeR3a8otPywQ9MUA/07Tz4Y5IjKsyDu01fisdQG64wt1KKDIiDBQd/KXjf+BlQjb1Q581dw==
X-Received: by 2002:a05:6512:519:: with SMTP id o25mr33652054lfb.422.1638004801650;
        Sat, 27 Nov 2021 01:20:01 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id v7sm743066ljd.31.2021.11.27.01.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 01:20:00 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] ASoC: intel: boards: bytcht*: Constify static snd_soc_ops
Date:   Sat, 27 Nov 2021 10:19:54 +0100
Message-Id: <20211127091954.12075-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are only assigned to the ops fields in the snd_soc_dai_link struct
which is a pointer to const struct snd_soc_ops. Make them const to allow
the compiler to put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 sound/soc/intel/boards/bytcht_cx2072x.c | 2 +-
 sound/soc/intel/boards/bytcht_nocodec.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/bytcht_cx2072x.c b/sound/soc/intel/boards/bytcht_cx2072x.c
index 0a736308052a..ffd497a5b5a5 100644
--- a/sound/soc/intel/boards/bytcht_cx2072x.c
+++ b/sound/soc/intel/boards/bytcht_cx2072x.c
@@ -147,7 +147,7 @@ static int byt_cht_cx2072x_aif1_startup(struct snd_pcm_substream *substream)
 					    SNDRV_PCM_HW_PARAM_RATE, 48000);
 }
 
-static struct snd_soc_ops byt_cht_cx2072x_aif1_ops = {
+static const struct snd_soc_ops byt_cht_cx2072x_aif1_ops = {
 	.startup = byt_cht_cx2072x_aif1_startup,
 };
 
diff --git a/sound/soc/intel/boards/bytcht_nocodec.c b/sound/soc/intel/boards/bytcht_nocodec.c
index 67b3c4e97864..115c2bcaabd4 100644
--- a/sound/soc/intel/boards/bytcht_nocodec.c
+++ b/sound/soc/intel/boards/bytcht_nocodec.c
@@ -93,7 +93,7 @@ static int aif1_startup(struct snd_pcm_substream *substream)
 			&constraints_48000);
 }
 
-static struct snd_soc_ops aif1_ops = {
+static const struct snd_soc_ops aif1_ops = {
 	.startup = aif1_startup,
 };
 
-- 
2.34.1

