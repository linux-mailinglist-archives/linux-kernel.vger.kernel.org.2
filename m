Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8669C4389BC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 17:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhJXPUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 11:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhJXPUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 11:20:17 -0400
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9731DC061745;
        Sun, 24 Oct 2021 08:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=Wx0knZzTTV3Xd6oi7w1NDuFxpSk5IUn+b6TO2aUcEUY=; b=Qv
        WbbBuc/AlP0qdIMpm9MQ0d51msICbWr+GY0F5eGFoA1abcRCPA1BX8wx0ghNXBxErE+TCtNFit/0q
        A5nBohhn0JbEGppLK4DRvrV5zxQ/VQjrSc6vRfxgPNKqVbfgfbAsIWzAl8bVVmf++jInwVYC4+Cex
        DMoXyPr3GbgwgLxEeRX3KliSvRe6N1pI1wmdn1ZXYaVo1aGIG29b+SK+mJ77o/gB1F5qixZ/Fzmn4
        7eXa3VCnWDMBSzPaZSxkFDpTrBog7onaVHZNJNPNjBx/ca6qFFP05Q+nuKatctMJf17DazfBQ0NRo
        T+9wxapJOpb0zhAuMEtypkntlZya5FLA==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mefFn-0005Px-Iz; Sun, 24 Oct 2021 16:17:43 +0100
From:   John Keeping <john@metanate.com>
To:     alsa-devel@alsa-project.org
Cc:     John Keeping <john@metanate.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: doc: update codec example code
Date:   Sun, 24 Oct 2021 16:17:31 +0100
Message-Id: <20211024151731.360638-1-john@metanate.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the codec API has evolved the documentation has not kept up and still
uses old fields that have been removed.  Update the examples to
represent the current API.

Signed-off-by: John Keeping <john@metanate.com>
---
 Documentation/sound/soc/codec.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/sound/soc/codec.rst b/Documentation/sound/soc/codec.rst
index 8a9737eb7597..57df149acafc 100644
--- a/Documentation/sound/soc/codec.rst
+++ b/Documentation/sound/soc/codec.rst
@@ -40,7 +40,7 @@ e.g.
 	.prepare	= wm8731_pcm_prepare,
 	.hw_params	= wm8731_hw_params,
 	.shutdown	= wm8731_shutdown,
-	.digital_mute	= wm8731_mute,
+	.mute_stream	= wm8731_mute,
 	.set_sysclk	= wm8731_set_dai_sysclk,
 	.set_fmt	= wm8731_set_dai_fmt,
   };
@@ -60,7 +60,7 @@ e.g.
 		.rates = WM8731_RATES,
 		.formats = WM8731_FORMATS,},
 	.ops = &wm8731_dai_ops,
-	.symmetric_rates = 1,
+	.symmetric_rate = 1,
   };
 
 
@@ -177,10 +177,10 @@ when the mute is applied or freed.
 i.e.
 ::
 
-  static int wm8974_mute(struct snd_soc_dai *dai, int mute)
+  static int wm8974_mute(struct snd_soc_dai *dai, int mute, int direction)
   {
 	struct snd_soc_component *component = dai->component;
-	u16 mute_reg = snd_soc_component_read32(component, WM8974_DAC) & 0xffbf;
+	u16 mute_reg = snd_soc_component_read(component, WM8974_DAC) & 0xffbf;
 
 	if (mute)
 		snd_soc_component_write(component, WM8974_DAC, mute_reg | 0x40);
-- 
2.33.1

