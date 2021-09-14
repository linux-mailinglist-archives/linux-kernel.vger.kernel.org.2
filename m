Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E0640ACEF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 13:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbhINMA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 08:00:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232065AbhINMAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 08:00:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44D95610D1;
        Tue, 14 Sep 2021 11:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631620777;
        bh=FCuXQcS6e3Dll56A+ppVPVOpP06sE13MRDHOAVBIvm0=;
        h=From:To:Cc:Subject:Date:From;
        b=AKS1V/im6xfhj5Nl9HrqtNJK/o/Cnyc1+jQGD5Do3BNpg2QlQ9IswAxTw+1AOmPkJ
         UBDzrTqc6qBFGYF/4hQ2GCLgGUz60IlyH2MJ9aGQWo4DQvD0SiHcIU8F0dzFE4Kbk7
         TJ+7H5isbnLRep92BRdY1T2SYUEn44mJ7SaL7evIrxKAD8lYdP84gxxUlwnzx11ESG
         Qe8jHXbGHdhdVRJmRimC262qJGaML7cY4eNNabM9pwTmpgLAXZ8tyHik2r/CETTcCN
         r3K0R5I+5Te2LmW8pVfSCkhM30k7jrASI4GkxqxKCPhEIoiZ95PDzU/wrUnCVLNC/2
         v6enX1jPN2aBg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs: expose a single cs seq in staged submissions
Date:   Tue, 14 Sep 2021 14:59:32 +0300
Message-Id: <20210914115932.69518-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Staged submission consists of multiple command submissions.
In order to be explicit, driver should return a single cs sequence
for every cs in the submission, or else user may try to wait on
an internal CS rather than waiting for the whole submission.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index a4ed91ed991d..91b57544f7c6 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -1295,6 +1295,12 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 	if (rc)
 		goto free_cs_object;
 
+	/* If this is a staged submission we must return the staged sequence
+	 * rather than the internal CS sequence
+	 */
+	if (cs->staged_cs)
+		*cs_seq = cs->staged_sequence;
+
 	/* Validate ALL the CS chunks before submitting the CS */
 	for (i = 0 ; i < num_chunks ; i++) {
 		struct hl_cs_chunk *chunk = &cs_chunk_array[i];
-- 
2.17.1

