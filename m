Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1272E3EDAFC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 18:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhHPQa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 12:30:59 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:47138
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229774AbhHPQa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:30:58 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 7D8683F36B;
        Mon, 16 Aug 2021 16:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629131425;
        bh=AQHbWOZjETXK025PEaVBeSGWavPhhgLfSL/2rlGWJZQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=BNmfU2s066DTpWSnzFRf/WZtr8fq0A1Il8w8JslCFFNyv9DFwswWeKFK0kpgBWZTV
         +RLfiTr7zJOwBGpB189OzlLSdv7GMgOdcVHg6I9kUrmZcqlT+c7oWy0HYaqSFbTE6y
         SC1nQyVpCvUOHdjpiB5umYWAtq8d70tYxDlXEEJBl9Uvd2omykGsfAe4es0xd6AIsU
         GvJTwtdLKzSn0265zFYe2wMTYDhPeF7mE6DebVuGlA7Yo6+aHjBikR9fy805udHgL+
         hHOP3Q/x89Q9OYOKQCmiwf2h1/nz1aeCF4ikugMNG9rp1FFbvAS2J4VFA5zyn1aEnD
         JKiX19FpJAQ8w==
From:   Colin King <colin.king@canonical.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] fs/ntfs3: Fix integer overflow in multiplication
Date:   Mon, 16 Aug 2021 17:30:25 +0100
Message-Id: <20210816163025.81770-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The multiplication of the u32 data_size with a int is being performed
using 32 bit arithmetic however the results is being assigned to the
variable nbits that is a size_t (64 bit) value. Fix a potential
integer overflow by casting the u32 value to a size_t before the
multiply to use a size_t sized bit multiply operation.

Addresses-Coverity: ("Unintentional integer overflow")
Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/ntfs3/index.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 6aa9540ece47..9386c551e208 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -2012,7 +2012,7 @@ static int indx_shrink(struct ntfs_index *indx, struct ntfs_inode *ni,
 		unsigned long pos;
 		const unsigned long *bm = resident_data(b);
 
-		nbits = le32_to_cpu(b->res.data_size) * 8;
+		nbits = (size_t)le32_to_cpu(b->res.data_size) * 8;
 
 		if (bit >= nbits)
 			return 0;
-- 
2.32.0

