Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741C9447DB0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238822AbhKHKTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238642AbhKHKPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:15:39 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7926C061220
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 02:12:39 -0800 (PST)
Received: from zn.tnic (p200300ec2f33110088892b77bd117736.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:8889:2b77:bd11:7736])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 79C881EC052A;
        Mon,  8 Nov 2021 11:12:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636366358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I5C5KaPMNkId+WvkDE2ITw4GnQtUUojtBVUD4mzClAg=;
        b=EN2uwZY90FbtAenrLusETZ3c0OEaf5+STGYUDETB+fuklFOUEFa7DeVXNq62rkLLcGVNQb
        fPItqHAzoGFy6tn5apT2TCpeseVK37U5/jxs/CYJZlUjdAxSFdWi+REUqOL054G1vt4UXc
        oaLrEH5Y7zyf/Ts1UqhrFVPA971QQCw=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-xtensa@linux-xtensa.org
Subject: [PATCH v0 38/42] xtensa: Check notifier registration return value
Date:   Mon,  8 Nov 2021 11:11:53 +0100
Message-Id: <20211108101157.15189-39-bp@alien8.de>
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
Cc: linux-xtensa@linux-xtensa.org
---
 arch/xtensa/platforms/iss/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/xtensa/platforms/iss/setup.c b/arch/xtensa/platforms/iss/setup.c
index d3433e1bb94e..00b847e3cb76 100644
--- a/arch/xtensa/platforms/iss/setup.c
+++ b/arch/xtensa/platforms/iss/setup.c
@@ -81,5 +81,6 @@ void __init platform_setup(char **p_cmdline)
 		}
 	}
 
-	atomic_notifier_chain_register(&panic_notifier_list, &iss_panic_block);
+	if (atomic_notifier_chain_register(&panic_notifier_list, &iss_panic_block))
+		pr_warn("Panic notifier already registered\n");
 }
-- 
2.29.2

