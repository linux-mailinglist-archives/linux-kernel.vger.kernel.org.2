Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0E73569F9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351287AbhDGKkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:40:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234911AbhDGKkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:40:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 173A5613B3;
        Wed,  7 Apr 2021 10:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617791990;
        bh=TbudOCCDwTXxK2l251NN3FOx6Ha1jj6poWzJiRM5aXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TY/cnwfmxRHbcNaxnNM0SlyEHRSO6QvfiAcb59d9HDhoYfSbr9m6DgNUduJpJ3RTC
         ZyHSKlPfVEO6DD8DljM09idLVO2azzN76IoFgjvEWhbOu80umeWafOss983hNwlNr7
         j7hBHLuY+NAurpDw9UactflhrKz1qd0VmJnJdHVf92RAiPTzKkUsfyd7Ml3eq1ctFw
         1xN2y/M1D0nBClR6y5c9hGOYvxzOj5VZxKuuOFggZZCbSPe/p5pGtx3nBYlnuADGsT
         IbkScjgEmZJqd9P10cCr9jejrgp+HsM3mjhvIc0srz2cDX7Q9a8qvwRMlaLXGQX4OJ
         +iJyq/T5msZlA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU5b4-0000Ef-Fq; Wed, 07 Apr 2021 12:39:42 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/24] USB: serial: f81534: fix TIOCGSERIAL implementation
Date:   Wed,  7 Apr 2021 12:39:04 +0200
Message-Id: <20210407103925.829-4-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210407103925.829-1-johan@kernel.org>
References: <20210407103925.829-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TIOCSSERIAL is a horrid, underspecified, legacy interface which for most
serial devices is only useful for setting the close_delay and
closing_wait parameters.

The port parameter is used to set the I/O port and does not make any
sense to use for USB serial devices.

The close_delay and closing_wait parameters returned by TIOCGSERIAL are
specified in centiseconds. The driver does not yet support changing
these, but let's report back the default values actually used (0.5 and
30 seconds, respectively).

Fixes: aac1fc386fa1 ("USB: serial: add Fintek F81232 usb to serial driver")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/f81534.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/f81534.c b/drivers/usb/serial/f81534.c
index a763b362f081..c9f90d437e3a 100644
--- a/drivers/usb/serial/f81534.c
+++ b/drivers/usb/serial/f81534.c
@@ -1149,9 +1149,11 @@ static int f81534_get_serial_info(struct tty_struct *tty,
 	port_priv = usb_get_serial_port_data(port);
 
 	ss->type = PORT_16550A;
-	ss->port = port->port_number;
 	ss->line = port->minor;
 	ss->baud_base = port_priv->baud_base;
+	ss->close_delay = 50;
+	ss->closing_wait = 3000;
+
 	return 0;
 }
 
-- 
2.26.3

