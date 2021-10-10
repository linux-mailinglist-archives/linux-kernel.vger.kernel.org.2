Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163A7427FFD
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 10:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhJJIFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 04:05:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231169AbhJJIFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 04:05:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF5EC608FB;
        Sun, 10 Oct 2021 08:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633852998;
        bh=nFzzRQ4VJkVqJNHl4Sic8Udnwibe6UUr2tMjaChOWVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VfMXgjJsEbG1uKI+avnxXzJLW5fbS1Enlxx8/d4IkZgraZDiGFlKusCvuKR9FeIjA
         FmK6FaRmCca2UMqCqH53EVt/gLH6ZW/RSGGfbDWuJLsLYwmvjjfQ+gtSJstrIqjuyO
         VIUwPvXL87HH7TyWwYoNnFniAQ7w3RaNMBlHk0NnqoPLARUfrgfQOUH5vMJGMDlTH2
         5BNL1RiK177HN7OvNG/sVwhXx0SBynSrd2MJDLkgBvcdGoRzvCi34mV26vdpwEtV7R
         d3GByijy/W+RSA9cG1j6CaUbU//XyhWGcE4ADjwfFzNu/97IWE3Bv0FT/POBcnzqEn
         c7VtHbmqyXk5w==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 5/5] habanalabs: fix NULL pointer dereference
Date:   Sun, 10 Oct 2021 11:03:07 +0300
Message-Id: <20211010080307.153420-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211010080307.153420-1-ogabbay@kernel.org>
References: <20211010080307.153420-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dani Liberman <dliberman@habana.ai>

When polling fences for multi CS, it is possible that fence is
no longer exists (its corresponding CS completed and the fence was
deleted) but we still accessing its parameters, causing NULL pointer
dereference.

Fixed by checking if fence exits before accessing its parameters.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 8e4dc1441fff..a3358cc3c877 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -2382,7 +2382,15 @@ static int hl_cs_poll_fences(struct multi_cs_data *mcs_data)
 			break;
 		}
 
-		mcs_data->stream_master_qid_map |= fence->stream_master_qid_map;
+		/*
+		 * It is possible to get an old sequence numbers from user
+		 * which related to already completed CSs and their fences
+		 * already gone. In this case, no need to consider its QID for
+		 * mcs completion.
+		 */
+		if (fence)
+			mcs_data->stream_master_qid_map |=
+					fence->stream_master_qid_map;
 
 		/*
 		 * Using mcs_handling_done to avoid possibility of mcs_data
@@ -2390,7 +2398,8 @@ static int hl_cs_poll_fences(struct multi_cs_data *mcs_data)
 		 * all of its mcs handling, to avoid race the next time the
 		 * user waits for mcs.
 		 */
-		if (status == CS_WAIT_STATUS_BUSY || !fence->mcs_handling_done)
+		if (status == CS_WAIT_STATUS_BUSY ||
+				(fence && !fence->mcs_handling_done))
 			continue;
 
 		mcs_data->completion_bitmap |= BIT(i);
-- 
2.25.1

