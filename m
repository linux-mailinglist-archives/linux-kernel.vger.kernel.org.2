Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1B13F24CB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 04:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237697AbhHTCfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 22:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237269AbhHTCfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 22:35:03 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA04BC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 19:34:26 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id dt3so4778991qvb.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 19:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VoGBCWp3KCNfgB/Df5rElpIhp6P6dUadsEIrn/tjMyk=;
        b=lHDeTH5eYqmuMWehbWpNCnLy2x0qltq/wnwxqkp574COOjpeXYoxZVWThj7NyFE4Hi
         l/CnAimflK3MxW5xhT4W8ka6ZLHUaDWQzpkFPzTpzq3Og5s6yvjiG8zfsBaO/jgD4YGO
         bTnRSmIAKyJZMc5pUS4M2QvBR3CpGElgz8DMmvu6ifKoqlKVCpzNNafrJgsxgUo2kQUG
         a08TX9h1Kl0IOdPoAgesC+DBRz1YaJfYqE7qbb4vKSDkqtDMMgaqa6fGRpB9wFvFkNsh
         vUQZUBeAwGQnBdpkhEsSP5WxmfJXE8fi9YY5Qa+bEoHeN7heCyMtez5XMOojON14pFip
         fAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VoGBCWp3KCNfgB/Df5rElpIhp6P6dUadsEIrn/tjMyk=;
        b=aA/TdueqCu6r7Dlqo/7qOAEpNE75E8gbG5azaJrv2Evu0PAGBVCYbQfsJrBlSfRgdR
         RsRgAa8IrbbQ1kfXnrsSZGwxiZoxskCbZgkBr6i4OF5kOyF4JE00JzFbILdFBU8SXDqP
         e7R650NxbvxrBt/ZqvrFZlqaiXmfgWtpaBhyryMKte3NC35YZYsBZ5bHjyOANjt4Gage
         8P7RVLijmqGiXlsu1YhHtZgdwuWIPPnqexjbRrpVi9L/GHByEr+r2zPOSdZoUFjLUkU5
         ZUoU0Pv3AqYnd73RhuRghEReJ0JPs3DPicwaxnmN3hHlGdbLj5cS81Lz3ssR/LvRFvBU
         c/gg==
X-Gm-Message-State: AOAM531GpeMiuU9nr1Sf8vqaT1W1Sgs87BJTh3DbzfT+wGHEDg7yghCJ
        sAiZuyodwQS25JBuDYDGKcY=
X-Google-Smtp-Source: ABdhPJzYzgrCRZIg+O/2IZU7ylfpuT40S9ORMT3V/sxyKAAUeNrRmqvLLZ+J+8sSB2r4iqlr4XJ2AQ==
X-Received: by 2002:ad4:54f2:: with SMTP id k18mr17878753qvx.24.1629426866086;
        Thu, 19 Aug 2021 19:34:26 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id r18sm2119277qtm.96.2021.08.19.19.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 19:34:25 -0700 (PDT)
From:   jing yangyang <cgel.zte@gmail.com>
X-Google-Original-From: jing yangyang <jing.yangyang@zte.com.cn>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        jing yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] macintosh: fix warning comparing pointer to 0
Date:   Thu, 19 Aug 2021 19:34:14 -0700
Message-Id: <b12b200502312957065a12f8d78e8d250c244d21.1629193159.git.jing.yangyang@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

./drivers/macintosh/windfarm_pm91.c:152:12-13:WARNING comparing pointer to 0

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>
---
 drivers/macintosh/windfarm_pm91.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/windfarm_pm91.c b/drivers/macintosh/windfarm_pm91.c
index 3f346af..568f8a2 100644
--- a/drivers/macintosh/windfarm_pm91.c
+++ b/drivers/macintosh/windfarm_pm91.c
@@ -149,7 +149,7 @@ static void wf_smu_create_cpu_fans(void)
 
 	/* First, locate the PID params in SMU SBD */
 	hdr = smu_get_sdb_partition(SMU_SDB_CPUPIDDATA_ID, NULL);
-	if (hdr == 0) {
+	if (!hdr) {
 		printk(KERN_WARNING "windfarm: CPU PID fan config not found "
 		       "max fan speed\n");
 		goto fail;
-- 
1.8.3.1


