Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5079A30AC6B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 17:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhBAQPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 11:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbhBAQPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 11:15:17 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF127C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 08:14:35 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id z6so17149019wrq.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 08:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Sc8HrNbNzr7EkYfVerEBW1a3Yr6pb0g+SBRh2dP5aU=;
        b=x7vVGDj9TzIFhACvAUd9rk5AXnb/M228ghcnXZmSzBJKDz2374Uc1YSYsxdfgD36KP
         HHEIswk3DhRZmcwxRnFbexKg5of/3SVR0o/B08AH8hJZBLDWhlvg6/TMrRDFXwEQZLxH
         vniI5qIRDhsPeCAmf5pYiBNtm1Fqs12nKJuzXur/Vt6PjQujIvXJku41G1JnagpjjVGv
         FdBwFk+i0OPJrT8bTLDlvDfPq54aZj0bTc1sYjpzc6vdxt0usLVYCo4GJVbgZ13qLfyU
         wahBfFCF2I2MqVHtM8Sxcko+3oqmgjwfFWkfR84PQf8a5QP0wqzjIAbmydStExc9JTLC
         W07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Sc8HrNbNzr7EkYfVerEBW1a3Yr6pb0g+SBRh2dP5aU=;
        b=X0a4qX0oPy4VyuOGwO84B42k3bzh+COALBjGyyYpXEqxhPcY/JfZYC8FBY7moJJlaQ
         02FrTKmLfMauVVawGacrYDHZyzHuIXqvfdU8n8kbIpvnrMdtbjvmzjFJ7cjSEjU4ajdQ
         0yH7fsINXXY2Paa32pneYhRdGo2B9LGjMGlDWeTqGGauCRWFZxj09on4nuAMwJWDrTcx
         UcTGVcfTVsG41eTQNr/xknwZiyCDhZLfF+sx414n5FlamMoo2de3vyMKU61cMba6K0Mj
         mGaTlwvHHk/xt2LFpjP+5l6ndWR4fZBXhAOPNkcHrikD559GjkHpLjvDd41SOeyZWws6
         s+lQ==
X-Gm-Message-State: AOAM531Uj32k53MebH5C/niPi4UJzo2nhcQ2YVWwUZ+FAth9yV5yp1JW
        OVdBB1ayo/RUIeg7kvRgcuZEsA==
X-Google-Smtp-Source: ABdhPJw2qAboWdH9n62YQqAACUMGCNBbJj9wAfkZ0ZfVXEnfnDod78K0LfB+QPJ6f6FNxXDRVrX7yw==
X-Received: by 2002:a05:6000:1249:: with SMTP id j9mr19487793wrx.307.1612196074682;
        Mon, 01 Feb 2021 08:14:34 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id k131sm22226533wmb.37.2021.02.01.08.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 08:14:33 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org, vkoul@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: codecs: add missing max_register in regmap config
Date:   Mon,  1 Feb 2021 16:14:29 +0000
Message-Id: <20210201161429.28060-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason setting max_register was missed from regmap_config.
Without this cat /sys/kernel/debug/regmap/sdw:0:217:2010:0:1/range
actually throws below Warning.

WARNING: CPU: 7 PID: 540 at drivers/base/regmap/regmap-debugfs.c:160
 regmap_debugfs_get_dump_start.part.10+0x1e0/0x220
...
Call trace:
 regmap_debugfs_get_dump_start.part.10+0x1e0/0x220
 regmap_reg_ranges_read_file+0xc0/0x2e0
 full_proxy_read+0x64/0x98
 vfs_read+0xa8/0x1e0
 ksys_read+0x6c/0x100
 __arm64_sys_read+0x1c/0x28
 el0_svc_common.constprop.3+0x6c/0x190
 do_el0_svc+0x24/0x90
 el0_svc+0x14/0x20
 el0_sync_handler+0x90/0xb8
 el0_sync+0x158/0x180
...

Fixes: a0aab9e1404a ("ASoC: codecs: add wsa881x amplifier support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wsa881x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index 4530b74f5921..db87e07b11c9 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -640,6 +640,7 @@ static struct regmap_config wsa881x_regmap_config = {
 	.val_bits = 8,
 	.cache_type = REGCACHE_RBTREE,
 	.reg_defaults = wsa881x_defaults,
+	.max_register = WSA881X_SPKR_STATUS3,
 	.num_reg_defaults = ARRAY_SIZE(wsa881x_defaults),
 	.volatile_reg = wsa881x_volatile_register,
 	.readable_reg = wsa881x_readable_register,
-- 
2.21.0

