Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F8234EE57
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbhC3Qqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbhC3QpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:45:24 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48ACBC061764
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:24 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id x13so16872675wrs.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/4ggTZY5Mb2A++UxjsiJDknoDlbEazCL2TGQOUARVh0=;
        b=sW/D+3KH1+2NZF5e1/wNrvvDYSt5MRCR1hc33zkg3/9Nd/s1Y/24i7+LpnP+X1iym8
         B8jN+aLt+7X3e7nO0JA5/S30ze118bSWrme1DhEz6u/oePp77b7+XFHJ8zBS1TrDmvSY
         bYDGvaRwOe5g10vyBr7yX7Y5LGS9fyJ2YUQdZSa2nnJ+dpRDcKYuvxeIk81I6W7ch/Z1
         Gj8MTYEVaHVe/ZZ/kDCNgVDE2eLx1WYxlRx1tmv0+7etMuwSS+MIQb7BEITw1QAJXo38
         Ck19pqhLIFcsIFq+a6mdx2t92oeX+CpXicQPp/p3yU0+4zC5zT1m2B4/2B5QWOaVbGXr
         bw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/4ggTZY5Mb2A++UxjsiJDknoDlbEazCL2TGQOUARVh0=;
        b=VNl3ojfmSCKwcQ0AG9NK214+sLHHyfMH7zV6PgQa1kmOIRXuK0cBwXMB4vpItb2crN
         Rlr2C+469dDCa0SjnCKZTsOyQHIetuGK0a/MWwtvnx0EHM+c1o+QPjwa7wTdmW16VuzJ
         bV983BHnA62/36S50X8kSR/fen8kgUaCjODCtAtxGSe9B8AUEBgyAUomOwbI3t1PFcCe
         OB0AnDXqohmaV9HLYkARj368OHT1qPe3r/gOwJ2QhaGauuDan6Nbz7P9EEN8rQHSDvOe
         eqgBpxZtmbUtfHpPuZ8lm6wbh2k+tIL+KIUQwubASd3TtTIpR0ktIT+G7893kWLm+v80
         dZzw==
X-Gm-Message-State: AOAM533MGX96+IrViMhfGDEaz7j03TzufmNggI//PjGzsX8G+dPIwfll
        B5jmElhonnb9oGAHjxTrWHhgVw==
X-Google-Smtp-Source: ABdhPJwGHtvG6SwTcE6+U/TMsax0s13UFKaCdIO9mJcRKCNVdiMMjiwGTBr4H+JcJJEVghtMhskUag==
X-Received: by 2002:a5d:4d8d:: with SMTP id b13mr34238630wru.259.1617122723061;
        Tue, 30 Mar 2021 09:45:23 -0700 (PDT)
Received: from dell.default ([91.110.221.217])
        by smtp.gmail.com with ESMTPSA id a15sm25660805wrr.53.2021.03.30.09.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 09:45:22 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>,
        "Michael A. Halcrow" <mahalcro@us.ibm.com>,
        ecryptfs@vger.kernel.org
Subject: [PATCH 22/31] fs: ecryptfs: kthread: Demote file header and provide description for 'cred'
Date:   Tue, 30 Mar 2021 17:44:49 +0100
Message-Id: <20210330164458.1625478-23-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/ecryptfs/kthread.c:16: warning: cannot understand function prototype: 'struct ecryptfs_open_req '
 fs/ecryptfs/kthread.c:120: warning: Function parameter or member 'cred' not described in 'ecryptfs_privileged_open'

Cc: Tyler Hicks <code@tyhicks.com>
Cc: "Michael A. Halcrow" <mahalcro@us.ibm.com>
Cc: ecryptfs@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/ecryptfs/kthread.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ecryptfs/kthread.c b/fs/ecryptfs/kthread.c
index a7c903cb01a05..ae4cb4e2e1348 100644
--- a/fs/ecryptfs/kthread.c
+++ b/fs/ecryptfs/kthread.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * eCryptfs: Linux filesystem encryption layer
  *
  * Copyright (C) 2008 International Business Machines Corp.
@@ -108,6 +108,7 @@ void ecryptfs_destroy_kthread(void)
  * @lower_file: Result of dentry_open by root on lower dentry
  * @lower_dentry: Lower dentry for file to open
  * @lower_mnt: Lower vfsmount for file to open
+ * @cred: credential to use for this call
  *
  * This function gets a r/w file opened against the lower dentry.
  *
-- 
2.27.0

