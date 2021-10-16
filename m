Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8B24303FD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 19:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244457AbhJPRjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 13:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244460AbhJPRiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 13:38:22 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11E9C061767
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 10:36:09 -0700 (PDT)
Received: from ipservice-092-217-067-147.092.217.pools.vodafone-ip.de ([92.217.67.147] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mbnbJ-0006dq-5S; Sat, 16 Oct 2021 19:36:05 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/3] staging: r8188eu: Makefile: don't overwrite global settings
Date:   Sat, 16 Oct 2021 19:35:43 +0200
Message-Id: <20211016173544.25376-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211016173544.25376-1-martin@kaiser.cx>
References: <20211016173544.25376-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove settings from the Makefile that are set by higher-level Makefiles.

Some of those settings might have been useful when the driver was
maintained out of tree.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/Makefile | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/staging/r8188eu/Makefile b/drivers/staging/r8188eu/Makefile
index fccf7e6d1520..8294fb69ecf9 100644
--- a/drivers/staging/r8188eu/Makefile
+++ b/drivers/staging/r8188eu/Makefile
@@ -1,8 +1,3 @@
-SHELL := /bin/bash
-EXTRA_CFLAGS += $(USER_EXTRA_CFLAGS)
-EXTRA_CFLAGS += -O1
-
-ccflags-y += -D__CHECK_ENDIAN__
 
 OUTSRC_FILES :=				\
 		hal/HalHWImg8188E_MAC.o	\
@@ -46,15 +41,6 @@ _OS_INTFS_FILES :=				\
 
 _HAL_INTFS_FILES += $(OUTSRC_FILES)
 
-SUBARCH := $(shell uname -m | sed -e "s/i.86/i386/; s/ppc.*/powerpc/; s/armv.l/arm/; s/aarch64/arm64/;")
-
-ARCH ?= $(SUBARCH)
-CROSS_COMPILE ?=
-KVER  ?= $(if $(KERNELRELEASE),$(KERNELRELEASE),$(shell uname -r))
-KSRC ?= $(if $(KERNEL_SRC),$(KERNEL_SRC),/lib/modules/$(KVER)/build)
-MODDESTDIR := /lib/modules/$(KVER)/kernel/drivers/net/wireless
-INSTALL_PREFIX :=
-
 rtk_core :=				\
 		core/rtw_ap.o		\
 		core/rtw_br_ext.o	\
-- 
2.20.1

