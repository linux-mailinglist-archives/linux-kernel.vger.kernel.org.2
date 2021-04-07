Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41ADD357146
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 18:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354027AbhDGQAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 12:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353990AbhDGQAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 12:00:21 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1628C061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 09:00:11 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id m11so10574937pfc.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 09:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ozroWOawqnjXu9cPVP1M7cQjlG3EKoA57RnBxtQAZc=;
        b=SviGHM0K3PoUiJnqVmy9gj5Uy/yhlvRSZUuFgVW4w1YfrJ6H6nw+0YLTyGBwBIlTwj
         BrgI4BDHxmKM5sK7nwi/7KIVZ5bh7xfsBkyEqLeavcFkrJpZnRXErpu5hMsgPuCZrLqk
         LRlCv8liWrX0MIfR8o8chorvtbj62hlUKRuTGHJICPXxt5Cj6Iy3HGd5hNi/EMq88Adm
         BwVqZuJOKPk0choDKxdv8tl4IvOQAnqANy0nO4jEmmlIk/u8SPOeltcyjCYTMbFuUBjQ
         eKsjz/DuOzx/h9TfmdVnK9vpGQm3/wJ3fj8EobaB6pY7xVmL6j1tFLtSjtTHdVunEdmQ
         Wfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ozroWOawqnjXu9cPVP1M7cQjlG3EKoA57RnBxtQAZc=;
        b=ibgyycgVxp+ChlmsOf6XVSgz5axSW9MaUClO2tWbzBBZdWW9QDN/haPVfuRJJxnf+I
         SI1YweAyXpJQOnR/72MGAzRKXIyhDyHEn1FQ6K/j/OW7jGn2MPc8ZQEyPy4I+ogymTww
         wlVe1p72WtCfCDwkyOLutrS2Iv2ASHfMt8/y5TZYTwGIpwNMGhSyG+kjArXubX67zQdT
         cFUgk+DG61xrFueTNtuB1xVSnC7oYYf9yfSnfRAWmmSwwdDzwMc+z9QAEFwNTq5Hkfe/
         0lKfvbdGvaVyPy+Xu2N/mYPkvMks0oE8r6PE31XRwEZRIh8ppOa3zzAkWb6jVvcLfY/M
         AwAw==
X-Gm-Message-State: AOAM532WsdZ1dETqETue7Y5lHLEGL6zNW6tX3OWeBP5/zVll1KpWfsz1
        xibkM+h47Tb0Qwfiemznz2gG1Crex8Yv+Q==
X-Google-Smtp-Source: ABdhPJzzreQC5NXDrH0S4ktBi3zIx7jgeq0DaQ5JwtOMd9v5UPDZRri/pjHHt2EGuZn7R5aq8Kdukg==
X-Received: by 2002:a63:2ec7:: with SMTP id u190mr3980498pgu.18.1617811211279;
        Wed, 07 Apr 2021 09:00:11 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id s22sm21464713pfe.150.2021.04.07.09.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 09:00:11 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] coresight: core: Fix typo in coresight-core.c
Date:   Wed,  7 Apr 2021 10:00:06 -0600
Message-Id: <20210407160007.418053-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210407160007.418053-1-mathieu.poirier@linaro.org>
References: <20210407160007.418053-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qi Liu <liuqi115@huawei.com>

Fix the following checkpatch warning:
WARNING: 'compoment' may be misspelled - perhaps 'component'?

Link: https://lore.kernel.org/r/1616487086-50418-1-git-send-email-liuqi115@huawei.com
Signed-off-by: Qi Liu <liuqi115@huawei.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 0062c8935653..b57bea167102 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -86,7 +86,7 @@ static int coresight_id_match(struct device *dev, void *data)
 	    i_csdev->type != CORESIGHT_DEV_TYPE_SOURCE)
 		return 0;
 
-	/* Get the source ID for both compoment */
+	/* Get the source ID for both components */
 	trace_id = source_ops(csdev)->trace_id(csdev);
 	i_trace_id = source_ops(i_csdev)->trace_id(i_csdev);
 
-- 
2.25.1

