Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDF43A79BE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 11:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhFOJEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 05:04:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231271AbhFOJEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 05:04:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B98BB61425
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623747749;
        bh=PiMcnDcsnM6jPd+cPJEchuNOA4RbUjHCcDIS7gKq6cY=;
        h=From:To:Subject:Date:From;
        b=meql4ImJIoCpAzlIdGU1vLa3slRN7uNk74BLJiS8YG5s5u9jRr41LGyWNUMlH9hcb
         rsjoEdyYsE/DvaTeJQsl/RRks/kod6Wvf39aslLBwKB+FowutBl1pG/sJTbJorodIP
         L7jTDEcUiD+BtMHbetvbtWQFdBt3/FkiGcdZf9Pnl/5GxzvgxRdhu8hD/VL1sQJoIM
         Po04OrBYSKbR/mL436y2UPx0Pyf+z8rgwvC16LZrn4M//jEgneZGbBmzfhMWTBUygk
         7FFeRc1ekbMVSJOYw/YG443FGJQ4Hq2lrIh9W5MSr3xE0uhh1K99/nt8sTDwOeAbKH
         vv6sfYltYTD7A==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] habanalabs: remove a rogue #ifdef
Date:   Tue, 15 Jun 2021 12:02:25 +0300
Message-Id: <20210615090225.20530-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was a rogue #ifdef that crept into the upstream code for
backwards compatibility which isn't needed of course.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/memory.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index eb004d19f638..14d12bbecc84 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -1387,12 +1387,7 @@ int hl_hw_block_mmap(struct hl_fpriv *hpriv, struct vm_area_struct *vma)
 	/* Driver only allows mapping of a complete HW block */
 	block_size = vma->vm_end - vma->vm_start;
 
-#ifdef _HAS_TYPE_ARG_IN_ACCESS_OK
-	if (!access_ok(VERIFY_WRITE,
-		(void __user *) (uintptr_t) vma->vm_start, block_size)) {
-#else
 	if (!access_ok((void __user *) (uintptr_t) vma->vm_start, block_size)) {
-#endif
 		dev_err(hdev->dev,
 			"user pointer is invalid - 0x%lx\n",
 			vma->vm_start);
-- 
2.25.1

