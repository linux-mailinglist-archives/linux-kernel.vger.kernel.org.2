Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A938839A1EA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 15:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhFCNN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 09:13:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38175 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbhFCNN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 09:13:57 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lon8s-0005ts-Ee; Thu, 03 Jun 2021 13:12:10 +0000
From:   Colin King <colin.king@canonical.com>
To:     Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] habanalabs/gaudi: remove redundant assignment to variable err
Date:   Thu,  3 Jun 2021 14:12:10 +0100
Message-Id: <20210603131210.84763-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable err is being assigned a value that is never read, the
assignment is redundant and can be removed. Also remove some empty
lines.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 9e4a6bb3acd1..22f220859b46 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7379,9 +7379,6 @@ static int gaudi_hbm_read_interrupts(struct hl_device *hdev, int device,
 			device, ch, hbm_ecc_data->first_addr, type,
 			hbm_ecc_data->sec_cont_cnt, hbm_ecc_data->sec_cnt,
 			hbm_ecc_data->dec_cnt);
-
-		err = 1;
-
 		return 0;
 	}
 
-- 
2.31.1

