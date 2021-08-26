Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589B83F87C0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 14:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242341AbhHZMkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 08:40:51 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:56268
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240770AbhHZMks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 08:40:48 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id A83393F245;
        Thu, 26 Aug 2021 12:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629981599;
        bh=TKF+42ZxrWYsLD4ysTzhSy+xn6UWr/AHBlUXLt4dSZk=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=rxUlkGiLXpfYa8vyM8fgzMeu6qaskz6I1UBFgrx0ayQmf0kAg40uEeQsusT3MY/8/
         K+CEQDTLoV2oN14f0Z6ccV5wn1eQT4hOg8jsEr2/TwkpRKAia8+arSEl/jVHG1EArf
         VaeWLtdT12C6m2mXgcZwzPN3zLp/CD0sNoXH7tYlGWWmZkH01ceadfHsvsq+e5Fd2B
         24AN6b/D3jPfqQtr0uT1aKWD9X7JqnoCehsavXdpIWsNJGqTRKtbnGms5zv7fZ2+Na
         Q8Y2CJyMMucfeRfEkDwRvYjnyQi9C0ynL6uXXBXC1frKhUHFZqUJD8ZLUPJYNil4Jt
         lF+VvjxOJlTJA==
From:   Colin King <colin.king@canonical.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: typec: tcpm: Fix spelling mistake "atleast" -> "at least"
Date:   Thu, 26 Aug 2021 13:39:59 +0100
Message-Id: <20210826123959.14838-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are spelling mistakes in a comment and a literal string.
Fix them.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 049f4c61ee82..b981fc39fa3c 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -278,7 +278,7 @@ struct pd_mode_data {
  * @req_max_curr: Requested max current of the port partner
  * @req_out_volt: Requested output voltage to the port partner
  * @req_op_curr: Requested operating current to the port partner
- * @supported: Parter has atleast one APDO hence supports PPS
+ * @supported: Parter has at least one APDO hence supports PPS
  * @active: PPS mode is active
  */
 struct pd_pps_data {
@@ -2050,7 +2050,7 @@ enum pdo_err {
 
 static const char * const pdo_err_msg[] = {
 	[PDO_ERR_NO_VSAFE5V] =
-	" err: source/sink caps should atleast have vSafe5V",
+	" err: source/sink caps should at least have vSafe5V",
 	[PDO_ERR_VSAFE5V_NOT_FIRST] =
 	" err: vSafe5V Fixed Supply Object Shall always be the first object",
 	[PDO_ERR_PDO_TYPE_NOT_IN_ORDER] =
-- 
2.32.0

