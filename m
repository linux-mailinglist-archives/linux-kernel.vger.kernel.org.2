Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88E93426C4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 21:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhCSUXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 16:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhCSUX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 16:23:28 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43107C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 13:23:28 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id 61so10324201wrm.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 13:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=44KsTqzi5W4F/LKdf/AcJLY9ExD+NYSEObPt4n6POTs=;
        b=vZPkGxaMNuCSL6+mP/HGTfTS0T6fQGDBB3BJOWuuMrBfJepf5D9OjvMaNjE78X4TOQ
         nKVjYLRqtLQOkWU1fNP0n9uZvo0QpfWtWodm+AiNIjXze+AQe3oT5YncUd/i2lL3gk+B
         g2HhwTguIWXYhbwGsRyK29HIsfSOEy9+hMTJv15gVqDbRaaQuCbnZPcRqDbSuTG18MbO
         KakSz8FHnqjix72PKlSmcL02EVM9g6If+zyw5FKh+B2xttXVkHQnaLaT2n27NjY8LFr5
         SC/EyRs5e28eO1dw1ZRziO4izlrgUyT5jnK6ocQj97qIb5/0o7jvdl/QpO0vl7kHYvyr
         QlpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=44KsTqzi5W4F/LKdf/AcJLY9ExD+NYSEObPt4n6POTs=;
        b=XHG0EYhlBY/sSXK9HZjTyWnNOZ0iK3sTAmkRAtszlGbBZKcGRLqP23r76kjq+XjDMF
         S4zXNpc3mHysA/C1ROxQi7YRsHd6mDPdJKmoP5LmQVR27wEsovDjLtN7X2tnhIMRV4Y/
         hdchODglk9Wj01g3vueec8O1ZqCckUWxgM9qHqjimvUV4Mb1LFXtxDPenflUVvL4jb++
         t4U/ThwaTdWXPrTA6wzjU5MzGzsyINNhBKMOdsGq7ijAZo9jxxxeOY+a6QkCOXmy/jP8
         0Y/xl39Vf7zsOKDXBgX1IyqsftbxMpNPmCR5ykCA0ikxhC5ycHkgfRJXWzjw7D7uMCe+
         fA7g==
X-Gm-Message-State: AOAM5325+3vNTbTs6iFEXkTkt7Av4SckJbjaoGKp2iticUA5vZRVGjFA
        te7RyfJ/6MjY/qT4qx/VZgCooQ==
X-Google-Smtp-Source: ABdhPJx8J41wuNIe0b18P/OW8/B3NbsSvYKNT2EUw+637iMhWKuMgYQNBEdbsZdXK24jOhkjDdc6mg==
X-Received: by 2002:adf:eec9:: with SMTP id a9mr6403333wrp.252.1616185406849;
        Fri, 19 Mar 2021 13:23:26 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:ddd7:1eb:a66:7a85])
        by smtp.gmail.com with ESMTPSA id g11sm9505524wrw.89.2021.03.19.13.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 13:23:26 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] thermal: core: Fix memory leak in the error path
Date:   Fri, 19 Mar 2021 21:22:57 +0100
Message-Id: <20210319202257.890848-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210317142215.GA2087@kadam>
References: <20210317142215.GA2087@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following error:

 smatch warnings:
 drivers/thermal/thermal_core.c:1020 __thermal_cooling_device_register() warn: possible memory leak of 'cdev'

by freeing the cdev when exiting the function in the error path.

Fixes: 584837618100 ("thermal/drivers/core: Use a char pointer for the cooling device name")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index c8d4010940ef..3566fd291399 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1017,6 +1017,7 @@ __thermal_cooling_device_register(struct device_node *np,
 out_ida_remove:
 	ida_simple_remove(&thermal_cdev_ida, cdev->id);
 out_kfree_cdev:
+	kfree(cdev);
 	return ERR_PTR(ret);
 }
 
-- 
2.25.1

