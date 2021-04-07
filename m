Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB7D3569E7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351238AbhDGKkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:40:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234463AbhDGKj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:39:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A72E613A3;
        Wed,  7 Apr 2021 10:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617791990;
        bh=zecdlwn06S6EnBdUVHmnGszqZfSeUN4/Do04x9qNU+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CiIf4b+AgPcExylUWFTxmKsZyg1nnFIAGQmiU8iXM6NMBZZXF48pHaVDCf66N7khE
         TuVPaK5eoKMhSi1+GKCOPBaCdjgTBUh9SFC7YggDT1PMu2cgRfqYSjmBBkIdTjn/pX
         A4/kvfxQU8IJkWjxOGwuLZw01Evfau6LdrlHtyceAQmmPnBiOcDQG8ntOHT+KUFj8A
         uIBs16ykqGxoX8/JJAGmbBEtFbWtfRedgpgrLq5TjJV2jKMg90CEMFfql/4wtTn9Bn
         qWId9s0OPzfjLAydKQp6LkDcAE6l8Ohc4n00uUWj7ysWstRA/DHy/aBvfv5zqo7UXa
         yfpfzZKtE3fyA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU5b4-0000EZ-9j; Wed, 07 Apr 2021 12:39:42 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/24] USB: serial: ark3116: fix TIOCGSERIAL implementation
Date:   Wed,  7 Apr 2021 12:39:02 +0200
Message-Id: <20210407103925.829-2-johan@kernel.org>
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

Fixes: 2f430b4bbae7 ("USB: ark3116: Add TIOCGSERIAL and TIOCSSERIAL ioctl calls.")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ark3116.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/ark3116.c b/drivers/usb/serial/ark3116.c
index b9bedfe9bd09..957cdd694b1f 100644
--- a/drivers/usb/serial/ark3116.c
+++ b/drivers/usb/serial/ark3116.c
@@ -392,8 +392,9 @@ static int ark3116_get_serial_info(struct tty_struct *tty,
 
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

