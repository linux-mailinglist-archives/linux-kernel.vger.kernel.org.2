Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B2333D147
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 11:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235979AbhCPJ7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 05:59:49 -0400
Received: from lucky1.263xmail.com ([211.157.147.131]:41604 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbhCPJ7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 05:59:36 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id DEFB1B9C13;
        Tue, 16 Mar 2021 17:59:23 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED: 0
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [111.207.172.18])
        by smtp.263.net (postfix) whith ESMTP id P24307T139684751603456S1615888764106483_;
        Tue, 16 Mar 2021 17:59:24 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <d7221418796d3fc50478431db0aa96c7>
X-RL-SENDER: zhaoxiao@uniontech.com
X-SENDER: zhaoxiao@uniontech.com
X-LOGIN-NAME: zhaoxiao@uniontech.com
X-FST-TO: gregkh@linuxfoundation.org
X-SENDER-IP: 111.207.172.18
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     gregkh@linuxfoundation.org
Cc:     straube.linux@gmail.com, lu@pplo.net, dan.carpenter@oracle.com,
        serrazimone@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH] staging: rtl8192u: remove extra lines
Date:   Tue, 16 Mar 2021 17:59:22 +0800
Message-Id: <20210316095922.21123-1-zhaoxiao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove extra lines in the struct r8192_private_args.

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
 drivers/staging/rtl8192u/r8192U_wx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_wx.c b/drivers/staging/rtl8192u/r8192U_wx.c
index 6ead461e3279..e9de7dc8f049 100644
--- a/drivers/staging/rtl8192u/r8192U_wx.c
+++ b/drivers/staging/rtl8192u/r8192U_wx.c
@@ -879,12 +879,10 @@ static iw_handler r8192_wx_handlers[] = {
 
 
 static const struct iw_priv_args r8192_private_args[] = {
-
 	{
 		SIOCIWFIRSTPRIV + 0x0,
 		IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0, "badcrc"
 	},
-
 	{
 		SIOCIWFIRSTPRIV + 0x1,
 		IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0, "activescan"
@@ -897,7 +895,6 @@ static const struct iw_priv_args r8192_private_args[] = {
 	{
 		SIOCIWFIRSTPRIV + 0x3,
 		IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0, "forcereset"
-
 	}
 
 };
-- 
2.20.1



