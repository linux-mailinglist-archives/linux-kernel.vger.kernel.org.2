Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8280D3F874D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 14:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242604AbhHZMXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 08:23:12 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:39730
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234453AbhHZMXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 08:23:11 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 661573F051;
        Thu, 26 Aug 2021 12:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629980543;
        bh=hzj/AgwawxnfAiYUQP6Ph16Yf+1fzvWWBLo3a/kuqmo=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=WLGM31GcZ1TTHdAtx8vZylB2E+onRuDkULSNLAe42mIkc0dwcBTDrKOfjjpXyIHkc
         w3++rkyAYkY6coNAUiPmqf2vcFChkpOT6OboYCYD4GPB4EQrqI/ZJICoi+f4shsaUy
         hkG7jCLyv0xAMfHMhCh27+80EC2Ob4bvu9i/XnHl9k9Fk6BU1ntX718wg3gF4WObKZ
         jyfohHU7z4r6wb5JBWxeVfwZpkQo13lU/xUsnG9lGUS4isgxQ4glXhlQqC8RRIl9So
         JCFmzg/alaKi//q1v1Trzsj7iHnHWIDTBFSJzGzhHgo1G1TJcnH5m49N3fTOmjIXkX
         b5wd05jow95vg==
From:   Colin King <colin.king@canonical.com>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc2: Fix spelling mistake "was't" -> "wasn't"
Date:   Thu, 26 Aug 2021 13:22:23 +0100
Message-Id: <20210826122223.13533-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a deb_dbg message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/dwc2/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/core.c b/drivers/usb/dwc2/core.c
index 272ae5722c86..cf0bcd0dc320 100644
--- a/drivers/usb/dwc2/core.c
+++ b/drivers/usb/dwc2/core.c
@@ -295,7 +295,7 @@ void dwc2_hib_restore_common(struct dwc2_hsotg *hsotg, int rem_wakeup,
 	if (dwc2_hsotg_wait_bit_set(hsotg, GINTSTS, GINTSTS_RESTOREDONE,
 				    20000)) {
 		dev_dbg(hsotg->dev,
-			"%s: Restore Done wan't generated here\n",
+			"%s: Restore Done wasn't generated here\n",
 			__func__);
 	} else {
 		dev_dbg(hsotg->dev, "restore done  generated here\n");
-- 
2.32.0

