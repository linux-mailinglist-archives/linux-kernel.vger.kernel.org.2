Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E519447DA8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238703AbhKHKTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238628AbhKHKPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:15:35 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC571C06120B
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 02:12:31 -0800 (PST)
Received: from zn.tnic (p200300ec2f33110088892b77bd117736.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:8889:2b77:bd11:7736])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 452BD1EC051E;
        Mon,  8 Nov 2021 11:12:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636366350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tBs2L8hWR0xYGSYsNcuF1/5/ldlnD+5PTmvcTf/W4Tg=;
        b=BTe1imLKRDxct4JHKDpr11I57bb07Dw/mMDg+l/s4HXk0TmHNrhpHqwf+5/3+cfrp8/mJn
        wM+60SMpFNCWhMQh6mjdlOC7/9Q0t5rwKOUKPo1D8A3Dk/7O3G5DYfASQVASTzrtg/pmTr
        ONf0osyjECZXRLcNgLDjCrCiZpnhllk=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH v0 28/42] soc: bcm: brcmstb: pm: pm-arm: Check notifier registration return value
Date:   Mon,  8 Nov 2021 11:11:43 +0100
Message-Id: <20211108101157.15189-29-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211108101157.15189-1-bp@alien8.de>
References: <20211108101157.15189-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Avoid homegrown notifier registration checks.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: bcm-kernel-feedback-list@broadcom.com
---
 drivers/soc/bcm/brcmstb/pm/pm-arm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/bcm/brcmstb/pm/pm-arm.c b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
index 3cbb165d6e30..f80068ec57cb 100644
--- a/drivers/soc/bcm/brcmstb/pm/pm-arm.c
+++ b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
@@ -802,8 +802,9 @@ static int brcmstb_pm_probe(struct platform_device *pdev)
 		goto out;
 	}
 
-	atomic_notifier_chain_register(&panic_notifier_list,
-				       &brcmstb_pm_panic_nb);
+	if (atomic_notifier_chain_register(&panic_notifier_list,
+					   &brcmstb_pm_panic_nb))
+		pr_warn("Panic notifier already registered\n");
 
 	pm_power_off = brcmstb_pm_poweroff;
 	suspend_set_ops(&brcmstb_pm_ops);
-- 
2.29.2

