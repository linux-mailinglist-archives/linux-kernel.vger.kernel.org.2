Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2881331BAC7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 15:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhBOOKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 09:10:51 -0500
Received: from m12-12.163.com ([220.181.12.12]:47968 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230410AbhBOOKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 09:10:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=16B0TKSp4VuKrzbX5F
        LXQVCjxLhrmDPq1Zobmwb0iMc=; b=Tii0gi/WnQzFRa6ldoBcqX7NWzNHNbdtb7
        phOHkHNzHUbGRKQl2gKxXT++aFQ9SZigk+/f+KLm/h0K/qLjCZfwsY8ozqaIaKfe
        EaysgdXCnq4nJ6MBvH0QJ82kq5MekiJahCDLFXCAoh4t7Zn+TQPmbbeBOjl4dqdE
        QqrH8KqGU=
Received: from localhost.localdomain (unknown [125.70.196.55])
        by smtp8 (Coremail) with SMTP id DMCowAAXb+_WSSpgRDr7Qg--.51259S2;
        Mon, 15 Feb 2021 18:15:55 +0800 (CST)
From:   Chen Lin <chen45464546@163.com>
To:     balbi@kernel.org
Cc:     gregkh@linuxfoundation.org, gustavoars@kernel.org,
        martin.petersen@oracle.com, bvanassche@acm.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen Lin <chen.lin5@zte.com.cn>
Subject: [PATCH] usb: gadget: storage: Remove unused function pointer typedef fsg_routine_t
Date:   Mon, 15 Feb 2021 18:15:30 +0800
Message-Id: <1613384130-3028-1-git-send-email-chen45464546@163.com>
X-Mailer: git-send-email 1.7.9.5
X-CM-TRANSID: DMCowAAXb+_WSSpgRDr7Qg--.51259S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr1DXF1kKF1kAw15Xr18Zrb_yoW3KFgEkr
        1jvr1xJr1qga9xKw1Yg3y3ZrW8u3WUZr4kW3Wvvr93Ca4q9w4kuw4jyrn5CFyUuryxGFsI
        y3s8XFs7Ww1xXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0ROJUUUUUU==
X-Originating-IP: [125.70.196.55]
X-CM-SenderInfo: hfkh0kqvuwkkiuw6il2tof0z/xtbBzhs6nlQHLo-5+AAAsC
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Lin <chen.lin5@zte.com.cn>

Remove the 'fsg_routine_t' typedef as it is not used.

Signed-off-by: Chen Lin <chen.lin5@zte.com.cn>
---
 drivers/usb/gadget/function/f_mass_storage.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
index 950c943..4a47036 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -351,8 +351,6 @@ static inline struct fsg_dev *fsg_from_func(struct usb_function *f)
 	return container_of(f, struct fsg_dev, function);
 }
 
-typedef void (*fsg_routine_t)(struct fsg_dev *);
-
 static int exception_in_progress(struct fsg_common *common)
 {
 	return common->state > FSG_STATE_NORMAL;
-- 
1.7.9.5


