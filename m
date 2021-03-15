Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F69233B0CE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 12:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhCOLQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 07:16:44 -0400
Received: from lucky1.263xmail.com ([211.157.147.132]:35374 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhCOLQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 07:16:20 -0400
Received: from localhost (unknown [192.168.167.225])
        by lucky1.263xmail.com (Postfix) with ESMTP id 37D18F2D33;
        Mon, 15 Mar 2021 19:16:18 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [124.126.19.250])
        by smtp.263.net (postfix) whith ESMTP id P2274T140461670921984S1615806972641643_;
        Mon, 15 Mar 2021 19:16:18 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <5029d3549c0123fd912d29e648a7e3c9>
X-RL-SENDER: penghaob@uniontech.com
X-SENDER: penghaob@uniontech.com
X-LOGIN-NAME: penghaob@uniontech.com
X-FST-TO: gregkh@linuxfoundation.org
X-SENDER-IP: 124.126.19.250
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Hao Peng <penghaob@uniontech.com>
To:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        izabela.bakollari@gmail.com, penghaob@uniontech.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rts5208: add empty line in general.c
Date:   Mon, 15 Mar 2021 19:12:20 +0800
Message-Id: <20210315111220.27090-1-penghaob@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add one empty line upon return for easy reading.

Signed-off-by: Hao Peng <penghaob@uniontech.com>
---
 drivers/staging/rts5208/general.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rts5208/general.c b/drivers/staging/rts5208/general.c
index 0f912b011064..1ddfbc5aecb7 100644
--- a/drivers/staging/rts5208/general.c
+++ b/drivers/staging/rts5208/general.c
@@ -20,6 +20,7 @@ int bit1cnt_long(u32 data)
 			cnt++;
 		data >>= 1;
 	}
+
 	return cnt;
 }
 
-- 
2.20.1



