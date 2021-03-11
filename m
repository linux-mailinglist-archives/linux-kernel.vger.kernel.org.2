Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E247336F56
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 10:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbhCKJxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 04:53:33 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52429 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbhCKJxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 04:53:18 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lKI0K-0004EF-Up; Thu, 11 Mar 2021 09:53:17 +0000
From:   Colin King <colin.king@canonical.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org
Subject: [PATCH][next] nvmem: core: Fix unintentional sign extension issue
Date:   Thu, 11 Mar 2021 09:53:16 +0000
Message-Id: <20210311095316.6480-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The shifting of the u8 integer buf[3] by 24 bits to the left will
be promoted to a 32 bit signed int and then sign-extended to a
u64. In the event that the top bit of buf[3] is set then all
then all the upper 32 bits of the u64 end up as also being set
because of the sign-extension. Fix this by casting buf[i] to
a u64 before the shift.

Addresses-Coverity: ("Unintended sign extension")
Fixes: 097eb1136ebb ("nvmem: core: Add functions to make number reading easy")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 635e3131eb5f..bca671ff4e54 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1693,7 +1693,7 @@ int nvmem_cell_read_variable_le_u64(struct device *dev, const char *cell_id,
 	/* Copy w/ implicit endian conversion */
 	*val = 0;
 	for (i = 0; i < len; i++)
-		*val |= buf[i] << (8 * i);
+		*val |= (uint64_t)buf[i] << (8 * i);
 
 	kfree(buf);
 
-- 
2.30.2

