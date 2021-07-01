Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE063B8F99
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 11:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbhGAJRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 05:17:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56492 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235654AbhGAJRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 05:17:14 -0400
Received: from mail-pl1-f198.google.com ([209.85.214.198])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <andy.chi@canonical.com>)
        id 1lysmQ-00075M-Q0
        for linux-kernel@vger.kernel.org; Thu, 01 Jul 2021 09:14:42 +0000
Received: by mail-pl1-f198.google.com with SMTP id b2-20020a1709027e02b0290128e572ee46so2495948plm.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 02:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q9/fqvpbjKgQMRg7iZrW6B8O8Uu9VdWOniL08X6W/aU=;
        b=Mt1enSmaCuJjz36t2YTEWFhzI1krqlWFO1MGdSBjllg9zicGmmRuQf6qfpI8/FOLZM
         xcliK6Nc5Mec4EwQYawmosajkBqhtQOTBS5ynLB7xG8V9BRTdzN9Z1g2NBucQjbfeE4f
         sdRvwz7ggnCHxaXtQmlS+rZb0WvWiwlku9nK4i/GCpIw1axhNhjP35366EH695dwcROH
         +HPSklJa5xueahPebvUM9IqVV2sbDWL5yu2JJIqk/vpx+Y61Dph0oK2sc2GJ1POdJqrH
         CCIA9iZfqEQ1L1+MmloMz/P/sT617gAiLXc/B54GxE/js7TkBu8DSt+teE8ZDdAztSJB
         VqSQ==
X-Gm-Message-State: AOAM5330xfuftRV/Urv73ognhNAir/AZ/BlCR6a6UcYGSJ2tMfUbZV8B
        aRwsjIa1C/N1RQnAtTVK95ga/SC27O6sPDGHYxoo1i2P8aBK93Mz/s9TLMCkCoc8pUMfv0ua0KV
        fyuLat2Sz472g7auwhd1lwJwkTnXl5UZOWth6kTTqrg==
X-Received: by 2002:a62:6447:0:b029:30d:4bba:8b5a with SMTP id y68-20020a6264470000b029030d4bba8b5amr17894358pfb.71.1625130881480;
        Thu, 01 Jul 2021 02:14:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJasFPj16Ov0bOfkITpp0DDnYHeL11ZbT+TguiSAiGd55GdvBTgzRgX2sTPujm8vg8dEQ4tA==
X-Received: by 2002:a62:6447:0:b029:30d:4bba:8b5a with SMTP id y68-20020a6264470000b029030d4bba8b5amr17894332pfb.71.1625130881287;
        Thu, 01 Jul 2021 02:14:41 -0700 (PDT)
Received: from localhost.localdomain (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id c14sm18133190pfj.205.2021.07.01.02.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 02:14:40 -0700 (PDT)
From:   Andy Chi <andy.chi@canonical.com>
Cc:     andy.chi@canonical.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Jeremy Szu <jeremy.szu@canonical.com>,
        Hui Wang <hui.wang@canonical.com>,
        Jian-Hong Pan <jhp@endlessos.org>,
        Chris Chiu <chris.chiu@canonical.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sami Loone <sami@loone.fi>,
        Werner Sembach <wse@tuxedocomputers.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/3] ALSA: hda/realtek: fix mute/micmute LEDs for HP ProBook 445 G8
Date:   Thu,  1 Jul 2021 17:14:14 +0800
Message-Id: <20210701091417.9696-2-andy.chi@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210701091417.9696-1-andy.chi@canonical.com>
References: <20210701091417.9696-1-andy.chi@canonical.com>
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
index 6c423172a1f4..949c8e5ac54a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8372,6 +8372,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8847, "HP EliteBook x360 830 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x884b, "HP EliteBook 840 Aero G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x884c, "HP EliteBook 840 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8862, "HP ProBook 445 G8 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8863, "HP ProBook 445 G8 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x886d, "HP ZBook Fury 17.3 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x8870, "HP ZBook Fury 15.6 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x8873, "HP ZBook Studio 15.6 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
-- 
2.25.1

