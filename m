Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAA0338926
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbhCLJtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbhCLJsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:48:15 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B37EC0613D8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:48:15 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id j2so4419005wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Ke6o4zu3Y1mMgZH32XDTQeE3CdSvHz52a/xHYynlH0=;
        b=OC9DBEziDd97rCc6RpwLUznVjblQ0eolzB8iPuqHbnfUSxb/6Qms6KQ5qz+p1oBmQw
         otUhqtwwQ5rZNL+UG6vunINrXd+PfdwmU8XR/wTzDd8pGrPKvn2hSEELGpm1s7gQRo5T
         nP/+J+8iy1BSsO4m7Db5pqkSF0oQxfOc7mflo0zQydY34SvsqVfSxRR+9K9epmzGdune
         fDRSrMRO6VBc7NtVfVRS1srFoYoWSMMDfc2fWGFYXe/7RgJPLkVkfd//LKS3YK4in08l
         znxRUkfbAxbkTjXmJyVOghF93yFsMWv/aY1Hi29jByYmAOT3kcsf66gW5axdQQKHZJDQ
         PiQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Ke6o4zu3Y1mMgZH32XDTQeE3CdSvHz52a/xHYynlH0=;
        b=ODc7L7HF+hLHqb/ExB3W/utD3fT2GEfipTadsZ/ZbR69zux1NGHqlww+dCSfEmKUP1
         E2RlWbFp9zMuoUQy4X++3FcnOVMWNM2xynU/j4clFfcGzs4v24kyY4JysroLpXlKzpEe
         nwI4qLZwzXt7YJTZAbadvPu8TnZr1rf9yhQ439o0/BadcNb1kWtdmGUt/ziez7gUIIfZ
         f90bce2dd7nck8cp95YBuiP6cK37E6sGChuGd6w8PD7Qv5qElR1NCl8ZPAFOQr7uwqE0
         NOQpwGR/W9Uqu/8SlAHs4l8U3rFgU27NxRuDQQBmQavinyofXUkLoq5EqKuYka+SVJ0r
         gXmg==
X-Gm-Message-State: AOAM5323gsWmi++R99Lnn6bDJ8qE1Epvn1lTa8MHbZfut2IXGru9nd6j
        QMF9/Cy4f/0Lhyvkucn1paAhkw==
X-Google-Smtp-Source: ABdhPJwU10xDuswdcd0DJBB5bvQSHdp/5A3psb+ZircGEGbMDgJgvyr1CuBMNGbkVeqx176K6nfv5w==
X-Received: by 2002:adf:a219:: with SMTP id p25mr13260335wra.400.1615542493724;
        Fri, 12 Mar 2021 01:48:13 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id f7sm1539536wmq.11.2021.03.12.01.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:48:13 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Oliver Neukum <oliver@neukum.org>,
        Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "C.L. Huang" <ching@tekram.com.tw>,
        Erich Chen <erich@tekram.com.tw>,
        Kurt Garloff <garloff@suse.de>, dc395x@twibble.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH 25/30] scsi: dc395x: Fix incorrect naming in function headers
Date:   Fri, 12 Mar 2021 09:47:33 +0000
Message-Id: <20210312094738.2207817-26-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312094738.2207817-1-lee.jones@linaro.org>
References: <20210312094738.2207817-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/dc395x.c:980: warning: expecting prototype for dc395x_queue_command(). Prototype was for dc395x_queue_command_lck() instead
 drivers/scsi/dc395x.c:4263: warning: expecting prototype for adapter_init_host(). Prototype was for adapter_init_scsi_host() instead
 drivers/scsi/dc395x.c:4353: warning: Function parameter or member 'acb' not described in 'adapter_init'
 drivers/scsi/dc395x.c:4353: warning: Function parameter or member 'io_port_len' not described in 'adapter_init'
 drivers/scsi/dc395x.c:4353: warning: expecting prototype for init_adapter(). Prototype was for adapter_init() instead

Cc: Oliver Neukum <oliver@neukum.org>
Cc: Ali Akcaagac <aliakc@web.de>
Cc: Jamie Lenehan <lenehan@twibble.org>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: "C.L. Huang" <ching@tekram.com.tw>
Cc: Erich Chen <erich@tekram.com.tw>
Cc: Kurt Garloff <garloff@suse.de>
Cc: dc395x@twibble.org
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/dc395x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
index 3ea345c124673..e28f8931e23f8 100644
--- a/drivers/scsi/dc395x.c
+++ b/drivers/scsi/dc395x.c
@@ -958,7 +958,7 @@ static void build_srb(struct scsi_cmnd *cmd, struct DeviceCtlBlk *dcb,
 
 
 /**
- * dc395x_queue_command - queue scsi command passed from the mid
+ * dc395x_queue_command_lck - queue scsi command passed from the mid
  * layer, invoke 'done' on completion
  *
  * @cmd: pointer to scsi command object
@@ -4248,7 +4248,7 @@ static void adapter_init_params(struct AdapterCtlBlk *acb)
 
 
 /**
- * adapter_init_host - Initialize the scsi host instance based on
+ * adapter_init_scsi_host - Initialize the scsi host instance based on
  * values that we have already stored in the adapter instance. There's
  * some mention that a lot of these are deprecated, so we won't use
  * them (we'll use the ones in the adapter instance) but we'll fill
@@ -4336,7 +4336,7 @@ static void adapter_init_chip(struct AdapterCtlBlk *acb)
 
 
 /**
- * init_adapter - Grab the resource for the card, setup the adapter
+ * adapter_init - Grab the resource for the card, setup the adapter
  * information, set the card into a known state, create the various
  * tables etc etc. This basically gets all adapter information all up
  * to date, initialised and gets the chip in sync with it.
-- 
2.27.0

