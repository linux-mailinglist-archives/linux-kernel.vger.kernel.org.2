Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F62B4303E9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 19:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244417AbhJPR01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 13:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244409AbhJPR00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 13:26:26 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F39C061570
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 10:24:18 -0700 (PDT)
Received: from ipservice-092-217-067-147.092.217.pools.vodafone-ip.de ([92.217.67.147] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mbnPq-0006XE-MB; Sat, 16 Oct 2021 19:24:14 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/2] staging: r8188eu: remove BT_COEXIST settings from Makefile
Date:   Sat, 16 Oct 2021 19:23:45 +0200
Message-Id: <20211016172345.23114-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211016172345.23114-1-martin@kaiser.cx>
References: <20211016172345.23114-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_BT_COEXIST is disabled and not used outside of the Makefile.
Remove the settings in the Makefile as well.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/Makefile | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/r8188eu/Makefile b/drivers/staging/r8188eu/Makefile
index d63fad20e9d2..1e0cb819f7f3 100644
--- a/drivers/staging/r8188eu/Makefile
+++ b/drivers/staging/r8188eu/Makefile
@@ -4,7 +4,6 @@ EXTRA_CFLAGS += -O1
 
 ccflags-y += -D__CHECK_ENDIAN__
 
-CONFIG_BT_COEXIST = n
 CONFIG_WOWLAN = n
 
 OUTSRC_FILES :=				\
@@ -53,10 +52,6 @@ _OS_INTFS_FILES :=				\
 
 _HAL_INTFS_FILES += $(OUTSRC_FILES)
 
-ifeq ($(CONFIG_BT_COEXIST), y)
-EXTRA_CFLAGS += -DCONFIG_BT_COEXIST
-endif
-
 ifeq ($(CONFIG_WOWLAN), y)
 EXTRA_CFLAGS += -DCONFIG_WOWLAN
 endif
-- 
2.20.1

