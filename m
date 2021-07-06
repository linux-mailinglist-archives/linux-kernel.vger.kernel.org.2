Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B003BD600
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 14:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239973AbhGFM0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 08:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245564AbhGFMM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 08:12:58 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B17C03DC80
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 05:08:55 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d12so19274668pfj.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 05:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6JWokwgpWa/kqSQrF9XnkQnxgxlRMc8jy6B5qssDqmw=;
        b=hF1X1Mm6nQqL72WU6+FEst5a2fqJjiKPaO8ykKpH2thiwFObKEHsmhZ+Nphw/ooymk
         Q/lgUZlN3xAsLGWa8AiVqARmmkLjq9b6j4DTCXbUKVa36b19XJCCl07vjWos2pVhxEuR
         ktJtVGG9bIb3wCDiMOP6PFVUgmtS55ZA/4tX0LRSSDVFo4Li3/vQLjHpEIT/Z9kU+72B
         sXc8HhxpcBCc7qKnxnxGwyUmYp+KN8irX4Q5SPGWHrY9XoMHFwEJFOVZkSb+XyOaL23H
         N4vQZKQgI2j3rWFNuDGNqzOtWd2AgCfEaMRtnn9SrjsrZf8jnko5V0+VpDc+W97QrGgA
         oRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6JWokwgpWa/kqSQrF9XnkQnxgxlRMc8jy6B5qssDqmw=;
        b=Lt+GR48ZmaHprXmPM2Co5HQXXtj5DVXCyx1A7X4UW1dKoLSa5MGLZWrj3AvnAXEHEd
         NajsTF2FBKDoyAPjSA5wmjVPzOAnTNUjvn9RXCIWP8xCx+vV2ALKQVP7eCc4VB5Gf4Ay
         T99ZHNetOTJgWqU4beB+6dkd0fk4VeVewqVvmQR37FVgmi7jk1Nro0ThOar+qPp+eiOm
         LHAZ06huMbK0Ej7OhtC7aCrIXtrrEQGB9ZZzwyF2NzN2fw2ONYzq72QmN10SVWt1kals
         53FreVKzWOet70A+9LYJJmXh5bGgK1gH5XeuiA1BAGB75ot7d0Fa1jlcw5bbgJEb6wB1
         iaZg==
X-Gm-Message-State: AOAM532Uh4Oxp0W9Oh6x8kxORdF3uzyhAdl0UianNtV7vNA7HKrJweMH
        5nTBXTIjIzrLXUg5Y2kV/Vo=
X-Google-Smtp-Source: ABdhPJybpvS5xRr/UE+uiFLksiGMagfYUn86GdtZRneeqO2d61T4E/kCp/WuLUHtQujFOrlb2U1SKg==
X-Received: by 2002:a63:5652:: with SMTP id g18mr20670740pgm.178.1625573334819;
        Tue, 06 Jul 2021 05:08:54 -0700 (PDT)
Received: from ubuntu.localdomain ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id l23sm2756638pjy.43.2021.07.06.05.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 05:08:54 -0700 (PDT)
From:   Gu Shengxian <gushengxian507419@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com
Cc:     linux-kernel@vger.kernel.org, Gu Shengxian <gushengxian@yulong.com>
Subject: [PATCH] ASoC: cygnus:fix spelling mistakes
Date:   Tue,  6 Jul 2021 20:08:49 +0800
Message-Id: <20210706120849.9939-1-gushengxian507419@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gu Shengxian <gushengxian@yulong.com>

controlable ==> controllable
caputure ==> capture

Signed-off-by: Gu Shengxian <gushengxian@yulong.com>
---
 sound/soc/bcm/cygnus-ssp.c | 2 +-
 sound/soc/bcm/cygnus-ssp.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/bcm/cygnus-ssp.c b/sound/soc/bcm/cygnus-ssp.c
index fca5a3f2eec5..383d824fbbb2 100644
--- a/sound/soc/bcm/cygnus-ssp.c
+++ b/sound/soc/bcm/cygnus-ssp.c
@@ -1327,7 +1327,7 @@ static int cygnus_ssp_probe(struct platform_device *pdev)
 	if (IS_ERR(cygaud->i2s_in))
 		return PTR_ERR(cygaud->i2s_in);
 
-	/* Tri-state all controlable pins until we know that we need them */
+	/* Tri-state all controllable pins until we know that we need them */
 	writel(CYGNUS_SSP_TRISTATE_MASK,
 			cygaud->audio + AUD_MISC_SEROUT_OE_REG_BASE);
 
diff --git a/sound/soc/bcm/cygnus-ssp.h b/sound/soc/bcm/cygnus-ssp.h
index 33dd34305928..0bd2d6708fe0 100644
--- a/sound/soc/bcm/cygnus-ssp.h
+++ b/sound/soc/bcm/cygnus-ssp.h
@@ -37,7 +37,7 @@ struct ringbuf_regs {
 	unsigned wraddr;
 	unsigned baseaddr;
 	unsigned endaddr;
-	unsigned fmark;   /* freemark for play, fullmark for caputure */
+	unsigned fmark;   /* freemark for play, fullmark for capture */
 	unsigned period_bytes;
 	unsigned buf_size;
 };
-- 
2.25.1

