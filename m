Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2DC640696E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 12:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhIJKDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 06:03:17 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:32836
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232187AbhIJKDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 06:03:15 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 45B7C4017D;
        Fri, 10 Sep 2021 10:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631268123;
        bh=CLu82bq5SWKeIc/2RlhTe1WwLhYQwCATV9tHg0yoIUI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=KxW7shY4l4HMrOtyTk0llxEcnqsRn06pUSZaWASEYRNefbBxdxa3rBqXzBGxUjDbd
         uydUBiT0wBgCS7HKjQTLqdugvQfs5Wmuk1+HahX8hkIBk53OAB0GFPauaDbzkwjf72
         P3NMxt7/bzehSSZzsNPngLQTfWYkVSVPVyXBqWQj8wI+5u0odltlBWxlxBUfg+PB8V
         jtfpKsflJb9ZKaJbIQju2OQsFvs5VWx80tUPSNyufZO4PDIayGVgRvsZy3tZ87WzoH
         1ls0189rswfKoHZNe+55aQdqBK4j089rl4/DiSXiysxNJX5L0l1HqPxEEBIuNnhFz8
         fcoqhv/wcqd+Q==
From:   Colin King <colin.king@canonical.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] fs/ntfs3: Fix a memory leak on object opts
Date:   Fri, 10 Sep 2021 11:02:02 +0100
Message-Id: <20210910100202.29254-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently a failed allocation on sbi->upcase will cause an exit via
the label free_sbi causing a memory leak on object opts. Fix this by
re-ordering the exit paths free_opts and free_sbi so that kfree's occur
in the reverse allocation order.

Addresses-Coverity: ("Resource leak")
Fixes: 27fac77707a1 ("fs/ntfs3: Init spi more in init_fs_context than fill_super")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/ntfs3/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 3cba0b5e7ac7..69f23db0d727 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1450,10 +1450,10 @@ static int ntfs_init_fs_context(struct fs_context *fc)
 	fc->ops = &ntfs_context_ops;
 
 	return 0;
-free_opts:
-	kfree(opts);
 free_sbi:
 	kfree(sbi);
+free_opts:
+	kfree(opts);
 	return -ENOMEM;
 }
 
-- 
2.32.0

