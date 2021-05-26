Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF29D391D85
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 19:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbhEZRHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 13:07:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36104 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbhEZRHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 13:07:18 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1llwyK-0002II-Td; Wed, 26 May 2021 17:05:33 +0000
From:   Colin King <colin.king@canonical.com>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2][next] mm: selftests: fix potential integer overflow on shift of a int
Date:   Wed, 26 May 2021 18:05:30 +0100
Message-Id: <20210526170530.3766167-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The left shift of the int mapped is evaluated using 32 bit arithmetic
and then assigned to an unsigned long. In the case where mapped is
0x80000 when PAGE_SHIFT is 12 will lead to the upper bits being
sign extended in the unsigned long. Larger values can lead to an
int overflow. Avoid this by making mapped an unsigned long.

Addresses-Coverity: ("Uninitentional integer overflow")
Fixes: 8b2a105c3794 ("mm: selftests for exclusive device memory")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: Make mapped an unsigned long rather than casting it to unsigned long

---
 lib/test_hmm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 74d69f87691e..8c55c4723692 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -733,7 +733,8 @@ static int dmirror_exclusive(struct dmirror *dmirror,
 
 	mmap_read_lock(mm);
 	for (addr = start; addr < end; addr = next) {
-		int i, mapped;
+		unsigned long mapped;
+		int i;
 
 		if (end < addr + (ARRAY_SIZE(pages) << PAGE_SHIFT))
 			next = end;
-- 
2.31.1

