Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61799455024
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 23:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241057AbhKQWI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 17:08:27 -0500
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:56340 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241024AbhKQWI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 17:08:27 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id nT3VmkJwwf6fnnT3Vmnq7e; Wed, 17 Nov 2021 23:05:27 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 17 Nov 2021 23:05:27 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     alexandre.belloni@bootlin.com, npitre@baylibre.com,
        boris.brezillon@collabora.com
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] i3c/master: Fix a potentially infinite loop in 'hci_dat_v1_get_index()'
Date:   Wed, 17 Nov 2021 23:05:23 +0100
Message-Id: <0cdf3cb10293ead1acd271fdb8a70369c298c082.1637186628.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code in 'hci_dat_v1_get_index()' really looks like a hand coded version
of 'for_each_set_bit()', except that a +1 is missing when searching for the
next set bit.

This really looks odd and it seems that it will loop until 'dat_w0_read()'
returns the expected result.

So use 'for_each_set_bit()' instead. It is less verbose and should be more
correct.

Fixes: 9ad9a52cce28 ("i3c/master: introduce the mipi-i3c-hci driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Speculative fix. Untested.
---
 drivers/i3c/master/mipi-i3c-hci/dat_v1.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/dat_v1.c b/drivers/i3c/master/mipi-i3c-hci/dat_v1.c
index 783e551a2c85..97bb49ff5b53 100644
--- a/drivers/i3c/master/mipi-i3c-hci/dat_v1.c
+++ b/drivers/i3c/master/mipi-i3c-hci/dat_v1.c
@@ -160,9 +160,7 @@ static int hci_dat_v1_get_index(struct i3c_hci *hci, u8 dev_addr)
 	unsigned int dat_idx;
 	u32 dat_w0;
 
-	for (dat_idx = find_first_bit(hci->DAT_data, hci->DAT_entries);
-	     dat_idx < hci->DAT_entries;
-	     dat_idx = find_next_bit(hci->DAT_data, hci->DAT_entries, dat_idx)) {
+	for_each_set_bit(dat_idx, hci->DAT_data, hci->DAT_entries) {
 		dat_w0 = dat_w0_read(dat_idx);
 		if (FIELD_GET(DAT_0_DYNAMIC_ADDRESS, dat_w0) == dev_addr)
 			return dat_idx;
-- 
2.30.2

