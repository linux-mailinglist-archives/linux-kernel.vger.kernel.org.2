Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56A53DCA64
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 08:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhHAGkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 02:40:37 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:34700
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229557AbhHAGkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 02:40:33 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id F308F3F09E;
        Sun,  1 Aug 2021 06:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627800024;
        bh=Pj0slGC1ljlR96lXk8aWILLc/beGdmbsTdYuPg9E7Ro=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=XDtnfw8guEmwENieLo8WJB7SXykC4QoMYCW5cwOZmQoQFwhGQdWyabDjRNqi46o3E
         1orrWS7KTaJxL3eOjDSHiFakKrwznHrS0GBNKWJkSRr5kjM29Y/SEskcqpoUqVpA7n
         qKKtjEcO08kgWUbC5a95wXflv7WXjYByNANiSzcN+6EQM/gCzSzAQgOWhpxjJz0BtI
         zcWpkAvO9LvaXJOT+LF057+wbxnWVn7g0qxZd/PX9p3EIl1h8khaNZzbzZ6hUQoILc
         AttIooFo8K5Cx3IDkk/uBYTBe2SuiKEkP8tIBIeMJeTFQw08VrdXitF42p24yaztzM
         1dAHqjUkXyPVA==
From:   Colin King <colin.king@canonical.com>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: rt5514: make array div static const, makes object smaller
Date:   Sun,  1 Aug 2021 07:40:23 +0100
Message-Id: <20210801064023.138359-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the array div on the stack but instead it
static const. Makes the object code smaller by 48 bytes.

Before:
   text    data     bss     dec     hex filename
  53894   16368     128   70390   112f6 ./sound/soc/codecs/rt5514.o

After:
   text    data     bss     dec     hex filename
  53750   16464     128   70342   112c6 ./sound/soc/codecs/rt5514.o

(gcc version 10.2.0)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/rt5514.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index 7081142a355e..4b1ad5054e8d 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -494,7 +494,7 @@ static const struct snd_kcontrol_new rt5514_sto2_dmic_mux =
  */
 static int rt5514_calc_dmic_clk(struct snd_soc_component *component, int rate)
 {
-	int div[] = {2, 3, 4, 8, 12, 16, 24, 32};
+	static const int div[] = {2, 3, 4, 8, 12, 16, 24, 32};
 	int i;
 
 	if (rate < 1000000 * div[0]) {
-- 
2.31.1

