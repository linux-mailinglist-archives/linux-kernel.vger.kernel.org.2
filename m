Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CBA388A7C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345227AbhESJWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:22:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344889AbhESJVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:21:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D56A611AE;
        Wed, 19 May 2021 09:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621416029;
        bh=YhJbvkmwFzzsKfnc6qJ0TLdbhKOJRSXI6iLzQvK4J0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s7nUutTTvfMMpOmIEU5FExVB8NKW2Rce/nOr3EE9EFnkcuKHduCtCbTtg0+0TLG1A
         B3VPOHTmdQQHXGsupYjmXI1zvYmlSIi8u1BtYnj8jR7Ziexe3ao8UZr2XtKmD6IF5X
         bO3ub73jtwNSGbddYeWcD8cJv+Q9Yef6Db6DDVnuL3sCJKsR5XNZfY7Zi151sNJs9L
         MuL24iHKEUU+KQ1MtIYbGn4quSDiuaGToe0b1No9sznwPFHOCaIW1utS5ij2YzWlYO
         gaBJjXqdtpWvVj3PPQPdin41kPprLUN99uW1nlPL2i7W9JaCpHPY/1JKhO/nCERfDP
         C2PBI5fwSTXdA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ljINQ-0002YY-I1; Wed, 19 May 2021 11:20:28 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] USB: serial: digi_acceleport: reduce chars_in_buffer over-reporting
Date:   Wed, 19 May 2021 11:20:01 +0200
Message-Id: <20210519092006.9775-2-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210519092006.9775-1-johan@kernel.org>
References: <20210519092006.9775-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to an ancient quirk in n_tty poll implementation, the
digi_acceleport driver has been reporting that its queue contains 256
(WAKEUP_CHARS) characters whenever its write URB is in use.

This has not been necessary since 2003 when the line-discipline started
taking the write room into account so let's return the maximum transfer
size again in order to over-report a little less and incidentally fix
the related debug statement.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/digi_acceleport.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
index 19ee8191647c..a4194b70a6fe 100644
--- a/drivers/usb/serial/digi_acceleport.c
+++ b/drivers/usb/serial/digi_acceleport.c
@@ -1048,8 +1048,7 @@ static unsigned int digi_chars_in_buffer(struct tty_struct *tty)
 	if (priv->dp_write_urb_in_use) {
 		dev_dbg(&port->dev, "digi_chars_in_buffer: port=%d, chars=%d\n",
 			priv->dp_port_num, port->bulk_out_size - 2);
-		/* return(port->bulk_out_size - 2); */
-		return 256;
+		return port->bulk_out_size - 2;
 	} else {
 		dev_dbg(&port->dev, "digi_chars_in_buffer: port=%d, chars=%d\n",
 			priv->dp_port_num, priv->dp_out_buf_len);
-- 
2.26.3

