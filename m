Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE1E3995DF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 00:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhFBW0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 18:26:32 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:36408 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhFBW0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 18:26:31 -0400
Received: by mail-ed1-f50.google.com with SMTP id w21so4663414edv.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 15:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qBpa/cpofHvmcHx3LHuTwb3Zzf828m3Uc7MASj7qIrU=;
        b=uOwXr+nrw4AgIqT4dwpisz0E62205LgzTu1Bu64GjwqIodNTUqnYTcz6bYceFPK5LA
         a2hNBDKTZfadjo6M8t6vtJjo1fsH+mHGKA5wz0FAu2JUVxIcpxR8ykV8ySL93YtiCjz7
         eMSndm7oRbxqevzJAFxuU6hydYpRrGX7jcH5NVsknS7qRoZtyK9KX0GCnihogRSGyn1z
         b0/+jeyte60z1C3dCGmNjOPm4Q/Dma9cSSuTYmdcZziFIeEd9gnD4qgFWAIbgeTMaguZ
         ALMlLY0Ny1uxAb4dbD/SML7JmecrLqKAaPpqenbbgHDcwSoyjpSZwGwb8OpXTU+XU7vT
         fl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qBpa/cpofHvmcHx3LHuTwb3Zzf828m3Uc7MASj7qIrU=;
        b=hfOYX7K9tEOlGUay+vka85mjMTeAirnj28W+TG84ofRZKd3Ps80NPFoZPqOnM+KkSo
         XFLKtAp+uYv3QAI/kv2cg5LhpE1vUhveCUUiEdSixfJf48k/j4fM8APfVMpqv+cEfK2Z
         s/y87tIPTt3sdXEJ8GFx+Z2QceZIkMWSpyevsY6TKt2+EdneT7kULVJSkg+OFPMfl25O
         HPffd40ShqgEjidBBFQ9zHpru/+1P2iGcAzFRclXpKG/wLg9CD146Ju3aSV3DNsTCKEt
         AvUnSWPveaGBVwau2WWtd4GGKt+KJ0kUkgzId1yGjlFpGNNkM5bGzgPq1n/jJ7MPdp9w
         5S8A==
X-Gm-Message-State: AOAM53108NPBpMkQ8bakRXj28AOHwq1zLrOSi7t74rmYS8AdY/1Q+MEp
        xGrL1qv6SnyzT3Tog9Ktow5dKcng2+hB0w==
X-Google-Smtp-Source: ABdhPJxo5pFq3eqZO8RHzX67zKoCEunUG8nvwDZzJ0DLb5Ogny+xRVovLD+JLzNMC/KbcS3QjmTBTw==
X-Received: by 2002:a50:99d5:: with SMTP id n21mr478767edb.223.1622672611643;
        Wed, 02 Jun 2021 15:23:31 -0700 (PDT)
Received: from linux.local (host-79-52-107-152.retail.telecomitalia.it. [79.52.107.152])
        by smtp.gmail.com with ESMTPSA id i2sm636201edc.96.2021.06.02.15.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 15:23:31 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] x86: kernel: cpu: resctrl: Fix kernel-doc in pseudo_lock.c
Date:   Thu,  3 Jun 2021 00:23:26 +0200
Message-Id: <20210602222326.7765-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed sparse warnings about the descriptions of some function
parameters.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index f6451abddb09..c3629db90570 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -520,7 +520,7 @@ static int pseudo_lock_fn(void *_rdtgrp)
 
 /**
  * rdtgroup_monitor_in_progress - Test if monitoring in progress
- * @r: resource group being queried
+ * @rdtgrp: resource group being queried
  *
  * Return: 1 if monitor groups have been created for this resource
  * group, 0 otherwise.
@@ -1140,6 +1140,8 @@ static int measure_l3_residency(void *_plr)
 
 /**
  * pseudo_lock_measure_cycles - Trigger latency measure to pseudo-locked region
+ * @rdtgrp: resource group to which the pseudo-locked region belongs
+ * @sel: cache level selector
  *
  * The measurement of latency to access a pseudo-locked region should be
  * done from a cpu that is associated with that pseudo-locked region.
-- 
2.31.1

