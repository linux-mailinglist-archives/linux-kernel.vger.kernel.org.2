Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C923DCA6A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 08:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhHAGsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 02:48:17 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:35004
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229491AbhHAGsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 02:48:16 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id B43CB3F10D;
        Sun,  1 Aug 2021 06:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627800487;
        bh=oI3Kd0QjwSYwaV+e2/loeSN2Q26jSUvl0TRKj83+fR0=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=fHFoVul2hFXNQJr1+O1H2SguDMaj9sMH2AbZgbkqNrIgkO8b8XjpfnZtoMEpZJuXs
         xWtUSfAiU2x//vAYpi4wy7TnbcitEtZ20+3Zd/DdvVxCDN9hzXYstEjX3C1pTL+rMQ
         d3D2uIbHOxtwwBu6Rk3Yd7JtXfCv//KfaO94VviUUWYkpwVnDm0bzyN0aHWbP3l7rd
         fRSB6Mg/WblSBIQXtOnHkM+xESs7KhL8cqArhert9DGq9EFuza7Esgq4s3xyOEzkQt
         sOFS2YE79bQ5QThCy7BYja7EOFhzWR6qqZLXBlcvXAhqh40htkcyhHzH7ipDPOk+7g
         jeh85t57qFnFA==
From:   Colin King <colin.king@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: tlv320aic32x4: make array clocks static, makes object smaller
Date:   Sun,  1 Aug 2021 07:48:07 +0100
Message-Id: <20210801064807.138641-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the array clocks on the stack but instead it
static. Makes the object code smaller by 316 bytes.

Before:
   text    data     bss     dec     hex filename
  63668   28264       0   91932   1671c ./sound/soc/codecs/tlv320aic32x4.o

After:
   text    data     bss     dec     hex filename
  62616   29000       0   91616   165e0 ./sound/soc/codecs/tlv320aic32x4.o

(gcc version 10.2.0)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/tlv320aic32x4.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 254a016cb1f3..d31ffb6d5b4b 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -714,7 +714,7 @@ static int aic32x4_setup_clocks(struct snd_soc_component *component,
 	unsigned long adc_clock_rate, dac_clock_rate;
 	int ret;
 
-	struct clk_bulk_data clocks[] = {
+	static struct clk_bulk_data clocks[] = {
 		{ .id = "pll" },
 		{ .id = "nadc" },
 		{ .id = "madc" },
@@ -878,7 +878,7 @@ static int aic32x4_set_bias_level(struct snd_soc_component *component,
 {
 	int ret;
 
-	struct clk_bulk_data clocks[] = {
+	static struct clk_bulk_data clocks[] = {
 		{ .id = "madc" },
 		{ .id = "mdac" },
 		{ .id = "bdiv" },
@@ -994,7 +994,7 @@ static int aic32x4_component_probe(struct snd_soc_component *component)
 	u32 tmp_reg;
 	int ret;
 
-	struct clk_bulk_data clocks[] = {
+	static struct clk_bulk_data clocks[] = {
 		{ .id = "codec_clkin" },
 		{ .id = "pll" },
 		{ .id = "bdiv" },
@@ -1144,7 +1144,7 @@ static int aic32x4_tas2505_component_probe(struct snd_soc_component *component)
 	u32 tmp_reg;
 	int ret;
 
-	struct clk_bulk_data clocks[] = {
+	static struct clk_bulk_data clocks[] = {
 		{ .id = "codec_clkin" },
 		{ .id = "pll" },
 		{ .id = "bdiv" },
-- 
2.31.1

