Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639EB45F33A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 18:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbhKZR7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 12:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235018AbhKZR5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 12:57:53 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4325C07E5EB
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 09:32:24 -0800 (PST)
Received: from dslb-084-059-234-221.084.059.pools.vodafone-ip.de ([84.59.234.221] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mqf5B-00083N-J6; Fri, 26 Nov 2021 18:32:21 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 5/8] staging: r8188eu: if2 is not used
Date:   Fri, 26 Nov 2021 18:32:02 +0100
Message-Id: <20211126173205.21352-6-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211126173205.21352-1-martin@kaiser.cx>
References: <20211126173205.21352-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove if2 from struct dvobj_priv. It is not used.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/drv_types.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
index 3e4928320f17..c3d8ef134a4d 100644
--- a/drivers/staging/r8188eu/include/drv_types.h
+++ b/drivers/staging/r8188eu/include/drv_types.h
@@ -129,7 +129,6 @@ struct rt_firmware {
 
 struct dvobj_priv {
 	struct adapter *if1;
-	struct adapter *if2;
 
 	/* For 92D, DMDP have 2 interface. */
 	u8	InterfaceNumber;
-- 
2.20.1

