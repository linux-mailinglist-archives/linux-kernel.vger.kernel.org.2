Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A3F413430
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 15:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbhIUNdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 09:33:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233238AbhIUNcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 09:32:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E785561183;
        Tue, 21 Sep 2021 13:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632231085;
        bh=/FskAHTta8BR+nJOSZGpKWzqRfix/jvxVCeWQyU5duk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ag4OBn2icYdE4foTpjoIfZNzfxZUnjgW5hj2wcsN3WiXN1VoWB99W6rW+8T4r9ujZ
         BGolsSHWxoDht1EpCRtmPH3iWI6eIGdi/w2cpOOxFP0oSoJgUdNexuIhVCJT61p45y
         gJLbV+3elgiCDr7CJ5pSLHyMlj5y5hQcJExldapGdUiTVY46M/qWyktKbOKTz1H3fc
         6bM1ieBi2B92lZ9MjpgK+fhR6NWQBkbFVjNVzzUW07ddYMtB9m0TCSugoiaYOdPoyP
         txGEVtRvj2NYBTqct4d1mEQ6QvjjWuixp0KeWDf0FiTX1jPHCmZNuVNa4qA4YsKB9A
         9o5lKfiDoxDpw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mSfrp-0003bR-FS; Tue, 21 Sep 2021 15:31:25 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Himadri Pandya <himadrispandya@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] USB: serial: kl5kusb105: drop line-status helper
Date:   Tue, 21 Sep 2021 15:30:09 +0200
Message-Id: <20210921133009.13739-4-johan@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210921133009.13739-1-johan@kernel.org>
References: <20210921133009.13739-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the line-status conversion helper and do the conversion in place
instead.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/kl5kusb105.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/serial/kl5kusb105.c b/drivers/usb/serial/kl5kusb105.c
index 99dffbdd3142..edcc57bd9b5e 100644
--- a/drivers/usb/serial/kl5kusb105.c
+++ b/drivers/usb/serial/kl5kusb105.c
@@ -147,24 +147,12 @@ static int klsi_105_chg_port_settings(struct usb_serial_port *port,
 	return rc;
 }
 
-/* translate a 16-bit status value from the device to linux's TIO bits */
-static unsigned long klsi_105_status2linestate(const __u16 status)
-{
-	unsigned long res = 0;
-
-	res =   ((status & KL5KUSB105A_DSR) ? TIOCM_DSR : 0)
-	      | ((status & KL5KUSB105A_CTS) ? TIOCM_CTS : 0)
-	      ;
-
-	return res;
-}
-
 /*
  * Read line control via vendor command and return result through
- * *line_state_p
+ * the state pointer.
  */
 static int klsi_105_get_line_state(struct usb_serial_port *port,
-				   unsigned long *line_state_p)
+				   unsigned long *state)
 {
 	u16 status;
 	int rc;
@@ -186,7 +174,8 @@ static int klsi_105_get_line_state(struct usb_serial_port *port,
 
 	dev_dbg(&port->dev, "read status %04x\n", status);
 
-	*line_state_p = klsi_105_status2linestate(status);
+	*state = ((status & KL5KUSB105A_DSR) ? TIOCM_DSR : 0) |
+		 ((status & KL5KUSB105A_CTS) ? TIOCM_CTS : 0);
 
 	return 0;
 }
-- 
2.32.0

