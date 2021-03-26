Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26C434AB0D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhCZPMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbhCZPL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:11:29 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D16C0613B3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:11:29 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id f19so5727018ion.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ON7mTEa9Z5iycj+8Dq01c6t5kdr65s/3oEf4V/BNG54=;
        b=uSytPxU0fioXBXMUp74Lq1wYb48z4DVbO8EaBufLVXSI3G3ZySDuz4Nd16MiOnPVff
         /87vuHuWCfn/wcX3RoqnBnunpudy1P3D46oHVsXzgqXglJRz1hj3t1S/gKj5Rirwq/r8
         dodflE51CWocOj+jxPtxq/b5qW51EQZ9jIcOiMljQF37ymvUIY9MH4HctmV/8O1PaiXr
         aVuuVJk6nUYvT4nksgYiPkbhBwzB4z+gqGQ+Pq0O1+9vb0MzcPsAkaXOrDHXdS5nY884
         czM3u2//HNtlB1KPqJCu3oNk2S2yfNAz6PaSZ41ulA7IjoAzlFC3i/IyxViyek92PHpX
         Pfgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ON7mTEa9Z5iycj+8Dq01c6t5kdr65s/3oEf4V/BNG54=;
        b=PweC+1o4Aa1XNKKtZUoSYoJNxDGQkG/hdfTE3WGKLHlaUM1hq+XS7XDCBnsspGPTYq
         R366dyi6aBgkVbod5s9HgX1pFkkxPde7/ngJ8HTxLkVEFwUC4LpoWqy/z/iJDkZodHdf
         cWOWQe0fqVjldPxPPH/XlwP7l/gVRTxhSzSG+pLOMOVgOdJO/jeh8+vz1c3buvdv8oF7
         ODosZ2O4QLe7FSJMRRfVqfrm+yLoV66P36Y9cMkRNFGlF9cLi6e4bEq/UkxbDg/zbcs4
         Zw/I1diwqUZM/6+GaukP6yUnAUQ+st6Y8j8WazrIIdTR2wwOlm9tGv64SvVtYoOkgul/
         uJ4w==
X-Gm-Message-State: AOAM531c0mfeOG1u9Qjw2BxzH9gZz0zsYusFlvo2MS5F8z2Fxrz2cEYE
        7HqCDJYMCMe/CCS2Oy8/KsRIFA==
X-Google-Smtp-Source: ABdhPJzn1lAqd0prqLfqrIR8jHc/0onwvuVfk00mxzIYCqKvG0JEWDs2HAQhYwHwu+zh3I2RV7rV1A==
X-Received: by 2002:a05:6638:35ab:: with SMTP id v43mr12347521jal.65.1616771488582;
        Fri, 26 Mar 2021 08:11:28 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id j17sm4537706iok.37.2021.03.26.08.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 08:11:28 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 02/12] net: ipa: fix bug in resource group limit programming
Date:   Fri, 26 Mar 2021 10:11:12 -0500
Message-Id: <20210326151122.3121383-3-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326151122.3121383-1-elder@linaro.org>
References: <20210326151122.3121383-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the number of resource groups supported by the hardware is less
than a certain number, we return early in ipa_resource_config_src()
and ipa_resource_config_dst() (to avoid programming resource limits
for non-existent groups).

Unfortunately, these checks are off by one.  Fix this problem in the
four places it occurs.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_resource.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ipa/ipa_resource.c b/drivers/net/ipa/ipa_resource.c
index 2f0f2dca36785..edd9d1e5cbb62 100644
--- a/drivers/net/ipa/ipa_resource.c
+++ b/drivers/net/ipa/ipa_resource.c
@@ -139,14 +139,14 @@ static void ipa_resource_config_src(struct ipa *ipa,
 	ylimits = group_count == 1 ? NULL : &resource->limits[1];
 	ipa_resource_config_common(ipa, offset, &resource->limits[0], ylimits);
 
-	if (group_count < 2)
+	if (group_count < 3)
 		return;
 
 	offset = IPA_REG_SRC_RSRC_GRP_23_RSRC_TYPE_N_OFFSET(resource->type);
 	ylimits = group_count == 3 ? NULL : &resource->limits[3];
 	ipa_resource_config_common(ipa, offset, &resource->limits[2], ylimits);
 
-	if (group_count < 4)
+	if (group_count < 5)
 		return;
 
 	offset = IPA_REG_SRC_RSRC_GRP_45_RSRC_TYPE_N_OFFSET(resource->type);
@@ -165,14 +165,14 @@ static void ipa_resource_config_dst(struct ipa *ipa,
 	ylimits = group_count == 1 ? NULL : &resource->limits[1];
 	ipa_resource_config_common(ipa, offset, &resource->limits[0], ylimits);
 
-	if (group_count < 2)
+	if (group_count < 3)
 		return;
 
 	offset = IPA_REG_DST_RSRC_GRP_23_RSRC_TYPE_N_OFFSET(resource->type);
 	ylimits = group_count == 3 ? NULL : &resource->limits[3];
 	ipa_resource_config_common(ipa, offset, &resource->limits[2], ylimits);
 
-	if (group_count < 4)
+	if (group_count < 5)
 		return;
 
 	offset = IPA_REG_DST_RSRC_GRP_45_RSRC_TYPE_N_OFFSET(resource->type);
-- 
2.27.0

