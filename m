Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6491F39011F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 14:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbhEYMmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 08:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbhEYMl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 08:41:57 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED614C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 05:40:26 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso1733469pjx.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 05:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PUSkZPrTo4hXQ/NUoInJ1V3UNHg4yEH+B8SXWXI1XtM=;
        b=CAXGnC6ezIC2uHiq5izoHG16uh+4h6AzWxjc290cFVma+LE2qTS7C2irnA7o3UHewH
         S9TUyeRnf5o/tbR28kjofEFNC7up6emJWtyUKlntpI8eI612XoDfzCwju40UMitvNVYq
         v0dvcAsRQsB4n1qjMUKLp+/X8cG9zmecOHSWcPNqXNZZSCgPBknEIXv6HPRdHpVhFGYA
         W88ouqGgj9QXvmWBf3RwCmWBRsgqIKcXvJtFI9VOoER11HkcL7Wh+WQ2IPBLyZY4t1GI
         eaN/q1cM+ceZrg4M2JlYH8oOdeu6CGXTSVDGk4ycTzDFb8tPD4nzZ24L1m00cHKbMIya
         KXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PUSkZPrTo4hXQ/NUoInJ1V3UNHg4yEH+B8SXWXI1XtM=;
        b=bT3l+tAEVyxGKa+9Y4cZGSK8E99o7UQVyEdGwe81URIZITFJq334L4yQ7iCptqVGXa
         bER0N4CpvOxVqEeOS112uUGXPtHAtxo64J3oD6swj1Yf0SqnaqNqDQOyGgMIMytoIXvu
         Umr1V+DBlmxQcTrHjCDfN05xCTxPQEoo/Sv9MSdnTT4Rw0Vm3Ptf4Wbhe1lGCfxrlm9I
         icjv3VkormW2V35XdpiMqDHbne5oGOEjj85pZbFpnQf8jYhfW6S95uh36/5X4TaL8SGN
         58VZkS2L6pyNUDao+epwRwavWLYbfQz3eIwg6B24VTSl18J5y6Fam9uxbIQNuaNeL+xT
         HloA==
X-Gm-Message-State: AOAM531btuYhAKThOLkuePw0C3qOrc+maOK3TXdPufWkBy0Q3gSEHdUQ
        ORDVr5TE7mSlcyOAcwDLLpL/YQ==
X-Google-Smtp-Source: ABdhPJzNTSn/8zaWZhp8M+9LeU73A+sOv8hBSJ7QghBZgcrUBGqEE6NHGlSKh3gdMnHbPKlklTDQGw==
X-Received: by 2002:a17:902:8f93:b029:f0:ad44:35ee with SMTP id z19-20020a1709028f93b02900f0ad4435eemr30079017plo.43.1621946426178;
        Tue, 25 May 2021 05:40:26 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id i8sm14586927pgt.58.2021.05.25.05.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 05:40:25 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Yunfan Zhang <yfzhang@marvell.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: fan53555: Fix missing slew_reg/mask/shift settings for FAN53526
Date:   Tue, 25 May 2021 20:40:16 +0800
Message-Id: <20210525124017.2550029-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The di->slew_reg/di->slew_mask/di->slew_shift was not set in current code,
fix it.

Fixes: f2a9eb975ab2 ("regulator: fan53555: Add support for FAN53526")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/fan53555.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
index f3f49cf3731b..9770a4df83d4 100644
--- a/drivers/regulator/fan53555.c
+++ b/drivers/regulator/fan53555.c
@@ -296,6 +296,9 @@ static int fan53526_voltages_setup_fairchild(struct fan53555_device_info *di)
 		return -EINVAL;
 	}
 
+	di->slew_reg = FAN53555_CONTROL;
+	di->slew_mask = CTL_SLEW_MASK;
+	di->slew_shift = CTL_SLEW_SHIFT;
 	di->vsel_count = FAN53526_NVOLTAGES;
 
 	return 0;
-- 
2.25.1

