Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83DA43F07F4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 17:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239939AbhHRPSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 11:18:31 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:58256
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240172AbhHRPSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 11:18:25 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id B0AE13F361;
        Wed, 18 Aug 2021 15:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629299866;
        bh=z5jVFxsMugjMYW/N4BEa1uHFJbg9/7T7WDVguO5VseE=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=hf4+LckNw4pkWkuwMlwbVkmrw9okQEDxKdkcCSMAUMHNySVa0i9QPu/En3qJSZJeU
         t4x9CtV6yubBhn1kFq/mRQfK6GOUMNmhDMO2fqqQznJY8/6lzi1aBQLByu44/Z2wvL
         ANfox6rDlHHMKnaVrXgSyWkagjTYyfQwiDgYn+Fj18bLYDG1mi8N9Iq49Zr3a7wC8l
         ieDDfsYsU1JlKDn+UgEryq+2MxlIBOV/7jUFqJokvreB2WX0HK+ovS+nSTCwlZc5VN
         u6tPsLrb9BOrni6AFUdKYYdQ17RQqbv6lhowtZgfydvFxbv8Do9muwQATqUbd31ii5
         3ANfJY9nwOIyQ==
From:   Colin King <colin.king@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: uniphier: make arrays mul and div static const, makes object smaller
Date:   Wed, 18 Aug 2021 16:17:46 +0100
Message-Id: <20210818151746.38520-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the arrays mul and div on the stack but instead make them
static const. Makes the object code smaller by 4 bytes.

Before:
   text    data     bss     dec     hex filename
  16226    4984      64   21274    531a ./sound/soc/uniphier/aio-cpu.o

After:
   text    data     bss     dec     hex filename
  16062    5144      64   21270    5316 ./sound/soc/uniphier/aio-cpu.o

(gcc version 10.2.0)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/uniphier/aio-cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/uniphier/aio-cpu.c b/sound/soc/uniphier/aio-cpu.c
index cf9814130067..4e8d5f7532ba 100644
--- a/sound/soc/uniphier/aio-cpu.c
+++ b/sound/soc/uniphier/aio-cpu.c
@@ -128,8 +128,8 @@ static const struct uniphier_aio_spec *find_spec(struct uniphier_aio *aio,
 static int find_divider(struct uniphier_aio *aio, int pll_id, unsigned int freq)
 {
 	struct uniphier_aio_pll *pll;
-	int mul[] = { 1, 1, 1, 2, };
-	int div[] = { 2, 3, 1, 3, };
+	static const int mul[] = { 1, 1, 1, 2, };
+	static const int div[] = { 2, 3, 1, 3, };
 	int i;
 
 	if (!is_valid_pll(aio->chip, pll_id))
-- 
2.32.0

