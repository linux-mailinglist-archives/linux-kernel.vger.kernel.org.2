Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B103A670D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 14:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbhFNMxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 08:53:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:43994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233711AbhFNMxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 08:53:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 41BF661378;
        Mon, 14 Jun 2021 12:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623675066;
        bh=6hzHZ5yQeQhYYQkQ/sGhgsfezRI5BfO208XXZAp5tHI=;
        h=From:To:Cc:Subject:Date:From;
        b=Il48mGRYK55xqw5zmeb9Mx5r9uxZxc12DS3Ih5m5IZPRWbHtgzMzplhQM+Md0h+Ll
         napBoJa/HjRhSa2hHq7BE0o3lCa3L7SmMqc5lyjxEvcExHf1x7lD0gP24D4ckSLBfg
         mMJ77OvBwV7wpxeCuwv2hPpo1i6ipwOOYUe266lIGdLO+8tvhRYUrQMn4FiN24TroS
         0kGoHZdRtu/B5+ZRoYthaIRzyZ1j5izNuDjn1I5wl3PRsaUuc1VCH3/XDYApz3ReuZ
         qDmZdyB2owCc4dj09XxUyTEbAWsmlE8gEvAZnTXNucpCbz6FGqjX8dySSJX9cA6gx8
         LmCADg/F49eug==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 1/9] habanalabs: print more info when failing to pin user memory
Date:   Mon, 14 Jun 2021 15:50:52 +0300
Message-Id: <20210614125100.17627-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

pin_user_pages_fast() might fail and return a negative number, or pin
less pages than requested and return the number of the pages that were
pinned.
For the latter, it is informative to print also the memory size and the
number of requested pages.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index a7a8984e6af2..1cff1887e2e8 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -1612,8 +1612,8 @@ static int get_user_memory(struct hl_device *hdev, u64 addr, u64 size,
 
 	if (rc != npages) {
 		dev_err(hdev->dev,
-			"Failed (%d) to pin host memory with user ptr 0x%llx\n",
-			rc, addr);
+			"Failed (%d) to pin host memory with user ptr 0x%llx, size 0x%llx, npages %d\n",
+			rc, addr, size, npages);
 		if (rc < 0)
 			goto destroy_pages;
 		npages = rc;
-- 
2.25.1

