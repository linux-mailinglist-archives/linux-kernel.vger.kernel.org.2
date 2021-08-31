Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9A53FC3A4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 10:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239894AbhHaH0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 03:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239872AbhHaH0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 03:26:03 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31523C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 00:25:08 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id c8so23964085lfi.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 00:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NvXatvGat/zwzJqSmrQCEyhrxQWhLfa0q1L0IoYWuTg=;
        b=iNyRlbcMO4LknPkqP5iFDBV09Yqg0XtrnmdY7PN/0/E/2JDFxzTOEKDH92y7rH6B0L
         NigfgnbJciNP4Ku08MkJxAGZSHjaTp3zQLl03T1Js3UKctvjXxfkvtZbjRUUxxmwVuVY
         UJ9jnQFHtkBcO/HIPC/WE9xkKnLs1iH4WCchfenEEyFRsqbmSVIg7THPa3fDurPG/KSY
         EkGdv1DuxTpdfFWi1NTF4A/XR/EcniBHKcQgdhOW9LpGjlWfwserbx4WffQWBzS+6ESR
         T4HepE0Lr/FgW95zNICdnisx0RV3+uzytkvTl4caSgVFVdIwCUIZXVi5q+hlzjSpXdAR
         lDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NvXatvGat/zwzJqSmrQCEyhrxQWhLfa0q1L0IoYWuTg=;
        b=WNTqB9sAXb+dLaAXrQauPfypD+i5T+SP/+mUzItZP5ZSiD+rNETvWRmLx39n+O2z2Z
         EEshNPl5GDCGNe2jfxoPj2Hg32U31ywW6pp9WG4QjJaFZ5ZMhq6hcpjc2zC6b5mvcL6g
         tPcIBXAozqBlAxBy2IfkbJsEib7FE1qC4Q2i1ome1YqwszIoznOC1o3g8EnyoUqkGZ8p
         Kg4t+3y6CSL3qA7pNDbpIxvoV2hoUl5LLmd64Z9BN5TZs9/Xxi9V48L8qxKc9C3A0Srg
         mBsoj2tPt7rQgivJfhCOz4BBUuXCU6EmnR7nYKnit6PESCmZ74DgftK0S7TNNbF6Oqj3
         8Haw==
X-Gm-Message-State: AOAM533g1kwY254Zx7/neyacvj07L1LGGjPu94mq6jv0rNrTXmL2WwT9
        A3LXB6mRDgRNBqO807gVBrpCic9lYRx/GA==
X-Google-Smtp-Source: ABdhPJyqJhMtxAM+nqvSzFBxNdo5C3ywqecCyMvb+BiPoFVm9kMFZFdZhDqHVBqHGTFY0+qBKBkYXg==
X-Received: by 2002:a05:6512:128b:: with SMTP id u11mr1739974lfs.387.1630394706438;
        Tue, 31 Aug 2021 00:25:06 -0700 (PDT)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id c10sm1642569lfv.246.2021.08.31.00.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 00:25:06 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jerome Forissier <jerome@forissier.org>,
        sughosh.ganu@linaro.org, Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v5 1/5] tee: add sec_world_id to struct tee_shm
Date:   Tue, 31 Aug 2021 09:24:08 +0200
Message-Id: <20210831072412.887565-2-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210831072412.887565-1-jens.wiklander@linaro.org>
References: <20210831072412.887565-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds sec_world_id to struct tee_shm which describes a shared memory
object. sec_world_id can be used by a driver to store an id assigned by
secure world.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 include/linux/tee_drv.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 3ebfea0781f1..a1f03461369b 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -197,7 +197,11 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
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
@@ -213,6 +217,7 @@ struct tee_shm {
 	struct dma_buf *dmabuf;
 	u32 flags;
 	int id;
+	u64 sec_world_id;
 };
 
 /**
-- 
2.31.1

