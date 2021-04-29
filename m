Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6CD36E79A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 11:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240375AbhD2JGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 05:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240322AbhD2JGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 05:06:30 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DC7C06138C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 02:05:43 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u3so20064844eja.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 02:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/NOJtqVgo4b71x9EB2dWsym5Ul8QWvASKXqefQsrwjQ=;
        b=0sw+adDQFKWk7IB3L7fR9jOdHajHbjtvty+bwUCXBDO/kc7kgPVbgadSBnXtXidmNQ
         VqvDdnOcF2b/OH3AEDdQfgkm7vgE3UxYK/CLL70sOROYqlWwjnnSmec2XI9zcjA+7q65
         5tuwmJj4sMjb4+2UMIM8PXtsRUUYgCLnBPkJlN/LHDu9eJwV+ceWtLxAitnCPv8zOx1l
         u/1b4Wi1IMfykBWgErGBv3rMr6OnxRtpAFuMRnukNob5lLCgp/IAfNV7DAq8Apsg/0yk
         p4wzHXiXfzCyZAINPDDZz0lvcretWqjFzGZ1eAnjs8i5WVMSkQCJ0g6xNv3pjFDdpFDO
         WJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/NOJtqVgo4b71x9EB2dWsym5Ul8QWvASKXqefQsrwjQ=;
        b=VpcmILC8NofMZAnb49yaWVqaC4Pqn/X9PSHCyw0ybjfOdzuEDxDEoADfUTefhCNBAz
         RTq9/EEoU4VdVFkIP7VLrV8mmqJntN1p8CLnG5TQ4/exf3r6MJVBoMo8hVtoZlFFVdm0
         ugRD5bnKhkvZvvZKWEUvsQBVmlVfozweh6XQVg13CYoZYRYVOEHDl0nXrdCjAwNcVA6f
         jZxwRTvMu8YtXPG/0hJdzd13nfYAQoWN1Ab1PiuAR/ZdgTDfbhcrJhD27G8NqQ7m3zDs
         CcAFQGlGZOTUY57gYuNQG62Li6ZumOC5IMzDpBQ/41gAK8OyR6A3zBkdaOInCH+2XUq8
         ppNg==
X-Gm-Message-State: AOAM531eHb8hfO0uQES8ikBBIv4Fnq+MfRmHPvlYBQVhVSS+rxozX5EV
        qgzT3eLviXLQa72FG0X1M9UWqg==
X-Google-Smtp-Source: ABdhPJwIW9xVVuC+zSUpQDbIMAhvucM3JanIYTGinWEGxDvs3wp0tCa91qU9N7pyeonGgJd8ZtiGCQ==
X-Received: by 2002:a17:906:c1c5:: with SMTP id bw5mr34103287ejb.510.1619687142055;
        Thu, 29 Apr 2021 02:05:42 -0700 (PDT)
Received: from localhost.localdomain (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id o8sm1420349ejm.18.2021.04.29.02.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 02:05:41 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: meson: axg-audio: do not print error on defer
Date:   Thu, 29 Apr 2021 11:05:16 +0200
Message-Id: <20210429090516.61085-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not print an error if we are just waiting for the reset controller to
come up.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg-audio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
index 7c8d02164443..5e501eff0840 100644
--- a/drivers/clk/meson/axg-audio.c
+++ b/drivers/clk/meson/axg-audio.c
@@ -1811,7 +1811,8 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
 
 	ret = device_reset(dev);
 	if (ret) {
-		dev_err(dev, "failed to reset device\n");
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to reset device\n");
 		return ret;
 	}
 
-- 
2.31.1

