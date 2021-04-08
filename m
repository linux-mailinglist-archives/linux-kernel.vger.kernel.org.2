Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192CA3583D2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 14:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbhDHMwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 08:52:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:58086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231765AbhDHMwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:52:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C210661132;
        Thu,  8 Apr 2021 12:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617886330;
        bh=wSsBnErrWO8bVObp1Lb3zJckkJyv5qB/sBmENejT1lo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KAym3wVwDKTAM+oYPYWl0rfrusLwmLRl8u72+gmy5Qg4yMNugrdJa47d8+YCLlNMN
         t+mk0Pd43WozG8OSfjksgvz1NuLWJhsLCIacOrB/GxjtaiIgc6Ict2Cuw2FHb/Whjz
         VqGslehsRwXebXx0TLOsX+A6QiFQmKyIKrrvn9/c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 06/13] tty: remove tty_info_ratelimited()
Date:   Thu,  8 Apr 2021 14:51:27 +0200
Message-Id: <20210408125134.3016837-7-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210408125134.3016837-1-gregkh@linuxfoundation.org>
References: <20210408125134.3016837-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the one user of tty_info_ratelimited() and replace it with a
calls to dev_info_ratelimited() which provides more information about
the tty that has the error and uses the standard formatting logic.

Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/tty.h    | 3 ---
 drivers/tty/tty_io.c | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/tty.h b/drivers/tty/tty.h
index 45b15cc250e8..a2084b58d4f3 100644
--- a/drivers/tty/tty.h
+++ b/drivers/tty/tty.h
@@ -11,7 +11,4 @@
 
 #define tty_debug(tty, f, ...)	tty_msg(pr_debug, tty, f, ##__VA_ARGS__)
 
-#define tty_info_ratelimited(tty, f, ...) \
-		tty_msg(pr_info_ratelimited, tty, f, ##__VA_ARGS__)
-
 #endif
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 2c3efa854ba5..91062fcc6667 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1477,7 +1477,7 @@ struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx)
 	/* call the tty release_tty routine to clean out this slot */
 err_release_tty:
 	tty_ldisc_unlock(tty);
-	tty_info_ratelimited(tty, "ldisc open failed (%d), clearing slot %d\n",
+	dev_info_ratelimited(tty->dev, "ldisc open failed (%d), clearing slot %d\n",
 			     retval, idx);
 err_release_lock:
 	tty_unlock(tty);
-- 
2.31.1

