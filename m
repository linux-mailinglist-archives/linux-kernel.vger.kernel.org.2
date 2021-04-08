Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F27935846B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbhDHNQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:16:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:36544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229751AbhDHNQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:16:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE33D61151;
        Thu,  8 Apr 2021 13:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617887776;
        bh=lsyrtIigVOizPgWs0iXL/uoRm3JMsiE4v9eha+Vtaso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sIEUOX6tYD1uHeDGUt5yR1yqDaPUfMgG2QasCOv6bqRctObhLFub0pbPmrhRSHiZc
         tB+IeRhuRY6SE0k5TtOfDIFPOudIkUG8pJ3QmQsrfMMpNJ+Nbi7DRQqctZ9JVXagfO
         5CA3OBk4jVawnz8vZEvpMN1WD/+zBg96BQaD16TXjPJ2kzme6ZD4JBctoI+i1MDRH0
         Y3OH3GgV1lwWeUcw3/eqKmQNVokv1Y0NpqWqNVbr3myELCebVmxqkr58azI4NS/rPo
         IJJCq8zC/u6C5FP8WfCjUKalmQV8tQysVqMApYzXATsrd1mKnpC0FyOPTVic/tIqYu
         R0wJnI3ETE4yw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lUUW4-0007Hk-Ht; Thu, 08 Apr 2021 15:16:12 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 2/3] USB: cdc-acm: fix unprivileged TIOCCSERIAL
Date:   Thu,  8 Apr 2021 15:16:01 +0200
Message-Id: <20210408131602.27956-3-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210408131602.27956-1-johan@kernel.org>
References: <20210408131602.27956-1-johan@kernel.org>
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

Fix the cdc-acm implementation which instead indicated that the
TIOCSSERIAL ioctl was not even implemented when a non-privileged user
set the current values.

Fixes: ba2d8ce9db0a ("cdc-acm: implement TIOCSSERIAL to avoid blocking close(2)")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/class/cdc-acm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 96e221803fa6..43e31dad4831 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -955,8 +955,6 @@ static int set_serial_info(struct tty_struct *tty, struct serial_struct *ss)
 		if ((close_delay != acm->port.close_delay) ||
 		    (closing_wait != acm->port.closing_wait))
 			retval = -EPERM;
-		else
-			retval = -EOPNOTSUPP;
 	} else {
 		acm->port.close_delay  = close_delay;
 		acm->port.closing_wait = closing_wait;
-- 
2.26.3

