Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4423A41B7C5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 21:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242535AbhI1TxJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Sep 2021 15:53:09 -0400
Received: from mail1.shanghaitech.edu.cn ([119.78.254.90]:44389 "EHLO
        mail.shanghaitech.edu.cn" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242390AbhI1TxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 15:53:05 -0400
Received: from [10.15.44.215] by mail.shanghaitech.edu.cn with MESSAGESEC ESMTP id 456895203431526;
        Wed, 29 Sep 2021 03:51:16 +0800 (CST)
Received: from DESKTOP-FOJ6ELG.localdomain (10.15.44.220) by
 smtp.shanghaitech.edu.cn (10.15.44.215) with Microsoft SMTP Server (TLS) id
 14.3.399.0; Wed, 29 Sep 2021 03:51:16 +0800
From:   Mianhan Liu <liumh1@shanghaitech.edu.cn>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mianhan Liu <liumh1@shanghaitech.edu.cn>
Subject: [PATCH -next] ./drivers/bluetooth/bcm203x.c: remove superfluous header files from bcm203x.c
Date:   Wed, 29 Sep 2021 03:51:08 +0800
Message-ID: <20210928195108.17405-1-liumh1@shanghaitech.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
X-Originating-IP: [10.15.44.220]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bcm203x.c hasn't use any macro or function declared in linux/atomic.h.
Thus, these files can be removed from bcm203x.c safely without
affecting the compilation of the ./drivers/bluetooth module

Signed-off-by: Mianhan Liu <liumh1@shanghaitech.edu.cn>

---
 drivers/bluetooth/bcm203x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bluetooth/bcm203x.c b/drivers/bluetooth/bcm203x.c
index e667933c3..c738ad040 100644
--- a/drivers/bluetooth/bcm203x.c
+++ b/drivers/bluetooth/bcm203x.c
@@ -9,7 +9,6 @@
 
 #include <linux/module.h>
 
-#include <linux/atomic.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/slab.h>
-- 
2.25.1


