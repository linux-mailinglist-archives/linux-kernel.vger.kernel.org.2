Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2EE333B8E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 12:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhCJLhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 06:37:18 -0500
Received: from lucky1.263xmail.com ([211.157.147.131]:60356 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbhCJLgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 06:36:01 -0500
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 2F791B9494;
        Wed, 10 Mar 2021 19:35:20 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED: 0
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [124.126.19.250])
        by smtp.263.net (postfix) whith ESMTP id P24304T139685143766784S1615376108869662_;
        Wed, 10 Mar 2021 19:35:20 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <4ec89a2957857c08fc507248c6268e1d>
X-RL-SENDER: guolongji@uniontech.com
X-SENDER: guolongji@uniontech.com
X-LOGIN-NAME: guolongji@uniontech.com
X-FST-TO: gregkh@linuxfoundation.org
X-SENDER-IP: 124.126.19.250
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Longji Guo <guolongji@uniontech.com>
To:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        matthew.v.deangelis@gmail.com, dan.carpenter@oracle.com,
        amarjargal16@gmail.com, vkor@vkten.in, pterjan@google.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Longji Guo <guolongji@uniontech.com>
Subject: [PATCH] Staging: rtl8723bs/core: fix coding style issue
Date:   Wed, 10 Mar 2021 19:35:03 +0800
Message-Id: <20210310113503.1352-1-guolongji@uniontech.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move operators and spaces before tabs to fix coding style issues.

Signed-off-by: Longji Guo <guolongji@uniontech.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 3c9dbd7443d9..f249193edeb3 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -576,7 +576,7 @@ union recv_frame *portctrl(struct adapter *adapter, union recv_frame *precv_fram
 			prtnframe = precv_frame;
 
 			/* get ether_type */
-			ptr = ptr+pfhdr->attrib.hdrlen+pfhdr->attrib.iv_len+LLC_HEADER_SIZE;
+			ptr = ptr + pfhdr->attrib.hdrlen + pfhdr->attrib.iv_len + LLC_HEADER_SIZE;
 			memcpy(&be_tmp, ptr, 2);
 			ether_type = ntohs(be_tmp);
 
-- 
2.30.1



