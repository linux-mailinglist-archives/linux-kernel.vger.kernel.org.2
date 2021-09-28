Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3056241B7C4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 21:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242575AbhI1Ttl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Sep 2021 15:49:41 -0400
Received: from mail.shanghaitech.edu.cn ([119.78.254.11]:3840 "EHLO
        mail.shanghaitech.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242390AbhI1Ttk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 15:49:40 -0400
Received: from [10.15.44.215] by mail.shanghaitech.edu.cn with MESSAGESEC ESMTP id 480405203431526;
        Wed, 29 Sep 2021 03:47:49 +0800 (CST)
Received: from DESKTOP-FOJ6ELG.localdomain (10.15.44.220) by
 smtp.shanghaitech.edu.cn (10.15.44.215) with Microsoft SMTP Server (TLS) id
 14.3.399.0; Wed, 29 Sep 2021 03:47:48 +0800
From:   Mianhan Liu <liumh1@shanghaitech.edu.cn>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mianhan Liu <liumh1@shanghaitech.edu.cn>
Subject: [PATCH -next] ./drivers/bluetooth/ath3k.c: remove superfluous header files from ath3k.c
Date:   Wed, 29 Sep 2021 03:47:30 +0800
Message-ID: <20210928194730.16694-1-liumh1@shanghaitech.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
X-Originating-IP: [10.15.44.220]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ath3k.c hasn't use any macro or function declared in linux/device.h.
Thus, these files can be removed from ath3k.c safely without
affecting the compilation of the ./drivers/bluetooth module

Signed-off-by: Mianhan Liu <liumh1@shanghaitech.edu.cn>

---
 drivers/bluetooth/ath3k.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 759d78289..88262d3a9 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -10,7 +10,6 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/errno.h>
-#include <linux/device.h>
 #include <linux/firmware.h>
 #include <linux/usb.h>
 #include <asm/unaligned.h>
-- 
2.25.1


