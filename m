Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03AAC42FD3A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 23:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243055AbhJOVJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 17:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbhJOVJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 17:09:52 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91084C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 14:07:45 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id y15so46899448lfk.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 14:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bC5/do6YaE4lPDo0l97sBVrMnwWkBfvui2f3ar33Hc4=;
        b=eYZpMby4iGA+yh0NGF+8l+PJgizeDoLcmjeHyV4wtpwUUMvIQ3AXzmd7sgsMKFaAEZ
         HGwEWFsnA97BC5nK+vWjNWmsqMZ1Im1rXEY1pB+nOsZ6WjOO8J5sIu6bld0z5TfTDJp4
         nW8LdiaYhaDDgRW3w1oYL3q+CgM6oBiybdB+JAvQLP5CDM1kzoLNiqOdZ5+q9aUqW5Fh
         LjA+irP2bBP9CUjvT5nVex/k8Ng3w7CGm6lIea3dkjWeVYyIajfpVaz4erDghnSWB9QH
         1MWXfqPPPWTdbi+W92psmMlulWP2oV2+G6KaHPsRCyKzXxGhzPE7WaF0VB4CIkc9zhv7
         9yUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bC5/do6YaE4lPDo0l97sBVrMnwWkBfvui2f3ar33Hc4=;
        b=kyIaQy0dw6qu2Y2oXvqgsjxPLdDFRg07Q/IR9NTmB8UFhfBWfyzzBI9/V9pCsKg06d
         4OzpcmJqxytw4S4RgXW6dWZLuTpW/r0Nd3rEJ4XTg9Dom/4lFbFYY5cR9qVC2ipi3c5m
         oXQHbXo07mF2fxHmXoOm975AMCn6nvcJlbFzda2FakVN/IgD89u+kIH+d8zfPDc1izSQ
         /COlMqdVPuozU1G+DSNoBL0eQKTvIzYF5nK+XDvDON7vrcSAcwwANOUObiQGBozGMKoR
         PUbgJYzdSgpurnJDzAli6rA6yOVcQ164huj6k1k8Ta5UPQAEbIfWT3YXUamXdz65ccmB
         VJvA==
X-Gm-Message-State: AOAM531hDbILCPf9NOZR5T17JBoH1pTL8+sMrYf15la/k/lRVMXaIl53
        W4HbacTvkqDTk3KWresXWA0=
X-Google-Smtp-Source: ABdhPJwkecQzQcx4sJp1365mMubW5NhJvbb3QNHQkc1WY9qZz7N2viBUYDjQts57NocZZ1Q8Ya36dg==
X-Received: by 2002:a2e:bc03:: with SMTP id b3mr15169664ljf.54.1634332063982;
        Fri, 15 Oct 2021 14:07:43 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id a29sm125876ljq.37.2021.10.15.14.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 14:07:43 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: rockchip: i2s-tdm: Fix refcount test
Date:   Fri, 15 Oct 2021 23:07:29 +0200
Message-Id: <20211015210730.308946-1-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During development of V5 of the i2s-tdm patch series, I replaced
the atomic refcount with a regular integer, as it was only ever
accessed within a spinlock.

Foolishly, I got the semantics of atomic_dec_and_test wrong, which
resulted in a test for 0 actually becoming a test for >0.

The result was that setting the audio frequency broke; switching
from 44100 Hz audio playback to 96000 Hz audio playback would
garble the sound most unpleasantly.

Fix this by checking for --refcount == 0, which is what it should
have been all along.

Fixes: 081068fd6414 ("ASoC: rockchip: add support for i2s-tdm controller")
Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 sound/soc/rockchip/rockchip_i2s_tdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_i2s_tdm.c b/sound/soc/rockchip/rockchip_i2s_tdm.c
index 396277eaa417..5d3abbada72a 100644
--- a/sound/soc/rockchip/rockchip_i2s_tdm.c
+++ b/sound/soc/rockchip/rockchip_i2s_tdm.c
@@ -408,7 +408,7 @@ static void rockchip_snd_txrxctrl(struct snd_pcm_substream *substream,
 		else
 			rockchip_disable_rde(i2s_tdm->regmap);
 
-		if (--i2s_tdm->refcount) {
+		if (--i2s_tdm->refcount == 0) {
 			rockchip_snd_xfer_clear(i2s_tdm,
 						I2S_CLR_TXC | I2S_CLR_RXC);
 		}
-- 
2.33.1

