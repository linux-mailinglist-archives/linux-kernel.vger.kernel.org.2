Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CE7356979
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351034AbhDGKYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:24:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350934AbhDGKYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:24:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54215613A3;
        Wed,  7 Apr 2021 10:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617791030;
        bh=kwOTzonON0vUO8fC36wDLosAQK2gYWwv/SbIstc5420=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Elq5D+Z6RZLKiwDDE7Q36VTn/MsxG0hbtbwZe7NcgW3uEaiP0WmBeYs5F2saFn8+O
         BgmDCtuMcFIHk8pCI4uxE4Q3rNstQk4FE56CwCHqhz+paT6OcHKihFv+qTbxy03bzd
         xU8POqIvojNm05q4zwpalNnjStDnZGK6Dx0zR1Iln1TRHrBWzNM5YcahFL8yJlXOdJ
         5TKy/8oOPbOX+mS6hztxKmGhKmVyzMOuP3dog+G6G5XnEe4WDHYL7Q+gLaCE4n0dRc
         JmmO5GPUyS/5XzhwYwlunsZp5H5RZAaEiL69RoO5HFmSeomwMOuBAUpv2/HFyRz9i/
         BHidNVZekacJw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU5La-0008R6-Rk; Wed, 07 Apr 2021 12:23:42 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-staging@lists.linux.dev,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 03/16] staging: fwserial: fix TIOCSSERIAL implementation
Date:   Wed,  7 Apr 2021 12:23:21 +0200
Message-Id: <20210407102334.32361-4-johan@kernel.org>
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

Fix the fwserial implementation which was returning -EPERM also for a
privileged user when trying to change certain unsupported parameters,
and instead return success consistently.

Fixes: 7355ba3445f2 ("staging: fwserial: Add TTY-over-Firewire serial driver")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/staging/fwserial/fwserial.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/fwserial/fwserial.c b/drivers/staging/fwserial/fwserial.c
index 440d11423812..2888b80a2c1a 100644
--- a/drivers/staging/fwserial/fwserial.c
+++ b/drivers/staging/fwserial/fwserial.c
@@ -1234,10 +1234,6 @@ static int set_serial_info(struct tty_struct *tty,
 	struct fwtty_port *port = tty->driver_data;
 	unsigned int cdelay;
 
-	if (ss->irq != 0 || ss->port != 0 || ss->custom_divisor != 0 ||
-	    ss->baud_base != 400000000)
-		return -EPERM;
-
 	cdelay = msecs_to_jiffies(ss->close_delay * 10);
 
 	mutex_lock(&port->port.mutex);
-- 
2.26.3

