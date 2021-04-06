Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D38335592A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 18:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346411AbhDFQ1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 12:27:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39392 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244099AbhDFQ1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 12:27:30 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lToXv-0006Um-2c; Tue, 06 Apr 2021 16:27:19 +0000
From:   Colin King <colin.king@canonical.com>
To:     Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-erofs@lists.ozlabs.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] erofs: fix uninitialized variable i used in a while-loop
Date:   Tue,  6 Apr 2021 17:27:18 +0100
Message-Id: <20210406162718.429852-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The while-loop iterates until src is non-null or i is 3, however, the
loop counter i is not intinitialied to zero, causing incorrect iteration
counts.  Fix this by initializing it to zero.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: 1aa5f2e2feed ("erofs: support decompress big pcluster for lz4 backend")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/erofs/decompressor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index fe46a9c34923..8687ff81406b 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -154,6 +154,7 @@ static void *z_erofs_handle_inplace_io(struct z_erofs_decompress_req *rq,
 	}
 	kunmap_atomic(inpage);
 	might_sleep();
+	i = 0;
 	while (1) {
 		src = vm_map_ram(rq->in, nrpages_in, -1);
 		/* retry two more times (totally 3 times) */
-- 
2.30.2

