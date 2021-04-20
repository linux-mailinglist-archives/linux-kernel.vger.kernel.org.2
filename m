Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E984C36588E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 14:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhDTMLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 08:11:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40190 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbhDTMLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 08:11:21 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lYpDI-0007Xn-IJ; Tue, 20 Apr 2021 12:10:44 +0000
From:   Colin King <colin.king@canonical.com>
To:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] platform/x86: intel_pmc_core: fix unsigned variable compared to less than zero
Date:   Tue, 20 Apr 2021 13:10:44 +0100
Message-Id: <20210420121044.379350-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The check for ret < 0 is always false because ret is a (unsigned) size_t
and not a (signed) ssize_t, hence simple_write_to_buffer failures are
never detected. Fix this by making ret a ssize_t

Addresses-Coverity: ("Unsigned compared against 0")
Fixes: 8074a79fad2e ("platform/x86: intel_pmc_core: Add option to set/clear LPM mode")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/platform/x86/intel_pmc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 3ae00ac85c75..d174aeb492e0 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -1360,7 +1360,7 @@ static ssize_t pmc_core_lpm_latch_mode_write(struct file *file,
 	struct pmc_dev *pmcdev = s->private;
 	bool clear = false, c10 = false;
 	unsigned char buf[8];
-	size_t ret;
+	ssize_t ret;
 	int idx, m, mode;
 	u32 reg;
 
-- 
2.30.2

