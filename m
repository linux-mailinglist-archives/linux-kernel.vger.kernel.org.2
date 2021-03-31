Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4919F345EA5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhCWM4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:56:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230453AbhCWMzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:55:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59D34619C2;
        Tue, 23 Mar 2021 12:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616504139;
        bh=g8c3uxdKrpmxUuNjoAwznCNrlaiTJm8qlDIHtTeQkSU=;
        h=From:To:Cc:Subject:Date:From;
        b=o2VP3Wx/3B3eoEDwF46on2ovZ3XGfrawww5w8h4d0KDXBJs2ru9QCwu8wpi2d35VP
         PtT/sx5g6U3jOANm029jo+nun/nKm6NYaP4MHUru+NfEjIXUv1xLLhcllDox6peI3q
         poQa7EHNsLHHkd8LmXNA+I8k7NcV5r5nONGo43RYYrBDfzLKgWs1DpDCq/UBAiq5JD
         zkFK5fKSS/nEBWI3gdbCJVnrnK3uSim9l5MqmKm2VKPgMYsWRs/0DYp5KgzvmVWgQJ
         DtwTYctG/8cJmjy5b49NEYIfqByo3wuthq2Jd+QblMyuMUupSPYoU4kexNJGkhwNgT
         ve0zmScPVDt/A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Colin Ian King <colin.king@canonical.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] block/rnbd-clt: fix overlapping snprintf arguments
Date:   Tue, 23 Mar 2021 13:55:24 +0100
Message-Id: <20210323125535.1866249-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The -Wrestrict warning (disabled by default) points out undefined
behavior calling snprintf():

drivers/block/rnbd/rnbd-clt-sysfs.c: In function 'rnbd_clt_get_path_name':
drivers/block/rnbd/rnbd-clt-sysfs.c:486:8: error: 'snprintf' argument 4 overlaps destination object 'buf' [-Werror=restrict]
  486 |  ret = snprintf(buf, len, "%s@%s", buf, dev->sess->sessname);
      |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/block/rnbd/rnbd-clt-sysfs.c:472:67: note: destination object referenced by 'restrict'-qualified argument 1 was declared here
  472 | static int rnbd_clt_get_path_name(struct rnbd_clt_dev *dev, char *buf,
      |                                                             ~~~~~~^~~

This can be simplified by using a single snprintf() to print the
whole buffer, avoiding the undefined behavior.

Fixes: 91f4acb2801c ("block/rnbd-clt: support mapping two devices with the same name from different servers")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/block/rnbd/rnbd-clt-sysfs.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index d4aa6bfc9555..38251b749664 100644
--- a/drivers/block/rnbd/rnbd-clt-sysfs.c
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -479,11 +479,7 @@ static int rnbd_clt_get_path_name(struct rnbd_clt_dev *dev, char *buf,
 	while ((s = strchr(pathname, '/')))
 		s[0] = '!';
 
-	ret = snprintf(buf, len, "%s", pathname);
-	if (ret >= len)
-		return -ENAMETOOLONG;
-
-	ret = snprintf(buf, len, "%s@%s", buf, dev->sess->sessname);
+	ret = snprintf(buf, len, "%s@%s", pathname, dev->sess->sessname);
 	if (ret >= len)
 		return -ENAMETOOLONG;
 
-- 
2.29.2

