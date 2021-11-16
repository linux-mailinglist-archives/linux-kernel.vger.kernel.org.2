Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185B3453133
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 12:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbhKPLvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 06:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235500AbhKPLum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 06:50:42 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0680C061204
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 03:47:44 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id y196so16622208wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 03:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hiACY3RT/nmqVxVT6gUm+SJftE33Dn6ONZen5+wUKe4=;
        b=tZeXA7T7FxrH+wO2umeVX7gIv3IuM0a5aQVmrXuJ1OTHoFSzTTf2zrFF7KQtawbvWR
         B+VVnaU4/oqQolSpCmNu9yMal0+FxT7hUQ4DRQLI6TkkhCSmOh34qqWEJsm+ZIQuPRxs
         elS/Xtx+wP0nnsgT42M613bh2TG8nkgy9h9Q3AHyuxlD3CQUzIiTptq1pEbKTScRVT4l
         TDnwN8hENbR4CawWUtdQnyUw6cHcuiz5c5vAS046+mVeIhnfFbYRy24iN3ecN9huSA6u
         xNAgFo7vhyqmDasDHtr9I9K+6OaHoPr7hNQyhTKV0Laeo8cRntjfTzvE4DVdTbsGJOPK
         xQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hiACY3RT/nmqVxVT6gUm+SJftE33Dn6ONZen5+wUKe4=;
        b=8QnYx23G1ETfjIM1o2oeBnJolD5iREQVHnkFbxBweVhanvKkgVLw7ATIh0DWSezsfH
         pQqq64vCSCO42tdUA1QJ0xwfpA32GG0dadnyxNEwsg8iVaw1cVQLHxwtY7id1BhZeasZ
         LOcSkrpwjZYfwa8Mv3g3FKOFfPtFp12mbvcWuRydpo0cAEp2QFm8nDqCxilVZjggmGZz
         V555Io6WV85yPH2PRdf3vfozZTEE0EB4LqsNP2skh/gX1Y8t/ope0IK0anmPtdOSvYLC
         p6vTGeERxo0D0DvD3LE0Eh0D+1qf09ICb5+/1sJgdCoG+1wKeOg2O7TyJlbP6wQVzCBb
         4Zdw==
X-Gm-Message-State: AOAM533HjBLVIZl6543XTnJMGa8BiN7QyRiy8Zeai78Y76s54vue8D7R
        Cz1zvoBV8iKkDWTu31m6qJXk/w==
X-Google-Smtp-Source: ABdhPJyXMXt8SR0JdN8T3xvPScdTMbgiy4rZOsDKYHINmSSmOmu8w+Zjf+BXGplRetFG6okhaBxfkQ==
X-Received: by 2002:a05:600c:5125:: with SMTP id o37mr6995830wms.81.1637063263631;
        Tue, 16 Nov 2021 03:47:43 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id l8sm2260523wmc.40.2021.11.16.03.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 03:47:43 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/5] ASoC: qdsp6: q6adm: improve error reporting
Date:   Tue, 16 Nov 2021 11:47:20 +0000
Message-Id: <20211116114721.12517-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20211116114721.12517-1-srinivas.kandagatla@linaro.org>
References: <20211116114721.12517-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

reset value for port is -1 so printing an hex would not give us very
useful debug information, so use %d instead.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6adm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6adm.c b/sound/soc/qcom/qdsp6/q6adm.c
index 3d831b635524..72c5719f1d25 100644
--- a/sound/soc/qcom/qdsp6/q6adm.c
+++ b/sound/soc/qcom/qdsp6/q6adm.c
@@ -390,7 +390,7 @@ struct q6copp *q6adm_open(struct device *dev, int port_id, int path, int rate,
 	int ret = 0;
 
 	if (port_id < 0) {
-		dev_err(dev, "Invalid port_id 0x%x\n", port_id);
+		dev_err(dev, "Invalid port_id %d\n", port_id);
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -508,7 +508,7 @@ int q6adm_matrix_map(struct device *dev, int path,
 		int port_idx = payload_map.port_id[i];
 
 		if (port_idx < 0) {
-			dev_err(dev, "Invalid port_id 0x%x\n",
+			dev_err(dev, "Invalid port_id %d\n",
 				payload_map.port_id[i]);
 			kfree(pkt);
 			return -EINVAL;
-- 
2.21.0

