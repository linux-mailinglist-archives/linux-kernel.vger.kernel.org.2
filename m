Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF37D45A6AD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 16:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbhKWPmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 10:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238509AbhKWPmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 10:42:15 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B869FC061746
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 07:39:06 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso3681211otf.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 07:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nLQmUNabRXXOhYysWc62nCjRSBEMKoCg9jR25zW3RSk=;
        b=RQrUKUyQzNzg7rLCG3cxzoGDG0oNzIKHOfQJ9nks5WNuVHemxSfYdsH7TY9AuPPe2F
         zRpRzme9bN39IU08LKa8cC92y1B7a7fa007Ur6kL2QhFIs3vOi/+alGazlRzepkaMClH
         fqUKV9MRxRC5tDjN5NMa8EeKTky6VTLEMkim8k2KHV2Us4zfWVmHgakV96WVg/62LMOz
         jWBVTk11If3OhcQzLT1pO7brO+kFyyGsWgDe0P+Q5zuAr4kqX/ZutjzbYuoh7fWeysEG
         6/ZT7gucb1Uxe42OhBFhWRyv1PtMyDmTjwT22Ryus1l2WZh35y8SKJV8rj77sPmSh3XI
         jdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nLQmUNabRXXOhYysWc62nCjRSBEMKoCg9jR25zW3RSk=;
        b=OIYoL7XjWUzuNGrQqotluGLx21XhQEDDCswtoc/JcOOKJD3Kvv5rpYoPtIbSN7q5tY
         cpmVSRUu6Ct+vjs8OLDmOos5AelWVsfnCQth89M1BPsl1PIhj31yKVCxuZxhZBhDRfQi
         +2hzv171Wh+Lt1NC1nIrFR/ge7KXXVJjOYNxYfMNsjaTVENiipS5z/Kj+BqSyzgp5xt9
         /6hIVd2/o3Qvy3YpiF2jhOUZR1sqeOUW/y+LzIufm3ZfFZnfA/rIqxK53flImbhgDo7M
         76NVKXuhE0REqBP793pgRRMapVe1zEFFqnnpe6BW5T9PUD0qYKfroOtyqWsL3ADxaOlc
         IGyw==
X-Gm-Message-State: AOAM533eCPtWhHDCO2vNNx1vAHxfIo/K9hhNOXsnLESCPKh+grS8s7fY
        o4K2IJGxwqltkj6eK1GHlUc6LA==
X-Google-Smtp-Source: ABdhPJwVX3je7HOSpEkEO8fGDAkLEXCFz07Dr0tLR+EQr8fiokL9uIECNqrloZM+EO2jmZUej0+uPA==
X-Received: by 2002:a05:6830:453:: with SMTP id d19mr5487860otc.72.1637681945857;
        Tue, 23 Nov 2021 07:39:05 -0800 (PST)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r22sm2571632oij.36.2021.11.23.07.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 07:39:05 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Abhinav Kumar <abhinavk@codeaurora.org>,
        Robert Foss <robert.foss@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/dpu: Add more of the INTF interrupt regions
Date:   Tue, 23 Nov 2021 07:40:49 -0800
Message-Id: <20211123154050.40984-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to the other 7xxx INTF interrupt regions, SM8350 has
additional INTF regions at 0x0ae37000, 0x0ae38000 and 0x0ae39000, define
these. The 7xxx naming scheme of the bits are kept for consistency.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c  | 18 ++++++++++++++++++
 .../gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h  |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
index d2b6dca487e3..a77a5eaa78ad 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
@@ -30,6 +30,9 @@
 #define MDP_AD4_INTR_STATUS_OFF		0x420
 #define MDP_INTF_0_OFF_REV_7xxx             0x34000
 #define MDP_INTF_1_OFF_REV_7xxx             0x35000
+#define MDP_INTF_2_OFF_REV_7xxx             0x36000
+#define MDP_INTF_3_OFF_REV_7xxx             0x37000
+#define MDP_INTF_4_OFF_REV_7xxx             0x38000
 #define MDP_INTF_5_OFF_REV_7xxx             0x39000
 
 /**
@@ -110,6 +113,21 @@ static const struct dpu_intr_reg dpu_intr_set[] = {
 		MDP_INTF_1_OFF_REV_7xxx+INTF_INTR_EN,
 		MDP_INTF_1_OFF_REV_7xxx+INTF_INTR_STATUS
 	},
+	{
+		MDP_INTF_2_OFF_REV_7xxx+INTF_INTR_CLEAR,
+		MDP_INTF_2_OFF_REV_7xxx+INTF_INTR_EN,
+		MDP_INTF_2_OFF_REV_7xxx+INTF_INTR_STATUS
+	},
+	{
+		MDP_INTF_3_OFF_REV_7xxx+INTF_INTR_CLEAR,
+		MDP_INTF_3_OFF_REV_7xxx+INTF_INTR_EN,
+		MDP_INTF_3_OFF_REV_7xxx+INTF_INTR_STATUS
+	},
+	{
+		MDP_INTF_4_OFF_REV_7xxx+INTF_INTR_CLEAR,
+		MDP_INTF_4_OFF_REV_7xxx+INTF_INTR_EN,
+		MDP_INTF_4_OFF_REV_7xxx+INTF_INTR_STATUS
+	},
 	{
 		MDP_INTF_5_OFF_REV_7xxx+INTF_INTR_CLEAR,
 		MDP_INTF_5_OFF_REV_7xxx+INTF_INTR_EN,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h
index d50e78c9f148..1ab75cccd145 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h
@@ -26,6 +26,9 @@ enum dpu_hw_intr_reg {
 	MDP_AD4_1_INTR,
 	MDP_INTF0_7xxx_INTR,
 	MDP_INTF1_7xxx_INTR,
+	MDP_INTF2_7xxx_INTR,
+	MDP_INTF3_7xxx_INTR,
+	MDP_INTF4_7xxx_INTR,
 	MDP_INTF5_7xxx_INTR,
 	MDP_INTR_MAX,
 };
-- 
2.33.1

