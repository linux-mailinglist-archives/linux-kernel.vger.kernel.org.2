Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544AA391B3C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 17:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbhEZPLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 11:11:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:32788 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbhEZPL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 11:11:26 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1llvAK-0002oe-3B; Wed, 26 May 2021 15:09:48 +0000
From:   Colin King <colin.king@canonical.com>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] mm: selftests: fix potential integer overflow on shift of a int
Date:   Wed, 26 May 2021 16:09:47 +0100
Message-Id: <20210526150947.3751728-1-colin.king@canonical.com>
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
int overflow. Avoid this by casting mapped to unsigned long before
shifting.

Addresses-Coverity: ("Uninitentional integer overflow")
Fixes: 8b2a105c3794 ("mm: selftests for exclusive device memory")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 lib/test_hmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 74d69f87691e..b54657701b3a 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -749,7 +749,7 @@ static int dmirror_exclusive(struct dmirror *dmirror,
 			}
 		}
 
-		if (addr + (mapped << PAGE_SHIFT) < next) {
+		if (addr + ((unsigned int)mapped << PAGE_SHIFT) < next) {
 			mmap_read_unlock(mm);
 			mmput(mm);
 			return -EBUSY;
-- 
2.31.1

