Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47FE9347F94
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 18:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237043AbhCXRfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 13:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237277AbhCXRec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:34:32 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7095C0613DE
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:34:19 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id w3so34249938ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0mHXiyIAT3Jh+7rnIdNGX8xbXKM1ZM1Cw7hVW7vTCR8=;
        b=Np7Gqczcop2BAEOd5KsbvKOQIFPBBvyW4fHzsHJIWw9CZVh9CHsbDZVXATtKxFQe4X
         FCZOLULtAcRCBn9wftuKxPYlPRKKw3AuTm9e+FyvheDqQp0XkO6yJ25C2UFNL/PDJ145
         2jx08WTp3s4SVB4VLDqFw+tSEshmMWlPQbe2T6IZCaiiYIxSKRuSaglF2LlJgyr0MCCE
         tED9Y59bYKPKBFa4fqdIDsNMAzpV9/JPPJnoLYkkWd4eF3tTznwA80sgSoRToN2GQEB7
         rScsTfTymhFL6z29hJ+RiLjIA89Flk0EfnncTjR01q2TBpEMYZYMWHZW2i18oSTqkq/c
         yOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0mHXiyIAT3Jh+7rnIdNGX8xbXKM1ZM1Cw7hVW7vTCR8=;
        b=Bv418W0pA22kYFYU7j7Mn0s0tiE21ZEjK6mKlhLPjNrXDr+QfmGjgXS+7cINW5BvZD
         +Pht8LmXDLIHr+0Q4fK/KT2peDJB8GuTdfSIeptPVvAUqgcPNWRi0ejKmiqnWpDKKfvt
         X46xzSIxIjPkvbh2604g43AKub41pOsei6kJTDpSi0PN7ricuQXTQ+veurPKSGtyhUZs
         FtAMzUY76qIDDjKBqw/W6ObRlMIwvZVl+smsxMOtn5urCUMX9ZFdNBaN6hHNSAibYPD5
         TwxoQJdCTaTZLaaApZXCrBhogKBJKUNXe+5f0HWDtS4YyVd+u6IZVeuu2LIhfzBOQJyi
         vRNg==
X-Gm-Message-State: AOAM53057u3QC8k4OcZdS7SCEKYSVan7JT8INx7Nn0VLFCXVgBeDnKF0
        JCIeKDMxZ1UZT87UpFxMV75PVw==
X-Google-Smtp-Source: ABdhPJweP98nVFVaq6z1Lu6W/z3sWDeNKQ9W/fuGYpW716/w8Y+LTsbEFyB1kmzbGXH/ejLGt9anwQ==
X-Received: by 2002:a17:906:9bc5:: with SMTP id de5mr5019149ejc.284.1616607258539;
        Wed, 24 Mar 2021 10:34:18 -0700 (PDT)
Received: from dell.default ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id p19sm1466367edr.57.2021.03.24.10.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 10:34:18 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 10/25] HID: intel-ish-hid: Fix potential copy/paste error
Date:   Wed, 24 Mar 2021 17:33:49 +0000
Message-Id: <20210324173404.66340-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210324173404.66340-1-lee.jones@linaro.org>
References: <20210324173404.66340-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/hid/intel-ish-hid/ishtp-hid.c:11:
 drivers/hid/intel-ish-hid/ishtp-hid.c:263: warning: expecting prototype for ishtp_hid_probe(). Prototype was for ishtp_hid_remove() instead

Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/hid/intel-ish-hid/ishtp-hid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid.c b/drivers/hid/intel-ish-hid/ishtp-hid.c
index 393bed0abee99..14c271d7d8a94 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid.c
@@ -254,7 +254,7 @@ int ishtp_hid_probe(unsigned int cur_hid_dev,
 }
 
 /**
- * ishtp_hid_probe() - Remove registered hid device
+ * ishtp_hid_remove() - Remove registered hid device
  * @client_data:	client data pointer
  *
  * This function is used to destroy allocatd HID device.
-- 
2.27.0

