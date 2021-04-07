Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE07356978
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351023AbhDGKYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:24:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235325AbhDGKYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:24:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57972613AF;
        Wed,  7 Apr 2021 10:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617791030;
        bh=q75t/Q1MGPC6xo3XgfSDrASakXyQ8MWDs3muYTJjvH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kiI+LqReC4zKxnROfhOs4yC5XgkniTOl7xrPh4ldeUufjSSc5O4w5onJTGR1FFMjr
         Q+Og0+/5Z7f4jPRTrA3Yelxw7PIeb8IAkeuRCJDvU9UexKcVU5yBmVpWwen42lgGzh
         EWbKiUbVYG7d+f+TxZYcwhQ2aB+opkg4EZwHj2BwvHd0IQae/d3rYB4wrTd8KMyBji
         ByFRWU85PnpD3grnB/HuGzlL+N/KeEFsDl+kAiJwXo75Fh3feRcBARGOc2zzY3Hqvw
         wuoWJMrnUtRjYRSScKohL8ZKmPdKKM+yEa64cEa2j3NpfrGPoppAQBixOjIJYdRuUV
         0wvQy5OPK4tVA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU5Lb-0008RH-4O; Wed, 07 Apr 2021 12:23:43 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-staging@lists.linux.dev,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 06/16] staging: greybus: uart: fix unprivileged TIOCCSERIAL
Date:   Wed,  7 Apr 2021 12:23:24 +0200
Message-Id: <20210407102334.32361-7-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210407102334.32361-1-johan@kernel.org>
References: <20210407102334.32361-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TIOCSSERIAL is a horrid, underspecified, legacy interface which for most
serial devices is only useful for setting the close_delay and
closing_wait parameters.

A non-privileged user has only ever been able to set the since long
deprecated ASYNC_SPD flags and trying to change any other *supported*
feature should result in -EPERM being returned. Setting the current
values for any supported features should return success.

Fix the greybus implementation which instead indicated that the
TIOCSSERIAL ioctl was not even implemented when a non-privileged user
set the current values.

Fixes: e68453ed28c5 ("greybus: uart-gb: now builds, more framework added")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/staging/greybus/uart.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
index 29846dc1e1bf..a520f7f213db 100644
--- a/drivers/staging/greybus/uart.c
+++ b/drivers/staging/greybus/uart.c
@@ -641,8 +641,6 @@ static int set_serial_info(struct tty_struct *tty,
 		if ((close_delay != gb_tty->port.close_delay) ||
 		    (closing_wait != gb_tty->port.closing_wait))
 			retval = -EPERM;
-		else
-			retval = -EOPNOTSUPP;
 	} else {
 		gb_tty->port.close_delay = close_delay;
 		gb_tty->port.closing_wait = closing_wait;
-- 
2.26.3

