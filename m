Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CC23077C7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 15:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhA1OSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 09:18:36 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41459 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbhA1OSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 09:18:32 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1l586y-0001nf-Rd; Thu, 28 Jan 2021 14:17:28 +0000
From:   Colin King <colin.king@canonical.com>
To:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tian Tao <tiantao6@hisilicon.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-mm@kvack.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] mm/zswap: fix potential uninitialized pointer read on tmp
Date:   Thu, 28 Jan 2021 14:17:28 +0000
Message-Id: <20210128141728.639030-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

In the case where zpool_can_sleep_mapped(pool) returns 0
then tmp is not allocated and tmp is then an uninitialized
pointer. Later if entry is null, tmp is freed, hence free'ing
an uninitialized pointer. Fix this by ensuring tmp is initialized
to NULL.

Addresses-Coverity: ("Uninitialized pointer read")
Fixes: 908aa806dba0 ("mm/zswap: fix potential memory leak")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 mm/zswap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 8d1381b1178d..578d9f256920 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -935,7 +935,7 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 	struct scatterlist input, output;
 	struct crypto_acomp_ctx *acomp_ctx;
 
-	u8 *src, *tmp;
+	u8 *src, *tmp = NULL;
 	unsigned int dlen;
 	int ret;
 	struct writeback_control wbc = {
-- 
2.29.2

