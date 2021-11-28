Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A3F460973
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 20:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357712AbhK1TkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 14:40:12 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35514 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238477AbhK1TiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 14:38:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33AE8B80D62
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 19:34:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C063C53FC7;
        Sun, 28 Nov 2021 19:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638128085;
        bh=9j+uVxoMxAiknvBgP/E7zv/41CmvZWStZ5FHjtAbUA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IisPMzwe3U0jJp5rHqvztxYX9yESJzPkcjbRW4enh+wSbCtJYGSYBCMSKnfK5L6+O
         nHLTpWFtsM5Lk1Sf/tfi4lGnEyEze8htFmojPd9Q/3rvD64NJQ/IXvuhzO2bChYgNc
         Rc6HaElPU77qGQiRUmbSsJ1O0ANbam0QmWtFoyRUPTkdeLb9NAIjyFO0dpHoeHcNjd
         Ksp4POx/zdEq26ER/Q8Bsc5GECaaC9VG9+pZM7Rn5Iby1zrSjuGC3a6CP5zaF7E6Vp
         7fo8YyoaXVFrixqY5FSLxDuOayQz5To6NEPMtUVRVgRmcpG9S3o0KbcuTzSfsamXhd
         NOnHGOyzadvHg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 05/12] habanalabs: fix race condition in multi CS completion
Date:   Sun, 28 Nov 2021 21:34:28 +0200
Message-Id: <20211128193435.266534-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211128193435.266534-1-ogabbay@kernel.org>
References: <20211128193435.266534-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dani Liberman <dliberman@habana.ai>

Race example scenario:
1. User have 2 threads that waits on multi CS:
   - thread_0 waits on QID 0 and uses multi CS context 0.
   - thread_1 waits on QID 1 and uses multi CS context 1.
2. thread_1 got completion and release multi CS context 1.
3. CS related to multi CS of thread_0 starts executing
   complete_multi_cs function, the first iteration of the loop
   completes the multi CS of thread_0, hence multi CS context 0
   is released.
4. thread_1 waits on QID 1 and uses multi CS context 0.
5. thread_0 waits on QID 0 and uses multi CS context 1.
6. The second iterattion of the loop (from step 3) starts, which
   means, start checking multi CS context 1:
   - multi CS contetxt is being used by thread_0 waiting on QID 0.
   - The fence of the CS (still CS from step 3) has QID map the same
     as the multi CS context 1.
   - multi CS context 1 (thread_0) gets completion on CS that triggered
     already thread_0 (with multi CS context 0) and is no longer
     being waited on.

Fixed by exiting the loop in complete_multi_cs after getting completion

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index c1fd4ba14c60..4e893364a3cc 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -545,6 +545,13 @@ static void complete_multi_cs(struct hl_device *hdev, struct hl_cs *cs)
 			 * mcs fences.
 			 */
 			fence->mcs_handling_done = true;
+			/*
+			 * Since CS (and its related fence) can be associated with only one
+			 * multi CS context, once it triggered multi CS completion no need to
+			 * continue checking other multi CS contexts.
+			 */
+			spin_unlock(&mcs_compl->lock);
+			break;
 		}
 
 		spin_unlock(&mcs_compl->lock);
-- 
2.25.1

