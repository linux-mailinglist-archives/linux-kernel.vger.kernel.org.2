Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E852E342FDE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 23:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhCTWYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 18:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhCTWXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 18:23:53 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD633C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 15:23:52 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id x14so6821440qki.10
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 15:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Hd04KDAsAoVDrVE+uWlazOzKpC3XA/RFKS+Mgm3wpmw=;
        b=kHwHrADJ1T8h9/lq7AZ3fi5FcBUS49ffIuFHnfIrC7p4Gxa3HhzTyWTez/FcxmKsPD
         E8rVBSu0x+av/SUccLsOzs6u0hig1OpFaOoAaE0GhFUX8TpisaumLGcYL4un5hHN0rZt
         zY00cXr7eXQ+D1WwCd/7KCTw4AICVBKTFQhnYOhelyk7IkdVdmrUH/tvTGvfLt/Or3E4
         iCUECbUg7OhW9RwAZI4BPCBncfbo7LtGOnAzLdNcNwWKqVmt/+bflYqwB/v8tgfxzhyD
         KUp8gdAgKlgmUbwGjffjMFCJZsPTzSbJmxdGHrY3M67IUDj4Q1TPcvOOHq1iHFDidU+P
         nepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hd04KDAsAoVDrVE+uWlazOzKpC3XA/RFKS+Mgm3wpmw=;
        b=r87G6QQZozc2guuwVT+W57JPgYcRvVezJ831+5mqMC1DpOUtCj4TRTCGUwG2ho72Ya
         eh/zOCj0sZ99OiAAuXr/OcYIpeDPmIOuU1olsYT8eYCo6dOJlZ6ceG2hlwa1mzMDvz2d
         iTkPC+3YMrJ6ALF26Q67xwZWR3LmZK/edNlbnSTyRPGLHEEJ863F2eFZ9AGNa72fu6qs
         KoDP+G3Ek4HpyuBBohJDFaQF+0RMbGH3z+DEOnMsXZwhQr3ulnkC83ztv07IKYSWO0hQ
         wn09u+39IzstLWzCihuN5xtALiCucJM6Rr/Wcaud1RbhbjiDP7jospYeL5QwrTc6JaJx
         G+LA==
X-Gm-Message-State: AOAM531Ul4l+t/6a/em8QgaoxUPaSEnGk5Br5AoSYE8sOx+HzXb6hyuV
        Cpu7EJaGDviiLSoeItHioSU=
X-Google-Smtp-Source: ABdhPJxSFtHpaAFOdOQkiJTHu8MClNtatv3LhSMMPVsWx7Gcma3AGIv4neNWLdkWfNOsKGcA44iIMg==
X-Received: by 2002:a05:620a:4152:: with SMTP id k18mr4652122qko.446.1616279032069;
        Sat, 20 Mar 2021 15:23:52 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c200:27c6:f925:bb4b:54d2:533])
        by smtp.googlemail.com with ESMTPSA id i6sm7570213qkk.31.2021.03.20.15.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 15:23:51 -0700 (PDT)
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
Subject: [PATCH v2 1/3] ALSA: hdsp: don't disable if not enabled
Date:   Sat, 20 Mar 2021 18:23:34 -0400
Message-Id: <20210320222337.243368-2-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210320222337.243368-1-ztong0001@gmail.com>
References: <20210320222337.243368-1-ztong0001@gmail.com>
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

