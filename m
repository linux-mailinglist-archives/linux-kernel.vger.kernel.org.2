Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E913633D15B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 11:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236244AbhCPKEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 06:04:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40942 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236203AbhCPKEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 06:04:40 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lM6Yz-0005p6-G2; Tue, 16 Mar 2021 10:04:33 +0000
From:   Colin King <colin.king@canonical.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: cma: Fix potential null dereference on pointer cma
Date:   Tue, 16 Mar 2021 10:04:33 +0000
Message-Id: <20210316100433.17665-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

At the start of the function there is a null pointer check on cma
and then branch to error handling label 'out'.  The subsequent call
to cma_sysfs_fail_pages_count dereferences cma, hence there is a
potential null pointer deference issue.  Fix this by only calling
cma_sysfs_fail_pages_count if cma is not null.

Addresses-Coverity: ("Dereference after null check")
Fixes: dc4764f7e9ac ("mm: cma: support sysfs")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 mm/cma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/cma.c b/mm/cma.c
index 6d4dbafdb318..90e27458ddb7 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -512,7 +512,8 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 		cma_sysfs_alloc_pages_count(cma, count);
 	} else {
 		count_vm_event(CMA_ALLOC_FAIL);
-		cma_sysfs_fail_pages_count(cma, count);
+		if (cma)
+			cma_sysfs_fail_pages_count(cma, count);
 	}
 
 	return page;
-- 
2.30.2

