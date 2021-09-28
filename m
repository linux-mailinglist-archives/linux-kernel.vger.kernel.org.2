Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1940841B7E0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 22:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242603AbhI1UCE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Sep 2021 16:02:04 -0400
Received: from mail1.shanghaitech.edu.cn ([119.78.254.90]:44433 "EHLO
        mail.shanghaitech.edu.cn" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242604AbhI1UCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 16:02:03 -0400
Received: from [10.15.44.215] by mail.shanghaitech.edu.cn with MESSAGESEC ESMTP id 456895203431526;
        Wed, 29 Sep 2021 04:00:16 +0800 (CST)
Received: from DESKTOP-FOJ6ELG.localdomain (10.15.44.220) by
 smtp.shanghaitech.edu.cn (10.15.44.215) with Microsoft SMTP Server (TLS) id
 14.3.399.0; Wed, 29 Sep 2021 04:00:16 +0800
From:   Mianhan Liu <liumh1@shanghaitech.edu.cn>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mianhan Liu <liumh1@shanghaitech.edu.cn>
Subject: [PATCH -next] ./drivers/bluetooth/btrsi.c: remove superfluous header files from btrsi.c
Date:   Wed, 29 Sep 2021 03:59:54 +0800
Message-ID: <20210928195954.19629-1-liumh1@shanghaitech.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
X-Originating-IP: [10.15.44.220]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

btrsi.c hasn't use any macro or function declared in net/genetlink.h.
Thus, these files can be removed from btrsi.c safely without
affecting the compilation of the ./drivers/bluetooth module

Signed-off-by: Mianhan Liu <liumh1@shanghaitech.edu.cn>

---
 drivers/bluetooth/btrsi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bluetooth/btrsi.c b/drivers/bluetooth/btrsi.c
index 8646b6dd1..634cf8f5e 100644
--- a/drivers/bluetooth/btrsi.c
+++ b/drivers/bluetooth/btrsi.c
@@ -19,7 +19,6 @@
 #include <net/bluetooth/hci_core.h>
 #include <asm/unaligned.h>
 #include <net/rsi_91x.h>
-#include <net/genetlink.h>
 
 #define RSI_DMA_ALIGN	8
 #define RSI_FRAME_DESC_SIZE	16
-- 
2.25.1


