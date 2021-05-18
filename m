Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B93387891
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 14:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348879AbhERMTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 08:19:43 -0400
Received: from mail-m121144.qiye.163.com ([115.236.121.144]:39402 "EHLO
        mail-m121144.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242288AbhERMTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 08:19:41 -0400
Received: from Wanjb.localdomain (unknown [36.152.145.182])
        by mail-m121144.qiye.163.com (Hmail) with ESMTPA id 75D2EAC0D52;
        Tue, 18 May 2021 20:18:21 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Baidyanath Kundu <kundubaidya99@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jiabing Wan <kael_w@yeah.net>,
        Wan Jiabing <wanjiabing@vivo.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vc04_services: fix a whitespace coding style issue
Date:   Tue, 18 May 2021 20:17:33 +0800
Message-Id: <20210518121735.88767-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGh8dHlZMH05NTU1PGklIGUxVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hOSFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PS46Pyo4Kz8NLysfQxMuTkMp
        LzgwCxRVSlVKTUlKSE9LSEtJSk9KVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFJT0tLNwY+
X-HM-Tid: 0a797f69a9bcb039kuuu75d2eac0d52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiabing Wan <kael_w@yeah.net>

Fixing the following checkpatch warning:
WARNING: please, no spaces at the start of a line

Signed-off-by: Jiabing Wan <kael_w@yeah.net>
---
 drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h b/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
index fefc664eefcf..81db7fb76d6d 100644
--- a/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
+++ b/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
@@ -104,7 +104,7 @@ extern enum vchiq_status vchiq_bulk_receive(unsigned int service,
 	enum vchiq_bulk_mode mode);
 extern void *vchiq_get_service_userdata(unsigned int service);
 extern enum vchiq_status vchiq_get_peer_version(unsigned int handle,
-      short *peer_version);
+	short *peer_version);
 extern struct vchiq_header *vchiq_msg_hold(unsigned int handle);
 
 #endif /* VCHIQ_H */
-- 
2.20.1

