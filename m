Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3D83D233D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 14:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbhGVLhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 07:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbhGVLhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 07:37:35 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51846C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 05:18:10 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id h4so7076615ljo.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 05:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jho2K68ga+5iTIj/1FJanSXtGPFIBOymH8GgUKHdmJg=;
        b=n4Cd5KUlVp+rn78A7tSLeP1QaCRnUqd5Wo68GOklD8bEXOYq87gcZd5mOYtFr8Jwru
         VqI6QbD72tfLd26xc7jJwPjsSgpevZ7i7V5uB8e+yWtkDO9IdWspQvYRq2+klkkkjigm
         BDTLd7cT9nJ+PLLGY/DGEGP0RJSidE5xmun3+CcbvNdCGXW0/N+Ut6+pKZiDf7pZ6XQZ
         XBDXipn2wntiiUDqGmzxIyF6LyJRhkB0Kmgrb9r6DS80GpUOqZdTxfnm/nPoQLR9p8oC
         eqvOJ69gI4kq7YoK/Btv/ikDII3s97K7mJnzJEu1PKXXul1rJiCis5xpJcLE+zPzZcUp
         TnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jho2K68ga+5iTIj/1FJanSXtGPFIBOymH8GgUKHdmJg=;
        b=aucm32G+iUYD6fa8+Er1hPKjHqqtq6iZyXHLPT/nm4es++eH5rIyRwAuo3HG/j1Ryq
         llnpsZx7hAUXmqovPbr7VK6p3CGmGSMFz4Khil7vUwbK0He0bbud8X4lMACp/XPsnTiW
         ZQGucCEBPp4NT86qcyFAelsoWzGcUDxrf8ZfvdRIyYYwX5F52RfeA2SQAS7n2VYH1JJE
         kpXU7xQw/DYapibaqDFa37Mcqs0YOs+WXfUV6GeJ0nW/3fqloZOnwKhUMT4ZZTOvzVhp
         73phxLz7A1gMF0a5JWzGgXWjUJ/u7g9tuIljJ5okecZFxWocSbHZmw5sZ87BnfPWd9bU
         DsFw==
X-Gm-Message-State: AOAM532iNN2+W0Ss9nvEQXZ/Kev3qX7LK/TqPUssbS7PtbC9g6A28Hpq
        RKh6n0ajRwzYPpH0nlluN0EY22Di612EWg==
X-Google-Smtp-Source: ABdhPJxnX8s7IJblRfGI601d0Xtre+S/15kMK0Xhbddqz/BBy7LbQb6cZZ+5iKTudiLDPhSMvO0beA==
X-Received: by 2002:a2e:9695:: with SMTP id q21mr7034810lji.509.1626956287123;
        Thu, 22 Jul 2021 05:18:07 -0700 (PDT)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id b41sm845090ljr.67.2021.07.22.05.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 05:18:06 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jerome Forissier <jerome@forissier.org>,
        sughosh.ganu@linaro.org, Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v3 1/5] tee: add sec_world_id to struct tee_shm
Date:   Thu, 22 Jul 2021 14:17:53 +0200
Message-Id: <20210722121757.1944658-2-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210722121757.1944658-1-jens.wiklander@linaro.org>
References: <20210722121757.1944658-1-jens.wiklander@linaro.org>
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

