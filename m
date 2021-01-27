Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279D43052D8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 07:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbhA0GHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 01:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbhA0Fpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 00:45:54 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2CCC061574
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 21:45:13 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id o16so837911pgg.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 21:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jhf/7eY+iUjXrBxdzvgD4JXoXhLha5DC8Z1kc7WekkU=;
        b=oXkwZqE9ljdZ3CUlralaquZtKEpUPc+yjeuZgHO7DT8BI6FqRYLwlDlOOQxAYgMZvh
         jwVhfP1zNiN62zgbePLkRL3oOmTH0dI0/p9wrob3ErD9bG33S9sv4fi0JKYghzIEWT1j
         WGccIY9uJvsh+vELSq2VD5pfCdZY1ZP6ip1t+thuQAHFLop24atoMhqMb8JpMejBROae
         JzduTxaTa47DainxwJxQFpd13Mpgnf66mOI3m5+YD0gUAEP0hllVWlYnAvbgPGucs8s3
         Eu0hJRDqczaWPbSLJYvHCP7TdJfayg5vvItAdZj1drwRcxjqXt5Pn5A265DfaKV2LQKC
         rm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jhf/7eY+iUjXrBxdzvgD4JXoXhLha5DC8Z1kc7WekkU=;
        b=XOiL/6qcqBOkPqEx2vVgDpfmYNqYFnbWsWbNeRM2ET4BtqlYBZkisNywpJ402Xqq8A
         Aou1x2U3ldj3Zz8GxdkhPfEm4yB44/+UFBSGPsMMAlN//PfrsKVSoFt28QD6PMaohzyw
         cjj3Dk3hjHVzoh0E471roEFzreYt3udJJaBuq3Kqdl24re3yetGrt3ikrUY6gTbRGCUS
         UpiS69m8xLaQO6FTDmGXIQNq0vijCHKe/2+u/gy6RnER5vAbl0NeiiNmudRxK0QAnvfv
         s3sVt6IW4UMMm6QaRrbZnrDb8OiULFfvC4J3f9SJ4qX0e+cEPulYq71jvehssh2Z7oCD
         t4zA==
X-Gm-Message-State: AOAM5301WVqnqYjYAhBlqWRBSQv3q0YDz1z+5oErKTvGFZjx5hYOfy+G
        HuddgBc5Jum18m2ky5vwQATfmgLZP6o/lDOj
X-Google-Smtp-Source: ABdhPJwViuSz1Aio3CaCQIALcETPd9tUd+ujZ43P1epmfIHLWoWx7y7iHLkEv5sowxFq8rO9KABCAQ==
X-Received: by 2002:a63:5fcf:: with SMTP id t198mr9348426pgb.226.1611726313460;
        Tue, 26 Jan 2021 21:45:13 -0800 (PST)
Received: from tj.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id t6sm867024pfe.177.2021.01.26.21.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 21:45:12 -0800 (PST)
From:   Yue Hu <zbestahu@gmail.com>
To:     valentin.schneider@arm.com, thara.gopinath@linaro.org,
        peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, huyue2@yulong.com,
        zhangwen@yulong.com, zbestahu@163.com
Subject: [PATCH] init/Kconfig: correct thermal pressure retrieve API
Date:   Wed, 27 Jan 2021 13:44:51 +0800
Message-Id: <20210127054451.1240-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

We're using arch_scale_thermal_pressure() to retrieve per CPU thermal
pressure.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 init/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index c4e0a7e..5b35e15 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -525,7 +525,7 @@ config SCHED_THERMAL_PRESSURE
 	  i.e. put less load on throttled CPUs than on non/less throttled ones.
 
 	  This requires the architecture to implement
-	  arch_set_thermal_pressure() and arch_get_thermal_pressure().
+	  arch_set_thermal_pressure() and arch_scale_thermal_pressure().
 
 config BSD_PROCESS_ACCT
 	bool "BSD Process Accounting"
-- 
1.9.1

