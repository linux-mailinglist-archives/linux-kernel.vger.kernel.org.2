Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1D530FB2F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 19:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238941AbhBDSTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 13:19:50 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59687 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237811AbhBDSSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 13:18:40 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1l7jCW-0006Sg-KL; Thu, 04 Feb 2021 18:17:56 +0000
From:   Colin King <colin.king@canonical.com>
To:     Dave Airlie <airlied@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/mgag200: make a const array static, makes object smaller
Date:   Thu,  4 Feb 2021 18:17:56 +0000
Message-Id: <20210204181756.109549-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the const array m_div_val on the stack but instead make
it static. Makes the object code smaller by 29 bytes:

Before:
   text	   data	  bss   dec    hex filename
  34736	   4552	    0 39288   9978 drivers/gpu/drm/mgag200/mgag200_mode.o

After:
   text	   data	  bss   dec    hex filename
  34625	   4616	    0 39241   9949 drivers/gpu/drm/mgag200/mgag200_mode.o

(gcc version 10.2.0)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/mgag200/mgag200_mode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
index 1dfc42170059..27f33af09798 100644
--- a/drivers/gpu/drm/mgag200/mgag200_mode.c
+++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
@@ -712,7 +712,7 @@ static int mga_g200er_set_plls(struct mga_device *mdev, long clock)
 	unsigned int p, m, n;
 	unsigned int computed, vco;
 	int tmp;
-	const unsigned int m_div_val[] = { 1, 2, 4, 8 };
+	static const unsigned int m_div_val[] = { 1, 2, 4, 8 };
 
 	m = n = p = 0;
 	vcomax = 1488000;
-- 
2.29.2

