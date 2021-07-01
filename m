Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722CF3B8F97
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 11:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbhGAJRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 05:17:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56475 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235088AbhGAJRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 05:17:07 -0400
Received: from mail-pj1-f72.google.com ([209.85.216.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <andy.chi@canonical.com>)
        id 1lysmK-000749-0s
        for linux-kernel@vger.kernel.org; Thu, 01 Jul 2021 09:14:36 +0000
Received: by mail-pj1-f72.google.com with SMTP id x1-20020a17090ab001b02901726198443cso520548pjq.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 02:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xPTN30ZO1AZ2z4aTyWnCz44BtVf74Dz6y2exPPRRYvk=;
        b=SKjRsD+xkwVXwtCxdcfdX4SNKmfTi43WPaccCHFWHEdE9S5heNu6IDhs5aObuq590W
         HzQR3T+axWuQzf8lqkAYUK4HXJoOtdTSkV62SHr8/pHH/jr/DM6BvAK4DBxS4LgfW/z6
         1lpq+kCixNQJe+XavbQpdIuzd9Tkq1IaOAbepKn09YLufinEWKHWFX5OB0cJ8XAcWQU2
         1Nz64TQgNIhlHtZ/uqMC/3338EQ+OIdECxTPCLcc6QoL/KDvvV7gtO/3G4JEqT92JQeV
         4F/hUJotHWEZmvJRRhkEkjrvMFDNKZLjcvqrF2726w9kjAPhGxyZhYYh+D9o0vEwO976
         YRPA==
X-Gm-Message-State: AOAM532WehUh4GU07J/Pr5KG4Vp6dTkOfkoZHfavMUTXifGwQX33Ccmu
        hxwlWdnnqklcdj9S7wu80kxWalJrey96VUXwoQqpV/uCRR1s8gguMA7NiZP8jlbNQfw4PBH2xzV
        Dvq1cPWK5Xt5PZ10jVE1kAHufbshXWWckMXui1DAilQ==
X-Received: by 2002:a17:902:760c:b029:129:2dde:f8c9 with SMTP id k12-20020a170902760cb02901292ddef8c9mr3176897pll.41.1625130874737;
        Thu, 01 Jul 2021 02:14:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDXGfAk5uAuYrbBFUdY4xpCYOLzlyf1KZ2iTm/g8dW8upHdP5SCvvii2IzXt3bTlRvzhG33A==
X-Received: by 2002:a17:902:760c:b029:129:2dde:f8c9 with SMTP id k12-20020a170902760cb02901292ddef8c9mr3176876pll.41.1625130874499;
        Thu, 01 Jul 2021 02:14:34 -0700 (PDT)
Received: from localhost.localdomain (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id c14sm18133190pfj.205.2021.07.01.02.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 02:14:34 -0700 (PDT)
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
Subject: [PATCH v2 1/3] ALSA: hda/realtek: fix mute/micmute LEDs for HP ProBook 450 G8
Date:   Thu,  1 Jul 2021 17:14:13 +0800
Message-Id: <20210701091417.9696-1-andy.chi@canonical.com>
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
index 308a58a83f33..6c423172a1f4 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8363,6 +8363,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 		      ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x87c8, "HP", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87e5, "HP ProBook 440 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x87e7, "HP ProBook 450 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87f2, "HP ProBook 640 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87f4, "HP", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87f5, "HP", ALC287_FIXUP_HP_GPIO_LED),
-- 
2.25.1

