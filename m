Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4258432BD0C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447854AbhCCPQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 10:16:42 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58334 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240078AbhCCK2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:28:31 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lHOGw-00021a-Nu; Wed, 03 Mar 2021 09:58:26 +0000
From:   Colin King <colin.king@canonical.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ray Chi <raychi@google.com>, linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: Fix dereferencing of null dwc->usb_psy
Date:   Wed,  3 Mar 2021 09:58:26 +0000
Message-Id: <20210303095826.6143-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the null check logic on dwc->usb_psy is inverted as it allows
calls to power_supply_put with a null dwc->usb_psy causing a null
pointer dereference. Fix this by removing the ! operator.

Addresses-Coverity: ("Dereference after null check")
Fixes: 59fa3def35de ("usb: dwc3: add a power supply for current control")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/dwc3/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index d15f065849cd..94fdbe502ce9 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1628,7 +1628,7 @@ static int dwc3_probe(struct platform_device *pdev)
 assert_reset:
 	reset_control_assert(dwc->reset);
 
-	if (!dwc->usb_psy)
+	if (dwc->usb_psy)
 		power_supply_put(dwc->usb_psy);
 
 	return ret;
@@ -1653,7 +1653,7 @@ static int dwc3_remove(struct platform_device *pdev)
 	dwc3_free_event_buffers(dwc);
 	dwc3_free_scratch_buffers(dwc);
 
-	if (!dwc->usb_psy)
+	if (dwc->usb_psy)
 		power_supply_put(dwc->usb_psy);
 
 	return 0;
-- 
2.30.0

