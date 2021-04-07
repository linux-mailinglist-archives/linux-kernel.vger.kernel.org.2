Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754833569AC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244467AbhDGK3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:29:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233353AbhDGK3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:29:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43B286139C;
        Wed,  7 Apr 2021 10:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617791342;
        bh=lsyrtIigVOizPgWs0iXL/uoRm3JMsiE4v9eha+Vtaso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c9m2PHu6WalK4rMS2yp8AZ0JdEjYqoyCcw87aPccXMHJZ89/ImPmi8mOJ1Cknpfnr
         StJl6H/fY/L9Xcx/EapU975Nft/IAlViVRawL7s1o0B986DHOlJhcZtBVtcLJj2shq
         VBefZSF3fiMKQ3gbSeoRaJBgFf+29odJ6jfgjM9dtnrJLhvXHmn+HkgVCRMr0EiWhW
         ryhpTZYwf14nQTTQEzxBcG2+Da+cTOVa3A4qJSXQkpB9K82NZJXJ+sVwwYSsd/3WQK
         rY9zzwmI0TJStPt1QvgXdHZLZybRjmrqHJ9d0XabS+T+rkQxpTwGclCFibZFlpGldL
         EZe+nn0mOzoxA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU5Qc-00004u-Pe; Wed, 07 Apr 2021 12:28:54 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/3] USB: cdc-acm: fix unprivileged TIOCCSERIAL
Date:   Wed,  7 Apr 2021 12:28:44 +0200
Message-Id: <20210407102845.32720-3-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210407102845.32720-1-johan@kernel.org>
References: <20210407102845.32720-1-johan@kernel.org>
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

