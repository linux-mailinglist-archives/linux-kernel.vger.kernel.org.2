Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9CC1447D95
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237780AbhKHKRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:17:07 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38342 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238558AbhKHKPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:15:07 -0500
Received: from zn.tnic (p200300ec2f33110088892b77bd117736.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:8889:2b77:bd11:7736])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8A4191EC0503;
        Mon,  8 Nov 2021 11:12:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636366342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7P+1psRq8/HfQacGi22yCZu748tDOEEg0nO5q6foNi4=;
        b=cIuplv9KGmaQtphcAaDmcAC6xl2w0MeOIR4hIYs0MWfdHX/ARzmJwX7Xt95BiWbeP7Vaow
        /rT1rXqSh9J/jjp/apNMzA/3yRoAtxZawFAJ4KXO2c1kiVMYVwd5D7e8KJhBqrHyMaQLq5
        1uAygH3VwNg7vzyFj/holnwvkHSBmBA=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     xen-devel@lists.xenproject.org
Subject: [PATCH v0 18/42] drivers/xen: Check notifier registration return value
Date:   Mon,  8 Nov 2021 11:11:33 +0100
Message-Id: <20211108101157.15189-19-bp@alien8.de>
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
Cc: xen-devel@lists.xenproject.org
---
 drivers/xen/manage.c              | 3 ++-
 drivers/xen/xenbus/xenbus_probe.c | 8 +++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/xen/manage.c b/drivers/xen/manage.c
index 374d36de7f5a..f3c5cef0995f 100644
--- a/drivers/xen/manage.c
+++ b/drivers/xen/manage.c
@@ -48,7 +48,8 @@ static RAW_NOTIFIER_HEAD(xen_resume_notifier);
 
 void xen_resume_notifier_register(struct notifier_block *nb)
 {
-	raw_notifier_chain_register(&xen_resume_notifier, nb);
+	if (raw_notifier_chain_register(&xen_resume_notifier, nb))
+		pr_warn("Xen resume notifier already registered\n");
 }
 EXPORT_SYMBOL_GPL(xen_resume_notifier_register);
 
diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index bd003ca8acbe..4e83ce95acd1 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -731,10 +731,12 @@ int register_xenstore_notifier(struct notifier_block *nb)
 {
 	int ret = 0;
 
-	if (xenstored_ready > 0)
+	if (xenstored_ready > 0) {
 		ret = nb->notifier_call(nb, 0, NULL);
-	else
-		blocking_notifier_chain_register(&xenstore_chain, nb);
+	} else {
+		if (blocking_notifier_chain_register(&xenstore_chain, nb))
+			pr_warn("Xenstore notifier already registered\n");
+	}
 
 	return ret;
 }
-- 
2.29.2

