Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C445B34AA15
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhCZOgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhCZOf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:35:27 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271ADC0613B3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:35:27 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j9so4139031wrx.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cQiBvBGnEPCfXvDLlcXYmYRETtwubP2zncCLn7n+qro=;
        b=I00rzJ2Pb7xw7qyx/Ux/iw5avL4Qa+ePqFm2O47i8SPa2MwvByhdllikoreR5RZPq5
         gmf29+BchuESCtjhbW500HI1pMhjDYSqXRz0zpDsl0VWtvfTtm+yyvYEQLZq7ygzrLax
         uhk3PwjegUKYtD9HfqGHoLz2N1l+lBtd/82MXC7T39KAink0dpxWK8q0V+o75Bz6ijTg
         VQELl51GdcI6SVg266nyjrsOigDblcjUYU/UG48jNjSZGpYeMgUzogjETeYNI8OXS9ws
         bzBYIx32n/T5T2bFM/Cb5T+T45cBCLIOP22bxe37CEx/vLAW5+ETfsOQhYNDt5YYlW+o
         duEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cQiBvBGnEPCfXvDLlcXYmYRETtwubP2zncCLn7n+qro=;
        b=KGZKgIJsqhZ09Y15vtZKV85B+aRouZxU2XwmQ7fR4Mpj7SKUXkRBYR2hjlmJziZuGv
         krGlWxjhXK2nWIy6O191WJnwJDSAq68KB47Kjtu5kQnjHxPYq0gZ3WRyXMKA+QLZhMZQ
         AFA2sznrqMDlXd1gqevT9Os1xSFGoVu45BnYudNGkjD18l/S8axD3FD9gYqQ/Koj6gyh
         Mxgf0LW2mNwlxyUeYs4BcfNCkXRmgT+Wz+xeDmqOLddW2twb+Sb4M7oiGqwzBgclUFM2
         jcaiTdT4rfmacqWq/jcyKeIl9a+XGV6+9mst306LtwBIiIDpt0mAyrrujjezx0Q0nX33
         aEkA==
X-Gm-Message-State: AOAM5335WfedoAiG5KjEuGm+HZmW97O9Kz9W2rl3oT3oTMPKVP9ef25j
        hKx/q7XuBBESCTSyfndKAQy+3Q==
X-Google-Smtp-Source: ABdhPJxVQH9E7yz/g9mCKCmuf6kL2CneZmZwGC42RiuDWq3ME4fXeUoxutDqT538V/wUc8tO54qLtA==
X-Received: by 2002:adf:e34f:: with SMTP id n15mr14838333wrj.224.1616769325875;
        Fri, 26 Mar 2021 07:35:25 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id j26sm12878225wrh.57.2021.03.26.07.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 07:35:25 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH 23/25] HID: hid-sensor-hub: Move 'hsdev' description to correct struct definition
Date:   Fri, 26 Mar 2021 14:34:56 +0000
Message-Id: <20210326143458.508959-25-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326143458.508959-1-lee.jones@linaro.org>
References: <20210326143458.508959-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/hid/hid-sensor-hub.c:54: warning: Function parameter or member 'hsdev' not described in 'hid_sensor_hub_callbacks_list'

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Cc: linux-iio@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/hid/hid-sensor-hub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 36b6852f75dd5..95cf88f3bafb9 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -18,7 +18,6 @@
 
 /**
  * struct sensor_hub_data - Hold a instance data for a HID hub device
- * @hsdev:		Stored hid instance for current hub device.
  * @mutex:		Mutex to serialize synchronous request.
  * @lock:		Spin lock to protect pending request structure.
  * @dyn_callback_list:	Holds callback function
@@ -41,6 +40,7 @@ struct sensor_hub_data {
  * struct hid_sensor_hub_callbacks_list - Stores callback list
  * @list:		list head.
  * @usage_id:		usage id for a physical device.
+ * @hsdev:		Stored hid instance for current hub device.
  * @usage_callback:	Stores registered callback functions.
  * @priv:		Private data for a physical device.
  */
-- 
2.27.0

