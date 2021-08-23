Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0423F4B0B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 14:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236897AbhHWMqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 08:46:49 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:41936 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235954AbhHWMqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 08:46:48 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id 3711BA5E9158F9905E74;
        Mon, 23 Aug 2021 20:46:02 +0800 (CST)
Received: from kjyxh01app01.zte.com.cn ([10.30.12.226])
        by mse-fl1.zte.com.cn with SMTP id 17NCjpEJ071935;
        Mon, 23 Aug 2021 20:45:51 +0800 (GMT-8)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (kjyxh01app01[null])
        by mapi (Zmail) with MAPI id mid14;
        Mon, 23 Aug 2021 20:45:47 +0800 (CST)
Date:   Mon, 23 Aug 2021 20:45:47 +0800 (CST)
X-Zmail-TransId: 2af96123987b663e1db6
X-Mailer: Zmail v1.0
Message-ID: <202108232045471583580@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <gregkh@linuxfoundation.org>, <salah.triki@gmail.com>
Cc:     <linux-kernel@vger.kernel.org>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBkaW86IGFkZCBtaXNzaW5nIGlvdW5tYXAoKSBhZnRlciBpb3JlbWFwKCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 17NCjpEJ071935
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

If kzalloc() fails, the 'va' needs to be unmapped before returning -ENOMEM.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 drivers/dio/dio.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/dio/dio.c b/drivers/dio/dio.c
index 4c06c93..7d19250 100644
--- a/drivers/dio/dio.c
+++ b/drivers/dio/dio.c
@@ -218,9 +218,11 @@ static int __init dio_init(void)

        /* Found a board, allocate it an entry in the list */
        dev = kzalloc(sizeof(struct dio_dev), GFP_KERNEL);
-       if (!dev)
+       if (!dev) {
+           if (scode >= DIOII_SCBASE)
+               iounmap(va);
            return -ENOMEM;
+       }
        dev->bus = &dio_bus;
        dev->dev.parent = &dio_bus.dev;
        dev->dev.bus = &dio_bus_type;
-- 
2.15.2
