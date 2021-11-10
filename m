Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8F044BAB0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 04:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhKJDsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 22:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhKJDsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 22:48:18 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2265C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 19:45:31 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so649185pjc.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 19:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j+UNDzr76YtRYOgnj1yrFAUu6jSMEmlYMYsY1vhmpWg=;
        b=bbUCgCTUXdoC6/CIRW9kpIEIUXDm9r8asWvPrXn1jBH8vkY0wbbeVlnLLOA8kQLr5T
         czQLBLZf3wdbsyBaitNPs06rU9KSX0TUEBWw0b7S1oJGtYMgOZ+eABk2j2Ngvfpen3Z1
         G0pnZA/GaZqgc4CGyj3QhUdRC9EZWWAUDSGXr5RzZwPd/fBS9HbjU70nMlX631v23IFz
         ANV0jn21wJXlfCYEV12qScMW76bD7Tfbg+S2kDFMKfnEtIJZkNk9dFeNHDINTQx2bDu6
         4fhy21YDLMNDI/pdtvlwxlvyuixcDtMZ2ObWma4VfQow7vRZp7mTAVDWQ13cIwZwDAqp
         b5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j+UNDzr76YtRYOgnj1yrFAUu6jSMEmlYMYsY1vhmpWg=;
        b=Q0wP1bPonomruG50BfH3PfUdPsXo54aIdOnnr/HFelGxeIVyld26kKp5NFgv5u3nAu
         cDXo7NKEQrVc14FJQm6B+4nZwy96wtjeRINHyXZSRcou/eojk4WGL1n/3OcpvdH3WFYM
         PtpAK4eO93+/x7uH/GivY+kJfoOPVKtCAxhQQWPkJYSBbFR36JEqjV6VX//3aHbX9/Xl
         SpMUyRc9z7WiWRS2JF1Az9guEPeu7JzsOdi5gw5dIYaLebeM3hgkcbtB86n5yMlCZa3r
         5R51PzWvimJMHvzFzj+84cIr6NUbIB/oxGR5lt+SX0Ilb4wPN2e0b6TkNN4oiA+Xcysd
         a4CA==
X-Gm-Message-State: AOAM530amE1iXBz0CXE1K4QOytclrez3fv9t4+E+US3b4Uq4YTRfbXN/
        kg32i/shZwFmA/cXktaVOyeOzaNDr08=
X-Google-Smtp-Source: ABdhPJzoaSe0uLk6oAeUh0bwrbZj1a2WnpanO6XwD0mtnjcCQ2Zmzop9I5F0PKtmQof2Zq9T/kB27A==
X-Received: by 2002:a17:903:2348:b0:141:d60b:ee90 with SMTP id c8-20020a170903234800b00141d60bee90mr12175007plh.15.1636515931421;
        Tue, 09 Nov 2021 19:45:31 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:46a:f117:d5ee:c3e5:104f:c135])
        by smtp.gmail.com with ESMTPSA id q6sm5995293pgn.42.2021.11.09.19.45.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Nov 2021 19:45:30 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     oder_chiou@realtek.com, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com, allen_lin@richtek.com
Subject: [PATCH v2 1/3] ASoC: rt9120: Update internal ocp level to the correct value
Date:   Wed, 10 Nov 2021 11:45:19 +0800
Message-Id: <1636515921-31694-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1636515921-31694-1-git-send-email-u0084500@gmail.com>
References: <1636515921-31694-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Update internal ocp level to correct value.

Even the wrong ocp setting can also make the sound output, but the power
cannot match the IC capability.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 sound/soc/codecs/rt9120.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt9120.c b/sound/soc/codecs/rt9120.c
index f957498..032c520 100644
--- a/sound/soc/codecs/rt9120.c
+++ b/sound/soc/codecs/rt9120.c
@@ -149,8 +149,7 @@ static int rt9120_codec_probe(struct snd_soc_component *comp)
 	snd_soc_component_init_regmap(comp, data->regmap);
 
 	/* Internal setting */
-	snd_soc_component_write(comp, RT9120_REG_INTERNAL1, 0x03);
-	snd_soc_component_write(comp, RT9120_REG_INTERNAL0, 0x69);
+	snd_soc_component_write(comp, RT9120_REG_INTERNAL0, 0x04);
 	return 0;
 }
 
-- 
2.7.4

