Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A455343336
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 16:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhCUPjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 11:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhCUPjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 11:39:04 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600F8C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 08:39:03 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id q26so2881622qkm.6
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 08:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PRVsQVQHUV1BTAm1l1VygqbQNUFWwnup1fJPgSm87Fc=;
        b=D5zyTgKciaCTPsJGfDhlC/sxvSRbX4JibEGi31MBUNvdLN5TRwkkVmRCpRNNUNrRFr
         vLNZQ/o8WdXj76ikmdcEDHs1jK4uFcVCh8pFJNa1tvkpFzaydU/J/FBLJIezcusljaqL
         8LPZisVKD6eWlAbCGfbR03nBgsK9u/v7T3Q4BHlDFPG9twTjNQSf8IWPOyZO48zYgnyA
         jXNVdbyFOxqbQ77EjiN1ALOvwiWavm4q7h6/tzeZAs1oM9dirqWe7pLmAJ5yUqhkhepg
         yAlhJWlddfzBJAXzla/dId4/f0bMe1zlLlv6PPuitLEjqbfdU0bMSAe3bSlkQECHZ62b
         dEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PRVsQVQHUV1BTAm1l1VygqbQNUFWwnup1fJPgSm87Fc=;
        b=V4/d6xDnyHKC5gwMfwE4zocmJc7/ipzBloalmUPt6waf0ppsAvpVfI4snQgggDpJti
         9Eng0GuT8c3GIPfAXtHcJ7REG1h3FbfpHOcSl163Xq7kY6f4iG4C2Wy1AgK/sq6uXpcl
         aT2w4D1dmr/fsdQaNc1GeWBSc4HbBvdFqd1aHh6G6ruoQ9tk68vrsJYNy4asZYLs0LE+
         1KYov8lmL0Bo2JDl9XQTFH4/VGYKQWkl95PXUUIYr2Z3IvL0So/MnCA+DzajuCjqTTBO
         VgDEWEiuYeeMmN/QLqzFFkeE3ZwhnhBSFMTIcSZvM3o9y4CJWy+7QVKdBUWETKmJ3Yui
         A28A==
X-Gm-Message-State: AOAM532QSJkwuRkqupHVA1pQRxu312fqL0WGOKbJw9j5QeYT6U2lOyxs
        miiDNLM33Gj1QDyYxKDZ8r4=
X-Google-Smtp-Source: ABdhPJzpV1P+8tfIMZzfJjEPtm9lJqr3HvoQc/iullzdikquKZTsSxj4zzQMf8kSPkyUg4a9UsopfQ==
X-Received: by 2002:a37:6115:: with SMTP id v21mr7298791qkb.239.1616341142570;
        Sun, 21 Mar 2021 08:39:02 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c200:27c6:f925:bb4b:54d2:533])
        by smtp.googlemail.com with ESMTPSA id y19sm8976317qky.111.2021.03.21.08.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 08:39:02 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Jasmin Fazlic <superfassl@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Romain Perier <romain.perier@gmail.com>,
        Allen Pais <allen.lkml@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Naoki Hayama <naoki.hayama@lineo.co.jp>,
        Tom Rix <trix@redhat.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Cc:     Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v3 2/3] ALSA: hdspm: don't disable if not enabled
Date:   Sun, 21 Mar 2021 11:38:39 -0400
Message-Id: <20210321153840.378226-3-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <s5htup4exbl.wl-tiwai@suse.de>
References: <s5htup4exbl.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hdspm wants to disable a not enabled pci device, which makes kernel
throw a warning. Make sure the device is enabled before calling disable.

[    1.786391] snd_hdspm 0000:00:03.0: disabling already-disabled device
[    1.786400] WARNING: CPU: 0 PID: 182 at drivers/pci/pci.c:2146 pci_disable_device+0x91/0xb0
[    1.795181] Call Trace:
[    1.795320]  snd_hdspm_card_free+0x58/0xa0 [snd_hdspm]
[    1.795595]  release_card_device+0x4b/0x80 [snd]
[    1.795860]  device_release+0x3b/0xa0
[    1.796072]  kobject_put+0x94/0x1b0
[    1.796260]  put_device+0x13/0x20
[    1.796438]  snd_card_free+0x61/0x90 [snd]
[    1.796659]  snd_hdspm_probe+0x97b/0x1440 [snd_hdspm]

Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 sound/pci/rme9652/hdspm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 8d900c132f0f..00cbf81ab2a6 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -6883,7 +6883,8 @@ static int snd_hdspm_free(struct hdspm * hdspm)
 	if (hdspm->port)
 		pci_release_regions(hdspm->pci);
 
-	pci_disable_device(hdspm->pci);
+	if (pci_is_enabled(hdspm->pci))
+		pci_disable_device(hdspm->pci);
 	return 0;
 }
 
-- 
2.25.1

