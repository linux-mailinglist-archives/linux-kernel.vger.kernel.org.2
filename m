Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C05A342FE0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 23:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhCTWY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 18:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhCTWYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 18:24:00 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3746C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 15:23:59 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id z10so6812172qkz.13
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 15:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lzvC2v5LGnA+1DrgzVaX9z+VhLej+ZuhAR4hTFoaCjg=;
        b=EbwO3UZ+ZMpbnifPmvpHv2T7G9/OSymNWUU8GZAJqC0FJjpbRfy9WfQW4l4+1FtJdi
         LLkyivvfAgkkvYN5N4qxYx7FO0OHZR2CZvqg9BdCVfk56mjwvsuk59bfjsON3Mxrg2zs
         M+gR+wO/cswAC8SW/Yj3XLT5TUnMzr6tPKQOmBRgEaTp8NvYOKp9Qxs69v4BiqWcSb2o
         e74YQT8PvMHxVvB94eDXHovJUftAcx52jNDvn9cn7PqOjElqfoxjdK7tJ1msJyc9OMBn
         3EwN0sTeu16hSQrFOT/do7KfUjO8Db86/70fdnd8AGbUDZ+NX9BQ8mAyTbK9dE7Qx4D1
         Ishg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lzvC2v5LGnA+1DrgzVaX9z+VhLej+ZuhAR4hTFoaCjg=;
        b=IEH+4P5nESbLNwmqLb4BrN/0LOnY09IrXvOY7RlSljVQ2ToOuMA9K/RcxRgywRVl3F
         VNzjaalYFwMoqyRdlaPgEaYzMy8m8ND+wkrX+hjXVFaYiNLfI0+kB7xq2F9LdjKfKzkw
         bCrs4Sb0megxHnDz372/ck/2PWSlnGXAH+8RBxh5s01SDKeYwhBsYyXjf8vZkwBmLp0U
         ogGqWVWrcBUPt4TdpAfitj/Rm/Q47my7OZ21tz/EyOnJcQWOT+yGFF+UR6C5CCdZ1MMm
         coj3oO+Yoa8V7G4PC/eTKuc/JSZ5ntO3iWXvow6sfiTO6dDe0CRbCckAWwn7CmU57Kjc
         EWVQ==
X-Gm-Message-State: AOAM532Bf0OoI778jtZmKd4B56DLwxpRDZJ8oOiZi+EEadP/26zoYsgX
        6BZlKP+uDx3LVKAY34t3n7s=
X-Google-Smtp-Source: ABdhPJwehBLVzN3tr+XdSIF59VbuqPFEsJEnSPk7kTU2JWURSpTatst/TTAJV/9Sv+inkRksUq33Zw==
X-Received: by 2002:a37:a404:: with SMTP id n4mr4593388qke.439.1616279039041;
        Sat, 20 Mar 2021 15:23:59 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c200:27c6:f925:bb4b:54d2:533])
        by smtp.googlemail.com with ESMTPSA id i6sm7570213qkk.31.2021.03.20.15.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 15:23:58 -0700 (PDT)
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
Subject: [PATCH v2 3/3] ALSA: rme9652: don't disable if not enabled
Date:   Sat, 20 Mar 2021 18:23:36 -0400
Message-Id: <20210320222337.243368-4-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210320222337.243368-1-ztong0001@gmail.com>
References: <20210320222337.243368-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rme9652 wants to disable a not enabled pci device, which makes kernel
throw a warning. Make sure the device is enabled before calling disable.

[    1.751595] snd_rme9652 0000:00:03.0: disabling already-disabled device
[    1.751605] WARNING: CPU: 0 PID: 174 at drivers/pci/pci.c:2146 pci_disable_device+0x91/0xb0
[    1.759968] Call Trace:
[    1.760145]  snd_rme9652_card_free+0x76/0xa0 [snd_rme9652]
[    1.760434]  release_card_device+0x4b/0x80 [snd]
[    1.760679]  device_release+0x3b/0xa0
[    1.760874]  kobject_put+0x94/0x1b0
[    1.761059]  put_device+0x13/0x20
[    1.761235]  snd_card_free+0x61/0x90 [snd]
[    1.761454]  snd_rme9652_probe+0x3be/0x700 [snd_rme9652]

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 sound/pci/rme9652/rme9652.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/pci/rme9652/rme9652.c b/sound/pci/rme9652/rme9652.c
index 4df992e846f2..f9c9b8a80797 100644
--- a/sound/pci/rme9652/rme9652.c
+++ b/sound/pci/rme9652/rme9652.c
@@ -1728,10 +1728,10 @@ static int snd_rme9652_free(struct snd_rme9652 *rme9652)
 	if (rme9652->irq >= 0)
 		free_irq(rme9652->irq, (void *)rme9652);
 	iounmap(rme9652->iobase);
-	if (rme9652->port)
+	if (rme9652->port) {
 		pci_release_regions(rme9652->pci);
-
-	pci_disable_device(rme9652->pci);
+		pci_disable_device(rme9652->pci);
+  }
 	return 0;
 }
 
@@ -2454,8 +2454,10 @@ static int snd_rme9652_create(struct snd_card *card,
 
 	spin_lock_init(&rme9652->lock);
 
-	if ((err = pci_request_regions(pci, "rme9652")) < 0)
+	if ((err = pci_request_regions(pci, "rme9652")) < 0) {
+		pci_disable_device(pci);
 		return err;
+	}
 	rme9652->port = pci_resource_start(pci, 0);
 	rme9652->iobase = ioremap(rme9652->port, RME9652_IO_EXTENT);
 	if (rme9652->iobase == NULL) {
-- 
2.25.1

