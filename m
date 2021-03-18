Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B031340155
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 09:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhCRIw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 04:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhCRIwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 04:52:04 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6D9C061760
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:52:03 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id r15-20020a05600c35cfb029010e639ca09eso4913456wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GaackZ/z/LereQfTWx6EZY6YyaXRiP4t4NnTncEoRCA=;
        b=hOaFBnS1qL4EZR4viHQwVJgMva2mOeGRvIL4fuUMRhTF5KlXTL27cypHXcqyLPU9ym
         ptdWABTJunZmopbdxFY3/uyiRuUeA3/Q3UEN80dQm1oAGG49y9/rHmtT7WO3d+psKtIW
         4Wo9VIBg0fX6g9AnuIt18/iI+tv+gBWlBhyXS+hlNi+aLHsijUkLw3BrOUaLxh9SxQuV
         60+NQBDb9bQUXgG60CAZM6YSRq7WwpTT8gOFnLvS7dDyaQ/K4PwYAiaFZaQHjncg+ZjY
         I9puisGMIqbK3GatIdPjfeiOHp4t9xQN748FETqDNEtbHMcYlfVs2JhY0w2VtLpEZsHT
         kEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GaackZ/z/LereQfTWx6EZY6YyaXRiP4t4NnTncEoRCA=;
        b=JP7tqlAE5F3qP0Wrcu6Um2NGTGCwJ+TqqslbshlAPVX1NioeQxRytHWILQq/mzveqf
         zl4vHBX0pOWTWjbkNJ0Sr/zuliaeAkefFtsHTPXmM8lgZ3ciwEsVsG2k6Zvic6xAWjgU
         J1+6qgcxPu1nH2G7K7zp6G6UXypKQwW4YsA+XMASuKs5tabHolBoBtZBr50ekbmxztaE
         EjJSROPjvNxjAOQi4ShZ5KKUQJWkYTtzTHftbVJyzYffdUulKBQ0VZP8q79ploaIu8vc
         BX11c8dULktvHUR/6xi5IAEpO3QgVFyZ0MjEFO0zjT7+qvoZX+oNuHUG2ejepa47SOX6
         XA0g==
X-Gm-Message-State: AOAM532RQThbvSBoVK0r3xniHPgXp2/cd5aJVTlV/4ai3BFoYCMjK7V9
        04dRsM8/5brL2/T2UUhZxQmh7A==
X-Google-Smtp-Source: ABdhPJxyXMICdkigPOOwmxZ9OVNAiEXw7pw+/JSuD26xTSpiSRESPA5e655cnDxb8hRfkdI6Or5ojg==
X-Received: by 2002:a05:600c:b57:: with SMTP id k23mr2456756wmr.145.1616057522356;
        Thu, 18 Mar 2021 01:52:02 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id w131sm1526868wmb.8.2021.03.18.01.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 01:52:01 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Colten Edwards <pje120@cs.usask.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-ide@vger.kernel.org
Subject: [PATCH 11/15] ata: pata_legacy: Repair a couple kernel-doc problems
Date:   Thu, 18 Mar 2021 08:51:46 +0000
Message-Id: <20210318085150.3131936-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318085150.3131936-1-lee.jones@linaro.org>
References: <20210318085150.3131936-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_legacy.c:606: warning: expecting prototype for opt82c465mv_qc_issue(). Prototype was for opti82c46x_qc_issue() instead
 drivers/ata/pata_legacy.c:933: warning: Function parameter or member 'probe' not described in 'legacy_init_one'
 drivers/ata/pata_legacy.c:933: warning: Excess function parameter 'pl' description in 'legacy_init_one'
 drivers/ata/pata_legacy.c:1024: warning: Function parameter or member 'primary' not described in 'legacy_check_special_cases'
 drivers/ata/pata_legacy.c:1024: warning: Function parameter or member 'secondary' not described in 'legacy_check_special_cases'
 drivers/ata/pata_legacy.c:1024: warning: Excess function parameter 'master' description in 'legacy_check_special_cases'
 drivers/ata/pata_legacy.c:1024: warning: Excess function parameter 'master' description in 'legacy_check_special_cases'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Colten Edwards <pje120@cs.usask.ca>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_legacy.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index 4fd12b20df239..a7235bde6ae87 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -588,7 +588,7 @@ static void opti82c46x_set_piomode(struct ata_port *ap, struct ata_device *adev)
 }
 
 /**
- *	opt82c465mv_qc_issue		-	command issue
+ *	opti82c46x_qc_issue		-	command issue
  *	@qc: command pending
  *
  *	Called when the libata layer is about to issue a command. We wrap
@@ -923,7 +923,7 @@ static __init int probe_chip_type(struct legacy_probe *probe)
 
 /**
  *	legacy_init_one		-	attach a legacy interface
- *	@pl: probe record
+ *	@probe: probe record
  *
  *	Register an ISA bus IDE interface. Such interfaces are PIO and we
  *	assume do not support IRQ sharing.
@@ -1009,8 +1009,8 @@ static __init int legacy_init_one(struct legacy_probe *probe)
 /**
  *	legacy_check_special_cases	-	ATA special cases
  *	@p: PCI device to check
- *	@master: set this if we find an ATA master
- *	@master: set this if we find an ATA secondary
+ *	@primary: set this if we find an ATA master
+ *	@secondary: set this if we find an ATA secondary
  *
  *	A small number of vendors implemented early PCI ATA interfaces
  *	on bridge logic without the ATA interface being PCI visible.
-- 
2.27.0

