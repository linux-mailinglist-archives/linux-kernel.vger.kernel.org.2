Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CE53CA257
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 18:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhGOQeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 12:34:23 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:47440
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230162AbhGOQeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 12:34:21 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id DA24140610;
        Thu, 15 Jul 2021 16:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1626366682;
        bh=WBJgrOW3MINuGhTOEsZu5eF68Bgr1H9uid+GCE87DZc=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=cIToF8MA2D7c+v77Ze3s3Tw89cydPSM/RNOGI8FIGZq1YLvc87fCUF3BH/V5lPRxp
         IAGM9uIytx99z5xJD04V/jObuu8SZRvtic4JJbllSVK0HUdp/gNenpoSn9CaBBCadp
         rxJnicqqZptu+ZOoTyMCWxVpdTNPR3c/YBg2ljx9trMw42JLtkMLcW4c0xnXf2NmTN
         r0T6dTfuIFSFTtNiujnERUmSjAsYwPggc1rn+vZhoxYNgZup39j6AsWSbovZgpe0kj
         Vshx9nSo6eV0jN9clM5R3mBsh6O8aa7FJmTOqguflC73ABqr47b4eRUDqo6DUUrfuM
         Msa7wX6fsG0nw==
From:   Colin King <colin.king@canonical.com>
To:     array@vger.kernel.org, initializers@vger.kernel.org,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] speakup: use C99 syntax for array initializers
Date:   Thu, 15 Jul 2021 17:31:22 +0100
Message-Id: <20210715163122.62220-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The older obsolete array initializer syntax is currently being used
for some of the array elements. Fix this by using the preferred C99
array initializers syntax.

Fixes: 5b5140bf5182 ("speakup: Separate out translations for bright colors names")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/accessibility/speakup/i18n.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/accessibility/speakup/i18n.c b/drivers/accessibility/speakup/i18n.c
index bc7b47d1876f..d62079b1661f 100644
--- a/drivers/accessibility/speakup/i18n.c
+++ b/drivers/accessibility/speakup/i18n.c
@@ -90,13 +90,13 @@ static char *speakup_default_msgs[MSG_LAST_INDEX] = {
 	[MSG_COLOR_YELLOW] = "yellow",
 	[MSG_COLOR_WHITE] = "white",
 	[MSG_COLOR_GREY] = "grey",
-	[MSG_COLOR_BRIGHTBLUE] "bright blue",
-	[MSG_COLOR_BRIGHTGREEN] "bright green",
-	[MSG_COLOR_BRIGHTCYAN] "bright cyan",
-	[MSG_COLOR_BRIGHTRED] "bright red",
-	[MSG_COLOR_BRIGHTMAGENTA] "bright magenta",
-	[MSG_COLOR_BRIGHTYELLOW] "bright yellow",
-	[MSG_COLOR_BRIGHTWHITE] "bright white",
+	[MSG_COLOR_BRIGHTBLUE] = "bright blue",
+	[MSG_COLOR_BRIGHTGREEN] = "bright green",
+	[MSG_COLOR_BRIGHTCYAN] = "bright cyan",
+	[MSG_COLOR_BRIGHTRED] = "bright red",
+	[MSG_COLOR_BRIGHTMAGENTA] = "bright magenta",
+	[MSG_COLOR_BRIGHTYELLOW] = "bright yellow",
+	[MSG_COLOR_BRIGHTWHITE] = "bright white",
 
 	/* Names of key states. */
 	[MSG_STATE_DOUBLE] = "double",
-- 
2.31.1

