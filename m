Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFFA1447D74
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238696AbhKHKQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:16:23 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38212 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237414AbhKHKO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:14:58 -0500
Received: from zn.tnic (p200300ec2f33110088892b77bd117736.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:8889:2b77:bd11:7736])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BEB5A1EC04DE;
        Mon,  8 Nov 2021 11:12:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636366333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/n9zv3Ih/2b/ULU8CYj7KD0zgXcVtXxLDavocXSrT0w=;
        b=POP3CK1f/I03P+kpDnOv7Q/bh2MFk3no6AfJgV0+2NKHfn2NWmu4jJOoyA17+pWPwNBmyo
        BgbdWTxAF4YZwvU29DVvbgpwi8LSbpb4TYj8sayxKqBWgfhaFHQDBDRamWe64Fb68Fgpxv
        BJ69CX3Ff3OzXpKGSoKCWkfen9caYYw=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Subject: [PATCH v0 07/42] drm/i915: Check notifier registration return value
Date:   Mon,  8 Nov 2021 11:11:22 +0100
Message-Id: <20211108101157.15189-8-bp@alien8.de>
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
Cc: intel-gvt-dev@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/i915/gvt/scheduler.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/scheduler.c b/drivers/gpu/drm/i915/gvt/scheduler.c
index 6c804102528b..3bafaca5789f 100644
--- a/drivers/gpu/drm/i915/gvt/scheduler.c
+++ b/drivers/gpu/drm/i915/gvt/scheduler.c
@@ -1277,8 +1277,10 @@ int intel_gvt_init_workload_scheduler(struct intel_gvt *gvt)
 
 		gvt->shadow_ctx_notifier_block[i].notifier_call =
 					shadow_context_status_change;
-		atomic_notifier_chain_register(&engine->context_status_notifier,
-					&gvt->shadow_ctx_notifier_block[i]);
+
+		if (atomic_notifier_chain_register(&engine->context_status_notifier,
+						   &gvt->shadow_ctx_notifier_block[i]))
+			pr_warn("Context status notifier %d already registered\n", i);
 	}
 
 	return 0;
-- 
2.29.2

