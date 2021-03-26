Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B8634AA0B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhCZOgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbhCZOfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:35:11 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9CEC0613B8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:35:10 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id z6-20020a1c4c060000b029010f13694ba2so3100522wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FY6S2XOQI5BNN866n3675udEzH1TqJJkuTkGcMouhCM=;
        b=ia2sZt4iVeYOTP2LfQDVWQBZ/6HWewnM0yGBM2AU/4Pe0UtMK3nKZOc2gJEAVvAe15
         qxhmfAC5pnU8Igr7U378tRR5M2RYwb0glErGgfG4NdynYb1/Z+xjR6rLUTxjAxCQAuQk
         dxa8M/YjOjm3htK9a9ZMYcrbjy8nItZ60SuRclkwaTA40xwNQRA90KfJdI5pgekLL/Is
         5kGQpKXDhc8gQuLZlH6vMOGnNCLK3piGeE8MLG3zLLgDcIOT+puo1Cb9aTIeIjW5UGhL
         3s71rMR8Av/MZa+nFKflF0/QFhR/4hOtBW12sm9KI8VhJ4yGhc6Ueh6JUp3xWl0l/y9r
         jwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FY6S2XOQI5BNN866n3675udEzH1TqJJkuTkGcMouhCM=;
        b=fk5yu6KXZwh6aopY+f5eu6HFAbR5JiBgOMVG/vNj2MFnUktbeS1h9KMDTWVvhmkXYP
         M/3x+JwmgD/r6K7YOjMlnj+g/HjHvdVrV9omsTeUrGPawEhD597kMskY8rTtnztLgJxL
         +HFXY81VYBbEzscInrYdHFH5jz7StmNZFTZO1c25SALK5tlHEAoKu8h1pL+P8OvKzhXw
         nHQeK9kFIy20I/62Aqlp+eniuH2PtoGXWSImCiieF11pME1VMV/+NoN0UKnM8SrFuSgL
         FbgehZMhYaBKPoefw2x3uMbqRLHr/pKkrI4S3B1p7h3xR0pDrXvSOj29NndGppouhA4R
         LB/w==
X-Gm-Message-State: AOAM532/GBFhs1xIzjyt4fAUd/9uEPbORVNZp+hEFGwzeAvK0O15qo/N
        P4SyAP0DDTdF8O153OnbP0HzEA==
X-Google-Smtp-Source: ABdhPJwIv3+vhzC+cqzxmfce1IJXzerLfzCwAC57Y2r1nGVwi5Jy41HJ5CoXVxpufIS6PnJBE9X+QA==
X-Received: by 2002:a05:600c:4d95:: with SMTP id v21mr2766752wmp.184.1616769309158;
        Fri, 26 Mar 2021 07:35:09 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id j26sm12878225wrh.57.2021.03.26.07.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 07:35:08 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 07/25] HID: intel-ish-hid: Fix a little doc-rot
Date:   Fri, 26 Mar 2021 14:34:40 +0000
Message-Id: <20210326143458.508959-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326143458.508959-1-lee.jones@linaro.org>
References: <20210326143458.508959-1-lee.jones@linaro.org>
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
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
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

