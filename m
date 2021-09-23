Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF9A41573E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 05:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239138AbhIWD54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 23:57:56 -0400
Received: from smtp181.sjtu.edu.cn ([202.120.2.181]:32986 "EHLO
        smtp181.sjtu.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239133AbhIWD5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 23:57:52 -0400
Received: from proxy02.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
        by smtp181.sjtu.edu.cn (Postfix) with ESMTPS id B49BA1008CBCD;
        Thu, 23 Sep 2021 11:56:19 +0800 (CST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by proxy02.sjtu.edu.cn (Postfix) with ESMTP id DFA8C200B5750;
        Thu, 23 Sep 2021 11:56:18 +0800 (CST)
X-Virus-Scanned: amavisd-new at 
Received: from proxy02.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy02.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OmACp8iz5J-C; Thu, 23 Sep 2021 11:56:18 +0800 (CST)
Received: from guozhi-ipads.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
        (Authenticated sender: qtxuning1999@sjtu.edu.cn)
        by proxy02.sjtu.edu.cn (Postfix) with ESMTPSA id 1EB59200C02C8;
        Thu, 23 Sep 2021 11:55:57 +0800 (CST)
From:   Guo Zhi <qtxuning1999@sjtu.edu.cn>
To:     nsaenz@kernel.org, gregkh@linuxfoundation.org,
        peterz@infradead.org, maz@kernel.org, bsegall@google.com,
        rdunlap@infradead.org, airlied@redhat.com,
        kan.liang@linux.intel.com, odin@uged.al
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Guo Zhi <qtxuning1999@sjtu.edu.cn>
Subject: [PATCH] staging: vchip_arm: Fix misuse of %x
Date:   Thu, 23 Sep 2021 11:55:54 +0800
Message-Id: <20210923035554.669434-1-qtxuning1999@sjtu.edu.cn>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointers should be printed with %p or %px rather than
cast to (unsigned long) and printed with %lx.
Change %lx to %pK to print the pointers.

Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index b5aac862a29..408e5fe710b 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -591,11 +591,11 @@ service_callback(enum vchiq_reason reason, struct vchiq_header *header,
 		return VCHIQ_SUCCESS;
 
 	vchiq_log_trace(vchiq_arm_log_level,
-		"%s - service %lx(%d,%p), reason %d, header %lx, instance %lx, bulk_userdata %lx",
-		__func__, (unsigned long)user_service,
+		"%s - service %pK(%d,%p), reason %d, header %pK, instance %pK, bulk_userdata %pK",
+		__func__, user_service,
 		service->localport, user_service->userdata,
-		reason, (unsigned long)header,
-		(unsigned long)instance, (unsigned long)bulk_userdata);
+		reason, header,
+		instance, bulk_userdata);
 
 	if (header && user_service->is_vchi) {
 		spin_lock(&msg_queue_spinlock);
-- 
2.33.0

