Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC85E3B6F65
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 10:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbhF2Ibu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 04:31:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59553 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbhF2Ibt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 04:31:49 -0400
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <andy.chi@canonical.com>)
        id 1ly97R-0000Jr-Vl
        for linux-kernel@vger.kernel.org; Tue, 29 Jun 2021 08:29:22 +0000
Received: by mail-pg1-f198.google.com with SMTP id y1-20020a655b410000b02902235977d00cso13781230pgr.21
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 01:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N9fgFCKAEnFNvPWv2zgFK0h9Wc7b+MXEQqnNhBWeWpg=;
        b=aw3E6KW648u4cHfHrVabXe49f2BHEV6ybdagdf3D7mc+Yl6EhwYohrtJyNdIfTHnLu
         d+kU90AfIOemUn86jRIw2bznosAs23dSiNEFPi5HIzoEHClB85h3PxpMIfYSODX9K1Mv
         GxAiMFkbYwu73zQmpLw8Yi/VtqGDNae75E5csRrbfNcK6P9w8uuZF6yIe1RzoMUDD3Lz
         RwMgCUIL+CLSz+zfmvyQFoDV2ikNJ6+LpR13CjHfkvpQSc0cH44FgHN/EZ3wxccUPZyl
         x9uCHsC/A1Xe6CUf2ypKzljN8JtFCKLQFkVSS1uBF6aiKAC3FU5IiafFHj/dqpfDso/5
         hf5g==
X-Gm-Message-State: AOAM530QwW+wGcrFcuKAw3aPGtHoCcbAGz3g39db4VNn0YMamdNsNWZo
        jp38J1Gl2dP5ZRDtev4Mj/Ez5bnn1tOAu7spB7SpVMKg7EWa7qk985+KQtcNvf988hMLl8IhZZ6
        M8fjCqnPBMEKkJBXcYDhDL8d7Tvs3X5ShTxRI7IK56A==
X-Received: by 2002:a17:90a:5885:: with SMTP id j5mr33035759pji.89.1624955360772;
        Tue, 29 Jun 2021 01:29:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzszoUHT7VwstDKZhSSaQyW593EDxYrzS5Vzev/O5do4/MJXnQWrHt25Un4IUdkUWjsxRoDw==
X-Received: by 2002:a17:90a:5885:: with SMTP id j5mr33035735pji.89.1624955360549;
        Tue, 29 Jun 2021 01:29:20 -0700 (PDT)
Received: from localhost.localdomain (36-224-198-238.dynamic-ip.hinet.net. [36.224.198.238])
        by smtp.gmail.com with ESMTPSA id 28sm17526830pgq.39.2021.06.29.01.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 01:29:20 -0700 (PDT)
From:   Andy Chi <andy.chi@canonical.com>
Cc:     andy.chi@canonical.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>,
        Jeremy Szu <jeremy.szu@canonical.com>,
        Jian-Hong Pan <jhp@endlessos.org>,
        Chris Chiu <chris.chiu@canonical.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sami Loone <sami@loone.fi>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ALSA: hda/realtek: fix mute/micmute LEDs for HP ProBook 445 G8
Date:   Tue, 29 Jun 2021 16:28:58 +0800
Message-Id: <20210629082902.408881-2-andy.chi@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210629082902.408881-1-andy.chi@canonical.com>
References: <20210629082902.408881-1-andy.chi@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HP ProBook 445 G8 using ALC236 codec.
COEF index 0x34 bit 5 is used to control the playback mute LED, but the
microphone mute LED is controlled using pin VREF instead of a COEF index.
Therefore, add a quirk to make it works.

Signed-off-by: Andy Chi <andy.chi@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 9c3bb1a2b849..25a32b718fbc 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8344,6 +8344,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8846, "HP EliteBook 850 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x884b, "HP EliteBook 840 Aero G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x884c, "HP EliteBook 840 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8862, "HP ProBook 445 G8 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8863, "HP ProBook 445 G8 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x886d, "HP ZBook Fury 17.3 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x8870, "HP ZBook Fury 15.6 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x8873, "HP ZBook Studio 15.6 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
-- 
2.25.1

