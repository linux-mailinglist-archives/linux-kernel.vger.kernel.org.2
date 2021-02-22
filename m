Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C953C3221F7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 23:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhBVWJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 17:09:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:43064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231418AbhBVWJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 17:09:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7191364E3F
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 22:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614031726;
        bh=g20wRN1jFOUghz5lYzyY9xEZrsCvti3kh+DxttiXJNc=;
        h=From:To:Subject:Date:From;
        b=kEkSnn+5gKT0f5D+TzZxSKLHNZ5fAN0Q1IWAaRFivMcouTLR4RRcSxYm/yffWxvWj
         0zR7anLoMIv78ycgLasjKgpeRAhoMkbhU2BiUMCT88RooDQg6EFdDXTPP2rMVh7Sdn
         kRm3stErnB66GdQKfW+gorQiJwO121kLYE3ligcdBEglkHVL+C1GeWvj36rULx+Qqe
         gRoWuWMcsXrXlgCaNwpHvmeDDQJEfFtlyiyHGYewH66WkneDmYAR8CW6GWrNQaeppZ
         Xm0wEMtlWpfeB/oqaXvcSt1JTMldFPgXtyxtdjfAdD5jRR2bLhRcUxhBiyCLkPpgSn
         rZBpq9OsFxxVw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] habanalabs: change default CS timeout to 30 seconds
Date:   Tue, 23 Feb 2021 00:08:41 +0200
Message-Id: <20210222220842.9398-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because our graph contains network operations, we need to account
for delay in the network.

5 seconds timeout per CS is not enough to account for that.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 032d114f01ea..f695ea6253c1 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -27,13 +27,13 @@ static struct class *hl_class;
 static DEFINE_IDR(hl_devs_idr);
 static DEFINE_MUTEX(hl_devs_idr_lock);
 
-static int timeout_locked = 5;
+static int timeout_locked = 30;
 static int reset_on_lockup = 1;
 static int memory_scrub = 1;
 
 module_param(timeout_locked, int, 0444);
 MODULE_PARM_DESC(timeout_locked,
-	"Device lockup timeout in seconds (0 = disabled, default 5s)");
+	"Device lockup timeout in seconds (0 = disabled, default 30s)");
 
 module_param(reset_on_lockup, int, 0444);
 MODULE_PARM_DESC(reset_on_lockup,
-- 
2.25.1

