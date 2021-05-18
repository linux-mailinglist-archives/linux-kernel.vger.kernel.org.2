Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4D0386FF0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 04:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240375AbhERCct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 22:32:49 -0400
Received: from mail-m121144.qiye.163.com ([115.236.121.144]:50378 "EHLO
        mail-m121144.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbhERCct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 22:32:49 -0400
X-Greylist: delayed 521 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 May 2021 22:32:48 EDT
Received: from Wanjb.localdomain (unknown [36.152.145.182])
        by mail-m121144.qiye.163.com (Hmail) with ESMTPA id 29208AC0444;
        Tue, 18 May 2021 10:22:48 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Marco Cesati <marcocesati@gmail.com>,
        Jiabing Wan <kael_w@yeah.net>,
        Ivan Safonov <insafonov@gmail.com>,
        Ross Schmidt <ross.schm.dev@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: os_dep: Align comments and add a blank line
Date:   Tue, 18 May 2021 10:20:54 +0800
Message-Id: <20210518022207.83513-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGklITFYdGk5NGh9DThhLTxpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OAg6Pgw*Cj8VTjQWDjgtMjYI
        SjowFBVVSlVKTUlKSEtPTk1DTE1JVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFJT0hCNwY+
X-HM-Tid: 0a797d486a20b039kuuu29208ac0444
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiabing Wan <kael_w@yeah.net>

Fixing the following checkpatch warnings:
WARNING: Block comments should align the * on each line
WARNING: Missing a blank line after declarations

Signed-off-by: Jiabing Wan<kael_w@yeah.net>
---
 drivers/staging/rtl8723bs/os_dep/osdep_service.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/osdep_service.c b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
index c58555a4012f..2d965e62347f 100644
--- a/drivers/staging/rtl8723bs/os_dep/osdep_service.c
+++ b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
@@ -7,10 +7,10 @@
 #include <drv_types.h>
 #include <rtw_debug.h>
 
-/*
-* Translate the OS dependent @param error_code to OS independent RTW_STATUS_CODE
-* @return: one of RTW_STATUS_CODE
-*/
+/**
+ * Translate the OS dependent @param error_code to OS independent RTW_STATUS_CODE
+ * @return: one of RTW_STATUS_CODE
+ */
 inline int RTW_STATUS_CODE(int error_code)
 {
 	if (error_code >= 0)
@@ -262,6 +262,7 @@ bool rtw_cbuf_push(struct rtw_cbuf *cbuf, void *buf)
 void *rtw_cbuf_pop(struct rtw_cbuf *cbuf)
 {
 	void *buf;
+
 	if (rtw_cbuf_empty(cbuf))
 		return NULL;
 
-- 
2.20.1

