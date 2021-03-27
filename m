Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB0F34B9FF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 23:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhC0Wlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 18:41:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47721 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbhC0Wlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 18:41:32 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lQHcZ-00041U-Jx; Sat, 27 Mar 2021 22:41:31 +0000
From:   Colin King <colin.king@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: timberdale: remove redundant assignment to variable err
Date:   Sat, 27 Mar 2021 22:41:31 +0000
Message-Id: <20210327224131.25180-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable err is assigned -ENODEV followed by an error return path
via label err_mfd that does not access the variable and returns
with the -ENODEV error return code. The assignment to err is
redundant and can be removed.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mfd/timberdale.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/timberdale.c b/drivers/mfd/timberdale.c
index faecbca6dba3..0a9872ed722f 100644
--- a/drivers/mfd/timberdale.c
+++ b/drivers/mfd/timberdale.c
@@ -766,7 +766,6 @@ static int timb_probe(struct pci_dev *dev,
 	default:
 		dev_err(&dev->dev, "Unknown IP setup: %d.%d.%d\n",
 			priv->fw.major, priv->fw.minor, ip_setup);
-		err = -ENODEV;
 		goto err_mfd;
 	}
 
-- 
2.30.2

