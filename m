Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C787131E8BE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 11:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbhBRKd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 05:33:57 -0500
Received: from pv50p00im-ztbu10011701.me.com ([17.58.6.53]:38819 "EHLO
        pv50p00im-ztbu10011701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231307AbhBRJWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 04:22:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1613639435;
        bh=p7EGsARMs8loX+nsASACt4s7/oUqHQ9NEmCad21rcOc=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=vm129guHsQpLa3P91QHDdHQn3tf9n8kJXCEuO0hzQhob+nFPmzxJJiHftJnHQCQXx
         jGUxXLx4LU9k30VhhzoRgiL1gZnXDlYHwjjbBp5NHys8fuVkjyUCJRWfdfVFCvtg87
         hr7ZK65bflEYp4xfVDsfSWDaBPUidQiQwaYx2CWuoYg00V+N8oX4/vqzbGopDhpMdl
         cNEIkdCikSBCml16vu2C7KW4LcUUw0YHk7ri/xpuWVUdmVAY0IHFl+MnoiRwjfneYW
         Ck0p3oYvWqibhRaH8jN3Pnm1vg+En703zJAkuVH7r8qN/cljY+P8/nRaovxD2w1AfX
         UdtnJTC2qSlow==
Received: from everest.nathzi1505 (unknown [43.231.242.253])
        by pv50p00im-ztbu10011701.me.com (Postfix) with ESMTPSA id 52C288A04DE;
        Thu, 18 Feb 2021 09:10:29 +0000 (UTC)
From:   Pritthijit Nath <pritthijit.nath@icloud.com>
To:     nsaenzjulienne@suse.de, arnd@arndb.de, dan.carpenter@oracle.com,
        amarjargal16@gmail.com, phil@raspberrypi.com,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pritthijit Nath <pritthijit.nath@icloud.com>
Subject: [PATCH] staging: vc04_services: Fixed address type mismatch in vchiq_arm.c
Date:   Thu, 18 Feb 2021 14:40:15 +0530
Message-Id: <20210218091015.92467-1-pritthijit.nath@icloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_04:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2102180078
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change fixes a sparse address type mismatch warning "incorrect type
in assignment (different address spaces)".

Signed-off-by: Pritthijit Nath <pritthijit.nath@icloud.com>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c   | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 59e45dc03a97..3c715b926a57 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1214,11 +1214,7 @@ static int vchiq_ioc_await_completion(struct vchiq_instance *instance,
 		    !instance->use_close_delivered)
 			unlock_service(service);
 
-		/*
-		 * FIXME: address space mismatch, does bulk_userdata
-		 * actually point to user or kernel memory?
-		 */
-		user_completion.bulk_userdata = completion->bulk_userdata;
+		user_completion.bulk_userdata = (void __user *)completion->bulk_userdata;
 
 		if (vchiq_put_completion(args->buf, &user_completion, ret)) {
 			if (ret == 0)
-- 
2.25.1

