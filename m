Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7EE53221FB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 23:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhBVWLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 17:11:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:43136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231484AbhBVWJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 17:09:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B03464E2E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 22:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614031750;
        bh=zuno4uETWv37Rp1rPZkcFfLGWgEUPXIm3zshN/0/AUg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=s2npcbEYLHj8Ii4+IX+UT69a4slefW9JDKWTld156SJeLJOByto9AnXeGvDiaRA9C
         9qhLjoURIsyi4cKvlRcG4qrgjDZ0bm6u/6CzPstGm8bQtDX6HxGvRrc+/1oHnrbsOJ
         /V2U40Zltl7Jc29PU70oCxIBWxb87U6Mfwcxi/Ou+n/ZN+N0nfW7bDNdlEzMvzecXl
         b0i06NPl5FDs1ntzjPIhFg+NzFfXkFfnqTncvXm/L+xVszepBUuox4o3ywxIdlKXCs
         1hDE2jpozvhxxOtIEBncITLyqhCu1c9oF+jnxaqSj9PnBKexZirKagCAvdXQm9aQEa
         Pcb7KSQKbZj9Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] habanalabs: use correct define for 32-bit max value
Date:   Tue, 23 Feb 2021 00:09:03 +0200
Message-Id: <20210222220903.9487-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210222220903.9487-1-ogabbay@kernel.org>
References: <20210222220903.9487-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Timeout in wait for interrupt is in 32-bit variable so we need to use
the correct maximum value to compare.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 138cb77420bd..98fdb98ff4e4 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -1924,7 +1924,7 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 	u32 completion_value;
 	int rc = 0;
 
-	if (timeout_us == MAX_SCHEDULE_TIMEOUT)
+	if (timeout_us == U32_MAX)
 		timeout = timeout_us;
 	else
 		timeout = usecs_to_jiffies(timeout_us);
-- 
2.25.1

