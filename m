Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7114D3968AE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 22:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhEaUWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 16:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbhEaUWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 16:22:23 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8C3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 13:20:42 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id c3so11958322wrp.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 13:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zvSNi7GWP++Uf+d4WBnjHxk+zc2WB4sn27uaABnmu1Q=;
        b=T1hW9br+NVjR3JEXvCNmkV0zTOF4v7k6RQ+DFjLzLAc+u1YI0rFR7FI/QQrpZD1TJJ
         r3mdfyNmOxsv8MWKK353KcBLE975+agi0LRXzKU0b9C9X/u5jCnRVkEm3ZSMzPlnLT0w
         I88dgc57cRCtn7EPa351timB6mt0wWEE4ur1KwVjlRAliS67PqmyxR5Hn3RIXbnpOHH9
         9DI3eBrDiaIqyALGkyO1tzU/MiT2+/EIroiUHr8Rb8VtGDoyLvnS5xAYSywtWADc3K7i
         AOiO+cABKW8cwXtrseUrAzb8xUQThNdgL6ZBeGQ6si1g2hIBR0E3pJg/6f7KKYCrzLsU
         eIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zvSNi7GWP++Uf+d4WBnjHxk+zc2WB4sn27uaABnmu1Q=;
        b=D6QNL9L4o/+rehvFpgqQ9ssL/L+Px53W0a1jng8y6yoaAdbhILPBz3gMHJ8caRFAnJ
         twYmCCGkgHLJEx0pU6o7Ob7R92wzf+nvm5wyh4bhTmL4N541Zqn/jrb2eaLogq8S5LTi
         bT5pBsxxHbOS+OVQn+X8jKUjcE4v2FQhVHbs0FL8WGocQOz6lhjUqi/MLnfzUECYZy7V
         0Q7GdeXZ+r4BDed6jIQmtiRAWEW0/IKJYhCCrfur9JzbBva3Ybd+/1UDIHT0odC4cEpQ
         t58Nq6WbHd1RFSpDtUU3t2DP/oA6P6FpJIP1EUiCjI1X+j+OK/+uGUkRZkfl4eCjT2S8
         RpAw==
X-Gm-Message-State: AOAM533+qKCCcHgDCrwAh2F+xpSp/tLCb3+sJ5f7KodRhcPpD1j14Iy+
        N64OSOmoXvpfUJsS2URncB8=
X-Google-Smtp-Source: ABdhPJzIIy6XqQPefOP66e4UUQg3ZjANzkwH1c+QZONQaL4AwdIfsmkIiTZ6qE3BWehlYGbtLZJ+Rg==
X-Received: by 2002:a5d:6488:: with SMTP id o8mr21717439wri.113.1622492441201;
        Mon, 31 May 2021 13:20:41 -0700 (PDT)
Received: from localhost.localdomain (81.202.154.5.dyn.user.ono.com. [81.202.154.5])
        by smtp.gmail.com with ESMTPSA id v15sm407100wmj.39.2021.05.31.13.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 13:20:40 -0700 (PDT)
From:   Carlos M <carlos.marr.pz@gmail.com>
Cc:     tiwai@suse.com, Carlos M <carlos.marr.pz@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda: Fix for mute key LED for HP Pavilion 15-CK0xx
Date:   Mon, 31 May 2021 22:20:26 +0200
Message-Id: <20210531202026.35427-1-carlos.marr.pz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the HP Pavilion 15-CK0xx, with audio subsystem ID 0x103c:0x841c,
adding a line in patch_realtek.c to apply the ALC269_FIXUP_HP_MUTE_LED_MIC3
fix activates the mute key LED.

Signed-off-by: Carlos M <carlos.marr.pz@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 61a60c420..43e37145e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8303,6 +8303,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x82bf, "HP G3 mini", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x82c0, "HP G3 mini premium", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x83b9, "HP Spectre x360", ALC269_FIXUP_HP_MUTE_LED_MIC3),
+	SND_PCI_QUIRK(0x103c, 0x841c, "HP Pavilion 15-CK0xx", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x8497, "HP Envy x360", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x84da, "HP OMEN dc0019-ur", ALC295_FIXUP_HP_OMEN),
 	SND_PCI_QUIRK(0x103c, 0x84e7, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
-- 
2.31.1

