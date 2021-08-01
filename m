Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9C73DCA5B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 08:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhHAGct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 02:32:49 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:34466
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229451AbhHAGcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 02:32:48 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 023F83F051;
        Sun,  1 Aug 2021 06:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627799559;
        bh=AUaRd4BS3iiGKLLSuJWn46Te1rChqiyKMssPEqtpXaU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=A/A2/uoqD7cAjEnl2Hap81woM5IfW4SZtVQHOn86i7DfjvzberuZBE4S2OadUjRfk
         Ywogy3sn6HyBwNGpxIA/cRp5WwUib+ofWlMYJNQl583LekPLpj8D+94VRP66kk8n6o
         zCTqXPLeta8S3gF16c6jOHkMzEzM8HSJh1zQ3rfp3INFRrVSfuR6LwNaJ/j6SmTg5z
         BkInryYKCy/bpCFl5dpL3sMbFUH9+W0i8xXPFt1aECXNxzVorrl93vM9EZW83NMGQZ
         gHGqdJWaUMnztfqlh8eyTFBCz6ChaXxSyKz3E3OYIB1cgatMxqc+1QVsjx4cZlb/wn
         iYwDpx2FojwYg==
From:   Colin King <colin.king@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: rsnd: make some arrays static const, makes object smaller
Date:   Sun,  1 Aug 2021 07:32:37 +0100
Message-Id: <20210801063237.137998-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate arrays on the stack but instead them static const.
Makes the object code smaller by 242 bytes.

Before:
   text    data     bss     dec     hex filename
  23827    8764       0   32591    7f4f ./sound/soc/sh/rcar/ssi.o

After:
   text    data     bss     dec     hex filename
  23361    8988       0   32349    7e5d ./sound/soc/sh/rcar/ssi.o

gcc version 10.2.0)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/sh/rcar/ssi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 27f34ca6059d..87e606f688d3 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -165,7 +165,7 @@ static void rsnd_ssi_status_check(struct rsnd_mod *mod,
 
 static u32 rsnd_ssi_multi_secondaries(struct rsnd_dai_stream *io)
 {
-	enum rsnd_mod_type types[] = {
+	static const enum rsnd_mod_type types[] = {
 		RSND_MOD_SSIM1,
 		RSND_MOD_SSIM2,
 		RSND_MOD_SSIM3,
@@ -228,7 +228,7 @@ unsigned int rsnd_ssi_clk_query(struct rsnd_dai *rdai,
 		       int param1, int param2, int *idx)
 {
 	struct rsnd_priv *priv = rsnd_rdai_to_priv(rdai);
-	int ssi_clk_mul_table[] = {
+	static const int ssi_clk_mul_table[] = {
 		1, 2, 4, 8, 16, 6, 12,
 	};
 	int j, ret;
@@ -1079,7 +1079,7 @@ static void rsnd_ssi_connect(struct rsnd_mod *mod,
 			     struct rsnd_dai_stream *io)
 {
 	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
-	enum rsnd_mod_type types[] = {
+	static const enum rsnd_mod_type types[] = {
 		RSND_MOD_SSI,
 		RSND_MOD_SSIM1,
 		RSND_MOD_SSIM2,
-- 
2.31.1

