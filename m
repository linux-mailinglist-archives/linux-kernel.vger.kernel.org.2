Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010833B6F66
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 10:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhF2IcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 04:32:00 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59562 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbhF2Iby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 04:31:54 -0400
Received: from mail-pf1-f197.google.com ([209.85.210.197])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <andy.chi@canonical.com>)
        id 1ly97W-0000L2-Ss
        for linux-kernel@vger.kernel.org; Tue, 29 Jun 2021 08:29:27 +0000
Received: by mail-pf1-f197.google.com with SMTP id d22-20020a056a0024d6b0290304cbae6fdcso11014674pfv.21
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 01:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=toSlKwLIoJaylZ3jHBQTTvJkInZwz79Yfvkqkzo/W98=;
        b=oqpgZZMuTZbFGxKRLR7coUoFHAVxnN737FIBV/gL/8Ty1KiAGvRN21m0Ap10iUJkS7
         F2NqGmCbtHHKtoWOXJZjOQ1ACqefT8UNg7NL4g+vHkzPtWzaVuNMslOpu5x6ix1QGdSc
         PNXYLBJbdmI+B3SVE09/uePDCTFaEeKN2unjXufmvK9NPnWeFpjWrs3VdbUqo9ZBIXCI
         xUZMgunh5lzic88BwOy3fBE9zGxWxdeUwDfkCutE2eawwYdsYDXSMwtbPzn7qY3faL0/
         lChhi4b3C1fyOwM/C6ykn0pN79PqqeDhtHk9N30YcyfrOoCzaSEUwkW8xc4+UHDud7X5
         FMIg==
X-Gm-Message-State: AOAM5318wX6zRqdgk7ASJ/dgppeM+AcxXKWYZJoXKfD1URLkH26jEMp0
        btiDxv4iXfPS1bclW9ZZ0no78ny9UO9pLeBfKhrNasQU1SEyptm0Yh3nWHutYCpo0vZeRPgMGnY
        jjcdhfWUWU9LDqdxVFYtWhDwjyVacfnD9wuJrrkLNYA==
X-Received: by 2002:a17:902:7446:b029:128:ec77:b41e with SMTP id e6-20020a1709027446b0290128ec77b41emr5395334plt.80.1624955365642;
        Tue, 29 Jun 2021 01:29:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3rJTpLAVpOugSkqbdGzg37BM1HfA5uvI4BBZMTPky38pJlKqaSYVeohwYjsgN0PugSolhoQ==
X-Received: by 2002:a17:902:7446:b029:128:ec77:b41e with SMTP id e6-20020a1709027446b0290128ec77b41emr5395324plt.80.1624955365446;
        Tue, 29 Jun 2021 01:29:25 -0700 (PDT)
Received: from localhost.localdomain (36-224-198-238.dynamic-ip.hinet.net. [36.224.198.238])
        by smtp.gmail.com with ESMTPSA id 28sm17526830pgq.39.2021.06.29.01.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 01:29:25 -0700 (PDT)
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
Subject: [PATCH 3/3] ALSA: hda/realtek: fix mute/micmute LEDs for HP ProBook 630 G8
Date:   Tue, 29 Jun 2021 16:28:59 +0800
Message-Id: <20210629082902.408881-3-andy.chi@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210629082902.408881-1-andy.chi@canonical.com>
References: <20210629082902.408881-1-andy.chi@canonical.com>
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
index 25a32b718fbc..58e185c6e77f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8337,6 +8337,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x87c8, "HP", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87e5, "HP ProBook 440 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87e7, "HP ProBook 450 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x87f1, "HP ProBook 630 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87f2, "HP ProBook 640 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87f4, "HP", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87f5, "HP", ALC287_FIXUP_HP_GPIO_LED),
-- 
2.25.1

