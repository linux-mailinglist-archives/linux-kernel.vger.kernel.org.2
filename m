Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE31D344BFD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 17:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhCVQnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 12:43:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229951AbhCVQms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:42:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 389D061983;
        Mon, 22 Mar 2021 16:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616431368;
        bh=TAwK76ed5+zfDnDIcXVNPvbZotdftNE4vCI3pyJDoS8=;
        h=From:To:Cc:Subject:Date:From;
        b=ssrTvbEgWytbBrTzbt6A4aIg+PCmcgJBhxTBa/MNRtv30J5nzUJp0ulR+o65RyJhB
         ewjSbzISz4ag8EwNFbqWMBKGmAAtxf0TpKpvwZ602A/wN9njfX2m3wAHPxUugfjw/0
         j8mPe8MRFDiCJ1yiQaCY2lUIOs3FEycUndBjE2QHCOugVUBXfI7pc64ki+aGanf/JI
         rqwoJ9Gw541SHQdetJqMsRrEJvE/j5MRJvldJaRtmCUCvY2xKft6b2JZDkioGweHky
         FW19vDGXxGR8hzq0XNXwWAHPb1VVutv6bCAjMsrn0bXqZLGfZ6BuH8+ZTGUElcsFyc
         T16omCDo7u0kg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: sl811-hcd: improve misleading indentation
Date:   Mon, 22 Mar 2021 17:42:26 +0100
Message-Id: <20210322164244.827589-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc-11 now warns about a confusingly indented code block:

drivers/usb/host/sl811-hcd.c: In function ‘sl811h_hub_control’:
drivers/usb/host/sl811-hcd.c:1291:9: error: this ‘if’ clause does not guard... [-Werror=misleading-indentation]
 1291 |         if (*(u16*)(buf+2))     /* only if wPortChange is interesting */
      |         ^~
drivers/usb/host/sl811-hcd.c:1295:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the ‘if’
 1295 |                 break;

Rewrite this to use a single if() block with the __is_defined() macro.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/host/sl811-hcd.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/sl811-hcd.c b/drivers/usb/host/sl811-hcd.c
index 115ced0d93e1..1be692d3cf90 100644
--- a/drivers/usb/host/sl811-hcd.c
+++ b/drivers/usb/host/sl811-hcd.c
@@ -1287,11 +1287,10 @@ sl811h_hub_control(
 			goto error;
 		put_unaligned_le32(sl811->port1, buf);
 
-#ifndef	VERBOSE
-	if (*(u16*)(buf+2))	/* only if wPortChange is interesting */
-#endif
-		dev_dbg(hcd->self.controller, "GetPortStatus %08x\n",
-			sl811->port1);
+		if (__is_defined(VERBOSE) ||
+		    *(u16*)(buf+2)) /* only if wPortChange is interesting */
+			dev_dbg(hcd->self.controller, "GetPortStatus %08x\n",
+				sl811->port1);
 		break;
 	case SetPortFeature:
 		if (wIndex != 1 || wLength != 0)
-- 
2.29.2

