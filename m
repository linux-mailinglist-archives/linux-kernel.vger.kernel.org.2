Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D105347F8C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 18:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237376AbhCXRe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 13:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237252AbhCXReV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:34:21 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8BCC0613E3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:34:20 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ce10so34248067ejb.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dvVvI/0Wq9ZseHcmz0Zvsivscrc/Hml5KLcDLhGdq8Q=;
        b=Ukahjcp2pYWVcf0OSw8nTogJxbXbky2HnwP/sSbn6pPCP6dKZRkaxMLJUUILGQ5Lzz
         6j51TlmXH+mFznwr/GhPbjxVGeOB06WAbLC74BucxOT8+YThLCrjhUTW6pVqjeVis1mz
         leRbrOLEWsRk+z14ugjrFolBWWQBV+eji17lQI7LETqBZFgU/W/hx8o/sAKXUudUjRVH
         YSGD5Ql0v1TPhibnfKvfgUaSbquq59UeTyyRWJ8+jhWU8CxiGH44BxJAX937cvBnfH49
         +YHBNO2QZ+5FH+03V4vGg+z73KVVQTFCa5BSRTSMEnD24KVQP88ZRhSmGSacUapPq+TV
         884Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dvVvI/0Wq9ZseHcmz0Zvsivscrc/Hml5KLcDLhGdq8Q=;
        b=Ioa5rvjRFywNjJYW/syXIMZ2pjB5VVvc2s+IUa+hUfG3k0+FGj/26LnfcqZM0Hk8Xn
         f1IUQBTcR5wucHBB81mbFu4GTiXm1dCqzHeTr/tAitoREh8EfhKv8p1RmW1y1zYUNd38
         L4kToBu6F/lkLUB23uWZg33Dur6dy5whmfP3HoNLeoO9gnN3Iy4s1ST+NgRmhm/9hul0
         s7Ju0RRT8T1dy3+/i2+DOtkd+LufBRh42y6vx7i7+iBFAvEc4M/kP3MnjJ+BRovXwBSw
         bn3blpbnygXraVT5D4T1D4HFUSPtNHAqI4/+0hrP/5iOgCbAdv3oVod8PzKzI+Nn68+M
         ojaw==
X-Gm-Message-State: AOAM531bEzXGyMN+tgkAYid8FhMEXReKBhlo5qFX0BVIcqsoneAAlyOG
        YUx/e+x1G665WmAmbgxkPuln1g==
X-Google-Smtp-Source: ABdhPJw8Ct2xTGYdqYWfRhdWGor3peSqkXgdcOxKyfINiVvm40BgUlu59vvN+DDb/3CYGQA1GAUyTw==
X-Received: by 2002:a17:906:a1c8:: with SMTP id bx8mr4861222ejb.381.1616607259456;
        Wed, 24 Mar 2021 10:34:19 -0700 (PDT)
Received: from dell.default ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id p19sm1466367edr.57.2021.03.24.10.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 10:34:19 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Vojtech Pavlik <vojtech@suse.cz>,
        Michael Haboustak <mike-@cinci.rr.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 11/25] HID: hid-core: Fix incorrect function name in header
Date:   Wed, 24 Mar 2021 17:33:50 +0000
Message-Id: <20210324173404.66340-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210324173404.66340-1-lee.jones@linaro.org>
References: <20210324173404.66340-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/hid/hid-core.c:2142: warning: expecting prototype for store_new_id(). Prototype was for new_id_store() instead

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>
Cc: Michael Haboustak <mike-@cinci.rr.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/hid/hid-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 097cb1ee31268..0ae9f6df59d10 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2129,7 +2129,7 @@ struct hid_dynid {
 };
 
 /**
- * store_new_id - add a new HID device ID to this driver and re-probe devices
+ * new_id_store - add a new HID device ID to this driver and re-probe devices
  * @drv: target device driver
  * @buf: buffer for scanning device ID data
  * @count: input size
-- 
2.27.0

