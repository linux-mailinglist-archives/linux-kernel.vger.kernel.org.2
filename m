Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01D93240BF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237535AbhBXPX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbhBXOnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 09:43:43 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0331DC061786
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 06:42:36 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id u187so83779wmg.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 06:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3ID/hgUKl1RSEU96QA4fvwKCcAxvndH9usR4QCrUTSg=;
        b=eMxXV1Fgj/2c77+pZ1G2PmcAqH1R7S8K6jKMxhWmVffCbLwYmqDCbjUC7ilBJY5N6L
         C6qoKcbIOEZavTSJRQRD2PI36JJBDZw+Iu9TljIiWxNK/VB1RTC1emqDmMHV3M7Nx0zO
         H2/+skGmZ4CuHIVoriuud2Bm433BVpq2nfvjLFT9F50BsWSlX3P5t72wwasheAMw5DAN
         K1EAEqFkEa3NF0MF1qwHnC8tiaK2JxGPWCf6bwqoWQ3exO8/zqIHtN2EZLJmSLgIx+Z4
         TdR5WfnnrkWDjIvFoi72ikk0T+afh589Sv0OVtpyP2yF/fZJxd6Mo1Pkr77r3+8bAkB/
         6OHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3ID/hgUKl1RSEU96QA4fvwKCcAxvndH9usR4QCrUTSg=;
        b=WVt0GIPJnEV16wb0W/778HztT5AMDJFiTvyzA8NWRet/asr9d0GV7hXurPfwKo+e2f
         6iVCJc9xMIv9UDcRdaA1LIx1n3sAXM2dZSprpzHGWJPSrMPNIJldLdLtdkbg5v0khP8q
         wTpSRZO6EuLX4GNahlXcSW44omXmS+U+mvYhC0O5ocQfcCqWfdyYFddxAXDHoVUWDfgX
         j8PNwZ++R0Esi5/WEnZydq7Ca84oLcDAijZ6lrXI/tr/hpa4qzUPzlNV2llX1J30M5ya
         Cy/PkxiQej/E4rdhCpGwP1T0Tx9eE0oqwK0WrwitbvKOsHXk9rZxP7ihS1GWmS6JxWxj
         d7Cw==
X-Gm-Message-State: AOAM533YvBkqIfIu1albbM+FGhjbce3wGQHKTTosUJWBh63wLjWPP8OV
        VEBOIfbBOR1ZXKRFIJZWOWAnaE1Ff9xf3g==
X-Google-Smtp-Source: ABdhPJwPAmN1xgMC72zqcEAniQ3CRA0ZmA2VlvFovS01NjdoMcJUfwesHkwiEGuLYssl6T1oCYga+g==
X-Received: by 2002:a1c:9a48:: with SMTP id c69mr696200wme.157.1614177754622;
        Wed, 24 Feb 2021 06:42:34 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-157-252.adsl.proxad.net. [82.252.157.252])
        by smtp.gmail.com with ESMTPSA id p3sm4170669wro.55.2021.02.24.06.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 06:42:34 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, andriy.shevchenko@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        linux-pm@vger.kernel.org (open list:THERMAL)
Subject: [PATCH v2 2/9] thermal/drivers/devfreq_cooling: Use HZ macros
Date:   Wed, 24 Feb 2021 15:42:12 +0100
Message-Id: <20210224144222.23762-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210224144222.23762-1-daniel.lezcano@linaro.org>
References: <20210224144222.23762-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HZ unit conversion macros are available in units.h, use them and
remove the duplicate definition.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Christian Eggers <ceggers@arri.de>
---
 drivers/thermal/devfreq_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index fed3121ff2a1..fa5b8b0c7604 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -19,10 +19,10 @@
 #include <linux/pm_opp.h>
 #include <linux/pm_qos.h>
 #include <linux/thermal.h>
+#include <linux/units.h>
 
 #include <trace/events/thermal.h>
 
-#define HZ_PER_KHZ		1000
 #define SCALE_ERROR_MITIGATION	100
 
 static DEFINE_IDA(devfreq_ida);
-- 
2.17.1

