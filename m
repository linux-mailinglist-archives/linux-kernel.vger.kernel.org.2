Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F703BEC62
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 18:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhGGQkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 12:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhGGQkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 12:40:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F75C061574;
        Wed,  7 Jul 2021 09:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
        :Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=afkY8fwCdiinxqtpJexWC5QSojoHbl6E8/ynsI8qr+0=; b=jGgPW2qEz7oj4ztURfzsTH7ZXW
        UUkbmjXcTSOWX24r1uiYSFLinnI8pygrnAdBCC43Uod6ZCjY+NbQ9oue/HvrxzhTC4/UZRCjet6f+
        aliYhGProwyDtA4YCfbePZ4ZapgVirsW5RxoaG4a0lJcWU928znsaJHBTSyoSceNo9VgdaVVfM447
        iBt0v0tfP7Efwjb+2JV5vuo/E5pfNKxYu/YKcOvitgzxQB/PHkBM+S3bdebV9aekXA9ESOmp1VAOS
        Vcn5bn7LNVWiUxclA9nNLHHeMzO6jp2RMR9vX4AurdB1m/mDSXjV4Vay4YVhKMqAP0psSgpip/7z4
        O3UFPmqQ==;
Received: from [2601:1c0:6280:3f0::a22f] (helo=smtpauth.infradead.org)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m1AYH-00FPKf-Kh; Wed, 07 Jul 2021 16:37:34 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, uclinux-dev@uclinux.org
Subject: [PATCH] m68k/nommu: prevent setting ROMKERNEL when ROM is not set
Date:   Wed,  7 Jul 2021 09:37:29 -0700
Message-Id: <20210707163729.30388-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_ROMKERNEL is set but CONFIG_ROM is not set, the linker
complains:
  m68k-linux-ld:./arch/m68k/kernel/vmlinux.lds:5: undefined symbol `CONFIG_ROMSTART' referenced in expression

# CONFIG_ROM is not set
# CONFIG_RAMKERNEL is not set
CONFIG_ROMKERNEL=y

Since ROMSTART depends on ROM, make ROMKERNEL also depend on ROM.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Greg Ungerer <gerg@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
Cc: uclinux-dev@uclinux.org
---
 arch/m68k/Kconfig.machine |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20210701.orig/arch/m68k/Kconfig.machine
+++ linux-next-20210701/arch/m68k/Kconfig.machine
@@ -464,6 +464,7 @@ config RAMKERNEL
 
 config ROMKERNEL
 	bool "ROM"
+	depends on ROM
 	help
 	  The kernel will be resident in FLASH/ROM when running. This is
 	  often referred to as Execute-in-Place (XIP), since the kernel
