Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907B53583C3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 14:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhDHMwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 08:52:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231663AbhDHMwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:52:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12B4061105;
        Thu,  8 Apr 2021 12:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617886314;
        bh=LWEDlEpdaZy9mCPZhhIeAQ31AcOyG0vkFIx/iWaz4+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NeEbr/bN02e7D53o+bTTPaqixHNzN7fGserU9KwsvIbrSzs+Z7QXugmVpUK/RuFxb
         5/vsb7q4fehChRATBfQo8gHJWgwe8YuZWXxdZFIncJKAm0DAoYnjdLQCDDF4e9WprV
         +Zrqo6fcDTdg4X0qYNp+9/ERXc68sKxma9t+4iaY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 12/13] tty: remove tty_driver_name()
Date:   Thu,  8 Apr 2021 14:51:33 +0200
Message-Id: <20210408125134.3016837-13-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210408125134.3016837-1-gregkh@linuxfoundation.org>
References: <20210408125134.3016837-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one uses it, so remove it, it is dead code.

Cc: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/tty_io.c | 7 -------
 include/linux/tty.h  | 1 -
 2 files changed, 8 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index aa959f3371b1..5089104cafda 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -251,13 +251,6 @@ const char *tty_name(const struct tty_struct *tty)
 
 EXPORT_SYMBOL(tty_name);
 
-const char *tty_driver_name(const struct tty_struct *tty)
-{
-	if (!tty || !tty->driver)
-		return "";
-	return tty->driver->name;
-}
-
 static int tty_paranoia_check(struct tty_struct *tty, struct inode *inode,
 			      const char *routine)
 {
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 777887d8bd6d..143f393dca3b 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -430,7 +430,6 @@ static inline struct tty_struct *tty_kref_get(struct tty_struct *tty)
 	return tty;
 }
 
-extern const char *tty_driver_name(const struct tty_struct *tty);
 extern void tty_wait_until_sent(struct tty_struct *tty, long timeout);
 extern int __tty_check_change(struct tty_struct *tty, int sig);
 extern int tty_check_change(struct tty_struct *tty);
-- 
2.31.1

