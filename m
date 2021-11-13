Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA7144F4B5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 19:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbhKMS7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 13:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236070AbhKMS6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 13:58:51 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4A5C061767
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 10:55:59 -0800 (PST)
Received: from dslb-188-096-147-224.188.096.pools.vodafone-ip.de ([188.96.147.224] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mlyBu-0002H8-Uc; Sat, 13 Nov 2021 19:55:55 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 10/15] staging: r8188eu: remove defines for efuse type
Date:   Sat, 13 Nov 2021 19:55:13 +0100
Message-Id: <20211113185518.23941-11-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211113185518.23941-1-martin@kaiser.cx>
References: <20211113185518.23941-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've removed all code to handle efuse types. The last step is to
remove the defines for bt and wifi efuse types.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/rtw_efuse.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_efuse.h b/drivers/staging/r8188eu/include/rtw_efuse.h
index fe421fff127a..825f880a71da 100644
--- a/drivers/staging/r8188eu/include/rtw_efuse.h
+++ b/drivers/staging/r8188eu/include/rtw_efuse.h
@@ -8,9 +8,6 @@
 
 #define	EFUSE_ERROE_HANDLE		1
 
-#define	EFUSE_WIFI				0
-#define	EFUSE_BT				1
-
 /* E-Fuse */
 #define EFUSE_MAP_SIZE      512
 #define EFUSE_MAX_SIZE      256
-- 
2.20.1

