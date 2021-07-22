Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37343D20C5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 11:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhGVIkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 04:40:49 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38706 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbhGVIin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 04:38:43 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5DED81FEF8;
        Thu, 22 Jul 2021 09:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626945558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=wVV1NKQntPKSAXSmSaAxE4Ah/CdiL8B+h1eN+sjS5is=;
        b=b5IGVdj0o0o3ZgqB7IKc1pzH0l/qkGcPh8eya4gUuqptwL1mrR7XgLvAAj6Poq+7r1UxMS
        kXYVWCyYHAFehGHjWly6du60lhQ70F4+//lEctXmuixD269nIGvk7a3QZldsuKZ4Ur0FdZ
        3TCiCzx1kv24vG2SfM7JhElTXTv2G8k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4393D13DA5;
        Thu, 22 Jul 2021 09:19:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RknLDxY4+WCfewAAMHmgww
        (envelope-from <ailiop@suse.com>); Thu, 22 Jul 2021 09:19:18 +0000
From:   Anthony Iliopoulos <ailiop@suse.com>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dma-debug: fix debugfs initialization order
Date:   Thu, 22 Jul 2021 11:18:18 +0200
Message-Id: <20210722091818.13434-1-ailiop@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to link order, dma_debug_init is called before debugfs has a chance
to initialize (via debugfs_init which also happens in the core initcall
stage), so the directories for dma-debug are never created.

Move the dma_debug_init initcall from core to postcore stage so that
debugfs will already be initialized by the time this is called, making
it oblivious to link-ordering.

Fixes: 15b28bbcd567 ("dma-debug: move initialization to common code")
Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 kernel/dma/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 14de1271463f..49d80ef7f995 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -915,7 +915,7 @@ static int dma_debug_init(void)
 	pr_info("debugging enabled by kernel config\n");
 	return 0;
 }
-core_initcall(dma_debug_init);
+postcore_initcall(dma_debug_init);
 
 static __init int dma_debug_cmdline(char *str)
 {
-- 
2.32.0

