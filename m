Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4B43569F5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351283AbhDGKk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:40:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234963AbhDGKkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:40:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 434C6613CD;
        Wed,  7 Apr 2021 10:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617791990;
        bh=hu1SUyANoCuT1Q13sYyBfBeEv1ilJfqrVkL1hySgzds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cZQtfXD4kQGfJhgRishsh9vCk27Htx0VcaykWOTYh5wxpZtEyDhxHn3lzK4GzZ+kO
         BCiVXCbYzO/BGntozEt0iym3pyamy8vXIBxRzcePzgqwDV0QwjXCXIFq4URyeKhtoD
         C00wOnyQ3UWizDUIpazmnILrCeF3IeFNwhzYwoHxIUt6Sdvnfok+hG0lLjvgZwXuPi
         q8xqbhB4Q03C4x8VML9UCHsriafsRZBHBz5IzTiYGRuUM8w6lLGzU4cSwu0zb1IoNS
         skLaNmYEKfNyl5LCkaPAyuVtmErRfrSUlcrufOkv1229FVtOK3ahVlT+jm+/S0BW7d
         2oNhHKN/lu4uw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU5b5-0000F0-3U; Wed, 07 Apr 2021 12:39:43 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/24] USB: serial: pl2303: fix TIOCGSERIAL implementation
Date:   Wed,  7 Apr 2021 12:39:11 +0200
Message-Id: <20210407103925.829-11-johan@kernel.org>
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

The baud_base parameter could be used to set the UART base clock when it
could not be detected but might as well be left unset when it is not
known.

The close_delay and closing_wait parameters returned by TIOCGSERIAL are
specified in centiseconds. The driver does not yet support changing
these, but let's report back the default values actually used (0.5 and
30 seconds, respectively).

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/pl2303.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index eed9acd1ae08..0455add8593a 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -946,8 +946,9 @@ static int pl2303_get_serial(struct tty_struct *tty,
 
 	ss->type = PORT_16654;
 	ss->line = port->minor;
-	ss->port = port->port_number;
-	ss->baud_base = 460800;
+	ss->close_delay = 50;
+	ss->closing_wait = 3000;
+
 	return 0;
 }
 
-- 
2.26.3

