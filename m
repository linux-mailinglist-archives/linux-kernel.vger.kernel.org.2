Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64C9360A13
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 15:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbhDONG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 09:06:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48594 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbhDONGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 09:06:23 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lX1h1-0000Dq-Bl; Thu, 15 Apr 2021 13:05:59 +0000
From:   Colin King <colin.king@canonical.com>
To:     Richard Russon <ldm@flatcap.org>, Jens Axboe <axboe@kernel.dk>,
        linux-ntfs-dev@lists.sourceforge.net, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] partitions/ldm: remove redundant assignment to variable r_index
Date:   Thu, 15 Apr 2021 14:05:59 +0100
Message-Id: <20210415130559.1960198-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable r_index is being assigned a value that is never read,
the assignment is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 block/partitions/ldm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/partitions/ldm.c b/block/partitions/ldm.c
index d333786b5c7e..b40c0ac9022c 100644
--- a/block/partitions/ldm.c
+++ b/block/partitions/ldm.c
@@ -964,7 +964,6 @@ static bool ldm_parse_prt3(const u8 *buffer, int buflen, struct vblk *vb)
 		}
 		len = r_index;
 	} else {
-		r_index = 0;
 		len = r_diskid;
 	}
 	if (len < 0) {
-- 
2.30.2

