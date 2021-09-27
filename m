Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0917741952D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 15:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbhI0Nhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 09:37:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234114AbhI0Nhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 09:37:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A48E61074;
        Mon, 27 Sep 2021 13:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632749759;
        bh=ZB2Nc/Pfq6/kzESBG6YcRMmGA0aDu1nei2eFuS0nZPM=;
        h=From:To:Cc:Subject:Date:From;
        b=j7CwiPMmWfa0/Ssw/VjQusHU3JgpqPWIdvcvtcJ1KUGpDWyhCmvjYa9SAuK7bUNEN
         XwGb9OFrCz5CHdGLoMbeXai+VHM7Jv3lfYWC80rRvWNT8lntAmYcwriZ4qS2m3I5/F
         LeqHKJvMmM57kYjbSJ4Dchke/N++WZF2r76aW/pRTSiUpTwj7JfwHft67Aj62JYrcq
         pKh6Zcz8IZalRbSmlkPzuCq3mrUb6GcvspLLnNi4gHdN6WrWD9kvZhavdkN9UKmlGF
         zftZsayr/e7M/ckN5YbcW9pvoWjoGFk+CD9x8GMVwxKxDw76h/QHhIBeTAo4YKGPFl
         NThnHXNIEhAtg==
Received: by pali.im (Postfix)
        id 6E3D0C83; Mon, 27 Sep 2021 15:35:57 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] tty: baudrate: Explicit usage of B0 for encoding input baudrate
Date:   Mon, 27 Sep 2021 15:35:16 +0200
Message-Id: <20210927133516.8671-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function tty_termios_input_baud_rate() checks IBSHIFT & CBAUD against B0
constant to determinate if input speed equals to output speed. So do same
B0 check also in tty_termios_encode_baud_rate() function to make these two
functions compatible.

Currently macro B0 is defined to 0 so there is no functional change.

This change just make code more explicit to show that Bnnn constants are
stored in CBAUD.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/tty/tty_baudrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_baudrate.c b/drivers/tty/tty_baudrate.c
index 426b1252781a..d903e111dbcb 100644
--- a/drivers/tty/tty_baudrate.c
+++ b/drivers/tty/tty_baudrate.c
@@ -154,7 +154,7 @@ void tty_termios_encode_baud_rate(struct ktermios *termios,
 	termios->c_ospeed = obaud;
 
 #ifdef IBSHIFT
-	if ((termios->c_cflag >> IBSHIFT) & CBAUD)
+	if (((termios->c_cflag >> IBSHIFT) & CBAUD) != B0)
 		ibinput = 1;	/* An input speed was specified */
 #endif
 #ifdef BOTHER
-- 
2.20.1

