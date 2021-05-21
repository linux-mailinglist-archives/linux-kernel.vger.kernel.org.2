Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8D838C884
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 15:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236346AbhEUNme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 09:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbhEUNm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 09:42:27 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3056C0613ED
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:41:02 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id b7so10568832wmh.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=OrsL3ijuFSJ3ZZgJ9AxoZPMhh9aQmo9XUjzO0XjBs/0=;
        b=ISHFNr4RS6qw0pElX+tFiTJdSzm/pDscdwn2Jk0uOFOAW0hvfsBxw+omu/rd/T72DI
         KHrTvEN7ZYAQAyYGqqI38syyVLaBzqmPoIItwzSCf4Cnnk5qBl8BkZcdebrSjTnrN2Ma
         SXu+JEMBVcQ9BANF6NGSwXhBG9cXuD/i7jwe9rmfucyUHfCJMoMvARkYhyTtzX/ZNIEA
         HTjY3jwbaGAbBHMPaG5jPmI9icdbcPFG1baAPT+a1XQ3s3hqIioIamsA3Odqcljy9cpU
         TLjZrEhh7vIIUasczmsIXV3MROsfxdZDI1G6PDlKSOzEtNiLwroSNLWo/zCSFpODd1Up
         WqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OrsL3ijuFSJ3ZZgJ9AxoZPMhh9aQmo9XUjzO0XjBs/0=;
        b=qMk6TF2nfV3Oe9Np9+oOJqhpG+Gx/7ROtH3B9sYjO/mJT4gMcjH29rMgMGzOinyfsA
         0QYeYBSkIh4knkIGdyXoSdHcbcDsfbawZZBCYbK3ji4cDALwTRzq+FKk3djrDFVwMmwb
         dWp9W7lwmnjs8Of5QvsPFfNx/Oq73x+r7hp1yUSYY2kd92F8uH4VRWeTFB/5fFRiCTCs
         ZGUp7uS18WjEWqzMLQB4q/xdSIClniOrKv11Hjm8uNOxfI0041l46qGdLauFuNOctNQr
         A4s1lTHaHkr1jdX041Y6uNn1iJ+mspUndPgk30COpa8QIJ704rvOVBpeOKrSclNmBMpX
         F3gg==
X-Gm-Message-State: AOAM531ZIEIYE1hkI1ud3CbtXyPgC7kanoMcqc/lEr96ubfJDOkagNXT
        VohKeJWtvWOjdPEHKzSqbPKcgnrKmaD8F/Z8
X-Google-Smtp-Source: ABdhPJwYojvyeIOiL145Xr6wOf8/7FX0+5qHz+5IsU9AvaTL+XeekddE0zQe+K/uhzbxmNCjamROjA==
X-Received: by 2002:a7b:c252:: with SMTP id b18mr8938970wmj.32.1621604461145;
        Fri, 21 May 2021 06:41:01 -0700 (PDT)
Received: from lmecxl0524.home (2a01cb058b850800205e07f10870202e.ipv6.abo.wanadoo.fr. [2a01:cb05:8b85:800:205e:7f1:870:202e])
        by smtp.gmail.com with ESMTPSA id v3sm2161372wrr.19.2021.05.21.06.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 06:41:00 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH v2 1/4] firmware: arm_scmi: fix deps arm-smccc-discovery deps in Kconfig
Date:   Fri, 21 May 2021 15:40:51 +0200
Message-Id: <20210521134055.24271-1-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM_SCMI_PROTOCOL depends one either MAILBOX or HAVE_ARM_SMCCC_DISCOVERY,
not MAILBOX only. This change fixes this in Kconfig file and driver
private header file.

Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
No change since v1
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

