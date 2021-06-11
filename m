Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B5F3A3E1E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 10:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhFKIhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 04:37:05 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:43538 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbhFKIg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 04:36:57 -0400
Received: by mail-wr1-f54.google.com with SMTP id r9so5098514wrz.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 01:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tv+RikCFz0ZwyZRNRUXlAGKnGtrRgi+bKi5y7X19Exs=;
        b=L71PRtncFy0dZlyZfnguB1xI9BrzNL+hiyhHawF9w+vkwrZ0MSP92ZQ9pRT+jKL4jF
         141FvtTsLRuKMmWno4cBUUbhku5azsTUpcJcHrdiUbeQQLfpUF4BMV/3KWxsvEyUSEB5
         FRzfFIpoDgsbRtBzKbSjEJWELu5ZrI4/U9RNhNP3oMggqGFPyeABpqMtSqa6x3qRmYwS
         urQDzujkbBknvMK/m9rNA4oY87l3IDokzhn926tDxDkP9Icm/aKjuvCPEf2ETYF4g1fB
         9jagW41ibXbl0IH9zkA9/oNRzbPjislzCi8BKweO/4Awc5djObq8oCG9K5WVmNBMUQTr
         JDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tv+RikCFz0ZwyZRNRUXlAGKnGtrRgi+bKi5y7X19Exs=;
        b=YXnuOcoBLhUZ6jr5OVJP5uFy7u9/DdCKzbI4Hwm5hkrf60quCtcAyteIgOT2s/mMaf
         YjIaaq+2sB1jb8SSqJ1BOhfqr+kHlqWyZ/D+++nvRl/acypUjN9RzQROeiB56YkMJ/4x
         TQ/K61j7IxiT+deE3GWyCP0hwjhcOubHCaCQpCAIso854fflQgb4P0Zcx41tVlHcbk9f
         t9B7qNopHHSjBF/3K6K3iIbEs4BI1lfYUL8G8P21uta8Mfc//Cj8WR3r/W/dFcPLo36w
         77aKDTanZ3mPavq4YkG5/wo3oFNa50vsSIAAeP7KzmOxtSgukd/hJUO3gr+20n6hALNo
         /9Sw==
X-Gm-Message-State: AOAM532NEV/QdoX4nEOGAstoF8Zd26phKGoPFq8wiagYL4DH4HSGHuwC
        d50u6dBbBiF/OD7l3lPETbl84w==
X-Google-Smtp-Source: ABdhPJyfnoG60Ukr8a2zx9eMzN++EwNhc/q8xe22OEPm10VckqJYAosLzbqvIPHx+RpxmSwlRQk5/w==
X-Received: by 2002:a5d:474d:: with SMTP id o13mr2658028wrs.176.1623400439739;
        Fri, 11 Jun 2021 01:33:59 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id n42sm11547428wms.29.2021.06.11.01.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 01:33:59 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 7/9] nvmem: qfprom: minor nit fixes
Date:   Fri, 11 Jun 2021 09:33:46 +0100
Message-Id: <20210611083348.20170-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210611083348.20170-1-srinivas.kandagatla@linaro.org>
References: <20210611083348.20170-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajendra Nayak <rnayak@codeaurora.org>

Fix a missed newline, change an 'if' to 'else if' and update
a comment which is stale after the merge of '5a1bea2a: nvmem:
qfprom: Add support for fuseblowing on sc7280'

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/qfprom.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index d6d3f24685a8..1ba666bcb900 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -122,6 +122,7 @@ static const struct qfprom_soc_compatible_data sc7280_qfprom = {
 	.keepout = sc7280_qfprom_keepout,
 	.nkeepout = ARRAY_SIZE(sc7280_qfprom_keepout)
 };
+
 /**
  * qfprom_disable_fuse_blowing() - Undo enabling of fuse blowing.
  * @priv: Our driver data.
@@ -195,7 +196,7 @@ static int qfprom_enable_fuse_blowing(const struct qfprom_priv *priv,
 	}
 
 	/*
-	 * Hardware requires 1.8V min for fuse blowing; this may be
+	 * Hardware requires a min voltage for fuse blowing; this may be
 	 * a rail shared do don't specify a max--regulator constraints
 	 * will handle.
 	 */
@@ -399,7 +400,7 @@ static int qfprom_probe(struct platform_device *pdev)
 
 		if (major_version == 7 && minor_version == 8)
 			priv->soc_data = &qfprom_7_8_data;
-		if (major_version == 7 && minor_version == 15)
+		else if (major_version == 7 && minor_version == 15)
 			priv->soc_data = &qfprom_7_15_data;
 
 		priv->vcc = devm_regulator_get(&pdev->dev, "vcc");
-- 
2.21.0

