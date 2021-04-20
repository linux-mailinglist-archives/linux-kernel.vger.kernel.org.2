Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F2B3657B1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 13:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbhDTLjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 07:39:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39043 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbhDTLiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 07:38:51 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lYohu-0005Og-EL; Tue, 20 Apr 2021 11:38:18 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: storage: datafab: remove redundant assignment of variable result
Date:   Tue, 20 Apr 2021 12:38:18 +0100
Message-Id: <20210420113818.378478-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable result is being assigned with a value that is
never read, the assignment is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/storage/datafab.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/storage/datafab.c b/drivers/usb/storage/datafab.c
index 588818483f4b..bcc4a2fad863 100644
--- a/drivers/usb/storage/datafab.c
+++ b/drivers/usb/storage/datafab.c
@@ -294,7 +294,6 @@ static int datafab_write_data(struct us_data *us,
 		if (reply[0] != 0x50 && reply[1] != 0) {
 			usb_stor_dbg(us, "Gah! write return code: %02x %02x\n",
 				     reply[0], reply[1]);
-			result = USB_STOR_TRANSPORT_ERROR;
 			goto leave;
 		}
 
-- 
2.30.2

