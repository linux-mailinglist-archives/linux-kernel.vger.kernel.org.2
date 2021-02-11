Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4E0319039
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 17:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhBKQmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 11:42:24 -0500
Received: from pv50p00im-ztdg10011301.me.com ([17.58.6.40]:59074 "EHLO
        pv50p00im-ztdg10011301.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229944AbhBKPbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 10:31:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1613057440;
        bh=JR+lVwt36NeZVokhBbvGDtwHxUoQfVZjR1m7wDVCz1E=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=vmEnUIFWD1znxM/bGg6IxeCaf5PFw5fofPyPpX3XgkOI9FYgAA/V10WT7OkPjkfUQ
         uMr04VXoIn16yHjb7cVezg18XseT9lnMunUprarjrQjb1AkPlMbD8uo0qoJ8OE2hDJ
         UtkkDwarjWKy0NqbHc/E6ZRpxkR4WrxvP9os7ZltJccQHSVQ2391O9TOu0dZDsliix
         sWaY1Lkyn0wnlPhVSBWrHw9KswTJfRh1oJDWbJ9EsYekzAkqevb1Mo3esqLSt+iYYQ
         dIkfa/tnPYlpTKhelFf0j49Tdq72z5QDFrHDR+BYPtVCZ8ENjUT50ftiwgPh48csCR
         7d5z2byWGmWEQ==
Received: from everest.nathzi1505 (unknown [45.250.50.68])
        by pv50p00im-ztdg10011301.me.com (Postfix) with ESMTPSA id 9F631760552;
        Thu, 11 Feb 2021 15:30:37 +0000 (UTC)
From:   Pritthijit Nath <pritthijit.nath@icloud.com>
To:     vireshk@kernel.org, gregkh@linuxfoundation.org, johan@kernel.org,
        elder@kernel.org
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Pritthijit Nath <pritthijit.nath@icloud.com>
Subject: [PATCH] staging: greybus: Fixed misspelling and alignment issue in hid.c
Date:   Thu, 11 Feb 2021 21:00:01 +0530
Message-Id: <20210211153001.10358-1-pritthijit.nath@icloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change fixes a checkpatch CHECK style issue for "Alignment should match open parenthesis".
In addition the misspelling of "transferred" also has been fixed.

Signed-off-by: Pritthijit Nath <pritthijit.nath@icloud.com>
---
 drivers/staging/greybus/hid.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/greybus/hid.c b/drivers/staging/greybus/hid.c
index ed706f39e87a..adb91286803a 100644
--- a/drivers/staging/greybus/hid.c
+++ b/drivers/staging/greybus/hid.c
@@ -221,8 +221,8 @@ static void gb_hid_init_reports(struct gb_hid *ghid)
 }
 
 static int __gb_hid_get_raw_report(struct hid_device *hid,
-		unsigned char report_number, __u8 *buf, size_t count,
-		unsigned char report_type)
+				   unsigned char report_number, __u8 *buf, size_t count,
+				   unsigned char report_type)
 {
 	struct gb_hid *ghid = hid->driver_data;
 	int ret;
@@ -254,7 +254,7 @@ static int __gb_hid_output_raw_report(struct hid_device *hid, __u8 *buf,
 
 	ret = gb_hid_set_report(ghid, report_type, report_id, buf, len);
 	if (report_id && ret >= 0)
-		ret++; /* add report_id to the number of transfered bytes */
+		ret++; /* add report_id to the number of transferred bytes */
 
 	return 0;
 }
-- 
2.25.1

