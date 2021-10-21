Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A72435765
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 02:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhJUA0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 20:26:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232082AbhJUAZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 20:25:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42BF3611CC;
        Thu, 21 Oct 2021 00:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634775775;
        bh=hGpd3YvNPeXFjd18sjoJ/3BCSMDycHYGo7nmSGnP960=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ICL/EHm+FT8oJ1CWQFAT//ANkFpLV93lhUubTYQ6jDFeGDxAtCCMCj9hMkxCRoGXS
         gi4ODMfsGAnUklnzSL7Jli0o3sSxIjvCGt+4x1FFPajugP9+xeJ5dFmpFMds7wE1SM
         C7q1P9ISKejM0kOBXgWNyzHVIqekCCCi+VI5/oGnwoiLDiBNZCb04Q3HcUJfrJeTfj
         z9VDprLWWj2r7+lqJv/vXmq2Uta5Qu0MnSSjRQOxzYSgxTB/qWEUO76NLa4Q2cqS80
         DwRXaDl4RuMsLqJgE8N1PiiexxLBSDgEAkk+FTZAkptH2P2Pgq26bDWraEPnInIXTm
         +F8LWc7zhfXWw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>, mgross@linux.intel.com,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 08/11] platform/x86: intel_scu_ipc: Update timeout value in comment
Date:   Wed, 20 Oct 2021 20:22:34 -0400
Message-Id: <20211021002238.1129482-8-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211021002238.1129482-1-sashal@kernel.org>
References: <20211021002238.1129482-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prashant Malani <pmalani@chromium.org>

[ Upstream commit a0c5814b9933f25ecb6de169483c5b88cf632bca ]

The comment decribing the IPC timeout hadn't been updated when the
actual timeout was changed from 3 to 5 seconds in
commit a7d53dbbc70a ("platform/x86: intel_scu_ipc: Increase virtual
timeout from 3 to 5 seconds") .

Since the value is anyway updated to 10s now, take this opportunity to
update the value in the comment too.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
Cc: Benson Leung <bleung@chromium.org>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Link: https://lore.kernel.org/r/20210928101932.2543937-4-pmalani@chromium.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel_scu_ipc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index e330ec73c465..bcb516892d01 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -181,7 +181,7 @@ static inline int busy_loop(struct intel_scu_ipc_dev *scu)
 	return 0;
 }
 
-/* Wait till ipc ioc interrupt is received or timeout in 3 HZ */
+/* Wait till ipc ioc interrupt is received or timeout in 10 HZ */
 static inline int ipc_wait_for_interrupt(struct intel_scu_ipc_dev *scu)
 {
 	int status;
-- 
2.33.0

