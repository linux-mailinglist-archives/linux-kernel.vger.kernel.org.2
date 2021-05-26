Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D5539184D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 15:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbhEZNC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 09:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbhEZNCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 09:02:21 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48E5C061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 06:00:48 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x7so1009483wrt.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 06:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MphP17EX0/AXLtalAEYhX110xpkS7WBUGIWjY7Ufvo4=;
        b=kl7yRD7q2idFGBdau1DMeBezfOEIHpuwjbQEY8GKGot9XFdDoFo+U40D/+mMYsZeJS
         +W/V2dBsLSAdkJeZCzHwx2z3PaXdCVB+0osyMldD94IJVG8oxn6vUGdPYH05FuakaGHy
         Du3HGAkhISQmmrVREW45mhlvHLy09ADQOsTfWwsbiKyq33jNsNQmmhOE+XCEc1jSMGSz
         lgpvHyc1yc1k02Fp2zLGCcq0gL4Sr+xn0sxjVt7BhApp/LGjph/S8LfAwl4ulpGoVxMP
         wwCQt6YyIh4YYtIakigw91e9a9rtbdxQD548mLXJwl1LYoy5wrHJD20q1Xl2a07tLHIi
         CnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MphP17EX0/AXLtalAEYhX110xpkS7WBUGIWjY7Ufvo4=;
        b=FINt6NUCwh/Uhyf7oWw8OeP+/81LEH6Md2cU3wQyS9MLBVUnw7ZamcrSsrOP8IxSOI
         PS/VwYYq4aHznhVQ8Pq2RDsTMWNtrcUyR7LW+ZQGyWNzDWLNrxdmSYa5aYAGpoz/0cyD
         O9KolkZkb/9ffc40BU07AjOx27t2Gl8iy45oc9tYHb3sNFe4YMHpPkwjJYSO6i96tGcV
         Idn58s1DSa+5gGnYoxz007UEsakKFqDe5nWz7VPU15n+wmPjmtzA0Zd8HUhYIMjev/8b
         ELqc/N7S0ecD9RhJNR5Tfyzheosbu/GvbLBvqnxkDwysOxj5fDDkJRaiXnFbCc+qxCzh
         UqSw==
X-Gm-Message-State: AOAM531XPOkLRF0O8dvijLd8wE44bxtwtdb7/g33uh6U9xF5wsZBuy4n
        wJBnLupbaoh3V3eNS+dAFwJsvw==
X-Google-Smtp-Source: ABdhPJzWHzzkAvsiM2AEM+7p7YrLBxGJx848Nmp7flT0Iqd/5b2/jLrudbpEW8UnYEKpyQxhv+uOyQ==
X-Received: by 2002:a5d:4b89:: with SMTP id b9mr32545288wrt.238.1622034047197;
        Wed, 26 May 2021 06:00:47 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id y14sm6430036wmj.37.2021.05.26.06.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 06:00:46 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH 01/24] usb: cdns3: core: Fix a couple of incorrectly documented function names
Date:   Wed, 26 May 2021 14:00:14 +0100
Message-Id: <20210526130037.856068-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526130037.856068-1-lee.jones@linaro.org>
References: <20210526130037.856068-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/usb/cdns3/core.c:342: warning: expecting prototype for cdsn3_role_get(). Prototype was for cdns_role_get() instead
 drivers/usb/cdns3/core.c:428: warning: expecting prototype for cdns_probe(). Prototype was for cdns_init() instead

Cc: Peter Chen <peter.chen@kernel.org>
Cc: Pawel Laszczak <pawell@cadence.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Aswath Govindraju <a-govindraju@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/cdns3/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index bb739d88179ff..dbcdf3b24b477 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -332,7 +332,7 @@ int cdns_hw_role_switch(struct cdns *cdns)
 }
 
 /**
- * cdsn3_role_get - get current role of controller.
+ * cdns_role_get - get current role of controller.
  *
  * @sw: pointer to USB role switch structure
  *
@@ -419,7 +419,7 @@ static irqreturn_t cdns_wakeup_irq(int irq, void *data)
 }
 
 /**
- * cdns_probe - probe for cdns3/cdnsp core device
+ * cdns_init - probe for cdns3/cdnsp core device
  * @cdns: Pointer to cdns structure.
  *
  * Returns 0 on success otherwise negative errno
-- 
2.31.1

