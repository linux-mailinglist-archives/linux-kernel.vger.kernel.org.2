Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5543583C2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 14:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhDHMwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 08:52:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231660AbhDHMwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:52:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0046B610FC;
        Thu,  8 Apr 2021 12:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617886309;
        bh=rtBlR6XrPouRnhoxI3iExA2iH4/6aKZINYgAtq3QArc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z8xJgMKlhmcljO0A5qV8//93huqQQVbuHF4zASiQAhMPojZFnxkBKkO+A9qtGy3qO
         +Vdn4WfyTQbG1zsVmPkmSkuAvEGdSjRWNBTLvwGNY5GKLK0fQ7KOfhcazOtXmC9SWH
         niRXBlHk0RtjwELpxI9K3eIszC6UWVo/ndnPoA1s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 10/13] tty: make tty_release_redirect() static
Date:   Thu,  8 Apr 2021 14:51:31 +0200
Message-Id: <20210408125134.3016837-11-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210408125134.3016837-1-gregkh@linuxfoundation.org>
References: <20210408125134.3016837-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one calls this outside of the tty_io.c file, so mark this static and
do not export the symbol anymore.

Cc: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/tty_io.c | 3 +--
 include/linux/tty.h  | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 1c480c04374c..aa959f3371b1 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -547,7 +547,7 @@ EXPORT_SYMBOL_GPL(tty_wakeup);
  *	This is available to the pty code so if the master closes, if the
  *	slave is a redirect it can release the redirect.
  */
-struct file *tty_release_redirect(struct tty_struct *tty)
+static struct file *tty_release_redirect(struct tty_struct *tty)
 {
 	struct file *f = NULL;
 
@@ -560,7 +560,6 @@ struct file *tty_release_redirect(struct tty_struct *tty)
 
 	return f;
 }
-EXPORT_SYMBOL_GPL(tty_release_redirect);
 
 /**
  *	__tty_hangup		-	actual handler for hangup events
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 4b21d47bc098..1b6f5dc3dcb2 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -396,7 +396,6 @@ extern struct tty_struct *tty_kopen_shared(dev_t device);
 extern void tty_kclose(struct tty_struct *tty);
 extern int tty_dev_name_to_number(const char *name, dev_t *number);
 extern ssize_t redirected_tty_write(struct kiocb *, struct iov_iter *);
-extern struct file *tty_release_redirect(struct tty_struct *tty);
 #else
 static inline void tty_kref_put(struct tty_struct *tty)
 { }
-- 
2.31.1

