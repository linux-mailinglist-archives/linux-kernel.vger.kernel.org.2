Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2663245B0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 22:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbhBXVU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 16:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235853AbhBXVUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 16:20:11 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EAEC061788
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 13:19:30 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id a17so4803425lfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 13:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bNR1KI2pRCEa4jeqkN89XkpppOEohChHDZHILgnnwVE=;
        b=R5QRo2B2oMgyIpvYMaARSzalCqNsNEewkuyK8GqD+9Hxagz9bsLLkL3DqooEcgoPIS
         YSn7T5HdPxdYPFyANbYByP47cXHJ+b5zszT61j4rpTxLntkL/dnP9ipBpyOrZFxkHEFn
         o/db+R45qrMfzJPxh8dHJzvycEmdduga3fFDd6jQXxpjYOQ/L3cfT+FZVVCONeyeZxR9
         /0OjgZkoBXHeBv1bYlTPezKforNeaHfM6frb60ElrEuYgOj/J6LzkRcNT1cX/Lm0f/GZ
         2uIXNDIPmpLtYNFoihpO8xrWwxcWbe0ohfc6IAt2doig6ZIQr0c1+DAhN+LQ0JErOTho
         D7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bNR1KI2pRCEa4jeqkN89XkpppOEohChHDZHILgnnwVE=;
        b=G/NFfWTQesf0aJ+pdlTlpiONRjXKsLQjMEZjLB/Y+/OyluL/ZaCgAC3fa45h5k25mV
         7oLJ1/ci2TLLVmNX5peuaQI/I3nkgSqY+Ag5w0gQAl0pR2fA2kFmKZjLPcgpAvuFwHfw
         0k47Qlnk+i8RlWv37ijS5XGF70L5nPskmZjV6vsWkfs1J3oysL5VA2f5gemUFN/IrY77
         et/RNJ98GiwX/cVgWBx2iH+59+MoWEPnqNbtQuQ0F6+cgEbANS4QgyNBGWa+JR7rVBiv
         SBINz5y5KHv15DQdovyoW51Imi0zpQ1tVcZwuAWcXmOY8tKZl9xtx5ksHXlsNRppPrY2
         Q/VA==
X-Gm-Message-State: AOAM5334gNSGjn2cYC+1FvgZQ0fHKj5nrwAlJ8OJVWrS3OZCtjOKCd8E
        OhEspDcnhh9Mmx2flZx8Tb3oFBNVJvI=
X-Google-Smtp-Source: ABdhPJzQNo1uob0y8vJmKLbHqTEr+Oufmvez2ZwpS3vFdPnaJYuPf7kaRx3OTf4yuzXcJTaxneSGTQ==
X-Received: by 2002:ac2:420b:: with SMTP id y11mr19798338lfh.215.1614201569046;
        Wed, 24 Feb 2021 13:19:29 -0800 (PST)
Received: from localhost.localdomain (h-98-128-229-129.NA.cust.bahnhof.se. [98.128.229.129])
        by smtp.gmail.com with ESMTPSA id w26sm717116lfr.186.2021.02.24.13.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 13:19:28 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 4/4] ASoc: rt5631: Constify static struct coeff_clk_div
Date:   Wed, 24 Feb 2021 22:19:18 +0100
Message-Id: <20210224211918.39109-5-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210224211918.39109-1-rikard.falkeborn@gmail.com>
References: <20210224211918.39109-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

coeff_div is only read from, so make it const to show the intent.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 sound/soc/codecs/rt5631.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5631.c b/sound/soc/codecs/rt5631.c
index 653da3eaf355..afc1305a7fa5 100644
--- a/sound/soc/codecs/rt5631.c
+++ b/sound/soc/codecs/rt5631.c
@@ -1283,7 +1283,7 @@ static const struct pll_div codec_slave_pll_div[] = {
 	{3072000,  12288000,  0x0a90},
 };
 
-static struct coeff_clk_div coeff_div[] = {
+static const struct coeff_clk_div coeff_div[] = {
 	/* sysclk is 256fs */
 	{2048000,  8000 * 32,  8000, 0x1000},
 	{2048000,  8000 * 64,  8000, 0x0000},
-- 
2.30.1

