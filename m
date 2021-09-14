Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9264A40AA4F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 11:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhINJMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 05:12:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43296 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhINJMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 05:12:53 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 40B1B1FDD3;
        Tue, 14 Sep 2021 09:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631610695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=TqZ09VJe+QSg5tvEq+VkQHIZakC2U6+P8iDY466ODMQ=;
        b=w6rDB04qr9omE5UtpF+ENmhJGNdZaysMzGzSl9rIvAzMUmrEgTYpvyAxNZHzS2o4kBHnGj
        5lxdKqMvDU3OemBKdcfOQ3pvxcLzjWwIoAcJeTZyl3ZkQxcQnntElQiEImkEgKcyGy4M66
        kPOHZ+UDWKep3vekQpNlwjeiP+jtGBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631610695;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=TqZ09VJe+QSg5tvEq+VkQHIZakC2U6+P8iDY466ODMQ=;
        b=ROUcSZ1ooYa047BKtuJ2EczX49Iuq3VJvXkGKSU78l5K2n8/Yd+VRPuDxLIt3XHFa0WXl0
        T0khzOHxosd5BdCA==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 233A5A3B98;
        Tue, 14 Sep 2021 09:11:35 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 01/16] tty: unexport tty_ldisc_release
Date:   Tue, 14 Sep 2021 11:11:19 +0200
Message-Id: <20210914091134.17426-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initially, tty_ldisc_release() was exported for speakup (spk_tty) while
in staging. Later, the call to this function was removed as it was bogus
anyway.

Remove the export now.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/tty_ldisc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 756a4bfa6a69..3e4e0b20b4bb 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -812,7 +812,6 @@ void tty_ldisc_release(struct tty_struct *tty)
 
 	tty_ldisc_debug(tty, "released\n");
 }
-EXPORT_SYMBOL_GPL(tty_ldisc_release);
 
 /**
  *	tty_ldisc_init		-	ldisc setup for new tty
-- 
2.33.0

