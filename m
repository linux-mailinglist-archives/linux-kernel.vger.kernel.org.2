Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B801339120F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbhEZIMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbhEZIM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:12:26 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44530C06138B
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:10:54 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id n4so102008wrw.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QalgDLxIe/g/hTvvzl8xtwoLxem9VEdCVSmBFAk4KWI=;
        b=QS0yg/qQ6lEc1SwIeywM3XroTH1sTb43NALJP8LwG8O8e0m9ZUl4paE+IjwiEEndB0
         5CwoTTwIXuPrXIBS2CJNO/p80DZbgwYPHtWf5l/hVKL1d4qczuCZl6fdVvBMg7nV0OVd
         GKkzmMVf6efxp1hH22YlDTPQb7OYmroy/reNQJA8PMFMPP2sBpOn/hD7jBJic96WKN0N
         Er6B3h3LH4qfjlG6lsPFcs5x3zVdw0CNYjqIN2cZkwdwXC3O/Sa3BGCwr6CI6UGhCR73
         WvDrmP8SQnaur8ycam0z8OfFWSgPhza7hzSdrT3ReZz82ksUub2zyq3CWloXb1fr9Ghv
         x3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QalgDLxIe/g/hTvvzl8xtwoLxem9VEdCVSmBFAk4KWI=;
        b=pVxOFRC/evxcLg79JEE5xaXxBOpqup9Y30OGjxoL0RvDs26agq580ZAeOiuca/Zc35
         ikDygjWNnx/xbFSBdQGQYlGnaVpTqnSs2Z1dGriZ+KOTwhDQGCYvuGOcX6E2qnlNMMLx
         1QdQb0ZwAbVmgegpV3984QHVJxMUASTwDuEnVManTzRJ/58qB2zhiy4+1P8MNHX1P+ub
         gU3eDTtaeqvSaNKzk0qNXWjupF9sSqHHFuU+gpueq9jyxT32tRv/kxoQI/xk9hL9TpT/
         iK1R5exsPPlQU1QlZeZpOtDQlqhWAgb9R8seHG7rE+7GoWrwdbq8I7C+Txjj9T2k6/Hm
         SWIA==
X-Gm-Message-State: AOAM532Xsi8r9joavQ6etR+NIx+lj/2k4zbtMflEHokXLPGOgwxMLqvg
        vve+6RjpvpZbah8A+YqZN6JGm9DwbDRfWQ==
X-Google-Smtp-Source: ABdhPJxKp/nuBns7h8mzFi6UjTt+3vkXBFVgZFeXkoOvM3KduN0Yay+0l2Omszk9emT2GcyL9ibWGw==
X-Received: by 2002:a05:6000:52:: with SMTP id k18mr31210738wrx.419.1622016652758;
        Wed, 26 May 2021 01:10:52 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id v11sm22628319wrs.9.2021.05.26.01.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:10:52 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 07/10] bus: qcom-ebi2: Fix incorrect documentation for '{slow,fast}_cfg'
Date:   Wed, 26 May 2021 09:10:35 +0100
Message-Id: <20210526081038.544942-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526081038.544942-1-lee.jones@linaro.org>
References: <20210526081038.544942-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/bus/qcom-ebi2.c:112: warning: Function parameter or member 'slow_cfg' not described in 'cs_data'
 drivers/bus/qcom-ebi2.c:112: warning: Function parameter or member 'fast_cfg' not described in 'cs_data'

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/bus/qcom-ebi2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/qcom-ebi2.c b/drivers/bus/qcom-ebi2.c
index 0b8f53a688b8a..663c827492223 100644
--- a/drivers/bus/qcom-ebi2.c
+++ b/drivers/bus/qcom-ebi2.c
@@ -102,8 +102,8 @@
 /**
  * struct cs_data - struct with info on a chipselect setting
  * @enable_mask: mask to enable the chipselect in the EBI2 config
- * @slow_cfg0: offset to XMEMC slow CS config
- * @fast_cfg1: offset to XMEMC fast CS config
+ * @slow_cfg: offset to XMEMC slow CS config
+ * @fast_cfg: offset to XMEMC fast CS config
  */
 struct cs_data {
 	u32 enable_mask;
-- 
2.31.1

