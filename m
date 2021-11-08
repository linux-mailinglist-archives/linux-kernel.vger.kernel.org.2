Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202BA447D61
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238623AbhKHKPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:15:34 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38212 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231913AbhKHKO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:14:56 -0500
Received: from zn.tnic (p200300ec2f33110088892b77bd117736.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:8889:2b77:bd11:7736])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 29D9B1EC04DF;
        Mon,  8 Nov 2021 11:12:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636366332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1CKqF0DE8Be0vB1u1hCxGErnnln1gggVNvwi7ZjWJYY=;
        b=Y2KW/uok9k083wPWd+LGCZ4Ee3hUJbEvZMNHddmCdMXlFKLsDJT7vveXIXQTO647NITs3C
        J5lucPD3q0bOJwu55O4iDw3VLHz0krF1jsaPHa04RCrPpseyDOR3PAavfJdMjxv2wchwEi
        +E77VBKRX5oMStFhA2QAR+/BeYY3B6M=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v0 05/42] dca: Check notifier registration return value
Date:   Mon,  8 Nov 2021 11:11:20 +0100
Message-Id: <20211108101157.15189-6-bp@alien8.de>
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
---
 drivers/dca/dca-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dca/dca-core.c b/drivers/dca/dca-core.c
index c40c2ebfdae9..3e8f52214652 100644
--- a/drivers/dca/dca-core.c
+++ b/drivers/dca/dca-core.c
@@ -428,7 +428,8 @@ EXPORT_SYMBOL_GPL(unregister_dca_provider);
  */
 void dca_register_notify(struct notifier_block *nb)
 {
-	blocking_notifier_chain_register(&dca_provider_chain, nb);
+	if (blocking_notifier_chain_register(&dca_provider_chain, nb))
+		pr_warn("dca provider notifier already registered\n");
 }
 EXPORT_SYMBOL_GPL(dca_register_notify);
 
-- 
2.29.2

