Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8CB44609A5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 21:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343821AbhK1UZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 15:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbhK1UXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 15:23:18 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74B0C061574
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 12:20:01 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 207so30393952ljf.10
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 12:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k4DCyz8+/Fxa9vXLn5RMQDYsGviUlWwuLm5KSdNmdZY=;
        b=gEBN9h0rjiWtK6jttU/X32i65gXZsB9Rsw6WnTNHd6QQEECoU3oVb9Fzy+QKNq+M5b
         ij4GEouoWUkj9ibEDrFkACwGhqmGsX0pfmp4KKb8WXYuqS1KIuLYMEf8JVWKUBlAOvEc
         3DmhH8haP01CUUi+cI6ZdVIxdEa31t1e0pY0YnhQAkiJD1eMD7ILnkHEUEDhe/kuXj3p
         FI3Sbf58ynZrNaPEuz1nEJUrpQNPL3rmCqJSFl1rW6iHjgaNB8zacW6xN9QXbZD75twJ
         97G+ZAd9srSAWMgu4CgNHzGkzTOI/TisJ43wLaLrhYSq/drTtrcz0nipMGXek8KtPIeH
         QGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k4DCyz8+/Fxa9vXLn5RMQDYsGviUlWwuLm5KSdNmdZY=;
        b=M0p5vTraQT6Ghyb7s9ZabpLmLoiBavCEoE8qqnEgjMgrAMfOGRPA/WgefJpXzE/hyf
         rEmVinrV29Bv4BlDnch9kMqZ3fjF/YOkJ+66m6+mUZxeBNp/RtuKuVDImSbX68hUsvIy
         Cg2zw0Yuc7XMgTTi0k+IbzPfnwDtNAcXwFrpZvSm+VCcMCH1pupGDKqa0gmSToIWJa1S
         +qjrHTa3xIH8zVuDRRjpEeKVS3OcTGDuqi9GTtiGfPFMlXdGMcsHNKrLl4Lh7JDYCp/1
         HELZCC/jml3ThwSg6DMjp+Tj7TPLMQ4TJDtC+KEheduRGA3ngeRv5jgI9CCIy8ZFoYAk
         wkGQ==
X-Gm-Message-State: AOAM533RYuqbQMhnbdWjY3ZV0TShdw2Sq75PDXLYgIjUB7cxhvBEUQhF
        ASb9egznV4/7hgtq8JY8xilG2eK7zUg=
X-Google-Smtp-Source: ABdhPJxvPPnZuZKkpyL/VlLduwLNeb1FS0N0nAcE5rtjGsySNwTDTVMqW7CA+Av+gYdeEUBcSgrhfA==
X-Received: by 2002:a2e:a305:: with SMTP id l5mr45044119lje.73.1638130800165;
        Sun, 28 Nov 2021 12:20:00 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id c25sm1136949lja.38.2021.11.28.12.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 12:19:59 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] drm/etnaviv: constify static struct cooling_ops
Date:   Sun, 28 Nov 2021 21:19:16 +0100
Message-Id: <20211128201916.10230-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of cooling_ops is to pass its address to
thermal_of_cooling_device_register(), which takes a pointer to const
struct thermal_cooling_device_ops as input. Make it const to allow the
compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 06bde46df451..37018bc55810 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1658,7 +1658,7 @@ etnaviv_gpu_cooling_set_cur_state(struct thermal_cooling_device *cdev,
 	return 0;
 }
 
-static struct thermal_cooling_device_ops cooling_ops = {
+static const struct thermal_cooling_device_ops cooling_ops = {
 	.get_max_state = etnaviv_gpu_cooling_get_max_state,
 	.get_cur_state = etnaviv_gpu_cooling_get_cur_state,
 	.set_cur_state = etnaviv_gpu_cooling_set_cur_state,
-- 
2.34.1

