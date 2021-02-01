Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34EF30AF40
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbhBAS3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhBASP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:15:56 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFCCC061223
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:14:21 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id x9so4559840plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ujWQ8IDdSbwnxaXGdwQTjjikP4XSbHlkV7TpzfD9xCo=;
        b=QjzcqOoF+3AYpu6gKQF4yC3TQxBXrzL3mj0CT+BimMgQMbTp27c99IwABcp3t2sERt
         CatbW0kbH4brDMyfDaoidDWbeapQc8XtVxl1yCKP0dSf4OFqSmDP3oYIcxIEhh1CLoR6
         mjpAncFt1MAtEDsTW26606Km/TyI1Ux8Rj6R99+VR1kH/REGOu8V7huYvyyff/njmT/V
         11nkGTrXuaMGn5f5ciToOMU9nIgoA6aaQSTbkb3GlNL1uS9qcmHrpUGwdPQo9iN2v/Qp
         ctXRQgmECt5xAtl7XwduDl1hygEDbpj3eTzg+ecY+ttac3jsMunPl0sedhW9SaX+cze6
         Bcag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ujWQ8IDdSbwnxaXGdwQTjjikP4XSbHlkV7TpzfD9xCo=;
        b=DV/+CfVlidzrh64DBvx5Rc+kruiuXm0Q1V7F6N5X5qEK66I62AcXEFFY2oA/+c8hF1
         uAWsKktnafe6uycSd/1E0rN/wws39+D6GcipR6+U874bWTIb/88RLi3CA9O/eW8KFsDN
         pH22fTn/0K7OlzG/hl2WBMMNcBm+cpauJwb7ie0OCOWFIjTvPxJNJYGjkxZ59hnhJD59
         z6bBONIawXSw00pWzJUCDSyvHYm84PaqEJR3QsRGrhVDAuY1oyZ6cpdJJeutEYRBXxqc
         MH65QWjjiZljBjgue+2OLCgZxc9oqGG7edIF1TwzWvtHeE/xDFyQIb8RRb7IkhIBaPhD
         o0lg==
X-Gm-Message-State: AOAM532M964V/LRViddy2khEv4BVuxd+2cPRBrI/Fc3A5qdRN8TYtkM/
        +lqCdK4z3fIBv40BIAplc2rP2w==
X-Google-Smtp-Source: ABdhPJz9ZOmrWeFX+5JZYxQzresYToTz+3Wh8DeKHMzMvM5i51L/SqeO+RvVteVTFPFKCqQV/5TpLA==
X-Received: by 2002:a17:90a:f295:: with SMTP id fs21mr105601pjb.227.1612203261415;
        Mon, 01 Feb 2021 10:14:21 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e12sm75784pjj.23.2021.02.01.10.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:14:20 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 26/31] coresight: etm4x: Run arch feature detection on the CPU
Date:   Mon,  1 Feb 2021 11:13:46 -0700
Message-Id: <20210201181351.1475223-27-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
References: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

As we are about to add support for system register based devices,
we don't get an AMBA pid. So, the detection code could check
the system registers running on the CPU to check for the architecture
specific features. Thus we move the arch feature detection to
run on the CPU. We cannot always read the PID from the HW, as the
PID could be overridden by DT for broken devices. So, use the
PID from AMBA layer if available.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: liuqi115@huawei.com
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20210110224850.1880240-25-suzuki.poulose@arm.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index c3e458af618a..fc26ecbc2d87 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -60,6 +60,7 @@ static u64 etm4_get_access_type(struct etmv4_config *config);
 static enum cpuhp_state hp_online;
 
 struct etm4_init_arg {
+	unsigned int		pid;
 	struct etmv4_drvdata	*drvdata;
 	struct csdev_access	*csa;
 };
@@ -884,6 +885,8 @@ static void etm4_init_arch_data(void *info)
 	etm4_os_unlock_csa(drvdata, csa);
 	etm4_cs_unlock(drvdata, csa);
 
+	etm4_check_arch_features(drvdata, init_arg->pid);
+
 	/* find all capabilities of the tracing unit */
 	etmidr0 = etm4x_relaxed_read32(csa, TRCIDR0);
 
@@ -1750,6 +1753,7 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
 
 	init_arg.drvdata = drvdata;
 	init_arg.csa = &desc.access;
+	init_arg.pid = etm_pid;
 
 	if (smp_call_function_single(drvdata->cpu,
 				etm4_init_arch_data,  &init_arg, 1))
@@ -1794,8 +1798,6 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
 		drvdata->boot_enable = true;
 	}
 
-	etm4_check_arch_features(drvdata, etm_pid);
-
 	return 0;
 }
 
-- 
2.25.1

