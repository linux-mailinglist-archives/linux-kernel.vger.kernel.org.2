Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40240342FDF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 23:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhCTWYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 18:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhCTWX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 18:23:57 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80EAC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 15:23:56 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id c3so6814174qkc.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 15:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vdUN2b328BItSMlcqgEcX36NLs9U//nc/tlpRzp+rh4=;
        b=KXkFFVbv47EIbYA8M9x/Sjmwf28xFI74XS7fKw8U1URuIeYjfGuajrsU/JM94MwbiZ
         xuD6cBpk8ebKNMgr8Q7ffWA6YVTnp6hntyQ4ZPAxpnMI8sTKjLHxKf9OVH/N7ZMVBkFn
         qviYmXqKa4LgCes3Qi3+nGI0TLxn2rmGckhaYQ1ThHF14+KBx3aDhcpP+3E0UH3T72Gb
         iBhDFoLrOl/qTDDvByyuRFFqSxFEuTIdQXJb9cfpNCHbrDquXE5s1LNoxvETUaCMzpRX
         WbPdXqlzzemq0T4A9pgdQCsnQfiGnWBkEUYGaSbffSOwOqK0pHqAbr7p81vX9KQGDHHH
         tw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vdUN2b328BItSMlcqgEcX36NLs9U//nc/tlpRzp+rh4=;
        b=NWXX8dVGWZWIdVyNbewPgJqGHW/LPSkX3rknnGhqzzgMbKmvRF4eaJ/93UBZFQKm4X
         0KryywMhypRnW99CI2S0WPP2dXXWZ7DSWGxHkaaXCsc94TiIilzKeFy6cN0OCCA1wDLa
         bWavUOInms+gFTIjfa4+NkiiJD63r/qSri9hc+d3+AY5um+A0wKvmC8dOzuPkPXVNNR4
         2GS4CjJrEzB4DTXWs1Kpzj4RkJCPT+DGi48xrzEIlWOCJdKew7wNIwvgXXYQviccIaXs
         /8cQaEaI51MN4b2MijltF6DHZ2u2g9d6xNuoOtShER8CfLe9ujTjzD0bfwb/ZRYGtW2I
         OGUg==
X-Gm-Message-State: AOAM533ZW+KTFVSBEDE7d5rBZkI6srW6ASXeOwTRQ0sBVhyxfTno31vt
        Sw6AcyoQDE0f3y20Nf5iIqw=
X-Google-Smtp-Source: ABdhPJwIP8NEZjxbS95UPE9RkobVkAx7dNVTMrKz6G9W6bi8hQMQvMMH2xT3NmAOBed4gSB/oeNt7Q==
X-Received: by 2002:a37:9a07:: with SMTP id c7mr4669713qke.352.1616279036105;
        Sat, 20 Mar 2021 15:23:56 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c200:27c6:f925:bb4b:54d2:533])
        by smtp.googlemail.com with ESMTPSA id i6sm7570213qkk.31.2021.03.20.15.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 15:23:55 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Romain Perier <romain.perier@gmail.com>,
        Allen Pais <allen.lkml@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jasmin Fazlic <superfassl@gmail.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Mark Brown <broonie@kernel.org>, Joe Perches <joe@perches.com>,
        Tom Rix <trix@redhat.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Naoki Hayama <naoki.hayama@lineo.co.jp>
Subject: [PATCH v2 2/3] ALSA: hdspm: don't disable if not enabled
Date:   Sat, 20 Mar 2021 18:23:35 -0400
Message-Id: <20210320222337.243368-3-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210320222337.243368-1-ztong0001@gmail.com>
References: <20210320222337.243368-1-ztong0001@gmail.com>
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

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 sound/pci/rme9652/hdspm.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 8d900c132f0f..af3898c88bba 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -6582,8 +6582,10 @@ static int snd_hdspm_create(struct snd_card *card,
 	pci_set_master(hdspm->pci);
 
 	err = pci_request_regions(pci, "hdspm");
-	if (err < 0)
+	if (err < 0) {
+		pci_disable_device(pci);
 		return err;
+	}
 
 	hdspm->port = pci_resource_start(pci, 0);
 	io_extent = pci_resource_len(pci, 0);
@@ -6880,10 +6882,10 @@ static int snd_hdspm_free(struct hdspm * hdspm)
 	kfree(hdspm->mixer);
 	iounmap(hdspm->iobase);
 
-	if (hdspm->port)
+	if (hdspm->port) {
 		pci_release_regions(hdspm->pci);
-
-	pci_disable_device(hdspm->pci);
+		pci_disable_device(hdspm->pci);
+	}
 	return 0;
 }
 
-- 
2.25.1

