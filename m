Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4947E338900
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbhCLJsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbhCLJr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:47:58 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8235EC061764
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:47:57 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u16so4437058wrt.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c3yETdlK+zH07H8Lti8BgEvatH4uXRXgxfelJOoauw4=;
        b=gMeUlVmnT/5zFV9SxPaKYVCNJl29Wo3kd0S6O6UvwKxmA71n4hKbSuv0yrt6e4KnSx
         fR+tAXm9SPDB0SFqNona7VDk3B3p3LovUnPAXY+fLrP007ZJ8KP4CRilv6XTJ0BjPgGi
         UwC22kVYaaVbIiWSZoBhJi1Gc+Dtms2P7dqly+txc9g0V+vX+zz6uSTJX0HeOiYjTSPV
         Op5mo+mgc9zN6VEdMu/T2z/pu+KgC1wzgmaTsj2KVA5xkp+wUWOGuN1JQMgH45LnE30+
         mT0pmSu8aKc4FXnw2DYwS5xFBSOymKpvGFVH7hU98IVFuwrexflYz+x2M6PfIKrur/bS
         O3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c3yETdlK+zH07H8Lti8BgEvatH4uXRXgxfelJOoauw4=;
        b=lXUMyc2Fyjr8Hmxk7AdgSwej2sXZ3o+RLv0PSbdJOUtMsAT7yZRcU3Mx07LFodXx2v
         lS6XEddynqwtYU3oy9ZgpYTKiL7lIKJuR9PMr7c0yQHwJiQXmIaAqO6qczz1E2H421Fm
         d2xxFheITDX2UPch9+bFzOJ+aUw+/NQo15V73TXaKNIKHYBn221hWf9w8rckEtzCPJmA
         aSe2+XHke4EsaYl+sokHfZe162EpQDW4XcZceMrVS9rZiKrF+shtqfwZLKP2n/Rj5e9b
         hEzj+VvZ6ez75GasngMV5oNGSJwuIAdMyucntSDSpXVgCsAVR1AauBVn8+moq5hN0mEY
         klQw==
X-Gm-Message-State: AOAM5327R3v6yCd9G+vAhLjAYYoLCK1+7Ffcbhe4mWlpJ1zukbfNb9jO
        rQwRqDbm/PXififyptCZLgz+iA==
X-Google-Smtp-Source: ABdhPJydAh/jbUByditLKcxVtzpjFwbYiRP+yP/8peLkoOOE9QZ85WA3IHByYefqdrPBzFZKWAqWBQ==
X-Received: by 2002:adf:ea8d:: with SMTP id s13mr12915468wrm.32.1615542476229;
        Fri, 12 Mar 2021 01:47:56 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id f7sm1539536wmq.11.2021.03.12.01.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:47:55 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 07/30] scsi: libfc: fc_fcp: Fix misspelling of fc_fcp_destroy()
Date:   Fri, 12 Mar 2021 09:47:15 +0000
Message-Id: <20210312094738.2207817-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312094738.2207817-1-lee.jones@linaro.org>
References: <20210312094738.2207817-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/libfc/fc_fcp.c:2255: warning: expecting prototype for fc_fcp_destory(). Prototype was for fc_fcp_destroy() instead

Cc: Hannes Reinecke <hare@suse.de>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/libfc/fc_fcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/libfc/fc_fcp.c b/drivers/scsi/libfc/fc_fcp.c
index b43b5f62ee3e3..509eacd7893d7 100644
--- a/drivers/scsi/libfc/fc_fcp.c
+++ b/drivers/scsi/libfc/fc_fcp.c
@@ -2248,7 +2248,7 @@ int fc_slave_alloc(struct scsi_device *sdev)
 EXPORT_SYMBOL(fc_slave_alloc);
 
 /**
- * fc_fcp_destory() - Tear down the FCP layer for a given local port
+ * fc_fcp_destroy() - Tear down the FCP layer for a given local port
  * @lport: The local port that no longer needs the FCP layer
  */
 void fc_fcp_destroy(struct fc_lport *lport)
-- 
2.27.0

