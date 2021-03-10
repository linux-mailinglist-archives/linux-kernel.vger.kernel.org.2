Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D993349A1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 22:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbhCJVLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 16:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbhCJVKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 16:10:50 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC07C061762
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:10:39 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id t37so1425137pga.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XYqKe5JHKTsf6qqgvmLT8SEOr6JSbsFQUrC6la75+Tk=;
        b=QN2KSeHTMIJVqStmupfWoNju+6b6lOBn7SeIpMOv7ikOVNn+APCCBDhoTdRY4ayYYa
         DptUaojNxDDqkPdyGwyoMDGjz8G//29zZ8+77VxB0lMNsAwpaK1Uc8xYwG7rasPF5M8+
         qgL8IEYDPr3MgBl67MFqc6OHDjwO3uNRTituyHBHXX4jkZqdKnRnOpPkahGQp5/KW5Ml
         pHqZZhPKTuSjgNuhsmR5IzkA3tWw+kWOQA8768qsOYsSxdZH6ddNekUAxGYO5ATssmJb
         AIx5lNqpjNNxpKs03apoKVWtQGx2ezRAlySvHwEUTQZW3x3WPw+tKzBIJpF5HOBmydCv
         JhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XYqKe5JHKTsf6qqgvmLT8SEOr6JSbsFQUrC6la75+Tk=;
        b=GZh/gJnIL/Y1kRXJA3qYpMgB3sBbfJr+vEQ6Bxm3DWlno2PynFpoNZYaYyZ3db1bG4
         FRjpnDLx1EIFeb7N7+Y9i5e663jloFAPzYD8RWeEDIDf2Z+KxdqQ9U4kNTCGr1038g33
         CPVeFIwXowdH3i7sExlhenbpt9/i4WLM5nG6oS5IzvHLMCb4d/AGzESJL1RY8k3D6TbE
         iBGPJQtaeNFNiuBqST4Nt5MFklXlHIdQlHtCZRjRYvH3CG8g5fQ/R90JodJnyJkuH6a/
         oBeajl+Vp/4GQEQjMXumIc3/zOshEVuuXXau/ogWK5wudZfKFHeFCihK7ISygyABd9Yy
         di+w==
X-Gm-Message-State: AOAM530jYMfkORO1sb1ZReZo6whDkYIbHzXM74ALP98sZZfHXAu0Ax12
        +rlGAbu06akiiOtvAs8mUsvDZg==
X-Google-Smtp-Source: ABdhPJxaedrB6VtJPtWrf+nVKEW4VUlYYGPU1Tty49X6jvAbuncswZMdOLZz5f7TNwJmX+0J7LY77Q==
X-Received: by 2002:a65:584d:: with SMTP id s13mr4406136pgr.226.1615410639176;
        Wed, 10 Mar 2021 13:10:39 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id j21sm371508pfc.114.2021.03.10.13.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 13:10:38 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 08/17] remoteproc: Add new detach() remoteproc operation
Date:   Wed, 10 Mar 2021 14:10:16 -0700
Message-Id: <20210310211025.1084636-9-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210310211025.1084636-1-mathieu.poirier@linaro.org>
References: <20210310211025.1084636-1-mathieu.poirier@linaro.org>
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

