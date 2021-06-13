Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7756A3A5AF7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 01:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbhFMXdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 19:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbhFMXd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 19:33:29 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9A0C0617AF
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 16:31:27 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id f17so11042867wmf.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 16:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m0oGNH7E8tl8OaA4YPX5bbFuMWMnM1qZnDsgemwDFfg=;
        b=kTDezyeoKqDaGaMaOtpkBNskumEzfWsqZdJ1/VfH+DRRVJsv0jnKjMWP9LB7J6CkP+
         SdAlKxI1flmNEbdCXCwtEG2sLu6uro4rdO2Hh3cceJU84Z6MnDwB+pmtY+5bCYDZAZXy
         e1IfHaoqVtfY7tNyOKD+wqVfdT/WrbAXyuKAvlvJo14CByVF7V95DsmneV2pmXpW2YQS
         /78ct7Lnw6onpxSfu/4ypcDHlO31eCoWkQpIW+xp3Qjzp9w9V+goF9jkjRhcjvgNom+D
         s8m+qobuoaF0klVh6OClzVTUlHQygRbI4mj8F0JD8Beu9XJHPRnPqXarnl1JTmvrskmX
         iPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m0oGNH7E8tl8OaA4YPX5bbFuMWMnM1qZnDsgemwDFfg=;
        b=eEefQe9WgltZAbixn6r6LADnuxVHf6TizKQh3ua7Ge/Bp+PjlPrKP7cpX5iUgdjb2T
         uCXEUBs4ZZFX6mP9npORYouIVkPJkIfFykQrAkwJeUmDWIYrr9W+jJMXPXr6TxQlkM0j
         oMeMV3lVVJmjBLN5p3+aRUkQuQh4jfjz7ibq3UjRYDd4Wc2tCB77BFg7pkrCKgigK6CR
         wTCInupMCLfcYMrkdn9y1QziFonC8+zUECEeDerwNjNvVW+Pn75O8eSz9GQ4h8ebNbQG
         ZAT2rLIaWSpKcV9xFS1tGcU8tKE96/9l30qFDMcWzdQhwI7j4gp98HTD2jUsVv53cURt
         t1Ug==
X-Gm-Message-State: AOAM5331J5kcserkyqaNUeCOt6a4qDGWfL/5Ci3d7UI9zHImv73B/0SU
        IVek0oXpLCIZfriPs9TMULrU7wEwcA1amA==
X-Google-Smtp-Source: ABdhPJzfQrtWDN9pWI29RJGrqSnPcg8YpkTKEZldXMea3qFjL+9dRI9AEEnzbRYIGAs3MW7p+9RmTA==
X-Received: by 2002:a05:600c:228d:: with SMTP id 13mr13473663wmf.96.1623627084710;
        Sun, 13 Jun 2021 16:31:24 -0700 (PDT)
Received: from localhost.localdomain ([195.245.23.224])
        by smtp.gmail.com with ESMTPSA id i9sm17882511wrn.54.2021.06.13.16.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 16:31:24 -0700 (PDT)
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        alsa-devel@alsa-project.org
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] ASoC: cirrus: i2s: Prepare clock before using it
Date:   Mon, 14 Jun 2021 01:30:40 +0200
Message-Id: <20210613233041.128961-7-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210613233041.128961-1-alexander.sverdlin@gmail.com>
References: <20210613233041.128961-1-alexander.sverdlin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use clk_prepare_enable()/clk_disable_unprepare() in preparation for switch
to Common Clock Framework, otherwise the following is visible:

WARNING: CPU: 0 PID: 97 at drivers/clk/clk.c:1011 clk_core_enable+0x9c/0xbc
Enabling unprepared mclk
CPU: 0 PID: 97 Comm: OPAL-Event:97 Not tainted 5.13.0-rc5-tekon #1
Hardware name: Cirrus Logic EDB9302 Evaluation Board
[<c000d5b0>] (unwind_backtrace) from [<c000c590>] (show_stack+0x10/0x18)
[<c000c590>] (show_stack) from [<c03a5fd8>] (dump_stack+0x20/0x2c)
[<c03a5fd8>] (dump_stack) from [<c03a2138>] (__warn+0x98/0xc0)
[<c03a2138>] (__warn) from [<c03a21f0>] (warn_slowpath_fmt+0x90/0xc0)
[<c03a21f0>] (warn_slowpath_fmt) from [<c01d8358>] (clk_core_enable+0x9c/0xbc)
[<c01d8358>] (clk_core_enable) from [<c01d8698>] (clk_core_enable_lock+0x18/0x30)
[<c01d8698>] (clk_core_enable_lock) from [<c0291568>] (ep93xx_i2s_hw_params+0x1a0/0x1c0)
[<c0291568>] (ep93xx_i2s_hw_params) from [<c0287488>] (snd_soc_dai_hw_params+0x54/0xb4)
[<c0287488>] (snd_soc_dai_hw_params) from [<c028b0a4>] (soc_pcm_hw_params+0x418/0x5bc)
[<c028b0a4>] (soc_pcm_hw_params) from [<c0275608>] (snd_pcm_hw_params+0x14c/0x448)
[<c0275608>] (snd_pcm_hw_params) from [<c02761ac>] (snd_pcm_ioctl+0x258/0x1114)
[<c02761ac>] (snd_pcm_ioctl) from [<c00e6d40>] (sys_ioctl+0x290/0xbc4)
[<c00e6d40>] (sys_ioctl) from [<c0008200>] (ret_fast_syscall+0x0/0x4c)

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
2.32.0

