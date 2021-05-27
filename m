Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D873939294E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 10:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbhE0IPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 04:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbhE0IPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 04:15:53 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A838FC061760
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 01:14:20 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id w7so5161661lji.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 01:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ge755jFjD/pTxRhjKSdzjdOhplbUtYgCCIgYEHy+118=;
        b=hdKo5l4/GeaQDDS4E7RaP9HhNtUptVMkDBkQHZKUlhEo22w5u9aO6rcT11lLKbYKia
         mdAl9U/SjJHtj5iKIapgbDE9iywBcjs4xxnwhyA6qvZuL86X8bkUThOjwiES4BI+H1NN
         5vaP2UtDTp/LVnrc9RnmsEhoUzFxftOlkj06xbRhyEML5eD4PfLFq26CvZ5eTcf2WHLN
         vymMmI/jYTi1HmOa9PF8w5gG66xO1pckPMZFAst0dN9cZTa63jODQPFtnFv27m53HqyK
         BKEfJdq014K9QoqTpvrVPehpT+3LrHY2M2RK1b4ChNQQGElmzN/7nQb5pYTkYM+BzVF4
         r7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ge755jFjD/pTxRhjKSdzjdOhplbUtYgCCIgYEHy+118=;
        b=uRcfxx7h7NO3aFEBmEOIu7FB17IXW0wjdgZpuuh0M5YjF6sYbnZTCkH/x9WQ1zMqJi
         HuXaRWq4xqDhiONpQptVDc8Lvduj3QCA34qfPnXBSgEAuNOPjAZh4Ha0yNz1l7AtHf2v
         TSn+WLdatazm6BNtGRH5qfRau9Z+m/18HcrnbaCZvCwPNqRP0Xl79+vhpwXeNZpJhxCX
         jZS+Vqk72m71EsvgO1etLXgO7TzkZLcAfNN6nXW/tk1hnl2KYjMNAvUqZXcsuMk072Zd
         6JO5A/M5TZVhsVxJXf/fvCzi8vUP8I8D/2CfKyinL6GwGwZ1Kz8HUaO5oEHEeg7u28IP
         mppA==
X-Gm-Message-State: AOAM532k2g+MnFTSZ3uJvtz+KTYXbux2aGlHe80drQEgGK7HY06q2YHC
        4AekfuAlH0yI9P2J7vKy2Jt9CzupXJyB/Q==
X-Google-Smtp-Source: ABdhPJwpbbwdg8nu8BQuGEczDISF4tLxzm6RyDqv3rO/ZQGnXSEHrER7oiOOKBtqbzDOqiedAJGw+A==
X-Received: by 2002:a2e:9bc1:: with SMTP id w1mr1616152ljj.290.1622103258850;
        Thu, 27 May 2021 01:14:18 -0700 (PDT)
Received: from jade.urgonet (h-79-136-85-3.A175.priv.bahnhof.se. [79.136.85.3])
        by smtp.gmail.com with ESMTPSA id z10sm133186lfe.228.2021.05.27.01.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 01:14:18 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jerome Forissier <jerome@forissier.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v2 1/5] tee: add sec_world_id to struct tee_shm
Date:   Thu, 27 May 2021 10:14:00 +0200
Message-Id: <20210527081404.1433177-2-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210527081404.1433177-1-jens.wiklander@linaro.org>
References: <20210527081404.1433177-1-jens.wiklander@linaro.org>
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
2.25.1

