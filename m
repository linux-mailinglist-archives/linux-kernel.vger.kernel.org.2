Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E98533E431
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 02:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhCQA6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 20:58:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229896AbhCQAz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 20:55:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A4BB64F8F;
        Wed, 17 Mar 2021 00:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615942558;
        bh=ay1pn4ySndbEBJDvHwEjIDAYLrbbLtL1itocjZCDnIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s1S2wfBVfPUFD1FFA1SnWlRtIFC+faIp20A79KAqjPBfPb/ug026FGyoIzFME2Uv7
         37ZCY78+Fr/szYz7EGiOrM9rusdzzEYArfP18Uf3WYSlIHtpRY7qTRvTYk6zV1v3dU
         Dk9SSX42DpTSMiCJnXfFgfCh2ZkdSE7uQgtt8sN98AQxu0Cohux4GM0OCAtbkGu+an
         7lx0bzna66uRpPUaG6IE60qZK2GU/GUL/5nHT0oXiV36Nd633ywGIt1wVVemajfC2f
         am+H+S3GzlQEm7vqy2H8433GbxTYqGXvEI4+DHS1oi7sv4XDcE7/PsudwL7USbmG62
         Oecdto2omj6wA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aurelien Aptel <aaptel@suse.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 5.11 17/61] cifs: ask for more credit on async read/write code paths
Date:   Tue, 16 Mar 2021 20:54:51 -0400
Message-Id: <20210317005536.724046-17-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210317005536.724046-1-sashal@kernel.org>
References: <20210317005536.724046-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aurelien Aptel <aaptel@suse.com>

[ Upstream commit 88fd98a2306755b965e4f4567f84e73db3b6738c ]

When doing a large read or write workload we only
very gradually increase the number of credits
which can cause problems with parallelizing large i/o
(I/O ramps up more slowly than it should for large
read/write workloads) especially with multichannel
when the number of credits on the secondary channels
starts out low (e.g. less than about 130) or when
recovering after server throttled back the number
of credit.

Signed-off-by: Aurelien Aptel <aaptel@suse.com>
Reviewed-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2pdu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 794fc3b68b4f..6a1af5545f67 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -4033,8 +4033,7 @@ smb2_async_readv(struct cifs_readdata *rdata)
 	if (rdata->credits.value > 0) {
 		shdr->CreditCharge = cpu_to_le16(DIV_ROUND_UP(rdata->bytes,
 						SMB2_MAX_BUFFER_SIZE));
-		shdr->CreditRequest =
-			cpu_to_le16(le16_to_cpu(shdr->CreditCharge) + 1);
+		shdr->CreditRequest = cpu_to_le16(le16_to_cpu(shdr->CreditCharge) + 8);
 
 		rc = adjust_credits(server, &rdata->credits, rdata->bytes);
 		if (rc)
@@ -4340,8 +4339,7 @@ smb2_async_writev(struct cifs_writedata *wdata,
 	if (wdata->credits.value > 0) {
 		shdr->CreditCharge = cpu_to_le16(DIV_ROUND_UP(wdata->bytes,
 						    SMB2_MAX_BUFFER_SIZE));
-		shdr->CreditRequest =
-			cpu_to_le16(le16_to_cpu(shdr->CreditCharge) + 1);
+		shdr->CreditRequest = cpu_to_le16(le16_to_cpu(shdr->CreditCharge) + 8);
 
 		rc = adjust_credits(server, &wdata->credits, wdata->bytes);
 		if (rc)
-- 
2.30.1

