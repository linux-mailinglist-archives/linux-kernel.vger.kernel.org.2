Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE56333CB95
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 03:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbhCPCom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 22:44:42 -0400
Received: from lucky1.263xmail.com ([211.157.147.134]:39698 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234704AbhCPCod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 22:44:33 -0400
Received: from localhost (unknown [192.168.167.13])
        by lucky1.263xmail.com (Postfix) with ESMTP id AF7A6C79C7;
        Tue, 16 Mar 2021 10:44:11 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED: 0
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [124.126.19.250])
        by smtp.263.net (postfix) whith ESMTP id P13099T140547637376768S1615862652113859_;
        Tue, 16 Mar 2021 10:44:12 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <bc293e818f684546c9ed4c9b3b04b4ba>
X-RL-SENDER: zhaoxiao@uniontech.com
X-SENDER: zhaoxiao@uniontech.com
X-LOGIN-NAME: zhaoxiao@uniontech.com
X-FST-TO: gregkh@linuxfoundation.org
X-SENDER-IP: 124.126.19.250
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     gregkh@linuxfoundation.org
Cc:     straube.linux@gmail.com, lu@pplo.net, dan.carpenter@oracle.com,
        serrazimone@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH v2] staging: rtl8192u: remove extra lines
Date:   Tue, 16 Mar 2021 10:44:10 +0800
Message-Id: <20210316024410.24609-1-zhaoxiao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove extra lines in many functions in r8192U_wx.c.

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
 drivers/staging/rtl8192u/r8192U_wx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_wx.c b/drivers/staging/rtl8192u/r8192U_wx.c
index 6ead461e3279..e68d37914456 100644
--- a/drivers/staging/rtl8192u/r8192U_wx.c
+++ b/drivers/staging/rtl8192u/r8192U_wx.c
@@ -879,7 +879,6 @@ static iw_handler r8192_wx_handlers[] = {
 
 
 static const struct iw_priv_args r8192_private_args[] = {
-
 	{
 		SIOCIWFIRSTPRIV + 0x0,
 		IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0, "badcrc"
@@ -890,14 +889,15 @@ static const struct iw_priv_args r8192_private_args[] = {
 		IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0, "activescan"
 
 	},
+
 	{
 		SIOCIWFIRSTPRIV + 0x2,
 		IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0, "rawtx"
 	},
+
 	{
 		SIOCIWFIRSTPRIV + 0x3,
 		IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0, "forcereset"
-
 	}
 
 };
-- 
2.20.1



