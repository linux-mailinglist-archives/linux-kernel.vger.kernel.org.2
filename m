Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDEA4336EF8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 10:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhCKJdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 04:33:39 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51898 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbhCKJdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 04:33:08 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lKHgn-0002l7-3v; Thu, 11 Mar 2021 09:33:05 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ross Schmidt <ross.schm.dev@gmail.com>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: Fix spelling mistake "disabed" -> "disabled"
Date:   Thu, 11 Mar 2021 09:33:04 +0000
Message-Id: <20210311093304.5573-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a comment, fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/rtl8723bs/include/wifi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/wifi.h b/drivers/staging/rtl8723bs/include/wifi.h
index fe984fcb66a9..4080803d9b1b 100644
--- a/drivers/staging/rtl8723bs/include/wifi.h
+++ b/drivers/staging/rtl8723bs/include/wifi.h
@@ -719,7 +719,7 @@ struct ADDBA_request {
 
 #define	P2P_WILDCARD_SSID_LEN				7
 
-#define	P2P_FINDPHASE_EX_NONE				0	/*  default value, used when: (1)p2p disabed or (2)p2p enabled but only do 1 scan phase */
+#define	P2P_FINDPHASE_EX_NONE				0	/*  default value, used when: (1)p2p disabled or (2)p2p enabled but only do 1 scan phase */
 #define	P2P_FINDPHASE_EX_FULL				1	/*  used when p2p enabled and want to do 1 scan phase and P2P_FINDPHASE_EX_MAX-1 find phase */
 #define	P2P_FINDPHASE_EX_SOCIAL_FIRST		(P2P_FINDPHASE_EX_FULL+1)
 #define	P2P_FINDPHASE_EX_MAX					4
-- 
2.30.2

