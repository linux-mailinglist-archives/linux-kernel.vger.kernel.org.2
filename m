Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0659E391209
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbhEZIM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbhEZIMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:12:20 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D62EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:10:49 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id f20-20020a05600c4e94b0290181f6edda88so8044069wmq.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vj1UOtHIUtHOnKuozxuAOWrVGLQXivpBI+YkeHeq/B8=;
        b=c4NYhY0Ma0Z2m7x1AO4HY2cy771c3eOCdxbEyMjXuNTpd8jM7Wc1u8ROfzGYs+fYj7
         lRM8ZYQ9ibq1fTnpV8EstUfR9ByCX+thKETe8/jym1zDJPPuZSCLXLBu46V1GbCVNl5r
         84zaxQhcYDiJEVTo/aIT9i5s4RnkNUWL1wmDID1ZiZsrYRKMZkrQKGdspypJ8bdzRsem
         QU2UYDugghQ3Kk1xJ3wDDFmfwZILLStbSF4MxBe5qjp9QHXOkwjfB+WmHjeTYk1ReebY
         o5FjrQqeJEApzUlNlw3NRnOa3lqfHXoC2iM4B4BvUzYPqqULjvQTy49NUV0/FAyYbclB
         etUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vj1UOtHIUtHOnKuozxuAOWrVGLQXivpBI+YkeHeq/B8=;
        b=mdAJasld9t3ozdgTrp+nkW+R9ULn/cPMOWx0y+waYMeRqsnvRLI/Hiu8K46/gJzDp0
         vlhHA+GVUX8gloZHwN9bSAxnriyCTW2QCN2HsndhhoojBp7SmqMcHf39zYYEn+txF71e
         i/4R4hb6hbvDMk94Np7IVY0gxHOI833Oz8WSEgHWTRAZFcUoHzdnsjwLPU2xI7mBwxH8
         WkuN8k9DoHQX6Qm2XMp+KcdPjjYUInHRPQ2zA3IH5QmX3/MI2T8aiBjWJ2KnpBeSIc/v
         DZNOCrBv4Y4eBK3p/Rios0SaieAgpEGwIIKH/Cis00yBoiurBC8DvHdrEA63t0kULKCz
         veDQ==
X-Gm-Message-State: AOAM5317UdvzcVIr7jiIP1ea/fIcnsC6xeWt92an7k/4KOVjBv4gIp9R
        SKbHqCBp3zp3Mn9OGYQT+JEf7w==
X-Google-Smtp-Source: ABdhPJwHQ+OM/gKDtpzTAbVZ4HsxYlw6w1cSAGNKN71hyTlU3YxjI2pL9dyRh/rHdadhSZou82F/wQ==
X-Received: by 2002:a05:600c:1551:: with SMTP id f17mr2064161wmg.17.1622016647955;
        Wed, 26 May 2021 01:10:47 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id v11sm22628319wrs.9.2021.05.26.01.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:10:47 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 02/10] bus: fsl-mc: mc-sys: Supply missing function names in kernel-doc headers
Date:   Wed, 26 May 2021 09:10:30 +0100
Message-Id: <20210526081038.544942-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526081038.544942-1-lee.jones@linaro.org>
References: <20210526081038.544942-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/bus/fsl-mc/mc-sys.c:20: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/bus/fsl-mc/mc-sys.c:151: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/bus/fsl-mc/mc-sys.c:197: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/bus/fsl-mc/mc-sys.c:237: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Cc: Stuart Yoder <stuyoder@gmail.com>
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/bus/fsl-mc/mc-sys.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/bus/fsl-mc/mc-sys.c b/drivers/bus/fsl-mc/mc-sys.c
index b291b35e3884b..f2052cd0a0517 100644
--- a/drivers/bus/fsl-mc/mc-sys.c
+++ b/drivers/bus/fsl-mc/mc-sys.c
@@ -16,7 +16,7 @@
 
 #include "fsl-mc-private.h"
 
-/**
+/*
  * Timeout in milliseconds to wait for the completion of an MC command
  */
 #define MC_CMD_COMPLETION_TIMEOUT_MS	500
@@ -148,9 +148,10 @@ static inline enum mc_cmd_status mc_read_response(struct fsl_mc_command __iomem
 }
 
 /**
- * Waits for the completion of an MC command doing preemptible polling.
- * uslepp_range() is called between polling iterations.
- *
+ * mc_polling_wait_preemptible() - Waits for the completion of an MC
+ *                                 command doing preemptible polling.
+ *                                 uslepp_range() is called between
+ *                                 polling iterations.
  * @mc_io: MC I/O object to be used
  * @cmd: command buffer to receive MC response
  * @mc_status: MC command completion status
@@ -194,9 +195,9 @@ static int mc_polling_wait_preemptible(struct fsl_mc_io *mc_io,
 }
 
 /**
- * Waits for the completion of an MC command doing atomic polling.
- * udelay() is called between polling iterations.
- *
+ * mc_polling_wait_atomic() - Waits for the completion of an MC command
+ *                            doing atomic polling. udelay() is called
+ *                            between polling iterations.
  * @mc_io: MC I/O object to be used
  * @cmd: command buffer to receive MC response
  * @mc_status: MC command completion status
@@ -234,8 +235,8 @@ static int mc_polling_wait_atomic(struct fsl_mc_io *mc_io,
 }
 
 /**
- * Sends a command to the MC device using the given MC I/O object
- *
+ * mc_send_command() - Sends a command to the MC device using the given
+ *                     MC I/O object
  * @mc_io: MC I/O object to be used
  * @cmd: command to be sent
  *
-- 
2.31.1

