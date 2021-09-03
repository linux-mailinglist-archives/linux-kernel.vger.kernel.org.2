Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C810140007E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 15:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbhICN0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 09:26:00 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:33254
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235169AbhICN0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 09:26:00 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 1463F4060A;
        Fri,  3 Sep 2021 13:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1630675499;
        bh=sfWVSkiVXrsH15ykdL6F1vaX2G6vomR361T+ZKMS4bk=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=ayvrDtnfNQ1bjF5hZ4vvzMrfEXmqcD90XQojCtdQ4D7WyR3ZXwUKLxHGOpl8KlDnF
         l9FosKX/xPMdlnrg+VwCujg7vzhUBzNYZMMT49rJxfa210CYhUJDpf0bNh6yJyLmex
         XIz4zLm+lfBDId6qSzP4cJl4cZ7DwvCwVRx5KILRpymhY/r5vwDSdXlVqkGR8G/ol8
         46eRbkWUv5rGtIbXxplLSznxSbQTPoBTLcn7vgEY589J+acVPm46RBLmp180H16WiA
         yUYBFWs3o30RPxhVrYKbMFjWWLoU5L2VE+Oi0mayvNlIT/DNiJfaC2Zew9BKedNGHk
         hAIu0mKDjKs5g==
From:   Colin King <colin.king@canonical.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] fs/ntfs3: Remove redundant initialization of variable err
Date:   Fri,  3 Sep 2021 14:24:58 +0100
Message-Id: <20210903132458.14342-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable err is being initialized with a value that is never read, it
is being updated later on. The assignment is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/ntfs3/index.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 0daca9adc54c..b1175542d854 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1401,7 +1401,7 @@ int indx_find_raw(struct ntfs_index *indx, struct ntfs_inode *ni,
 static int indx_create_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
 				CLST *vbn)
 {
-	int err = -ENOMEM;
+	int err;
 	struct ntfs_sb_info *sbi = ni->mi.sbi;
 	struct ATTRIB *bitmap;
 	struct ATTRIB *alloc;
-- 
2.32.0

