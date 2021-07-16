Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7A93CBBC8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 20:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhGPSYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 14:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbhGPSYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 14:24:31 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C245C061760
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 11:21:36 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id b12so9607679pfv.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 11:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vex/ILcK4R2NwDbM2MbyC5BMouO4aXJ8r7D/S/2nS9M=;
        b=KSHGl7mK7fBaWCbtK+7mAwjHkhOrLqJ8rrAw814K7gfvDpirfHc7dZFSHpqfn7oFnH
         FYxP24S0y6pGK4UqmDusQCugCky0pM9/nHjexGZTZV7Eaj92CZEtsR/HQnRCMmQu6UVX
         d8b+XpGZlFjqFk2Dd5h8tKoIUuIhLgowYqLFZpP1RL5cHleYpb4lm2HZPotDmjYaSDJ0
         fNeddVbBtXOpF81YzWSyJjnDaJv094tzFYHCAabIO9Rid7jLJELkTiG2nzQs+P2DndSP
         eEm7Fv3iALoFUJSH64bJzOR82mRTnMc+bW/A9bUBdHML2/VdOwLrMbiau2U29SL1eC+9
         Hq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vex/ILcK4R2NwDbM2MbyC5BMouO4aXJ8r7D/S/2nS9M=;
        b=rE7mG3uOYfXLVmAIGRLbhCumh8f97qWKXmYn2w6tTrBOWxMqwgcSoJ0l2acq+iUeE4
         7RaOApUjCNLlj8FgYKOCEkCYHOeDa2wHkl1QN3BJ3UVr1mn8b+myv5cjjOnVY2Rlr/Jf
         rZPr+u+oFJl7BtyAMsuPS0BEFKVQ/erYfLOThIxZLfl8X2nmAI1gpiuv3kZS/Yj+/M0Y
         T2A5KIB496CfQs9fAaCkWC2TnZ9Azn1H1nWXSs9Q0EjDVp6rkzohv5Mrw7mwcboPrzxM
         vfaylHhrTerJ8Pl7iugKNyJGSwandnksI5EL4zvs4efSH3qEl5ymfqj5/Zb6EZsC0Snw
         CrbA==
X-Gm-Message-State: AOAM531jhsoVUV6yhamsjU+A2MYC2oAkjgsYFEwBUIeDZ8reUncubdh2
        D28PyMAqmXnPUcAFoTXX7zQ=
X-Google-Smtp-Source: ABdhPJw4mqlIyJ2lRqZvtFnkuvSYeRjgc5NOQGzCA3GGq44DjGlf8dVXTrUov/zt/yclKr/1IdewXQ==
X-Received: by 2002:a63:5511:: with SMTP id j17mr11385443pgb.191.1626459695892;
        Fri, 16 Jul 2021 11:21:35 -0700 (PDT)
Received: from localhost.localdomain ([49.37.48.177])
        by smtp.gmail.com with ESMTPSA id r15sm9001824pje.12.2021.07.16.11.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 11:21:35 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org,
        apw@canonical.com, Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH] checkpatch: remove obsolete check for __dev* section markers
Date:   Fri, 16 Jul 2021 23:51:26 +0530
Message-Id: <20210716182126.4392-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 54b956b90360 ("Remove __dev* markings from init.h")
completely removed the definitions of __dev* section
markers from init.h. They can no longer pop up in the kernel
and hence the check for those markers is unneeded now.

So remove __dev* section markers check from checkpatch.

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 461d4221e4a4..e29c0961b25e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4023,12 +4023,6 @@ sub process {
 			     "CVS style keyword markers, these will _not_ be updated\n". $herecurr);
 		}
 
-# check for old HOTPLUG __dev<foo> section markings
-		if ($line =~ /\b(__dev(init|exit)(data|const|))\b/) {
-			WARN("HOTPLUG_SECTION",
-			     "Using $1 is unnecessary\n" . $herecurr);
-		}
-
 # Check for potential 'bare' types
 		my ($stat, $cond, $line_nr_next, $remain_next, $off_next,
 		    $realline_next);
-- 
2.28.0

