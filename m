Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EF63ADBB7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 22:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhFSUnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 16:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhFSUni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 16:43:38 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D28C061574
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 13:41:27 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id my49so21606749ejc.7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 13:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y7heK8jLCMAsTutXG9D4DyhQ6mrjIGHXdgIEcCAASY0=;
        b=hngxuUDVRJVY6DUcHk9I1L3p2ved84CHmUxh6E5o2RGSW7sa5Hz++ePY+cOGZk+sY6
         DFj+2S8GlqRDhMo40Hq2BJZBvmihyq58llZRh4eI4qfRHQdeAGDwDkvsrLG7Y3D18re7
         4po8972Lz3XgjJkZ5bfeae6bYzcOcyhg8S9KiCDP/+G199J7gfzKZHDLhXjv3P2CvmOX
         MjekgnjbH0iV4Zjie8L6G37hhomr1bl+8yXXcO2l2iLn/KQXdTuY4M8taBP5IMPzJsT5
         Kpye7UBo0ror4XLcXfmwJk6pkDbq5oWgHrzpj737vhu/+4Mgb1mPC7Z9oCiXgRL1K9d0
         O3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y7heK8jLCMAsTutXG9D4DyhQ6mrjIGHXdgIEcCAASY0=;
        b=nCTLZRkPyTxafpYhlYUEo3hLy9msYFzTuaYK3xh+H2RM26SrpOx7IpmdI1m2qO++WI
         Xlo3V+EbNW3DzEvgrimIW7gIBaqTNQaB68+cFEeHidUSuE8qzAhCFfsjR+a9e6rPkGBX
         ntZaSy2oA/thJhNwGutArhvLbp1Y2d1vG15APUdZob85H8zJm9QQmMA1rO2moq5pJ9v8
         OAWGBeRl9jU5lz2qjx/NXcCbjZn6GTl3HLiZvYEC+rJFO5Uqbe3ABpgNFXuWLAgAOlfu
         3AMdZPPmzF8Fwf4ua8F8Gkv9ZHdFSJhGvBQg21d3HeWFElGAXN1S+/rpUHH2HMMsnEGJ
         VrYQ==
X-Gm-Message-State: AOAM532A4/rJIbuI18AiJdIvvuJ7goSTsad38oxcMV1Qk5kQZtkpHFeN
        xQb2JKJaceReTJmFcH05Gw0=
X-Google-Smtp-Source: ABdhPJwsp2ECG98d5l0TLg/JGqenBmU6zzzRTf63uWOHQ6NbHzdS1LeH0DS3H7tVjjmZUw2w3yhB/g==
X-Received: by 2002:a17:907:1011:: with SMTP id ox17mr9147195ejb.149.1624135285646;
        Sat, 19 Jun 2021 13:41:25 -0700 (PDT)
Received: from spectre.. (host-79-18-36-75.retail.telecomitalia.it. [79.18.36.75])
        by smtp.gmail.com with ESMTPSA id q16sm8408685edt.26.2021.06.19.13.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 13:41:25 -0700 (PDT)
From:   Elia Devito <eliadevito@gmail.com>
Cc:     Elia Devito <eliadevito@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Jeremy Szu <jeremy.szu@canonical.com>,
        Hui Wang <hui.wang@canonical.com>,
        Jian-Hong Pan <jhp@endlessos.org>,
        Chris Chiu <chris.chiu@canonical.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sami Loone <sami@loone.fi>,
        Werner Sembach <wse@tuxedocomputers.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Improve fixup for HP Spectre x360 15-df0xxx
Date:   Sat, 19 Jun 2021 22:41:04 +0200
Message-Id: <20210619204105.5682-1-eliadevito@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On HP Spectre x360 15-df0xxx, after system boot with plugged headset, the
headset mic are not detected.
Moving pincfg and DAC's config to single fixup function fix this.

Signed-off-by: Elia Devito <eliadevito@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 59d0936377eb..07eabcf22b5f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6354,6 +6354,24 @@ static void alc_fixup_no_int_mic(struct hda_codec *codec,
 	}
 }
 
+static void alc285_fixup_hp_spectre_x360(struct hda_codec *codec,
+					  const struct hda_fixup *fix, int action)
+{
+	static const hda_nid_t conn[] = { 0x02 };
+	static const struct hda_pintbl pincfgs[] = {
+		{ 0x14, 0x90170110 },  /* rear speaker */
+		{ }
+	};
+
+	switch (action) {
+	case HDA_FIXUP_ACT_PRE_PROBE:
+		snd_hda_apply_pincfgs(codec, pincfgs);
+		/* force front speaker to DAC1 */
+		snd_hda_override_conn_list(codec, 0x17, ARRAY_SIZE(conn), conn);
+		break;
+	}
+}
+
 /* for hda_fixup_thinkpad_acpi() */
 #include "thinkpad_helper.c"
 
@@ -8138,13 +8156,8 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chain_id = ALC269_FIXUP_HP_LINE1_MIC1_LED,
 	},
 	[ALC285_FIXUP_HP_SPECTRE_X360] = {
-		.type = HDA_FIXUP_PINS,
-		.v.pins = (const struct hda_pintbl[]) {
-			{ 0x14, 0x90170110 }, /* enable top speaker */
-			{}
-		},
-		.chained = true,
-		.chain_id = ALC285_FIXUP_SPEAKER2_TO_DAC1,
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc285_fixup_hp_spectre_x360,
 	},
 	[ALC287_FIXUP_IDEAPAD_BASS_SPK_AMP] = {
 		.type = HDA_FIXUP_FUNC,
-- 
2.31.1

