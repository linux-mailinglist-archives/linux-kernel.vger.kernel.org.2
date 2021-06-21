Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27FD3AEA0E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 15:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhFUNbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 09:31:02 -0400
Received: from m12-14.163.com ([220.181.12.14]:51797 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229807AbhFUNbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 09:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=g0Qjq
        YJGVwhG3ytopKC11SA85FuEgwfVn21G8TyG42I=; b=BulZ+qT3C5UzAr+06QwF7
        TWGBfQEfR3vLVW8VfxmsDNCkeu9XdGQkijRfGC3MllTnmDsc0o+iYg6tD5vKFqeV
        ERtLx/DI7+YGwVOxWiD7xzcX8Ub1Q5cwJT4uogdK77Q0ILEdNYwvOIk2IibMhVaX
        YoTQZu8e2/nLFqXwlQE4fQ=
Received: from yangjunlin.ccdomain.com (unknown [218.17.89.92])
        by smtp10 (Coremail) with SMTP id DsCowAAHChaak9BgehBNQA--.50618S2;
        Mon, 21 Jun 2021 21:26:52 +0800 (CST)
From:   Junlin Yang <angkery@163.com>
To:     gregkh@linuxfoundation.org, oneukum@suse.com,
        penguin-kernel@i-love.sakura.ne.jp, loic.poulain@linaro.org,
        davem@davemloft.net, lee.jones@linaro.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Junlin Yang <yangjunlin@yulong.com>
Subject: [PATCH] usb: class: cdc-wdm: return the correct errno code
Date:   Mon, 21 Jun 2021 21:24:15 +0800
Message-Id: <20210621132415.2341-1-angkery@163.com>
X-Mailer: git-send-email 2.24.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowAAHChaak9BgehBNQA--.50618S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF1DArWUJF1fAw1UGF1xKrg_yoWDtwb_GF
        W09ws3Wr4DZ3W8WryDt343Ar9YkF4vvrZxuFnaqry3CFyjkrWkGr1qqr98A3WxWF4SvFnr
        uFy2kw1fAF48GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeg18JUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5dqjyvlu16il2tof0z/1tbiLBy4I1spa5edLQAAsV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junlin Yang <yangjunlin@yulong.com>

The "rv" is initialized to "-ENOMEM", because "rv" is re-assigned to
"-EINVAL", when kmalloc & usb_alloc_urb failed, the return value should
return "-ENOMEM" rather than "-EINVAL",so the "rv" assignment is placed
in the position where usb_endpoint_is_int_in is false.

Signed-off-by: Junlin Yang <yangjunlin@yulong.com>
---
 drivers/usb/class/cdc-wdm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index 8e5490a..fdf79bc 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -1035,9 +1035,10 @@ static int wdm_create(struct usb_interface *intf, struct usb_endpoint_descriptor
 	INIT_WORK(&desc->rxwork, wdm_rxwork);
 	INIT_WORK(&desc->service_outs_intr, service_interrupt_work);
 
-	rv = -EINVAL;
-	if (!usb_endpoint_is_int_in(ep))
+	if (!usb_endpoint_is_int_in(ep)) {
+		rv = -EINVAL;
 		goto err;
+	}
 
 	desc->wMaxPacketSize = usb_endpoint_maxp(ep);
 
-- 
1.9.1

