Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4A938C3D7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 11:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhEUJwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 05:52:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39494 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbhEUJw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 05:52:28 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lk1o5-0005eY-OQ; Fri, 21 May 2021 09:51:01 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Joe Thornber <ejt@redhat.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2][next] dm space maps: Fix uninitialized variable r2
Date:   Fri, 21 May 2021 10:51:01 +0100
Message-Id: <20210521095101.42737-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

In the case where recursing(mm) is true variable r2 is not
inintialized and an uninitialized value is being used in the
call combine_errors later on. Fix this by setting r2 to zero.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: def6a7a9a7f0 ("dm space maps: improve performance with inc/dec on ranges of blocks")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: Add fix in function sm_metadata_inc_blocks

---
 drivers/md/persistent-data/dm-space-map-metadata.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/md/persistent-data/dm-space-map-metadata.c b/drivers/md/persistent-data/dm-space-map-metadata.c
index 3b70ee861cf5..a9a362777fad 100644
--- a/drivers/md/persistent-data/dm-space-map-metadata.c
+++ b/drivers/md/persistent-data/dm-space-map-metadata.c
@@ -417,6 +417,7 @@ static int sm_metadata_inc_blocks(struct dm_space_map *sm, dm_block_t b, dm_bloc
 		r = add_bop(smm, BOP_INC, b, e);
 		if (r)
 			return r;
+		r2 = 0;
 	} else {
 		in(smm);
 		r = sm_ll_inc(&smm->ll, b, e, &nr_allocations);
@@ -432,9 +433,10 @@ static int sm_metadata_dec_blocks(struct dm_space_map *sm, dm_block_t b, dm_bloc
 	int32_t nr_allocations;
 	struct sm_metadata *smm = container_of(sm, struct sm_metadata, sm);
 
-	if (recursing(smm))
+	if (recursing(smm)) {
 		r = add_bop(smm, BOP_DEC, b, e);
-	else {
+		r2 = 0;
+	} else {
 		in(smm);
 		r = sm_ll_dec(&smm->ll, b, e, &nr_allocations);
 		r2 = out(smm);
-- 
2.31.1

