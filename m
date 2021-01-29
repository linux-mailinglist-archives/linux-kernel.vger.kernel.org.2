Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C20308BB6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 18:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhA2Rgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 12:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbhA2Rdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 12:33:38 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13696C06178B
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 09:32:58 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 190so7443398wmz.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 09:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BgPuxMdkqPp4a6ple2m+0TbGMrlk3+s8+dfsxGz4L0w=;
        b=jx7M+m1ltlMzec+hs2KHhHvTFaBXscYkE36JNskfG61wPv1lOQX0JhP7S7WhUuSF3D
         axeHBLZE3RlL4s42xc3NDyGD7iD5MoXTqxv7Us1CilQ3U7G6ToBeBEIqtnjX1O89mCcf
         LhdL4yfPeTkkWS1VxXA9jYDGDI48LOUR1ZpyS1PsaY2Qb5Kr4dDKSHgFF3kCgHyee86h
         zyPuYwCr6LVl/Lx/z+UmyZ3qXFVCErdsb4YVgDOo+CnGiof4M7uTIicbxmtXcdB0i5ZO
         Hg8bsfk/ylG225Nyug5o3br9+Je+2qWX5pOStJSq1DOpmWVd0sp/3zKDl9zHjCuS2YGi
         31uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BgPuxMdkqPp4a6ple2m+0TbGMrlk3+s8+dfsxGz4L0w=;
        b=AqfS2o+BNQpaPA2kDVwwPJ9AGkHRWGVjnREPgyklXM1SANeLh87Eeuizp7O4qfuOJI
         U/gKRSo+rG6cd5S75DwlhQGFaPMrNc+aBCw1YJeS/k0KayzzFfyrBCjdjxeg7IO85NtQ
         5BeP9P8agyM/ePYhGei/sispI0q9SPMlZDzvUXA+2AD+kfeUCXLTzD/gKj7MAuOwhMna
         RIFgp1QBKoPMtI/qFh8qB4DP1xIceCCy6TmCcBmsZQIZeP0qdXHb+xV+1yXvYjTCQFwa
         zRb0BPVLLN5umJ7AfqG6zYzelPYYGmx0hWh7vQKgZpQnZltyKw3peQ39ZjfamAaURJ/h
         3mkA==
X-Gm-Message-State: AOAM53235A847s0KGM7wM02wYs1AnMVYA2es7wL9N6NBSDRx8RIH70OQ
        mWJkfATFhe7nurwuZL926W/zpQ==
X-Google-Smtp-Source: ABdhPJwunDHVtKKIWJW1662rovRtgJRIw4LYLRE2viDY9P/TVEqf079r/od4QGY0Pko8UCxm9HZ2Vw==
X-Received: by 2002:a05:600c:2249:: with SMTP id a9mr4909751wmm.169.1611941576507;
        Fri, 29 Jan 2021 09:32:56 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id h18sm13202294wru.65.2021.01.29.09.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 09:32:55 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/6] soundwire: qcom: extract version field
Date:   Fri, 29 Jan 2021 17:32:44 +0000
Message-Id: <20210129173248.5941-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
References: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract version field to major, minor and step, so that we can add
dynamic version checks to read/writes.

This will help for controller versions that need specific bits
to be programmed.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 36e273795cbe..da6e0d4e9622 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -110,7 +110,9 @@ struct qcom_swrm_ctrl {
 	u8 wr_cmd_id;
 	u8 rd_cmd_id;
 	int irq;
-	unsigned int version;
+	u8 version_major;
+	u8 version_minor;
+	u8 version_step;
 	int num_din_ports;
 	int num_dout_ports;
 	int cols_index;
@@ -961,7 +963,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	prop->default_col = data->default_cols;
 	prop->default_row = data->default_rows;
 
-	ctrl->reg_read(ctrl, SWRM_COMP_HW_VERSION, &ctrl->version);
+	ctrl->reg_read(ctrl, SWRM_COMP_HW_VERSION, &val);
 
 	ret = devm_request_threaded_irq(dev, ctrl->irq, NULL,
 					qcom_swrm_irq_handler,
@@ -985,9 +987,11 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_master_add;
 
+	ctrl->version_major = (val >> 24) & 0xff;
+	ctrl->version_minor = (val >> 16) & 0xff;
+	ctrl->version_step = val & 0xffff;
 	dev_info(dev, "Qualcomm Soundwire controller v%x.%x.%x Registered\n",
-		 (ctrl->version >> 24) & 0xff, (ctrl->version >> 16) & 0xff,
-		 ctrl->version & 0xffff);
+		 ctrl->version_major, ctrl->version_minor, ctrl->version_step);
 
 	return 0;
 
-- 
2.21.0

