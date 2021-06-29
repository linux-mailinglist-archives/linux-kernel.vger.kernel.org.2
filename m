Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4703B6F64
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 10:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbhF2Ibq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 04:31:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59537 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbhF2Ibp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 04:31:45 -0400
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <andy.chi@canonical.com>)
        id 1ly97M-0000IV-Uh
        for linux-kernel@vger.kernel.org; Tue, 29 Jun 2021 08:29:17 +0000
Received: by mail-pg1-f198.google.com with SMTP id h1-20020a63df410000b0290222939c0dd7so13739226pgj.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 01:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zT+AAyuwYYGwcA7gJxKF1kV6Ix+q/p+7TtOQey3g0sY=;
        b=t0dcMd67SPY/rXMIOnw6LfmBsD0xZV12PoqTCpyJNuv/xb3Lan/p+RyX8TLEaxo5dz
         zOqixKSylmgj857Srb5YZsYNIuJ41LyFsZVUExZTPlmTJVtBj6C+afqw4n6+8FMJ7vAA
         xJ4cR2GYpd6eYU3We6AeTU+SIccRCKkdRA0zppsSlv0uYr6hnYHnZDK8JIqQ1yQ0y+Qx
         PdUYDT3P/5Kark5LuiXqb10EOsJsR4omqAVy1ZOlRGuNIrO0uk7/x51McCWbFTrAJ4Ra
         pcc8YzLlDFf8jq21ZigvqgojdVCqFarJzdEDeB5tKz/JKkO0LBxda8fEeZwL39HNupHB
         EOhA==
X-Gm-Message-State: AOAM532g9RJYgwjmqLqHo17Mo4+hjmkcsWjuZg24+cn1ne8kRfGQFtyl
        IPEa3tsflF0XLAoAYc2uZbz+2nUw4obzxVS/C9wBdDDkdr4XBl1i4MuzlReio/RR7dwMgx25hgp
        kAWP+iCUMQWe355G3pC4JPOVMVPI1VpM+gXNI4PXHog==
X-Received: by 2002:a17:90a:6602:: with SMTP id l2mr1096613pjj.103.1624955355718;
        Tue, 29 Jun 2021 01:29:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYKEDhGe+xAvSsUjWW8jMLc/HpzQELmLPbu/30Sr5x7ckwsp151qQs4Wn4g+L5Rw7f6AYP7A==
X-Received: by 2002:a17:90a:6602:: with SMTP id l2mr1096589pjj.103.1624955355485;
        Tue, 29 Jun 2021 01:29:15 -0700 (PDT)
Received: from localhost.localdomain (36-224-198-238.dynamic-ip.hinet.net. [36.224.198.238])
        by smtp.gmail.com with ESMTPSA id 28sm17526830pgq.39.2021.06.29.01.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 01:29:14 -0700 (PDT)
From:   Andy Chi <andy.chi@canonical.com>
Cc:     andy.chi@canonical.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Jeremy Szu <jeremy.szu@canonical.com>,
        Hui Wang <hui.wang@canonical.com>,
        Jian-Hong Pan <jhp@endlessos.org>,
        Chris Chiu <chris.chiu@canonical.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sami Loone <sami@loone.fi>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ALSA: hda/realtek: fix mute/micmute LEDs for HP ProBook 450 G8
Date:   Tue, 29 Jun 2021 16:28:57 +0800
Message-Id: <20210629082902.408881-1-andy.chi@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HP ProBook 450 G8 using ALC236 codec which using 0x02 to
control mute LED and 0x01 to control micmute LED.
Therefore, add a quirk to make it works.

Signed-off-by: Andy Chi <andy.chi@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index ab5113cccffa..9c3bb1a2b849 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8336,6 +8336,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 		      ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x87c8, "HP", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87e5, "HP ProBook 440 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x87e7, "HP ProBook 450 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87f2, "HP ProBook 640 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87f4, "HP", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87f5, "HP", ALC287_FIXUP_HP_GPIO_LED),
-- 
2.25.1

