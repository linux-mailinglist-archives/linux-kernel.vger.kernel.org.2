Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26A2440EE2
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 15:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhJaOpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 10:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhJaOpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 10:45:15 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4C7C061570
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 07:42:43 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id q187so14878506pgq.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 07:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VuCaajuKPFmTiIUEF7c2E0sdpfzEPoBt97lGeDDdtio=;
        b=IHXRiKyL1xCYSqfH34x9ox8qwe+3Pmxtc1hOLOThYNEnfO9quSYULaXhRsUeczp77J
         JmytcFtp8j21vZP7efbz3tbI/Kcv5RQ96v3hgP4ts/MQbOS+2hUgOmqD4+Vvzs38wzBZ
         xMaveS0YsceHzLlWTd5y8+k3Q/sS8V3iwXVjcudK5xsRU+l5GzDss8lIDJJtWfhKKWQ+
         KxtZAw7XPWJXFUlkrHbOFewfOUssO/wZWqtKbtIcJEU3I4b2OTGShRiwuZT8oXMM8E0S
         TLgTz/U+h0GOki5FreB0D3dxtY70zPuQIzi2c++WSd+XUNYtF2WA97QLkVbKG15KuysC
         ABNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VuCaajuKPFmTiIUEF7c2E0sdpfzEPoBt97lGeDDdtio=;
        b=4Hn84QoCiGui6qJl0WCAGIz+HXlrTYL0z2jKHjFAHYI+oUNWT4CbubcFZ4PgJD6KOU
         zrm6gevKECSnF4XR8QdZDCOoZ4UEaEFSgyIqENk3xgxSPNGQLGfX6+t6RTcTCAHIfyxQ
         /bfS3hdEMA+VfzPF24rkKX8n4SC8AF/4+rwnLkc9QrKhpBIDyRiJCFiFe/Ms+gW+NpxT
         zfojB4jTZm2zxerykQJ1lWWMiOYx/vTGPf2o4V4TgM3a/YulcxItUsPzHhGzeT+nERYg
         L4ahmVRAVboseQNSUl0Zpg72OFo1xwNWLEhajZwFnHz9kBdG5seqaP9tgQ+IjHV0BxBM
         4y4g==
X-Gm-Message-State: AOAM533mBJr1Tmmws2MC81JVxnEYt/CQrJoiCRi3AZALCRv+nvC7H5Im
        rWN2Sf44guDRUdQ0Ni2RXnZqhQ==
X-Google-Smtp-Source: ABdhPJzIsBGgktY1Uw2RqUWoMU33KsH/0a59nrOxFpzoAxXE7fbKTYrX7NXJlim1x/psRc1X6tTChA==
X-Received: by 2002:a65:44c4:: with SMTP id g4mr17804689pgs.254.1635691363442;
        Sun, 31 Oct 2021 07:42:43 -0700 (PDT)
Received: from localhost ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id w12sm16094817pjq.2.2021.10.31.07.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 07:42:43 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 3/4] coresight: etm4x: Don't trace contextID for non-root namespace in perf mode
Date:   Sun, 31 Oct 2021 22:42:13 +0800
Message-Id: <20211031144214.237879-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211031144214.237879-1-leo.yan@linaro.org>
References: <20211031144214.237879-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When runs in perf mode, the driver always enables the contextID tracing.
This can lead to confusion if the program runs in non-root PID namespace
and potentially leak kernel information.

When programs running in perf mode, this patch changes to only enable
contextID tracing for root PID namespace.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index e24252eaf8e4..6e614bfb38c6 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -615,7 +615,9 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 		config->cfg |= BIT(11);
 	}
 
-	if (attr->config & BIT(ETM_OPT_CTXTID))
+	/* Only trace contextID when runs in root PID namespace */
+	if ((attr->config & BIT(ETM_OPT_CTXTID)) &&
+	    (task_active_pid_ns(current) == &init_pid_ns))
 		/* bit[6], Context ID tracing bit */
 		config->cfg |= BIT(ETM4_CFG_BIT_CTXTID);
 
@@ -629,7 +631,11 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 			ret = -EINVAL;
 			goto out;
 		}
-		config->cfg |= BIT(ETM4_CFG_BIT_VMID) | BIT(ETM4_CFG_BIT_VMID_OPT);
+
+		/* Only trace virtual contextID when runs in root PID namespace */
+		if (task_active_pid_ns(current) == &init_pid_ns)
+			config->cfg |= BIT(ETM4_CFG_BIT_VMID) |
+				       BIT(ETM4_CFG_BIT_VMID_OPT);
 	}
 
 	/* return stack - enable if selected and supported */
-- 
2.25.1

