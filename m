Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E581738944B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 19:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355479AbhESRDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 13:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238398AbhESRDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 13:03:48 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0024FC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 10:02:26 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q5so14779872wrs.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 10:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=tGWKO5u7gpqNCAE2Ums4MXR4h+ThFKB7vvcoqwCqQfo=;
        b=Srn/M9pbAH/Y4bbXNXDSEChfg4VZJITbIPL3sH1PFlhwbn7zX+0YsUIFi6hRgck+b4
         O08gyrw7cZnaMaF/DAoecVKa9TfhKFYXaY3OQotkemHeCfS27I6eUMEX4kWMgNn1jo5s
         YD7Z2haTrtxqri4453WaG0dzJMcJJJR/nPhLxVeHgzXanHwlMJ3I3lgkqHBda41Ngf/I
         8m0ZWzsYzQOMWEUCXoZBKjpQ3/FGPE6yID0Dv81CHZpmR5UgZe2EfOVqeQZWa33RV5kt
         oLrCNOYkm+SFRdBP2RzWTLJoErIxZMnwuGA4UBsXrWucIIx23f6DtJidyqNFORFMwauS
         DPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tGWKO5u7gpqNCAE2Ums4MXR4h+ThFKB7vvcoqwCqQfo=;
        b=aEqfG5ziWMFBUtvV9YKMzpvf1NzWSflLzVxt4VhpCFSWl747KfiFzXHwDasMwcmVPh
         OfC9iaMl2wVl4G011V+xlLLi7ooKAvBeG8XxLS8UR0LBhMkOKo0FIfmfsMeQYIbkel5z
         sWeq6hJuCME0Ye1eAehpYYdcwbs/r70zaj9o5aEbAcowPPsJB1R7f9gvcpvIywpbegGa
         XcoH4+JgQK9G2onX/Yns11K0wWdGfgLLEa+735S0DfFB112Pgm5kPJLM5+Q466L4Ctv0
         uj40LgB2N/MJ5nIu1jNRcljSzi3soKEpv/xQ+iOeXZPVVHyHMC6B0LKmO4ogcGPVyk4O
         3UXw==
X-Gm-Message-State: AOAM532l34LHTO6TFEIZGtR4mBHMUsCvCBTaXKRm927uDd1KUXq4jRi5
        r1YY0mWz5aCYc/LAuGrk7eT8TlDh0U5iG0IH
X-Google-Smtp-Source: ABdhPJz1O7BqkGxZa6eDlyAv6XN+9R0/JKmc7TvGyLZte6b6EI/WtKG+sa00F0QHu6h9Rb/gRbvM5g==
X-Received: by 2002:adf:e4c8:: with SMTP id v8mr15842465wrm.345.1621443745369;
        Wed, 19 May 2021 10:02:25 -0700 (PDT)
Received: from lmecxl0524.home (2a01cb058b850800205e07f10870202e.ipv6.abo.wanadoo.fr. [2a01:cb05:8b85:800:205e:7f1:870:202e])
        by smtp.gmail.com with ESMTPSA id q1sm6390561wmq.48.2021.05.19.10.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 10:02:24 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH 1/3] firmware: arm_scmi: fix deps arm-smccc-discovery deps in Kconfig
Date:   Wed, 19 May 2021 19:01:56 +0200
Message-Id: <20210519170158.27586-1-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM_SCMI_PROTOCOL depends one either MAILBOX or HAVE_ARM_SMCCC_DISCOVERY,
not MAILBOX only. This change fixes this in Kconfig file and driver
private header file.

Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
 drivers/firmware/Kconfig           | 2 +-
 drivers/firmware/arm_scmi/common.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index db0ea2d2d75a..a9c613c32282 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -9,7 +9,7 @@ menu "Firmware Drivers"
 config ARM_SCMI_PROTOCOL
 	tristate "ARM System Control and Management Interface (SCMI) Message Protocol"
 	depends on ARM || ARM64 || COMPILE_TEST
-	depends on MAILBOX
+	depends on MAILBOX || HAVE_ARM_SMCCC_DISCOVERY
 	help
 	  ARM System Control and Management Interface (SCMI) protocol is a
 	  set of operating system-independent software interfaces that are
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 228bf4a71d23..8685619d38f9 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -331,7 +331,7 @@ struct scmi_desc {
 };
 
 extern const struct scmi_desc scmi_mailbox_desc;
-#ifdef CONFIG_HAVE_ARM_SMCCC
+#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
 extern const struct scmi_desc scmi_smc_desc;
 #endif
 
-- 
2.17.1

