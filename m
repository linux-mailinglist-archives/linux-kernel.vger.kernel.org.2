Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672D642AE1A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 22:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbhJLUqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 16:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbhJLUqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 16:46:20 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04611C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 13:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=sKGTat30RNCy2/FTRskvWCn5egJkoLenpbku9vap1/U=; b=YK8/Tw+cplklLXX9Rq2G0wY+87
        oCnHKEyqtemkSgkAY2l6CMlou7JN2iYohsDoaCzWLtycs2YWInmIokYOJcD5mVIofVKlaiKprezDI
        5PobrSqN58yc9KTpYidWIURe1KJ2fbMF5oIVAsGLqCC3ULtWcc2iUPYAHiwP+Eo5Jw6Kg+S2Oa3hO
        jvrf+Bc04nfa1bJa3dRIjjvu3wI9Jk9V7AXV7N8UbWGMDQ/DI8XkDJUF1Bky/rY+9nCtXAFUZ3/8m
        LXcYmtFPr+SXfGDQcnO77NCa8gJzrDbd+nX/qGPXTXl7SY4oQqCqdqDOZR4PbIgJ6WMaSHHGEXQrc
        WqsJI0+w==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maOdF-00Dx7u-CW; Tue, 12 Oct 2021 20:44:17 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Corey Minyard <minyard@acm.org>,
        openipmi-developer@lists.sourceforge.net,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH -next] ipmi: ipmb: fix dependencies to eliminate build error
Date:   Tue, 12 Oct 2021 13:44:16 -0700
Message-Id: <20211012204416.23108-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_I2C=m, CONFIG_I2C_SLAVE=y (bool), and CONFIG_IPMI_IPMB=y,
the build fails with:

ld: drivers/char/ipmi/ipmi_ipmb.o: in function `ipmi_ipmb_remove':
ipmi_ipmb.c:(.text+0x6b): undefined reference to `i2c_slave_unregister'
ld: drivers/char/ipmi/ipmi_ipmb.o: in function `ipmi_ipmb_thread':
ipmi_ipmb.c:(.text+0x2a4): undefined reference to `i2c_transfer'
ld: drivers/char/ipmi/ipmi_ipmb.o: in function `ipmi_ipmb_probe':
ipmi_ipmb.c:(.text+0x646): undefined reference to `i2c_slave_register'
ld: drivers/char/ipmi/ipmi_ipmb.o: in function `ipmi_ipmb_driver_init':
ipmi_ipmb.c:(.init.text+0xa): undefined reference to `i2c_register_driver'
ld: drivers/char/ipmi/ipmi_ipmb.o: in function `ipmi_ipmb_driver_exit':
ipmi_ipmb.c:(.exit.text+0x8): undefined reference to `i2c_del_driver'

This is due to having a tristate depending on a bool symbol.
By adding I2C (tristate) as a dependency, the desired dependencies
are met, causing IPMI_IPMB to be changed from =y to =m:

  -CONFIG_IPMI_IPMB=y
  +CONFIG_IPMI_IPMB=m

Fixes: 63c4eb347164 ("ipmi:ipmb: Add initial support for IPMI over IPMB")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Corey Minyard <minyard@acm.org>
Cc: openipmi-developer@lists.sourceforge.net
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/ipmi/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20211012.orig/drivers/char/ipmi/Kconfig
+++ linux-next-20211012/drivers/char/ipmi/Kconfig
@@ -77,7 +77,7 @@ config IPMI_SSIF
 
 config IPMI_IPMB
 	tristate 'IPMI IPMB interface'
-	depends on I2C_SLAVE
+	depends on I2C && I2C_SLAVE
 	help
 	  Provides a driver for a system running right on the IPMB bus.
 	  It supports normal system interface messages to a BMC on the IPMB
