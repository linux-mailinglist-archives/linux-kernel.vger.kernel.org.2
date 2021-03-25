Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C043495E1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 16:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhCYPpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 11:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbhCYPok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 11:44:40 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3B8C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 08:44:39 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id w37so3154582lfu.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 08:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kv02eM8NeYnnByA8FlayEK6mh+4PxaRpmwdYdtGmEa4=;
        b=Rra31NRtKhL6xfXOQ6S73tmdqvH5K1e1EqVUNVIcwOwViaQOStlau4wLxjKsDMsBX/
         QjHYpdH8Tm1C8J2wnjlxXSPkqA9nbDdn/RlNW2wp+E/reQ8Gng+d0Ha2c+A+6Ubo29x2
         TiEvrFLMn/+tFiuC7V0nXeTPBEyo5ExYy8kpIe2IUTnRMl4RvfpevTUEbRb6j3c3dP3o
         xJdqgmJgdPjSuESbLtUgjV+/lY2OVvv9pMhOr2WfLa1UGiuacOEZ5OyrauLyfV/qQuRw
         JoxJO0JmpVbYQolECFsONwJhV4EsWJpkla/5fR2KcVY/PakdSUhmpzfPpbAOMqt/9Z3R
         VFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kv02eM8NeYnnByA8FlayEK6mh+4PxaRpmwdYdtGmEa4=;
        b=NlkzsbAdGVHxohiRYetj/So81aZ7exoHOWujouIhtwKBA/1DydWLFbeknz8ewR7uey
         +zWkOLY4QNXYiwjpLrkJSEAeH9idWJBN69JktGzo4/Cc+3fLIKj6DiNKTMXVQnbKSLna
         sTIcJ7U25qmFZj9UaC1y5fLAXsrbQjJF1eCka8rMy2cRNdCeBteZk0oFQIgMi9T2yrYR
         lot+moTdlC+VHr3+ZV3cn7JXxG94/K1qfxvdpYpMiQrZQAF5FrjOW7skxHpu6zLiQA/t
         P8He+0a6ENKa4QYnsxGFdNCtRtGxpI89iV95WwMDy5vDrg4benuB4FQAc40g5EHwmWdA
         H6Tw==
X-Gm-Message-State: AOAM530g40daIHrAVH/bDRLiBauQ0OBfswnbiO2I3dIO38lLY4JnPAZt
        cz2f9lEqswySsPOa9lGmcoqFQxN4gwxPL7cy
X-Google-Smtp-Source: ABdhPJwUy0zuNgDLX4J8OZDlAy36S/+zA2k8VHCJcf2rekhc7vYkWdHy/GDxi1sxe4lh4+vaWy596g==
X-Received: by 2002:a19:f501:: with SMTP id j1mr5641541lfb.231.1616687076286;
        Thu, 25 Mar 2021 08:44:36 -0700 (PDT)
Received: from jade.urgonet (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id m27sm770916ljc.109.2021.03.25.08.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:44:35 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jerome Forissier <jerome@forissier.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 1/6] tee: add sec_world_id to struct tee_shm
Date:   Thu, 25 Mar 2021 16:44:21 +0100
Message-Id: <20210325154426.3520148-2-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325154426.3520148-1-jens.wiklander@linaro.org>
References: <20210325154426.3520148-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds sec_world_id to struct tee_shm which describes a shared memory
object. sec_world_id can be used by a driver to store an id assigned by
secure world.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 include/linux/tee_drv.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index cdd049a724b1..93d836fded8b 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -196,7 +196,11 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
  * @num_pages:	number of locked pages
  * @dmabuf:	dmabuf used to for exporting to user space
  * @flags:	defined by TEE_SHM_* in tee_drv.h
- * @id:		unique id of a shared memory object on this device
+ * @id:		unique id of a shared memory object on this device, shared
+ *		with user space
+ * @sec_world_id:
+ *		secure world assigned id of this shared memory object, not
+ *		used by all drivers
  *
  * This pool is only supposed to be accessed directly from the TEE
  * subsystem and from drivers that implements their own shm pool manager.
@@ -212,6 +216,7 @@ struct tee_shm {
 	struct dma_buf *dmabuf;
 	u32 flags;
 	int id;
+	u64 sec_world_id;
 };
 
 /**
-- 
2.25.1

