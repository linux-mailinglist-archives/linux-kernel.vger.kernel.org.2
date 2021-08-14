Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898583EC5DA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 00:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbhHNWqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 18:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbhHNWqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 18:46:36 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7516BC061764
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 15:46:07 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 28-20020a17090a031cb0290178dcd8a4d1so14415407pje.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 15:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tombom-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=/p/AlWyP8M9N5zLquf5wX/0RU+ZA4WWIHT28Ac+xSz8=;
        b=ZiGmsYvHMtYHgt0yZsNLW7miB2BWa5D5chQAgg2fFHeGBbnGB+RZ+sZA1hibY/NBMV
         VzrNdvgn013aTVdcLIau0QO0ttXEUCakD6oOS62my9Y6e8YwnBPCS7t2xPwDGiLhmY9V
         AP80w1VybUj8DFMKfWDbFF7SBcQeOzfG0pp4vLaLNuhSLRXu5N+c+ucDjTw0IsaJV3Ll
         9jTaMgs0Xasz+IwauGYwzP1mGWIVuGCL1tER9bCo7WR1af4iu6lDq4etqDxYoEJ6WRAO
         WlLVOvP+z3dvpl4wKfp1xrjpUfq0eDa7LeJZZvP3FK61jXUT/vBBzR14npKW7UQE/XUD
         Tl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=/p/AlWyP8M9N5zLquf5wX/0RU+ZA4WWIHT28Ac+xSz8=;
        b=GwvXbSR4Ti+dp0ogEQrhBAM/lKnZ2+EiodO7rYkPgYvM/koToL+mLhN55lGqC8CY2P
         qc2XmR5JO54l7pU1Y5l20czr+ZTrddUGX+uJGhgpso1YJ14hNfzEwnONkOj23MVZLZNp
         O3HYxKV8c3Ej6UvbTyqbz/wbAgfYTSx6nVY8DCJ3INQaEP5I7zYvbC3Ep3KQl9Uo0YCS
         IauPdlsNVdywBhBJ1jICoFNN5y9mk3uYSWwx5gJ1IaBwmHbviuv00AMBh7qXEjqIkQzE
         +3OVevR6VpegpOJWBYy42/lHkclIip/zxZFHMxQ9mmW7CSjW7u9e1cGc/UkT7G9IwlTB
         0HqQ==
X-Gm-Message-State: AOAM531ZuXNlZCda6eqQXpfCHVHFkPhyKzydIDSgWmcK1B76EvErYvnK
        KVNKwnpWtEVokR5jswyNP1eRq2i40FN/zA==
X-Google-Smtp-Source: ABdhPJyjXtG/QiK941IOluP82ln6hje+AKe/2/zb4wvPH42YlCrKyhfgQulJU+t03bYv1ujoKOkhqw==
X-Received: by 2002:a17:902:8348:b029:12b:b2a0:941b with SMTP id z8-20020a1709028348b029012bb2a0941bmr7326770pln.62.1628981166822;
        Sat, 14 Aug 2021 15:46:06 -0700 (PDT)
Received: from [192.168.10.193] (c-69-181-163-252.hsd1.ca.comcast.net. [69.181.163.252])
        by smtp.googlemail.com with ESMTPSA id v10sm6561089pfu.100.2021.08.14.15.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Aug 2021 15:46:06 -0700 (PDT)
From:   Kristin Paget <kristin@tombom.co.uk>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Enable 4-speaker output for Dell XPS 15
 9510 laptop
Message-ID: <e1fc95c5-c10a-1f98-a5c2-dd6e336157e1@tombom.co.uk>
Date:   Sat, 14 Aug 2021 15:46:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 2021-model XPS 15 appears to use the same 4-speakers-on-ALC289 audio
setup as the Precision models, so requires the same quirk to enable woofer
output. Tested on my own 9510.

Signed-off-by: Kristin Paget <kristin@tombom.co.uk>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 218d1aa0fd14..8b72064f8321 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8319,6 +8319,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
        SND_PCI_QUIRK(0x1028, 0x0a2e, "Dell", ALC236_FIXUP_DELL_AIO_HEADSET_MIC),
        SND_PCI_QUIRK(0x1028, 0x0a30, "Dell", ALC236_FIXUP_DELL_AIO_HEADSET_MIC),
        SND_PCI_QUIRK(0x1028, 0x0a58, "Dell", ALC255_FIXUP_DELL_HEADSET_MIC),
+       SND_PCI_QUIRK(0x1028, 0x0a61, "Dell XPS 15 9510", ALC289_FIXUP_DUAL_SPK),
        SND_PCI_QUIRK(0x1028, 0x164a, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
        SND_PCI_QUIRK(0x1028, 0x164b, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
        SND_PCI_QUIRK(0x103c, 0x1586, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC2),
