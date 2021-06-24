Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1D33B29BE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 09:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbhFXHy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 03:54:26 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:25699 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbhFXHyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 03:54:25 -0400
X-Greylist: delayed 572 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Jun 2021 03:54:25 EDT
Received: from spf.mail.chinamobile.com (unknown[172.16.121.7]) by rmmx-syy-dmz-app10-12010 (RichMail) with SMTP id 2eea60d43758048-ec932; Thu, 24 Jun 2021 15:42:17 +0800 (CST)
X-RM-TRANSID: 2eea60d43758048-ec932
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
        by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee460d43752bc5-e26d2;
        Thu, 24 Jun 2021 15:42:16 +0800 (CST)
X-RM-TRANSID: 2ee460d43752bc5-e26d2
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] ARM: bL_switcher: use IS_ERR_OR_NULL() to simplify code
Date:   Thu, 24 Jun 2021 15:42:23 +0800
Message-Id: <20210624074223.11372-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use IS_ERR_OR_NULL() instead of IS_ERR() to simplify code.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 arch/arm/common/bL_switcher.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
index 9a9aa5354..b8e8e2567 100644
--- a/arch/arm/common/bL_switcher.c
+++ b/arch/arm/common/bL_switcher.c
@@ -352,11 +352,9 @@ int bL_switch_request_cb(unsigned int cpu, unsigned int new_cluster_id,
 
 	t = &bL_threads[cpu];
 
-	if (IS_ERR(t->task))
-		return PTR_ERR(t->task);
-	if (!t->task)
-		return -ESRCH;
-
+	if (IS_ERR_OR_NULL(t->task))
+		return t->task ? PTR_ERR(t->task) : -ESRCH;
+
 	spin_lock(&t->lock);
 	if (t->completer) {
 		spin_unlock(&t->lock);
-- 
2.20.1.windows.1



