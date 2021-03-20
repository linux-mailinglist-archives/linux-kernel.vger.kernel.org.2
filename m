Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30534342FD3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 23:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhCTWQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 18:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhCTWQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 18:16:36 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A754FC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 15:16:36 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id c4so6811018qkg.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 15:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Hd04KDAsAoVDrVE+uWlazOzKpC3XA/RFKS+Mgm3wpmw=;
        b=izv0gFXZvAk9Q6CSBkzd0kTxnkTa76rhfqectkbkVjOrXbA9Ara4WSg2dyjA2/cXmt
         jbqLKnobebnskosV166Uvt/y4Io4Sobxj7MCKwsueEeiDWHteennFOFwj/JzdYX7d0Bu
         o6djyWLHDD6Y73bHe+vhutUJIZCuycVDMNC6mkElDTsWEMTkll0NmhNlXqtGFiVGrR0T
         SsV/uZr7OVAzzyz4fB35n0yrMmjfOVQlMCQ6FjgWlcxGOmHv2hGX+1prjAcnBkDPA1Uv
         Z8l3Ut7Yk6m3WVWOLRamvfzurPcvCdLWpBi22g9R1Bf3QAc4uHDKdu3p8bSuS78xOgX5
         C3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hd04KDAsAoVDrVE+uWlazOzKpC3XA/RFKS+Mgm3wpmw=;
        b=EKtepPjojx/WEPVtRlBiruEROaE2ean/uWmCqTZLS4QYDlJ14aV1g57oPXAovD5Ql+
         67UlqA+Omina9ah1oqcuaN7eh5EUM2w64SevyL9OAYht0ZLe19feIqK9repBRsUoOiwl
         5L+h5OdHlwQENCyn/juNypC8NRkkv/9S3mCIRU6xD90OHdMxPlQIIYWwV9NqKmxCkgHd
         NrkTRu6bioSFzLwiQtvUNnyVhpCzrD3OsojFKrmTmj5+ZMp43SiEhg9CXb4s0wH5tC65
         UEXdr7G7AIZvLqDxN1REKSpmsTlk8IXrb2OqBgJiiOayRgrrAmcRoJLFLGKYKKP+Hus7
         cs/g==
X-Gm-Message-State: AOAM531rQd2wAkDHCWJ2gmfYPKbMFRxDaZdQFbNaDAd78+6neyUG5M3j
        WBi3wsviFFoXb3h4jpEcTtI=
X-Google-Smtp-Source: ABdhPJzNmsPAw5Npetn7lsEU78C2q/sjYkDviZYWTzSSfpksjjzxKC/WtEssLP+SHsRTJWlAbkkpNQ==
X-Received: by 2002:a37:ef14:: with SMTP id j20mr4740946qkk.471.1616278595941;
        Sat, 20 Mar 2021 15:16:35 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c200:27c6:f925:bb4b:54d2:533])
        by smtp.googlemail.com with ESMTPSA id x1sm6223973qtr.97.2021.03.20.15.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 15:16:35 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jasmin Fazlic <superfassl@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Tong Zhang <ztong0001@gmail.com>,
        Allen Pais <allen.lkml@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Naoki Hayama <naoki.hayama@lineo.co.jp>,
        Tom Rix <trix@redhat.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Joe Perches <joe@perches.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 1/2] ALSA: hdsp: don't disable if not enabled
Date:   Sat, 20 Mar 2021 18:16:19 -0400
Message-Id: <20210320221620.226155-2-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210320221620.226155-1-ztong0001@gmail.com>
References: <20210320221620.226155-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hdsp wants to disable a not enabled pci device, which makes kernel
throw a warning. Make sure the device is enabled before calling disable.

[    1.758292] snd_hdsp 0000:00:03.0: disabling already-disabled device
[    1.758327] WARNING: CPU: 0 PID: 180 at drivers/pci/pci.c:2146 pci_disable_device+0x91/0xb0
[    1.766985] Call Trace:
[    1.767121]  snd_hdsp_card_free+0x94/0xf0 [snd_hdsp]
[    1.767388]  release_card_device+0x4b/0x80 [snd]
[    1.767639]  device_release+0x3b/0xa0
[    1.767838]  kobject_put+0x94/0x1b0
[    1.768027]  put_device+0x13/0x20
[    1.768207]  snd_card_free+0x61/0x90 [snd]
[    1.768430]  snd_hdsp_probe+0x524/0x5e0 [snd_hdsp]

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 sound/pci/rme9652/hdsp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index 4cf879c42dc4..d9879a5bd60e 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -5285,8 +5285,10 @@ static int snd_hdsp_create(struct snd_card *card,
 
 	pci_set_master(hdsp->pci);
 
-	if ((err = pci_request_regions(pci, "hdsp")) < 0)
+	if ((err = pci_request_regions(pci, "hdsp")) < 0) {
+		pci_disable_device(pci);
 		return err;
+	}
 	hdsp->port = pci_resource_start(pci, 0);
 	if ((hdsp->iobase = ioremap(hdsp->port, HDSP_IO_EXTENT)) == NULL) {
 		dev_err(hdsp->card->dev, "unable to remap region 0x%lx-0x%lx\n",
@@ -5387,10 +5389,10 @@ static int snd_hdsp_free(struct hdsp *hdsp)
 	vfree(hdsp->fw_uploaded);
 	iounmap(hdsp->iobase);
 
-	if (hdsp->port)
+	if (hdsp->port) {
 		pci_release_regions(hdsp->pci);
-
-	pci_disable_device(hdsp->pci);
+		pci_disable_device(hdsp->pci);
+	}
 	return 0;
 }
 
-- 
2.25.1

