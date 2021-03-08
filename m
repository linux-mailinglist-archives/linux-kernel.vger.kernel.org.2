Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F147E331A35
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 23:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbhCHWbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 17:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbhCHWau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 17:30:50 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18065C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 14:30:50 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id m22so23672244lfg.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 14:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iW5ng6iEejvRMljMHfkKvj6+YTTzMof7NCYEOCF/AsQ=;
        b=Q2RMvGYZWGjX429xvgVCL9cuQIc+3cKcAD9TLhoHLcmuIXN2Let0Jbtk3LdbODPNTa
         NxeK/8zzqLqmf1qVDoT9MN/ocENVPb1ekZ4Gj+Sw3vIB74lolRKGxVQ54yjAaiJN97tT
         7iNprzA6v1+yu6EXzCkzSYB4qm+pSA+mKWfgKJ70nFYjgkPLry9BvZuujFXL8P7BXOzt
         cNhhkw8fO4oXkvWQKt84Ssqe9TlQK7tde3SyruRlvdk9CV5gOI7Omf331lSkOFgdbwOk
         ngCsz58cGJr76i8xxLSr1ilU95Kd0swhXX00QzpDXO50aqdBTBTP8H7zzyWl4XAGUfSI
         DTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iW5ng6iEejvRMljMHfkKvj6+YTTzMof7NCYEOCF/AsQ=;
        b=TwQ4+M3kBBU4+OMjMF4JGxJxXseOwAkmrgv/xRP/nRDGjEfp1f/MdJqjoERf5qZdj6
         mMiO+KheLCJtdQ4LMCHYGDPimaYQiI7HTuRcZ2kWitOHz9KBkZW4SetHiyXtHsxcPqX4
         stsU7Ub+mhsaEI/LDnofBg0zeVAw74fNVbDcQfE1e464r/1wgLtqCVv+6VIw5HNPABNT
         3KTPMCrrjI+sa4rpq2TyopOSJWET5jv1y5Kgl2HrkViOrbr0YIKENROcxXxttucvp2Cv
         BNmkgfIYW3QT1Rq348VgKMjUv4XK6TxJupJUCWGDk4AfXbjh9HBoHbh28CNj/w9QklPJ
         elVg==
X-Gm-Message-State: AOAM530A28BrneJaJGnMXvyKU/jFFh6bZd5wdf6QEoolqsoyQTpBNDni
        QQOMbBRukuAKXNV5R2RSy9E=
X-Google-Smtp-Source: ABdhPJxoslaDSSHtgXh6g/iImKFgMLC6pad8pEJWqxQDJorwJEiY3vd+1Oh2zSRB94JhMkf6WShACw==
X-Received: by 2002:a05:6512:482:: with SMTP id v2mr15983387lfq.52.1615242648619;
        Mon, 08 Mar 2021 14:30:48 -0800 (PST)
Received: from localhost.localdomain ([94.103.235.167])
        by smtp.gmail.com with ESMTPSA id x27sm1496976lfu.151.2021.03.08.14.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 14:30:48 -0800 (PST)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, kai.heng.feng@canonical.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        syzbot+719da9b149a931f5143f@syzkaller.appspotmail.com
Subject: [PATCH next 1/2] sound: usb: fix NULL ptr dereference in usb_audio_probe
Date:   Tue,  9 Mar 2021 01:30:36 +0300
Message-Id: <f1ebad6e721412843bd1b12584444c0a63c6b2fb.1615242183.git.paskripkin@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1615242183.git.paskripkin@gmail.com>
References: <cover.1615242183.git.paskripkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot reported null pointer dereference in usb_audio_probe.
The problem was in case, when quirk == NULL. It's not an
error condition, so quirk must be checked before dereferencing.

Call Trace:
 usb_probe_interface+0x315/0x7f0 drivers/usb/core/driver.c:396
 really_probe+0x291/0xe60 drivers/base/dd.c:554
 driver_probe_device+0x26b/0x3d0 drivers/base/dd.c:740
 __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:846
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:431
 __device_attach+0x228/0x4a0 drivers/base/dd.c:914
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0xbdb/0x1db0 drivers/base/core.c:3242
 usb_set_configuration+0x113f/0x1910 drivers/usb/core/message.c:2164
 usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd9/0x2c0 drivers/usb/core/driver.c:293
 really_probe+0x291/0xe60 drivers/base/dd.c:554
 driver_probe_device+0x26b/0x3d0 drivers/base/dd.c:740
 __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:846
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:431
 __device_attach+0x228/0x4a0 drivers/base/dd.c:914
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0xbdb/0x1db0 drivers/base/core.c:3242
 usb_new_device.cold+0x721/0x1058 drivers/usb/core/hub.c:2555
 hub_port_connect drivers/usb/core/hub.c:5223 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5363 [inline]
 port_event drivers/usb/core/hub.c:5509 [inline]
 hub_event+0x2357/0x4320 drivers/usb/core/hub.c:5591
 process_one_work+0x98d/0x1600 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

Reported-by: syzbot+719da9b149a931f5143f@syzkaller.appspotmail.com
Fixes: 9799110825db ("ALSA: usb-audio: Disable USB autosuspend properly in setup_disable_autosuspend()")
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 sound/usb/card.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 08c794883299..3fd1743513b5 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -830,7 +830,8 @@ static int usb_audio_probe(struct usb_interface *intf,
 		snd_media_device_create(chip, intf);
 	}
 
-	chip->quirk_type = quirk->type;
+	if (quirk)
+		chip->quirk_type = quirk->type;
 
 	usb_chip[chip->index] = chip;
 	chip->intf[chip->num_interfaces] = intf;
-- 
2.25.1

