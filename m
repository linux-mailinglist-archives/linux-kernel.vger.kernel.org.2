Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE687370DB7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 17:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbhEBPwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 11:52:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230110AbhEBPwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 11:52:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C4A661139
        for <linux-kernel@vger.kernel.org>; Sun,  2 May 2021 15:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619970707;
        bh=OQvOW6DDf4I5Cf1TzWSfkMCjBHaKCQvFsAk0tQiO1qI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=c3KQVYUiTGUQDgy7gL3/gVcJljt11+g+fyoXp2OY9ZbZF0uZkpgr2kqa05do4qo7/
         fNAb6IiaBRNSqcUkmc97SHiN7J3ruEsD88BccbMioUPFFAc8fwqFGMhz/66t5++piM
         c8war4Ixwh2hStIPvWEYVIErSEpPH+sSQKzH67iSY1ife6WIH3nr2CUtlaylGIZYH+
         9WA66Rxek+befUiGXkCxvtbyvmhRrHIXW/0CTEa59OHPvWelT2jmlmCuwglUG+wsz+
         HhlWfCJUO+cAJZbgz03mHP0gj6abKpE3u0LQnSw/cBHrQohLgLDYSzh5Vh9VXnx8J+
         vIkYTAviiGTmg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] habanalabs: better error print for pin failure
Date:   Sun,  2 May 2021 18:51:39 +0300
Message-Id: <20210502155140.4359-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210502155140.4359-1-ogabbay@kernel.org>
References: <20210502155140.4359-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print the user given pointer and error code on failure to get user
pages for easier debugging.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 43924e1c0315..a7a8984e6af2 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -1612,7 +1612,8 @@ static int get_user_memory(struct hl_device *hdev, u64 addr, u64 size,
 
 	if (rc != npages) {
 		dev_err(hdev->dev,
-			"Failed to map host memory, user ptr probably wrong\n");
+			"Failed (%d) to pin host memory with user ptr 0x%llx\n",
+			rc, addr);
 		if (rc < 0)
 			goto destroy_pages;
 		npages = rc;
-- 
2.25.1

