Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885073AE1D1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 05:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhFUDOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 23:14:06 -0400
Received: from m12-18.163.com ([220.181.12.18]:44802 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230161AbhFUDOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 23:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=ubUEfq7Xyv0KG9gx3E
        ltCVrbavw+fD3K0qgWgNu4dT0=; b=hr2FYSX+xhAlgvTVAuMapmyYq3I9E+YH04
        +RvYZlcL2xX41r3yt7szDOq3qKMEChMaOGIexZS44/QW522RVMrt7MyDHyMw0+6z
        3gUo4X8jEVuSSsSQ8TP7093Z0e03cfVGQtsvZpG++46su1mWwdq3kRhBc5HVk/gD
        O2d1S5ClQ=
Received: from localhost.localdomain (unknown [218.94.48.178])
        by smtp14 (Coremail) with SMTP id EsCowAC3xgpcA9BgMeG4qg--.32530S2;
        Mon, 21 Jun 2021 11:11:25 +0800 (CST)
From:   Guoqing Chi <chi962464zy@163.com>
To:     gregkh@linuxfoundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org, chi962464zy@163.com,
        chiguoqing@yulong.com
Subject: [PATCH] misc: ibmasm: Modify matricies to matrices
Date:   Mon, 21 Jun 2021 03:11:00 +0000
Message-Id: <20210621031100.13093-1-chi962464zy@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: EsCowAC3xgpcA9BgMeG4qg--.32530S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFy7tw4ruw4fXrW8ZFW5Wrg_yoWxurXE9F
        s5urs2qryUKw1Skrn5GrsavryjgF4UZF1FgF13tayrWr9xAws3Gwn2gryrXan0yr45uFW3
        W34DWFW0yrnFyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xREVWltUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: pfklmlasuwk6r16rljoofrz/xtbB+A24RF2MZU2l-gAAsr
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guoqing Chi <chiguoqing@yulong.com>

The plural of "matrix" is "matrices".

Signed-off-by: Guoqing Chi <chiguoqing@yulong.com>
---
 drivers/misc/ibmasm/remote.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/ibmasm/remote.h b/drivers/misc/ibmasm/remote.h
index 8d364462aeea..ec4e78ec5a67 100644
--- a/drivers/misc/ibmasm/remote.h
+++ b/drivers/misc/ibmasm/remote.h
@@ -43,7 +43,7 @@
 #define REMOTE_BUTTON_MIDDLE	0x02
 #define REMOTE_BUTTON_RIGHT	0x04
 
-/* size of keysym/keycode translation matricies */
+/* size of keysym/keycode translation matrices */
 #define XLATE_SIZE 256
 
 struct mouse_input {
-- 
2.17.1


