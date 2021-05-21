Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2C138CB86
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237917AbhEURIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:08:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229896AbhEURIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:08:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E74F1613E4
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 17:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621616817;
        bh=e9ywnrnCML4GuY8Z5sRM+jWxfmXjm8GdhfKjoo6MalM=;
        h=From:To:Subject:Date:From;
        b=XoCAvCC7RjKx3qSjJxerJCyQAtkE+uF23fzmqX3QgpgcAImaVJyzYOBaDP29VjC+j
         BNOKiAYXXX59ee4OV5cO5PW1zvnZhzXT+34DjJIAXu8qtcjUjaKJGHAgJNMSWo3HX7
         TF301cEuT4REvTT9n9S4Zwv5dyunnOiXDiANiCqMoltSyUTnowAnHvWLLiqgx48OTS
         I7NqO6kRpqCTUBCWQi6xjIc2gz5l9W2VcU/BAC5VhoaWMw5ldk6Uab9PrIG5Svk41Y
         cGDn9Qm4oPlhJHjY2n8Q93fRkg/W7BL7/aF8iz8b8IheCGqNNIEG6cOQCGHvTwmHWl
         6BYzofVBB93+g==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] habanalabs: set memory scrubbing to disabled by default
Date:   Fri, 21 May 2021 20:06:50 +0300
Message-Id: <20210521170653.4700-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scrubbing memory after every unmap is very costly in terms of
performance. If a user wants it he can enable it but the default
should prioritize performance.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index df1e91f810cc..339a1860c1e7 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -29,7 +29,7 @@ static DEFINE_MUTEX(hl_devs_idr_lock);
 
 static int timeout_locked = 30;
 static int reset_on_lockup = 1;
-static int memory_scrub = 1;
+static int memory_scrub;
 static ulong boot_error_status_mask = ULONG_MAX;
 
 module_param(timeout_locked, int, 0444);
@@ -42,7 +42,7 @@ MODULE_PARM_DESC(reset_on_lockup,
 
 module_param(memory_scrub, int, 0444);
 MODULE_PARM_DESC(memory_scrub,
-	"Scrub device memory in various states (0 = no, 1 = yes, default yes)");
+	"Scrub device memory in various states (0 = no, 1 = yes, default no)");
 
 module_param(boot_error_status_mask, ulong, 0444);
 MODULE_PARM_DESC(boot_error_status_mask,
-- 
2.25.1

