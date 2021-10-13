Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1DD42BEAC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 13:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhJMLLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 07:11:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229571AbhJMLLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 07:11:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24011610A1;
        Wed, 13 Oct 2021 11:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634123348;
        bh=dOkqsJEISz3/QuJjno6nvMjn/MqfCUVMDLekrAfMO6I=;
        h=From:To:Cc:Subject:Date:From;
        b=p0c/CIltwGpCOIYKK46xr7DhHTvd0jqfhlxlteNeSICey8j2PSMrxQlTki2bWFnza
         mZBALOL5JLFlUE+AE29nt2rUi1eg5NLq0j8sjMEutxPhuQce+aOvMyRAkfYJF+Wa19
         BgFq9BfqSyAvqpJan5MMYT72UDx4il4KqXR4YcgZ7/QFesQWdvEohyqS4Jlr5O61wf
         p2wezEkTVd/4h+lCOF0gD1KksmQmMzu9EXqr/GeXyn/RmzenoVXHH4oz3KQdkkSztG
         Y/n/YYHYbMwC8qsSvDlZpOKTuZ4OLZZQNmKdCnGHS2GvmZqHEy3QuSIsFyQK2IcN/t
         CYCfEBV0DRByA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>
Subject: [PATCH] habanalabs: refactor fence handling in hl_cs_poll_fences
Date:   Wed, 13 Oct 2021 14:09:03 +0300
Message-Id: <20211013110903.14963-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dani Liberman <dliberman@habana.ai>

To avoid checking if fence exists multipled times, changed fence
handling to depend only on the fence status field:

Busy, which means CS still did not completed :
	Add its QID so multi CS wait on its completion.
Finished, which means CS completed and fence exists:
	Raise its completion bit if it finished mcs handling and
	update if necessary the earliest timestamp.
Gone, which means CS already completed and fence deleted:
	Update multi CS data to ignore timestamp and raise its
	completion bit.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 71 ++++++++++---------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index f94ac2350a9b..4c8000fd246c 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -2382,47 +2382,48 @@ static int hl_cs_poll_fences(struct multi_cs_data *mcs_data)
 			break;
 		}
 
-		/*
-		 * It is possible to get an old sequence numbers from user
-		 * which related to already completed CSs and their fences
-		 * already gone. In this case, no need to consider its QID for
-		 * mcs completion.
-		 */
-		if (fence)
+		switch (status) {
+		case CS_WAIT_STATUS_BUSY:
+			/* CS did not finished, keep waiting on its QID*/
 			mcs_data->stream_master_qid_map |=
 					fence->stream_master_qid_map;
+			break;
+		case CS_WAIT_STATUS_COMPLETED:
+			/*
+			 * Using mcs_handling_done to avoid possibility of mcs_data
+			 * returns to user indicating CS completed before it finished
+			 * all of its mcs handling, to avoid race the next time the
+			 * user waits for mcs.
+			 */
+			if (!fence->mcs_handling_done)
+				break;
 
-		/*
-		 * Using mcs_handling_done to avoid possibility of mcs_data
-		 * returns to user indicating CS completed before it finished
-		 * all of its mcs handling, to avoid race the next time the
-		 * user waits for mcs.
-		 */
-		if (status == CS_WAIT_STATUS_BUSY ||
-				(fence && !fence->mcs_handling_done))
-			continue;
-
-		mcs_data->completion_bitmap |= BIT(i);
-
-		/*
-		 * best effort to extract timestamp. few notes:
-		 * - if even single fence is gone we cannot extract timestamp
-		 *   (as fence not exist anymore)
-		 * - for all completed CSs we take the earliest timestamp.
-		 *   for this we have to validate that:
-		 *       1. given timestamp was indeed set
-		 *       2. the timestamp is earliest of all timestamps so far
-		 */
-
-		if (status == CS_WAIT_STATUS_GONE) {
+			mcs_data->completion_bitmap |= BIT(i);
+			/*
+			 * For all completed CSs we take the earliest timestamp.
+			 * For this we have to validate that the timestamp is
+			 * earliest of all timestamps so far.
+			 */
+			if (mcs_data->update_ts &&
+					(ktime_compare(fence->timestamp, first_cs_time) < 0))
+				first_cs_time = fence->timestamp;
+			break;
+		case CS_WAIT_STATUS_GONE:
 			mcs_data->update_ts = false;
 			mcs_data->gone_cs = true;
-		} else if (mcs_data->update_ts &&
-			(ktime_compare(fence->timestamp,
-						ktime_set(0, 0)) > 0) &&
-			(ktime_compare(fence->timestamp, first_cs_time) < 0)) {
-			first_cs_time = fence->timestamp;
+			/*
+			 * It is possible to get an old sequence numbers from user
+			 * which related to already completed CSs and their fences
+			 * already gone. In this case, CS set as completed but
+			 * no need to consider its QID for mcs completion.
+			 */
+			mcs_data->completion_bitmap |= BIT(i);
+			break;
+		default:
+			dev_err(hdev->dev, "Invalid fence status\n");
+			return -EINVAL;
 		}
+
 	}
 
 	hl_fences_put(mcs_data->fence_arr, arr_len);
-- 
2.17.1

