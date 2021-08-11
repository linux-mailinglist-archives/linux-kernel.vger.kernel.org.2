Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A6F3E998E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 22:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhHKUP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 16:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbhHKUPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 16:15:53 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C47C06179B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 13:15:28 -0700 (PDT)
Received: from dslb-094-219-033-123.094.219.pools.vodafone-ip.de ([94.219.33.123] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mDudH-0004sF-TL; Wed, 11 Aug 2021 22:15:23 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 5/5] staging: r8188eu: remove CONFIG_USB_HCI from Makefile
Date:   Wed, 11 Aug 2021 22:14:50 +0200
Message-Id: <20210811201450.31366-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210811201450.31366-1-martin@kaiser.cx>
References: <20210811201450.31366-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already depend on USB. There's no need to set CONFIG_USB_HCI in the
Makefile.

Some other Realtek drivers use #ifdef CONFIG_USB_HCI in their code, the
r8188 driver doesn't.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/r8188eu/Makefile b/drivers/staging/r8188eu/Makefile
index cca7a58c5f29..6bd3a0590aa3 100644
--- a/drivers/staging/r8188eu/Makefile
+++ b/drivers/staging/r8188eu/Makefile
@@ -4,8 +4,6 @@ EXTRA_CFLAGS += -O1
 
 ccflags-y += -D__CHECK_ENDIAN__
 
-CONFIG_USB_HCI = y
-
 CONFIG_BT_COEXIST = n
 CONFIG_WOWLAN = n
 
-- 
2.20.1

