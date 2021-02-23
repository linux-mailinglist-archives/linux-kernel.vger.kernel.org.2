Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E7D32348B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 01:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbhBWX6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 18:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbhBWXju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 18:39:50 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95917C06121E
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 15:35:26 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id r5so28698pfh.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 15:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XYqKe5JHKTsf6qqgvmLT8SEOr6JSbsFQUrC6la75+Tk=;
        b=MVV3vhm//Qy9ZrlCKMb16NdKTMroR2imuUkINcRxjjux/bl+uLuSLPbpRD1+1mGIZ2
         /+sbA0DrgyiBvh1ce7jR11k4/prDQABZEu8ZLl3253su/2GxBM+oPNcmyeOpwTYRE+7z
         +rEw6KT7cYrDATX1TD0OrKkoCUkaxwMFoCtsF8rAZqLVI00FRRM7Smxj+VDWVRSjMIV3
         OThZC45qFdxVv2NFrY+eZC93qdE+bRPGGmbzveBgWmpKZ2ubGAN8sVI9cO3knHgUkDs5
         DIp1kZYv0d42wEBFiWsihBdlBZHobFfXoZup1cI+LlhkMqK7Dncr90uKVhwBfkAxZDjG
         Lq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XYqKe5JHKTsf6qqgvmLT8SEOr6JSbsFQUrC6la75+Tk=;
        b=DnZquPbuxA8caBd/j7PzrxeyhRxG4a3E2PA6BxW1aAjYAVTsgnNZUsJVXLiYInfpJG
         zgcInT/vpQYovWfJtdolKuDeTbkL7stYMm5ee7rG7ylWeC+BVab3Bg1rtmBlaT3sO2MQ
         RCkf1KpswgO3ka6fYJPA5lMPRPpHqQRRYmUzAx7aGe4JxkyEGXplSZYtQoFHqcpRpusu
         WepGx0zWi6aLgpcG8lPSbyPKhx5oMpMGVdw0zVmDzBY/kQZ4dg6TsOYYyrr5LUZENvjP
         59v85K8J2dzP01PAWHPT0WZQvZUQicPKdMJWD2VKRBpmB5dxrIKf70o52jTY6Vt0PRm+
         MAmQ==
X-Gm-Message-State: AOAM53005SSYsWdY6k7spiRnii1aU2C8BX2HuJqEdTMX9KMNG0QApbr+
        WVMFrUvj8dc/lhFSez5V/fMl/w==
X-Google-Smtp-Source: ABdhPJznFf7DZqYNrPiOXAMW7oDr5knTQMa3p2jpXOrDYXjPzd9l0Vi8c8/FZ3GcjCq+M+pXBqRevg==
X-Received: by 2002:a63:fc1c:: with SMTP id j28mr26149581pgi.281.1614123326234;
        Tue, 23 Feb 2021 15:35:26 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id c24sm311999pfd.11.2021.02.23.15.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 15:35:25 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        arnaud.pouliquen@st.com
Cc:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 08/16] remoteproc: Add new detach() remoteproc operation
Date:   Tue, 23 Feb 2021 16:35:07 -0700
Message-Id: <20210223233515.3468677-9-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210223233515.3468677-1-mathieu.poirier@linaro.org>
References: <20210223233515.3468677-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an new detach() operation in order to support scenarios where
the remoteproc core is going away but the remote processor is
kept operating.  This could be the case when the system is
rebooted or when the platform driver is removed.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 include/linux/remoteproc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 51538a7d120d..eff55ec72e80 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -361,6 +361,7 @@ enum rsc_handling_status {
  * @start:	power on the device and boot it
  * @stop:	power off the device
  * @attach:	attach to a device that his already powered up
+ * @detach:	detach from a device, leaving it powered up
  * @kick:	kick a virtqueue (virtqueue id given as a parameter)
  * @da_to_va:	optional platform hook to perform address translations
  * @parse_fw:	parse firmware to extract information (e.g. resource table)
@@ -385,6 +386,7 @@ struct rproc_ops {
 	int (*start)(struct rproc *rproc);
 	int (*stop)(struct rproc *rproc);
 	int (*attach)(struct rproc *rproc);
+	int (*detach)(struct rproc *rproc);
 	void (*kick)(struct rproc *rproc, int vqid);
 	void * (*da_to_va)(struct rproc *rproc, u64 da, size_t len);
 	int (*parse_fw)(struct rproc *rproc, const struct firmware *fw);
-- 
2.25.1

