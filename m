Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA4E3AB1E3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhFQLHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 07:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbhFQLHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:07:22 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41CCC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:05:14 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id f2so6249491wri.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RRdn5bfjWdy77TkIbvs2SW0heF1dKRhpn0LBXcC7UQY=;
        b=ti6BvgsK68+N5WWoaEAwlY/jxLrUYRDnd7leGS9kvnVW/PkDENVZN0i66NNULOyJDT
         rRJ6KFwxfFhmQyXGJNlqFcSThE/+DoJ9Dy6ADiHYOKvf7HhmwK9ys0SeMeROhbod8mf8
         FFXu5VkNUsN75XUUsODu3hxep5WbFhJBSn4Y9T1Va2K9F6P8kZrlqM3CN+dxaN0G+OpM
         MGD57FxOqahVtHh3c13CJXlC6L1OddqV0FIpXthCy9Kuf+i+CaiP+VyZ4oHImmr2bTge
         H28eNGU39qg7Akq3fjuMVgty6khqfVWl3Epk3Lr1HztwZ6vAmZE4PIXoQAHVjm+LIokW
         C7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RRdn5bfjWdy77TkIbvs2SW0heF1dKRhpn0LBXcC7UQY=;
        b=uJiViBajmf2ZaIvZJ7lo0XcjXZzjQmTI+6Y4YCtCYTjn3tWh095t9hMQLr8Fq/zxab
         OKSFv6O7wxDqLWvwlXLJXvmPiCoAM8FGYY55e4Lz4Jj9C19SomO2h8R+TmlSjEbqpUK+
         sbkyynDOHb0L/mehYLHGsBD1IDC+WDpGNMwPyNaGTwjpC57DmdB3PuMNvwNX+Cyh8rPI
         WCkIu6o7ImjSwiT5G4dUEmdpr2WKp8n9pqGLepEcNQAWtD9IUdTroO2PbEFVeN6jcrEP
         PCqEqdygQzTBjibyLq+7IFCWVZBvwvI8BnNNHseWoPykT9Tv1/1o/vDgxeGJ+JUqhDe3
         tAeQ==
X-Gm-Message-State: AOAM533eONYQf7f87I0TFv6Q2fuGLqk0IZSXU+lVSzQRaEH1uN2qqU/e
        P0mPA1DFve2iY3TgsumO0yJ8qg==
X-Google-Smtp-Source: ABdhPJwryRfUm+esgvF8h7UyL7deyY6PixMsv4UPEyTR853roJOq11DPB1jpnuHkKQaCby7gYSGfGQ==
X-Received: by 2002:a5d:698a:: with SMTP id g10mr3861165wru.129.1623927913572;
        Thu, 17 Jun 2021 04:05:13 -0700 (PDT)
Received: from dell.default ([91.110.221.170])
        by smtp.gmail.com with ESMTPSA id v18sm5249487wrb.10.2021.06.17.04.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 04:05:12 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 2/8] bus: fsl-mc: mc-sys: Supply missing function names in kernel-doc headers
Date:   Thu, 17 Jun 2021 12:04:54 +0100
Message-Id: <20210617110500.15907-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617110500.15907-1-lee.jones@linaro.org>
References: <20210617110500.15907-1-lee.jones@linaro.org>
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
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
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
2.32.0

