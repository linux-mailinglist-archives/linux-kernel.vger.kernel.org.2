Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E73942C380
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236574AbhJMOjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:39:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234057AbhJMOjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:39:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7362960C40;
        Wed, 13 Oct 2021 14:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634135834;
        bh=62764QpdtQPwnbA7EbX2a/yKmFZtb1uxpoIAqRloIr8=;
        h=From:To:Cc:Subject:Date:From;
        b=qOqh/1i78uqaymOnML9xwizvXUJxIXeaLgGqrwan2Dxe/J6B1Rs41u9sxkD76vAbB
         dR3AqcPO8huctVvn97cdBcRmfAH7LyNltiLyLia0zmnMHGzOWfgQbdaoaREODcO4qa
         rxY2FedUT+ioamWVDONgpA6YMccK4X8zWwCyJyxCnwEoaffV2fNl+g8MiZdH4u17pc
         vtdJnlxB4ylRwwsEXXHPETRkIIVhjjTtD8UzY6MM8e184k7iQn+6bTu7Yd0QjGl7Yi
         iXtlZflKavDt32aGoOCja8eA6zlT3MUrHGbn52HXvOW5JzR6otcgtpXY2eQ+2JogS2
         ZfLO6+KOthZAQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Corey Minyard <minyard@acm.org>,
        Andrew Manley <andrew.manley@sealingtech.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Zev Weiss <zweiss@equinix.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ipmi: ipmb: add CONFIG_I2C dependency
Date:   Wed, 13 Oct 2021 16:36:53 +0200
Message-Id: <20211013143710.2077272-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_I2C is a loadable module, the slave interface is not
available to built-in drivers:

x86_64-linux-ld: drivers/char/ipmi/ipmi_ipmb.o: in function `ipmi_ipmb_remove':
ipmi_ipmb.c:(.text+0x37): undefined reference to `i2c_slave_unregister'
x86_64-linux-ld: drivers/char/ipmi/ipmi_ipmb.o: in function `ipmi_ipmb_thread':
ipmi_ipmb.c:(.text+0x284): undefined reference to `i2c_transfer'

Add another dependency to the ipmb backend to avoid this.

Fixes: 63c4eb347164 ("ipmi:ipmb: Add initial support for IPMI over IPMB")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/char/ipmi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/Kconfig b/drivers/char/ipmi/Kconfig
index ace882ed3d55..b061e6b513ed 100644
--- a/drivers/char/ipmi/Kconfig
+++ b/drivers/char/ipmi/Kconfig
@@ -77,7 +77,7 @@ config IPMI_SSIF
 
 config IPMI_IPMB
 	tristate 'IPMI IPMB interface'
-	depends on I2C_SLAVE
+	depends on I2C && I2C_SLAVE
 	help
 	  Provides a driver for a system running right on the IPMB bus.
 	  It supports normal system interface messages to a BMC on the IPMB
-- 
2.29.2

