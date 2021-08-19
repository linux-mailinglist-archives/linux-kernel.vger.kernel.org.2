Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859163F17B1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 13:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238482AbhHSLHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 07:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238283AbhHSLHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 07:07:45 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A5CC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 04:07:09 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id y34so12040230lfa.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 04:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1D0gSIIM9kS1WL3TFlvMwY6p2M7SlyyajH6eqSkCAe8=;
        b=nifBz83RuOk2yKZ7DlxSGk+2aMfRYklkUTCwiN6zI14J/Rdmrb4wCdDsMroxraY8X4
         iT2pqccqJc8J762yRWEVn9kFJIhp3zeTw1kIQyujU/Hhyw90q0RJnCl2uSY/TNyrFOTx
         k9Zz5nu2l7qT7rL0YdEq0Kc0BNjttgZmT+vhVEkZpnWh5zE0reGrX/2tP0lma9hYqdBE
         tLeMpgaVQ98KMsnGYOqRRqtt//bMgkQ58GtXyp4boRr6Bp8Db80AgX2iWhgj45fZtail
         N9/m4rCmZg8D6ELcAeNNJmg4U9C30j3zREhmpIEp/zKrlBRs/ntZi3tU659h6Zt6CQHj
         SrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1D0gSIIM9kS1WL3TFlvMwY6p2M7SlyyajH6eqSkCAe8=;
        b=FS0eRjSYb7MXEefR0ePE9TCNfUF+LklcOnJZURjAPeZuPgJgUJ/CnHq2H8J/+L1p6U
         ZstyT7QREKPTyL30WBKyWjlyhaXSGWv+RtF5lX8rmgKz0/kuz43LuW2sBUkgQEzzRqtb
         MHaGdt4k3+wPIVt64++EfBPXKXUe9Er3rJDUio4WoWLtV0vpicSS4JHmHK77Ds0AWuCN
         1Td8D7zeizBnrV3QKU9hsLKqgbQXRc0ZZ3/9hYuHgIGW/cnjBRvTjjjgpGM4ilfKi+PK
         fLrMaxMnJ0Xh774PlqZj91SqsftLl6uCG3sG9kfcahyopviU03V/P61BOYMUUq/dPdrm
         Bv1Q==
X-Gm-Message-State: AOAM53137ppfNJVA62/YbMIfesDWoYV71+IxJ29a25YXr3ZLOj/TI527
        Y01zpix+ZvFfjd7csi1ly+Z5ksvRUxhRdQ==
X-Google-Smtp-Source: ABdhPJwiXwK8BC5+5TfFKE8QPT4HlXOoSoQIwl3Kk/Umy9K8k2NaBTKuITEcDBaTImsVb4b/YkC12w==
X-Received: by 2002:a19:c7d4:: with SMTP id x203mr10117577lff.575.1629371227273;
        Thu, 19 Aug 2021 04:07:07 -0700 (PDT)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id l19sm261131ljj.36.2021.08.19.04.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 04:07:07 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jerome Forissier <jerome@forissier.org>,
        sughosh.ganu@linaro.org, Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v4 1/5] tee: add sec_world_id to struct tee_shm
Date:   Thu, 19 Aug 2021 13:06:51 +0200
Message-Id: <20210819110655.739318-2-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210819110655.739318-1-jens.wiklander@linaro.org>
References: <20210819110655.739318-1-jens.wiklander@linaro.org>
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
index 54269e47ac9a..1a29f0e66e13 100644
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
2.31.1

