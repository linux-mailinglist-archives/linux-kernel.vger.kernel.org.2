Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0F7348822
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 05:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhCYE4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 00:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhCYE4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 00:56:08 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EC7C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 21:56:08 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id dc12so579869qvb.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 21:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vOFtZuQM5FOGdQFIrDEg+pIzjeEKYvcrx12za6vf1O0=;
        b=gPoRgrTks3ClfErl+qf6WYv6Ibocp4W5DAFvkHuXUNGHR6lH09kr3yWAv+1ZUR5zr+
         nnZH2NIXXgPGXTD9RA4XjFNU4FLtK7M2TTWkf+9ShMpk7IpZD2MvN/DstPp2ja25F5XN
         4J9b32flTGRyPswbDEPhmR2UPWLHx+iPLSvkarIN9cFr76zdqAS91m1akhq5mI1kve12
         8hnGCnYTc++axF8BcL8ouj1tz/hhVIPpKoEoaML5wMUi9aOlrY61hxx3viD/foD8KMk9
         m4RrRDg1s4m4wkt5xle+NylCY6AfvK4YhxjzHKqWoTHpUHbsctAnCWbUttMmtfvUmBON
         +avg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vOFtZuQM5FOGdQFIrDEg+pIzjeEKYvcrx12za6vf1O0=;
        b=TzgxMj9CQM9+r0uD1iEWDw2k0nAtXIC6abY13qHT6zN0rc5H02/gQk/uU7/fgyyXQp
         ZJIkcvdSooaHy9XL6dxIjwqIqcT0Z3IfcIeKZWtDmiIbsyEoHkR+E4nzp/Y3uMS6D7d0
         THXH0dp41mFaKd0vtZFD3fn1EV2ygQy3vMZB3z8Aonw2e7YfKXD7CtjPwHsNDIHDqSw+
         cRrebuq1Edg+R075H7FTjYUYbqi8E9s8z5Krt55wml3GoOH+LfpxelI4Hy4BRsuCkuQa
         UF1GG8MMek/fjmP75aPbjhqxi3q9ttNL0VYjdeHhSo1Qc1aKWYc7EqITs6QjFjRxgyvh
         FOsQ==
X-Gm-Message-State: AOAM5331UOVeT2QXzkUzt+QjJLO3tMMyBRJTN1iEiJMhiZSsrzrxHsCK
        x9YCFMVrTI53znM5u5pve9o=
X-Google-Smtp-Source: ABdhPJzqyXwNN/jf8QDJSc10yiaM/8FIp+EEf8E32vmo3B4cv9N95pi3hQp95FYSshzX8fLDYMc7TQ==
X-Received: by 2002:a0c:bec3:: with SMTP id f3mr6495511qvj.49.1616648168047;
        Wed, 24 Mar 2021 21:56:08 -0700 (PDT)
Received: from Slackware.localdomain ([156.146.55.176])
        by smtp.gmail.com with ESMTPSA id v35sm2955192qtd.56.2021.03.24.21.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 21:56:07 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     linux@armlinux.org.uk, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        unixbhaskar@gmail.com, yukuai3@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] ARM: imx: Fix a typo
Date:   Thu, 25 Mar 2021 10:25:23 +0530
Message-Id: <20210325045523.31237-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/confgiured/configured/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/arm/mach-imx/pm-imx5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/pm-imx5.c b/arch/arm/mach-imx/pm-imx5.c
index e9962b48e30c..2e3af2bc7758 100644
--- a/arch/arm/mach-imx/pm-imx5.c
+++ b/arch/arm/mach-imx/pm-imx5.c
@@ -45,7 +45,7 @@
  * This is also the lowest power state possible without affecting
  * non-cpu parts of the system.  For these reasons, imx5 should default
  * to always using this state for cpu idling.  The PM_SUSPEND_STANDBY also
- * uses this state and needs to take no action when registers remain confgiured
+ * uses this state and needs to take no action when registers remain configured
  * for this state.
  */
 #define IMX5_DEFAULT_CPU_IDLE_STATE WAIT_UNCLOCKED_POWER_OFF
--
2.30.1

