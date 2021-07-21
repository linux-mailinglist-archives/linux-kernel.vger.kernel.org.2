Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E2C3D1281
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 17:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239947AbhGUOzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 10:55:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233009AbhGUOzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 10:55:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C744161208;
        Wed, 21 Jul 2021 15:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626881753;
        bh=aBhwRnD9XtaSII/i65BOdQGdvKUZuaG2pZMtFEP2L+c=;
        h=From:To:Cc:Subject:Date:From;
        b=dVZ+KRlxoTD2dpe1fPZHbVzym9aevejR5wjrIfdgudun+KNN8b50nOY3dcKjyIOiZ
         qzF6J7EGO2LZ3W4qTssPHT0TgqMMvCgJI0RSjM8hSgoV21pFqSqnjwdCpMVhrPL/05
         UhzRgw8FjdSnNCp/+LNNRZbPqHYFZER7bcYfoOdKKBdfB7RvWRG+7ZZA7KLf8YeK5Z
         irWvxyIec89lHVo7BevloDphSC1IkHRzgKGJ6Cm2djv3JW5Ui8va0cuzUn5mvIwLKk
         bwOpBVCjq/0FknCsRRl7ds1h8OOuSaEiLVwdWEu8GV4OITCbNfocSqOYgFYF8q/5ob
         aody9MHUnRYQA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: select CONFIG_CRYPTO_LIB_ARC4
Date:   Wed, 21 Jul 2021 17:35:44 +0200
Message-Id: <20210721153550.3624490-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The other rtlwifi drivers already have this, but r8723bs
was converted to the generic implementation without adding
the select:

ERROR: modpost: "arc4_crypt" [drivers/staging/rtl8723bs/r8723bs.ko] undefined!
ERROR: modpost: "arc4_setkey" [drivers/staging/rtl8723bs/r8723bs.ko] undefined!

Fixes: 1b11e893eda0 ("staging: rtl8723bs: replace private arc4 encryption with in-kernel one")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/rtl8723bs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8723bs/Kconfig b/drivers/staging/rtl8723bs/Kconfig
index a88467334dac..7eae820eae3b 100644
--- a/drivers/staging/rtl8723bs/Kconfig
+++ b/drivers/staging/rtl8723bs/Kconfig
@@ -5,6 +5,7 @@ config RTL8723BS
 	depends on m
 	select WIRELESS_EXT
 	select WEXT_PRIV
+	select CRYPTO_LIB_ARC4
 	help
 	This option enables support for RTL8723BS SDIO drivers, such as
 	the wifi found on the 1st gen Intel Compute Stick, the CHIP
-- 
2.29.2

