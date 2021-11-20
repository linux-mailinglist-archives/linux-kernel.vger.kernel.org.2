Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969F5457AB1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 04:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236771AbhKTDKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 22:10:43 -0500
Received: from marcansoft.com ([212.63.210.85]:48916 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236710AbhKTDKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 22:10:33 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 8216D424E8;
        Sat, 20 Nov 2021 03:07:26 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Peter <sven@svenpeter.dev>
Cc:     Hector Martin <marcan@marcan.st>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 1/2] usb: typec: tipd: Fix typo in cd321x_switch_power_state
Date:   Sat, 20 Nov 2021 12:07:16 +0900
Message-Id: <20211120030717.84287-2-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211120030717.84287-1-marcan@marcan.st>
References: <20211120030717.84287-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPSS should've been SSPS.

Fixes: c9c14be664cf ("usb: typec: tipd: Switch CD321X power state to S0")
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Sven Peter <sven@svenpeter.dev>
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/usb/typec/tipd/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index fb8ef12bbe9c..4da5a0b2aed2 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -653,7 +653,7 @@ static int cd321x_switch_power_state(struct tps6598x *tps, u8 target_state)
 	if (state == target_state)
 		return 0;
 
-	ret = tps6598x_exec_cmd(tps, "SPSS", sizeof(u8), &target_state, 0, NULL);
+	ret = tps6598x_exec_cmd(tps, "SSPS", sizeof(u8), &target_state, 0, NULL);
 	if (ret)
 		return ret;
 
-- 
2.33.0

