Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65CD4431630
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 12:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhJRKfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 06:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbhJRKfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 06:35:45 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAE8C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 03:33:34 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t2so40492654wrb.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 03:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cGn43/LGWV9yHPcjMkf3TCrUECrY0/XNXt2QNLZSx3Y=;
        b=GxmpyZ8aS8/cSgSoLniK7/q4OxJ45GEcM3HKfOdecelTtSYraAqBZd1BCaT5wBDswF
         8Y9fMfDIUWaLh6fkzpv2NfyNjA1J5SnrK5NkMFpdBiy2QeEf/jl7d68d+ZXeO1fLXDYz
         4AotQeZLj/fs4ihw36rPE3iloDRcfW9V8Py+IFWetqX6Uc3g3JgT/NKJDGBJzjXCQleP
         YyCcrvRyaGLnPGtyinYwTr2cxJdSmqUIXTc414vSuqRaggTskG3iIZjOmfhVsODPwXO3
         I/gAvBIIn1Y+c4Xnp9l5sodFMCvwn9Lkd2KYov1RANmRVCR6pKUJCmM23xwvvOu1+54U
         VXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cGn43/LGWV9yHPcjMkf3TCrUECrY0/XNXt2QNLZSx3Y=;
        b=7nFF2b1AGhlFlhAWI8IA82F5fBp8ooYI+mgXVipRsMGO/GzKK/qwR7Gwi3jJBNqf2R
         8p1KvRYfgeCNJOa43KbdTrAVQssKsv37ntds2fjMpyi0JpA/9NmA2+dBuwIxRy3IoZtz
         EvGl+ZWz8OhF/68DAROaPkkSLK3qqtiqzim+cSgEZwE+upUO6O1hPHGHQtn0r5uOdDmb
         nuYpLdMWTYcCYbuqUymvsiiWDBTXlKv4KY3S2Ok51olQgnIMnY+4wRHMtJfFQlgRNvdO
         VH5t3LVYwjjHfAhFnNSKMAfCD/CbmeEn/5WmUC0aFqzQaPbXzFM5qOA3MPVxDmyVzBke
         kEKA==
X-Gm-Message-State: AOAM532dDxK0ntZhMssVGGqNAoGioIQnzfoqDmLghTjDaqTnDWfEeytK
        m5dg36vhmgH7qCJKH+cb06uXDPq7oTg=
X-Google-Smtp-Source: ABdhPJxBlzTAQpkU3yiExmcuxDUQHvrCikPJsCPEIqWTQoJ+xLeFEuRno453UyTdReHeyeOmlTGrtw==
X-Received: by 2002:a5d:64c5:: with SMTP id f5mr33763933wri.321.1634553213568;
        Mon, 18 Oct 2021 03:33:33 -0700 (PDT)
Received: from localhost.localdomain ([195.245.16.219])
        by smtp.gmail.com with ESMTPSA id o8sm19062252wme.38.2021.10.18.03.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 03:33:33 -0700 (PDT)
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     soc@kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 1/2] ASoC: cirrus: i2s: Prepare clock before using it
Date:   Mon, 18 Oct 2021 12:31:04 +0200
Message-Id: <20211018103105.146380-2-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211018103105.146380-1-alexander.sverdlin@gmail.com>
References: <20211018103105.146380-1-alexander.sverdlin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use clk_prepare_enable()/clk_disable_unprepare() in preparation for switch
to Common Clock Framework, otherwise the following is visible:

WARNING: CPU: 0 PID: 97 at drivers/clk/clk.c:1011 clk_core_enable+0x9c/0xbc
Enabling unprepared mclk
...
Hardware name: Cirrus Logic EDB9302 Evaluation Board
...
clk_core_enable
clk_core_enable_lock
ep93xx_i2s_hw_params
snd_soc_dai_hw_params
soc_pcm_hw_params
snd_pcm_hw_params
snd_pcm_ioctl
...

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 sound/soc/cirrus/ep93xx-i2s.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/cirrus/ep93xx-i2s.c b/sound/soc/cirrus/ep93xx-i2s.c
index 0d26550d0df8..4d3179f03202 100644
--- a/sound/soc/cirrus/ep93xx-i2s.c
+++ b/sound/soc/cirrus/ep93xx-i2s.c
@@ -111,9 +111,9 @@ static void ep93xx_i2s_enable(struct ep93xx_i2s_info *info, int stream)
 	if ((ep93xx_i2s_read_reg(info, EP93XX_I2S_TX0EN) & 0x1) == 0 &&
 	    (ep93xx_i2s_read_reg(info, EP93XX_I2S_RX0EN) & 0x1) == 0) {
 		/* Enable clocks */
-		clk_enable(info->mclk);
-		clk_enable(info->sclk);
-		clk_enable(info->lrclk);
+		clk_prepare_enable(info->mclk);
+		clk_prepare_enable(info->sclk);
+		clk_prepare_enable(info->lrclk);
 
 		/* Enable i2s */
 		ep93xx_i2s_write_reg(info, EP93XX_I2S_GLCTRL, 1);
@@ -156,9 +156,9 @@ static void ep93xx_i2s_disable(struct ep93xx_i2s_info *info, int stream)
 		ep93xx_i2s_write_reg(info, EP93XX_I2S_GLCTRL, 0);
 
 		/* Disable clocks */
-		clk_disable(info->lrclk);
-		clk_disable(info->sclk);
-		clk_disable(info->mclk);
+		clk_disable_unprepare(info->lrclk);
+		clk_disable_unprepare(info->sclk);
+		clk_disable_unprepare(info->mclk);
 	}
 }
 
-- 
2.33.0

