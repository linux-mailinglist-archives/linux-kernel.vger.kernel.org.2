Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D5630D83E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbhBCLN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:13:28 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33408 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbhBCLNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:13:22 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1l7G5P-0007Fi-EL; Wed, 03 Feb 2021 11:12:39 +0000
From:   Colin King <colin.king@canonical.com>
To:     Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] usb: cdnsp: Fix spelling mistake "delagete" -> "delegate"
Date:   Wed,  3 Feb 2021 11:12:39 +0000
Message-Id: <20210203111239.18313-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a literal string. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/cdns3/cdnsp-ep0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/cdnsp-ep0.c b/drivers/usb/cdns3/cdnsp-ep0.c
index e2b1bcb3f80e..e30931ebc870 100644
--- a/drivers/usb/cdns3/cdnsp-ep0.c
+++ b/drivers/usb/cdns3/cdnsp-ep0.c
@@ -45,7 +45,7 @@ static int cdnsp_ep0_delegate_req(struct cdnsp_device *pdev,
 {
 	int ret;
 
-	trace_cdnsp_ep0_request("delagete");
+	trace_cdnsp_ep0_request("delegate");
 
 	spin_unlock(&pdev->lock);
 	ret = pdev->gadget_driver->setup(&pdev->gadget, ctrl);
-- 
2.29.2

