Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A451E41BD11
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 05:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243821AbhI2DGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 23:06:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243811AbhI2DGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 23:06:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB16E60F24;
        Wed, 29 Sep 2021 03:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632884695;
        bh=uKx3+P8SRHdwUFZd8YkUrLhfkgvBsO4avEN5WkWhal8=;
        h=From:To:Cc:Subject:Date:From;
        b=YPKRJcNJJzmNlIcaWZYinxzw9mR9AUIlcy22F8bmZJuR9QaQTEoTyzOi05t17eqiG
         fRuIL/fLZtlMYt0trt0S+o34hmAHrvEhru+4JES+lFpyKk0oMVwKF+ZvyH87KhYhTc
         WPXGcmM8haAiUl82AAS4LFw2bQpBIoa3chNJPyXtydvkyA7ZG5HuXhFeXxlF5VfC1q
         c/g/hVtKvQ9/9guoD2ol1SG7crcEUWvt68cbNJ46vhR9n+n5z3zlXt7qCVW62B1cVU
         7Zb4cbyCpNLpzceiTQx+PBlH3dRjoXDmrssKAeVvg41aFYK1E00pjChIBLLRgOmREg
         zf00tkJycMJaw==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix wrong condition to trigger background checkpoint correctly
Date:   Wed, 29 Sep 2021 03:19:14 +0800
Message-Id: <20210928191914.32845-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In f2fs_balance_fs_bg(), it needs to check both NAT_ENTRIES and INO_ENTRIES
memory usage to decide whether we should skip background checkpoint, otherwise
we may always skip checking INO_ENTRIES memory usage, so that INO_ENTRIES may
potentially cause high memory footprint.

Fixes: 493720a48543 ("f2fs: fix to avoid REQ_TIME and CP_TIME collision")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 53c7fa8f348c..f2473776c9e1 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -587,7 +587,7 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi, bool from_bg)
 		goto do_sync;
 
 	/* checkpoint is the only way to shrink partial cached entries */
-	if (f2fs_available_free_memory(sbi, NAT_ENTRIES) ||
+	if (f2fs_available_free_memory(sbi, NAT_ENTRIES) &&
 		f2fs_available_free_memory(sbi, INO_ENTRIES))
 		return;
 
-- 
2.32.0

