Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F8C305A12
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236964AbhA0Lls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236802AbhA0LbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:31:23 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A0EC061223
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 03:26:14 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id m13so1484726wro.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 03:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bv5N/W3oq+FZm8qEBRC53aadCUOUoa7ywZlmGmPMg74=;
        b=NK2TtYcdpOgyLLkQQic5gvtjp3/8VGKQr5GZThUNTjyAfO1pmjo7MWJNPtXgzp1KIO
         CH/gxQzwk618UaXMef+p+VpwV1+QCL7qpDSmAyPucEumV1UqiaH7DTDaqgKHXTvsrUuq
         ZUV2LNHehwRytkJXIroTKPhKVxMIngXvRJfqY/Wrg5MAML2J4nVbAAoxUBrB5mRfqGUS
         +M5GjKENRT4PYmWk32VwYzjagB4eh9lvBW2p+NjtmmLlIWF1zDnthz+zIGboKEoFARXI
         H9zMDaWg2I/bBlN5rCXNsQbgDte/Vr1K57tlWuH+JI4XrfgQYSwMz8vPtcQZqu1PXzvf
         WQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bv5N/W3oq+FZm8qEBRC53aadCUOUoa7ywZlmGmPMg74=;
        b=QGdjreI2CqlcpsyW5KdeiTi+OVa3v7j2tcCe9zNHPa1MXjEhyiOEJzjRqxVRJzkA9M
         0E+a88rLU+ougRF+V2ODFUL+BXiM/MxLpK+2bUjpQUvbDcEIQt0zcL1314MuC/EgRqyE
         JPl1CPn3TxpFFNF2fKNepq11cJAJ/4f72Li651O4jAB6rtEzDSVZNKw8qtHHRGKVLBs5
         A89/DVHl1P7QjakJclExcS8894+QsWMX8fsifHFEDo9iZCzViYIdIZItOcLcF7BqGWMK
         /EYNW7Hf4BCfuAi74XDRRAq5eZDW4PD3GSM+IMHCNhSIc/fKmKaqwFl5stbbxcWSP2O4
         3qsw==
X-Gm-Message-State: AOAM533MrTIQ5GnRmvaA2PaVHN60N/HQYF2YQe8FnCiEPnTd1qYv95sm
        3xCXii+mEgUPHIt3eRDMmMKaSA==
X-Google-Smtp-Source: ABdhPJybnAUfr55viAi3nE368goiE4XSTFzPj50nTPATCsP9WDIBu1EsnC6PAvP3slyBbDvstAJUXg==
X-Received: by 2002:adf:f8c1:: with SMTP id f1mr10664387wrq.76.1611746773216;
        Wed, 27 Jan 2021 03:26:13 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id m2sm2040065wml.34.2021.01.27.03.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 03:26:12 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH 12/12] thunderbolt: swit: Fix function name in the header
Date:   Wed, 27 Jan 2021 11:25:54 +0000
Message-Id: <20210127112554.3770172-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210127112554.3770172-1-lee.jones@linaro.org>
References: <20210127112554.3770172-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/thunderbolt/switch.c:1322: warning: expecting prototype for reset_switch(). Prototype was for tb_switch_reset() instead

Cc: Andreas Noever <andreas.noever@gmail.com>
Cc: Michael Jamet <michael.jamet@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/thunderbolt/switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index ce1b120d1cd46..6a3d5608431f6 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1313,7 +1313,7 @@ static void tb_dump_switch(const struct tb *tb, const struct tb_switch *sw)
 }
 
 /**
- * reset_switch() - reconfigure route, enable and send TB_CFG_PKG_RESET
+ * tb_switch_reset() - reconfigure route, enable and send TB_CFG_PKG_RESET
  * @sw: Switch to reset
  *
  * Return: Returns 0 on success or an error code on failure.
-- 
2.25.1

