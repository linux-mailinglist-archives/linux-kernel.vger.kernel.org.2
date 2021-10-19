Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6DC432DAE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 08:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbhJSGGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 02:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhJSGGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 02:06:07 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59078C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 23:03:55 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id e65so15973603pgc.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 23:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aAoohp3BZtxGGNheUbdSrC12LV0VSJwOP4SowcMpevU=;
        b=fJFWVL8fsRE1X7J3D7guL5McUx0WCWwk1cBFQh9RNL1+LhY0ukOqw7FQyxxDfgf2YC
         432esjPcSxvU8PxVJ5XtPvZbJXZ/sm6rcq+TRfMCna3USWpJkBRIZ/GtB8ZcFV6V5Tg2
         W9bmuhtUCRDse8w0TMP56COmBqYDSCdQXZgMnxusKfkAt/WL0kc8kH+VgtCXWoBIMwvg
         sAinwbwGjNKmWodBQnKrn3z6Fy0Wiu+0JDR5e94O7Mnhn9tnciIYWegclHhkHWiHq2hL
         kdnGww+iTgtK8CQNjamia2ZEd6YOrPZNTlOtZrGjd8jde3FKKNdHZLr9XGFw35CdQt7o
         D9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aAoohp3BZtxGGNheUbdSrC12LV0VSJwOP4SowcMpevU=;
        b=RPZy8yX9GJWz3ygrQ/x6apJ6jiLFgDvgDI/s9cMC1dr2PHtSiSFHzGBwrbJ2khF8Qk
         NOJMaIp7NwrMzkYwkUySNMkddC+MZHKb0hTaCdqJ6BifMupckTz3GD4pcclYNkHQze7d
         /l80zLO+o4QALj85sTeCX7EtqHl9SSV9gbc2GwCUTe9vn5mJ/kueo3BQ0AEakjFjQJZG
         90FPce6QrSwPx8h17Xw4iDxVi+vXU41JP9Sp3PmVGanQXxg06bFkbGFcjAx8R9fgzH/w
         dIMS85ayXFc3Oa4x1uLyU4dHUwrjcfs83PXwJx1ziwY84pPVkzKFdqx0cz1WeAWJYm2D
         tm0Q==
X-Gm-Message-State: AOAM530tyUVbuKmhzPjr2PgV1DUr+elOi2x4IeBm/6RzSpOqMN+sfIDc
        tUvJWgcgRuy+kIiekXUtjwo=
X-Google-Smtp-Source: ABdhPJyYUhzeBuAGb+Xtr7RXa3uesGkYSgpkmA2dmdEm1pxink0iq4MxnZgsjelI3mpoXXnl99gqmw==
X-Received: by 2002:a63:e00b:: with SMTP id e11mr27533032pgh.190.1634623434822;
        Mon, 18 Oct 2021 23:03:54 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d138sm14939496pfd.74.2021.10.18.23.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 23:03:54 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        lv.ruyi@zte.com.cn, Vijendar.Mukunda@amd.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ASoC: amd: remove duplicate include in acp5x-mach.c
Date:   Tue, 19 Oct 2021 06:03:49 +0000
Message-Id: <20211019060349.975656-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lv Ruyi <lv.ruyi@zte.com.cn>

'linux/io.h' and 'linux/module.h' included in 'acp5x-mach.c' is
duplicated.Only one duplicate header file is reserved.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 sound/soc/amd/vangogh/acp5x-mach.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/amd/vangogh/acp5x-mach.c b/sound/soc/amd/vangogh/acp5x-mach.c
index 14cf325e4b23..2d9229ba9c59 100644
--- a/sound/soc/amd/vangogh/acp5x-mach.c
+++ b/sound/soc/amd/vangogh/acp5x-mach.c
@@ -8,16 +8,14 @@
 
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
-#include <linux/module.h>
-#include <linux/io.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
-
 #include <sound/jack.h>
+
 #include <linux/clk.h>
 #include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/io.h>
-- 
2.25.1

