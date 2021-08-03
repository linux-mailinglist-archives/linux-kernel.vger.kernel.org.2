Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95873DF3FE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 19:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238294AbhHCRgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 13:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238204AbhHCRgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 13:36:46 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1447C061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 10:36:33 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id pj14-20020a17090b4f4eb029017786cf98f9so5772667pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 10:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=daBeiKU7OZ5S4Kn+dyrY3BRcedrp0R1B1krtRgfb8No=;
        b=isr9HZVl2CDuoqbmV8NRdMoSm3OnIdAuufLeBk4y1wrrLgpw35/qtgbNyP4GR5Qhrc
         jyQGxH9aWkYrmnoAfJjSUT1uhv/3fUTIF8nVuHTFjmDICJxcy21qN08De7sag0J+Ws6+
         poilQisUYMXHpFlFQ9JTAHQXVbGGq9L71y6Bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=daBeiKU7OZ5S4Kn+dyrY3BRcedrp0R1B1krtRgfb8No=;
        b=RgVwk4J/jV5vrj0ReasZ4LSAW/3AxuTFkM456tGgY3K/Y6KJEAHEGmqEypW6pd4vMl
         O1DAXSuOHBboltKd/BIa5hwQJzVEO4FIm/EFHIIoB6iMxM8brisYyvhzveDM4gYD3W8K
         MyatWwtf+UQpXBespDOgOPgDgscY0jnaYJ5pMbmjAZ9/dKsR/T9wsXo9Fukaid2dNk+G
         WMnWyFioKgS+cq3rQwbQ6eS5CCuK+qB/FHg0/SYJjP340a5wA+N3q7SRk3sMOZiPLiMK
         NtnXlbY6KTb2CaieSo4np9AqrzwmkehsFIKOP2AICXDcSsyopPT3iIlbTLwzya9CIYqJ
         f9cg==
X-Gm-Message-State: AOAM532HiRfswrselFpoTVlDHldjnoFmXTo0HeaM1nkHkp7Wxl3a1GFg
        zVCYDeG2HDbCMsh2kejA0kdr+C5VTKnu+g==
X-Google-Smtp-Source: ABdhPJztNBFRSlMOleu0EmP7zAV1EWpprCBBVsv0JR7oy4pssZuqRUfzsBi48tBk3zW2ToWz2LwxQA==
X-Received: by 2002:a63:2c01:: with SMTP id s1mr503565pgs.357.1628012193252;
        Tue, 03 Aug 2021 10:36:33 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:8875:fb28:686e:1c31])
        by smtp.gmail.com with ESMTPSA id g202sm2026748pfb.125.2021.08.03.10.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 10:36:32 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v2 1/2] platform/chrome: cros_ec_proto: Update feature check
Date:   Tue,  3 Aug 2021 10:36:19 -0700
Message-Id: <20210803173619.91539-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EC feature flags now require more than 32 bits to be represented. In
order to make cros_ec_check_features() usable for more recent features,
update it to account for the extra 32 bits of features.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
Changes in v2:
- No changes.

 drivers/platform/chrome/cros_ec_proto.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index a7404d69b2d3..772edad80593 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -813,6 +813,7 @@ EXPORT_SYMBOL(cros_ec_get_host_event);
 int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
 {
 	struct cros_ec_command *msg;
+	u32 mask;
 	int ret;
 
 	if (ec->features[0] == -1U && ec->features[1] == -1U) {
@@ -839,7 +840,12 @@ int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
 		kfree(msg);
 	}
 
-	return ec->features[feature / 32] & EC_FEATURE_MASK_0(feature);
+	if (feature >= 32)
+		mask = EC_FEATURE_MASK_1(feature);
+	else
+		mask = EC_FEATURE_MASK_0(feature);
+
+	return ec->features[feature / 32] & mask;
 }
 EXPORT_SYMBOL_GPL(cros_ec_check_features);
 
-- 
2.32.0.554.ge1b32706d8-goog

