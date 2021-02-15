Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A62131B473
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 04:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhBODtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 22:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhBODtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 22:49:16 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455F9C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 19:48:36 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id y25so110224pfp.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 19:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ZboPZGTHnwh0gHy4UlWwWYXJGu/5FQqNZU6e897Mv8=;
        b=k3r72FqMPgRS9a742Rw5nbobotfz1uYZ/aFOPlhxazzooPzB6SXBxluJOrEJQ2xClk
         5GycBOXLvRkr2TE4MAYpnhNjKwBAc82Q2Zg36XZYe8Yno7utEgvEHnuU4ReJM1QDVT6K
         /MW7Va38/+DIcy+o99ePoYkrWheiujmULWjKGeZfjsC0abVEPm2d8/9IUeEDFosKC0ft
         C62zO1YX4/3xpXVwf/Au+Y8RTi0dj5YfXhlE1n9HKydgUqIbhfmnf2AcO+cnPkjJY1Go
         sbqcQKnli1An++9CWyKe+O7LWyUeU6Ho30r1GRD8YVZcOWXQcoKyr1s8YaWDqPbpbjG/
         WaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ZboPZGTHnwh0gHy4UlWwWYXJGu/5FQqNZU6e897Mv8=;
        b=XWDU0SkezbQekBdd64fOVQmvKkB7LDzHFzWl6CITifFbrmFAXPgjl1eRHZv3Pk1lkb
         8vzcYgT6tQaDrwT7TzmY5fBUzaerHoZHWHUlyXfJVZTGrCNCgQwKT0K5wMpKvSLvdbJh
         hvAi6ubkUOAzGPkBLxPMTP/PwucvP4qVuCuzavoQ4rplN6eJqNxZPqlmdfNnYV8ASZbB
         DKk/9rEuxZyvm9vJ9oSxOOvUzBqPaXtfAGxH/L4f58dHT4sx5bNNZJDPh6cPpZKP6kiD
         rkMWt5ZHXIodqMmKqr6aaSO+DcyOz/cZImM0yvi+FqrYVkZLUJuvQfPuNTfMMes5U55z
         +hxw==
X-Gm-Message-State: AOAM533TiV5qN36WTDLM6VLE5tUJ8sJuOwaM5bGhHGj4sPIivXyT8g8S
        GQ5LW65993sJ8KuZohDwyV4nSv055FmYbQ==
X-Google-Smtp-Source: ABdhPJzBgIWAEo23KYzP+xhaZpLtaps79xtmQlNx+SEenAP7V0ta2YmpalpJvd7NlbiKe7A2mFXT4A==
X-Received: by 2002:a63:5223:: with SMTP id g35mr13368165pgb.255.1613360915757;
        Sun, 14 Feb 2021 19:48:35 -0800 (PST)
Received: from localhost.localdomain (36-239-219-129.dynamic-ip.hinet.net. [36.239.219.129])
        by smtp.gmail.com with ESMTPSA id oa10sm14847507pjb.45.2021.02.14.19.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 19:48:35 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: mt6315: Return REGULATOR_MODE_INVALID for invalid mode
Date:   Mon, 15 Feb 2021 11:48:13 +0800
Message-Id: <20210215034813.45510-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-EINVAL is not a valid return value for .of_map_mode, return
REGULATOR_MODE_INVALID instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/mt6315-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/mt6315-regulator.c b/drivers/regulator/mt6315-regulator.c
index d49a1534d8e9..fc7654624dd6 100644
--- a/drivers/regulator/mt6315-regulator.c
+++ b/drivers/regulator/mt6315-regulator.c
@@ -69,7 +69,7 @@ static unsigned int mt6315_map_mode(u32 mode)
 	case MT6315_BUCK_MODE_LP:
 		return REGULATOR_MODE_IDLE;
 	default:
-		return -EINVAL;
+		return REGULATOR_MODE_INVALID;
 	}
 }
 
-- 
2.25.1

