Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D767347F89
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 18:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237347AbhCXRev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 13:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237240AbhCXReR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:34:17 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A20CC0613DE
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:34:16 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id bf3so28605088edb.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hkSdOt3A8I2Fl/7qWj25aivbAO5QAKQ9HatKpk+E2jU=;
        b=r4NVGvRoC9XVcVeanMTdxp0FAJKtWFQXEPwv4kHm5tjVuVBSyDHj3QivdYQWMF0tq8
         dtdHKWEuMJJAvdRNeFcVBoIAbg+JYx6gXTlfzFK7JY4SlM9TznIcT3sQgWz4a0hxcify
         oO2RlpOJlbLOxc/fpjQqH7gqZ9N9xgfYqCn/LuqDct4CPbIvAFPgtvgHk1VFaGD42B7i
         eOHQbOoKn2hBOtHW6Vfnaiw4KeRTDPzx+ieq0nhTUsphHXXAlSUcCR8hQNyp+GlClgXJ
         BIeXDhqE9qltMwMDLmyQiUAfcSrDob94Oewr7j8BA2HC5oZYong8c5AKFSPtc4RuMBKh
         sGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hkSdOt3A8I2Fl/7qWj25aivbAO5QAKQ9HatKpk+E2jU=;
        b=JMtVKJm5qKnTF0MMi5lK8yvVZ6y+CFeeCIawMXaUt/+pytua/jIkgWR9IQs/MHlZpT
         0RZm8SWK1OR6es2l3hk16aMIAqgeJU0LG3nwwLp9CoZ9e6taUlL5n2kNfhzF3Dooyp5c
         /iLyPI4Nd94G4KlkYz4u3vXvxkFkKcfSNdKxXAufdoVkjwHualSQiM1F19ssr8L8hGnO
         C98GWly48MVy12vRVJmNLLTtj8GaDN+SyBZU58XlXjLU3XzdpcWeGn+Dv9khSv+Sb/d+
         XhPUowIxKNU8pZOI6QA6sveM0JqG9Kz/yAHmvWCLBW/hYEJgfzeWPqIvlLeGCqTAUsr7
         q2Eg==
X-Gm-Message-State: AOAM53108ceyU2uamnWsudDI05VQam/75Exje+bSTMxjhURr0A2pbPMr
        JdnvFiLMyIcrfN4gyu+PmUWvgg==
X-Google-Smtp-Source: ABdhPJzhsZ6kPNHj3Ti0TayNFxlvxcAyRChykT0uVkzBwnmqmHXKhV/PDQE3vF9jU+xnd0x29VyIRQ==
X-Received: by 2002:a05:6402:c0f:: with SMTP id co15mr4579118edb.373.1616607255355;
        Wed, 24 Mar 2021 10:34:15 -0700 (PDT)
Received: from dell.default ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id p19sm1466367edr.57.2021.03.24.10.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 10:34:14 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 07/25] HID: intel-ish-hid: Fix a little doc-rot
Date:   Wed, 24 Mar 2021 17:33:46 +0000
Message-Id: <20210324173404.66340-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210324173404.66340-1-lee.jones@linaro.org>
References: <20210324173404.66340-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/hid/intel-ish-hid/ishtp/client.c:121: warning: Function parameter or member 'cl_device' not described in 'ishtp_cl_allocate'
 drivers/hid/intel-ish-hid/ishtp/client.c:121: warning: Excess function parameter 'dev' description in 'ishtp_cl_allocate'

Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/hid/intel-ish-hid/ishtp/client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp/client.c b/drivers/hid/intel-ish-hid/ishtp/client.c
index c81a1f8a92685..585a5c4066cb3 100644
--- a/drivers/hid/intel-ish-hid/ishtp/client.c
+++ b/drivers/hid/intel-ish-hid/ishtp/client.c
@@ -111,7 +111,7 @@ static void ishtp_cl_init(struct ishtp_cl *cl, struct ishtp_device *dev)
 
 /**
  * ishtp_cl_allocate() - allocates client structure and sets it up.
- * @dev: ishtp device
+ * @cl_device: ishtp client device
  *
  * Allocate memory for new client device and call to initialize each field.
  *
-- 
2.27.0

