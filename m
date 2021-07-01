Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7807F3B8F9B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 11:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235775AbhGAJRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 05:17:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56509 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235654AbhGAJRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 05:17:19 -0400
Received: from mail-pj1-f71.google.com ([209.85.216.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <andy.chi@canonical.com>)
        id 1lysmV-00076Q-V3
        for linux-kernel@vger.kernel.org; Thu, 01 Jul 2021 09:14:48 +0000
Received: by mail-pj1-f71.google.com with SMTP id o11-20020a17090a420bb029016eed2aa304so918449pjg.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 02:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=thOYF/kB9x653HZTqKgDY2UQjnQQ7jDfvkUX/K+iT50=;
        b=Az7pLlt9IQiN0KGI50DN9+gpc+CWynbVBIssA5UVpGZ3WlJI1PUYXfVd+9RgV9IniX
         LtsG3OgZBuoyIJnJJ/FMp1NDyE/V9IEsdKoclQC2vgoogOJCWZjI8PK72cG7oet/hwaX
         Pq4hHyMMUr1qs6JidzvnsQ5sCgtiSgA47tmBEuz8oAU4iI2ei5aacmJqLJIKhKl3oreb
         eIGa6MTe4QJuOYDeMi9ZuK3htCPFJJTOCCMAZLVa7akeQKOw9wKdQKfnn6iuHBTTh2Fm
         YMWW98zmwZuniuMcpanDI7noSa/SsZczy53sBb0jLr68zR46XMSqMipP/eX/CBU5nUjC
         2hSg==
X-Gm-Message-State: AOAM5330GOlF5f28bWAe4//qkWyRlVabIBmGJqdJuOXC3s8j9O9Wm3vD
        DYQrrkZLwjZQ5iG5G4V3lnYf/eycNTowHnye6vaxZn/VhnkYQxbldLS90QLO1xDzTI0o9fGCAT2
        JLOJzk3FWATbA+/n1+qfyUxlNGwSFK6VQrkzalmQztw==
X-Received: by 2002:a62:aa18:0:b029:312:28be:4783 with SMTP id e24-20020a62aa180000b029031228be4783mr2887257pff.28.1625130886695;
        Thu, 01 Jul 2021 02:14:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJ3TmTny8WhyKTbAgqeIgvERKNfRFu0t0IJKVmV1iqpjj5R9HueAgkvwx/RI4KMUANW2BVZg==
X-Received: by 2002:a62:aa18:0:b029:312:28be:4783 with SMTP id e24-20020a62aa180000b029031228be4783mr2887232pff.28.1625130886498;
        Thu, 01 Jul 2021 02:14:46 -0700 (PDT)
Received: from localhost.localdomain (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id c14sm18133190pfj.205.2021.07.01.02.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 02:14:46 -0700 (PDT)
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
Subject: [PATCH v2 3/3] ALSA: hda/realtek: fix mute/micmute LEDs for HP ProBook 630 G8
Date:   Thu,  1 Jul 2021 17:14:15 +0800
Message-Id: <20210701091417.9696-3-andy.chi@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210701091417.9696-1-andy.chi@canonical.com>
References: <20210701091417.9696-1-andy.chi@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HP ProBook 630 G8 using ALC236 codec which using 0x02 to
control mute LED and 0x01 to control micmute LED.
Therefore, add a quirk to make it works.

Signed-off-by: Andy Chi <andy.chi@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 949c8e5ac54a..79e066b39f5e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8364,6 +8364,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x87c8, "HP", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87e5, "HP ProBook 440 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87e7, "HP ProBook 450 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x87f1, "HP ProBook 630 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87f2, "HP ProBook 640 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87f4, "HP", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87f5, "HP", ALC287_FIXUP_HP_GPIO_LED),
-- 
2.25.1

