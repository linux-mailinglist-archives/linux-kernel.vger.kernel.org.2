Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C1D39B117
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 05:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhFDDqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 23:46:10 -0400
Received: from m12-11.163.com ([220.181.12.11]:38944 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229752AbhFDDqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 23:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=FmxUj
        KVQIuJAaq3lGa+6X572w1A/7Qnk6NsprRvzZpI=; b=EV0Fp/V0DlhX49xj0KzBs
        XZ8Ise12m/uK/W1c/l2tvQQs/1Y/VUyMw5IZmgtYEP4wGpd1ChTMz6tihI3Y1L6j
        BqqW6V46bZoA9hFqQgopdeDF0P/Vi7nmFhiyfB+s/sa+qddeotQL/PHwKoO67fAY
        z4IWwUklvqdpSECqdWJgys=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp7 (Coremail) with SMTP id C8CowACnoJiSoblgMnNogA--.1235S2;
        Fri, 04 Jun 2021 11:44:19 +0800 (CST)
From:   lijian_8010a29@163.com
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, lijian <lijian@yulong.com>
Subject: [PATCH] video: fbdev: aty: mach64_gx: Added parentheses for the macro
Date:   Fri,  4 Jun 2021 11:43:21 +0800
Message-Id: <20210604034321.167789-1-lijian_8010a29@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowACnoJiSoblgMnNogA--.1235S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xry8Zr1DXr4xXF48Zr1fJFb_yoWxAFb_Cr
        42v3s7Jr90kFs2yrykZr1rury2va4xZFn3uFn0qrZak342yrWYgr1rWFy0qry5Gr4UXFWD
        WF1qgr1Fv34fGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5PrcDUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5olmxttqbyiikqdsmqqrwthudrp/1tbiRQenUFl9181h0gABs5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lijian <lijian@yulong.com>

Macros with complex values should be enclosed in parentheses，
so Added parentheses for the macro 'MAX_N'.

Signed-off-by: lijian <lijian@yulong.com>
---
 drivers/video/fbdev/aty/mach64_gx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/aty/mach64_gx.c b/drivers/video/fbdev/aty/mach64_gx.c
index 9619661b7843..4d89c05e5a65 100644
--- a/drivers/video/fbdev/aty/mach64_gx.c
+++ b/drivers/video/fbdev/aty/mach64_gx.c
@@ -33,7 +33,7 @@
 #define MIN_M		2
 #define MAX_M		30
 #define MIN_N		35
-#define MAX_N		255-8
+#define MAX_N		(255-8)
 
 
     /*
-- 
2.25.1

