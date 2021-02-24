Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08563243C8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 19:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbhBXSbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 13:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbhBXSbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 13:31:17 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4F3C061788
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 10:30:36 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m1so2720325wml.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 10:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wL1K9/n9PLRogotOLHvr5IREgjJjcX+pqPJAFHVOgkU=;
        b=h8fU3PBtSJjDPXgYs4/F4zTb4uHPnuRvghS3AJGYylHqnn11+oCHrRntCw2aOZXOnr
         KVy23orYJRYTnNI2w2+woHMgi1WG/1OgBES/Lu/gu0gfZG+SVaSFZJp4hzHUBHUAFLBK
         Fu3bbUnpoF/vzDJ0BXmUCMzl9qVuStBA/Hxqs2qVQ5ReNcTSvuoigefy2BE3zyn050Tc
         8tuawF1aelGfd8OPDaGtCb2e4jO61uwnO/E6/aIrQyKMSQHYCo073eDsYBe/gFO1aFAH
         kc+hdIUw0fbr7CgLdhqKDpvnpD5unIDtAFV1YvDw/O8Eq5jx89HJp5W9D1jczRd7q0ls
         FlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wL1K9/n9PLRogotOLHvr5IREgjJjcX+pqPJAFHVOgkU=;
        b=oG1KB2d7C1d0/v1DVX7+hrhX2dlC24xW1+pyPcN1PcoWGuL/9EuBy8dWF27VmOAlqD
         On4X85iUhLFqcjcjnEAMUwK3zTt7nDYEUDaPIr9OM0KwHm3XJV9ZEdb2b5kAKfsyR0+4
         EBsYH2FT8pEGIhtgyBuKlmeeP3j5JIamCLZW2dkSw+PMcC4O7YYk76CvOCOtOh2ZoyLc
         riVi5/DfALZ0+Q27AaVFGJXrocDov7BscAZudoJGJj6Xh2JTT915VXNhdGhHwwfRIzqU
         p+ah6nB6u5oQmTY4kihMNZEPNmRT8SB6uP3KDGsGQ8XskU8RmxDFrjTT7tslUewb5pt2
         SomA==
X-Gm-Message-State: AOAM532+hM2XiElq/0Dcnz3CMkAh4H551szfnjp9BK3Z1o0e7ZpFG6e+
        Lwljobjey/WWVy6/nkYdXS8q2Q==
X-Google-Smtp-Source: ABdhPJzuaCGVLQBXibxUShW+ewHVnBZ8EoV2btHiqLSkz3hyIphMVMElhwBxNmR7UVT1qw+fL8pypw==
X-Received: by 2002:a05:600c:2942:: with SMTP id n2mr515523wmd.137.1614191435563;
        Wed, 24 Feb 2021 10:30:35 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-157-252.adsl.proxad.net. [82.252.157.252])
        by smtp.gmail.com with ESMTPSA id c12sm5105987wru.71.2021.02.24.10.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 10:30:35 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 2/2] powercap/drivers/dtpm: Add the experimental label to the option description
Date:   Wed, 24 Feb 2021 19:30:22 +0100
Message-Id: <20210224183022.11846-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210224183022.11846-1-daniel.lezcano@linaro.org>
References: <20210224183022.11846-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DTPM framework will evolve in the next cycles. Let's add a
temporary EXPERIMENTAL tag to the option so users will be aware the
API may change over time.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
index 20b4325c6161..8242e8c5ed77 100644
--- a/drivers/powercap/Kconfig
+++ b/drivers/powercap/Kconfig
@@ -45,7 +45,7 @@ config IDLE_INJECT
 	  on a per CPU basis.
 
 config DTPM
-	bool "Power capping for Dynamic Thermal Power Management"
+	bool "Power capping for Dynamic Thermal Power Management (EXPERIMENTAL)"
 	help
 	  This enables support for the power capping for the dynamic
 	  thermal power management userspace engine.
-- 
2.17.1

