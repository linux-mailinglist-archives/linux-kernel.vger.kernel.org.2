Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4470438DE40
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 01:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbhEWX6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 19:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbhEWX6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 19:58:02 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE392C06138A;
        Sun, 23 May 2021 16:56:34 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id v5so31181407ljg.12;
        Sun, 23 May 2021 16:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XcXraiNoRPU0G8oGIVhPyNHE4YAr90zRs8GgZNjViE0=;
        b=qq7JN01neQFC1nt1RjhBXkkYdgb4M6Fkr5RK4eftNKgiX2uBFK4m0JQgi6+Dt68+ks
         f2/PZ1Wklem3LRx9B0h7lD6ODGuXTuPrMK48GtmQwxXcbIdG8Mq3wKIrMVtY5r5gTH7+
         oARR27AZL/lyvH8lgg6mRrbQ3gtkWgJ7HQLs5a0S9DOsfp6T4wSdrp44a220ftmVJ11Y
         nbGwN6kljms3UGPxXOXkdW7kxw8hlZFIzUywkEGGQVvcKkVs/uQEmY3UWo76Sdg2kgWj
         Kqvcy0LwG4jw9T4cDSGt0TjhUaDE0A2WcSvZ+Ikz7CrnkpsuflydX25BL16qmkW6rYQA
         TXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XcXraiNoRPU0G8oGIVhPyNHE4YAr90zRs8GgZNjViE0=;
        b=FzYbqY0LnGguVSWcNshSodKecdbwZHvJqC9ykrOE5k7MTCiKA8/7Bnrjkc9qu67nHo
         nFdw3uygpZZTlQxUU2ql7WtZZaSIl/sLxI0VWPAegfsxv9CKYHJod9gNmcnEn4evICBt
         zEDTewBMWfemGCu1Eb+z9OnCOEilPmcU1fOmUWdz1SVXWD4TS7FHAi8exqedks7YGWdy
         nKy3aj4TdUR+/eYwUVPOBX7TwsF4hzYsEzIkfiVqIN75WN9v+ytI3FOxQ2NJpfXG5TZ5
         tEzxP87icxO38Vvfb/sblHO3WDahc0MzNlVBiVdXOaMpwMEAQo7lzJvMvAl9rpCB8EU4
         qwUA==
X-Gm-Message-State: AOAM531+nxPtxxITtStM5yruMGG4TTCQOsQKyLxKYI4GUVXiDIksjz6i
        mr7lDF39wyfb+KbGgcDmCMY=
X-Google-Smtp-Source: ABdhPJyGEtTfR/XlS0JbwxpHNSb/95KFeP7p5VWXUtSjIHC+KvqddbHIkOaAxluzNUbkM2dsWIP4zg==
X-Received: by 2002:a2e:a78c:: with SMTP id c12mr14735696ljf.421.1621814193058;
        Sun, 23 May 2021 16:56:33 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-110.dynamic.spd-mgts.ru. [109.252.193.110])
        by smtp.gmail.com with ESMTPSA id h4sm1092987lfv.247.2021.05.23.16.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 16:56:32 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Ion Agorria <ion@agorria.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v2 2/7] thermal: thermal_of: Stop zone device before unregistering it
Date:   Mon, 24 May 2021 02:56:15 +0300
Message-Id: <20210523235620.31538-3-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210523235620.31538-1-digetx@gmail.com>
References: <20210523235620.31538-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zone device is enabled after thermal_zone_of_sensor_register() completion,
but it's not disabled before senors if unregistered, leaving temperature
polling active. This results in accessing a disabled zone device and
produces a warning about this problem. Stop zone device before
unregistering it in order to fix this "use-after-free" problem.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/thermal/thermal_of.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 5b76f9a1280d..6379f26a335f 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -559,6 +559,9 @@ void thermal_zone_of_sensor_unregister(struct device *dev,
 	if (!tz)
 		return;
 
+	/* stop temperature polling */
+	thermal_zone_device_disable(tzd);
+
 	mutex_lock(&tzd->lock);
 	tzd->ops->get_temp = NULL;
 	tzd->ops->get_trend = NULL;
-- 
2.30.2

