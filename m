Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD1043C791
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 12:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241406AbhJ0KY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 06:24:26 -0400
Received: from mail.bitwise.fi ([109.204.228.163]:42724 "EHLO mail.bitwise.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241366AbhJ0KYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 06:24:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.bitwise.fi (Postfix) with ESMTP id 75C02460029;
        Wed, 27 Oct 2021 13:21:57 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at 
Received: from mail.bitwise.fi ([127.0.0.1])
        by localhost (mustetatti.dmz.bitwise.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Zhm03kzXQedL; Wed, 27 Oct 2021 13:21:54 +0300 (EEST)
Received: from localhost.net (fw1.dmz.bitwise.fi [192.168.69.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: anssiha)
        by mail.bitwise.fi (Postfix) with ESMTPSA id 91093460026;
        Wed, 27 Oct 2021 13:21:54 +0300 (EEST)
From:   Anssi Hannula <anssi.hannula@bitwise.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH] tty: Fix extra "not" in TTY_DRIVER_REAL_RAW description
Date:   Wed, 27 Oct 2021 13:21:24 +0300
Message-Id: <20211027102124.3049414-1-anssi.hannula@bitwise.fi>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TTY_DRIVER_REAL_RAW flag (which is always set for e.g. serial ports)
documentation says that driver must always set special character
handling flags in certain conditions.

However, as the following sentence makes clear, what is actually
intended is the opposite.

Fix that by removing the unintended double negation.

Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
---

This one seems to have been there since 1994.

 include/linux/tty_driver.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index c20431d8def8..5bec04481c60 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -360,7 +360,7 @@ static inline void tty_set_operations(struct tty_driver *driver,
  * 	Used for PTY's, in particular.
  * 
  * TTY_DRIVER_REAL_RAW --- if set, indicates that the driver will
- * 	guarantee never not to set any special character handling
+ * 	guarantee never to set any special character handling
  * 	flags if ((IGNBRK || (!BRKINT && !PARMRK)) && (IGNPAR ||
  * 	!INPCK)).  That is, if there is no reason for the driver to
  * 	send notifications of parity and break characters up to the
-- 
2.31.1

