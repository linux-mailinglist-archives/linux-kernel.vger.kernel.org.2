Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A8938C2F8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 11:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236298AbhEUJXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 05:23:38 -0400
Received: from smtp.h3c.com ([60.191.123.50]:19527 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236200AbhEUJXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 05:23:32 -0400
X-Greylist: delayed 4098 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 May 2021 05:23:31 EDT
Received: from h3cspam02-ex.h3c.com (localhost [127.0.0.2] (may be forged))
        by h3cspam02-ex.h3c.com with ESMTP id 14L8Dl6V037338
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 16:13:47 +0800 (GMT-8)
        (envelope-from gao.yanB@h3c.com)
Received: from DAG2EX08-IDC.srv.huawei-3com.com ([10.8.0.71])
        by h3cspam02-ex.h3c.com with ESMTP id 14L8D35d035940;
        Fri, 21 May 2021 16:13:03 +0800 (GMT-8)
        (envelope-from gao.yanB@h3c.com)
Received: from localhost.localdomain (10.99.222.162) by
 DAG2EX08-IDC.srv.huawei-3com.com (10.8.0.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 21 May 2021 16:13:05 +0800
From:   Gao Yan <gao.yanB@h3c.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <paulus@samba.org>, <davem@davemloft.net>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Gao Yan <gao.yanB@h3c.com>
Subject: [PATCH] net: remove unnecessary disc_data_lock in ppp line discipline
Date:   Fri, 21 May 2021 15:57:26 +0800
Message-ID: <20210521075726.20568-1-gao.yanB@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.222.162]
X-ClientProxiedBy: BJSMTP02-EX.srv.huawei-3com.com (10.63.20.133) To
 DAG2EX08-IDC.srv.huawei-3com.com (10.8.0.71)
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 14L8Dl6V037338
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In tty layer, it use tty->ldisc_sem(using tty_ldisc_ref_wait and
tty_ldisc_deref) to proect tty_ldisc_ops.

So I think tty->ldisc_sem can also protect tty->disc_data;
For examlpe, When cpu A is running ppp_synctty_ioctl that hold
the tty->ldisc_sem, at the same time  if cpu B calls ppp_synctty_close,
it will wait until cpu A release tty->ldisc_sem.

So I think it is unnecessary to define additional disc_data_lock;

cpu A                           cpu B
tty_ioctl                       tty_reopen
 ->hold tty->ldisc_sem            ->hold tty->ldisc_sem(write), failed
 ->ld->ops->ioctl                 ->wait...
 ->release tty->ldisc_sem         ->wait...OK,hold tty->ldisc_sem
                                    ->tty_ldisc_reinit
                                      ->tty_ldisc_close
                                        ->ld->ops->close

Signed-off-by: Gao Yan <gao.yanB@h3c.com>
---
 drivers/net/ppp/ppp_async.c   | 11 ++---------
 drivers/net/ppp/ppp_synctty.c | 11 ++---------
 2 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index 8b41aa3fb..7bc4846f5 100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -127,17 +127,13 @@ static const struct ppp_channel_ops async_ops = {
  * FIXME: this is no longer true. The _close path for the ldisc is
  * now guaranteed to be sane.
  */
-static DEFINE_RWLOCK(disc_data_lock);
 
 static struct asyncppp *ap_get(struct tty_struct *tty)
 {
-	struct asyncppp *ap;
+	struct asyncppp *ap = tty->disc_data;
 
-	read_lock(&disc_data_lock);
-	ap = tty->disc_data;
 	if (ap != NULL)
 		refcount_inc(&ap->refcnt);
-	read_unlock(&disc_data_lock);
 	return ap;
 }
 
@@ -214,12 +210,9 @@ ppp_asynctty_open(struct tty_struct *tty)
 static void
 ppp_asynctty_close(struct tty_struct *tty)
 {
-	struct asyncppp *ap;
+	struct asyncppp *ap = tty->disc_data;
 
-	write_lock_irq(&disc_data_lock);
-	ap = tty->disc_data;
 	tty->disc_data = NULL;
-	write_unlock_irq(&disc_data_lock);
 	if (!ap)
 		return;
 
diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index 576b6a93b..812f309c5 100644
--- a/drivers/net/ppp/ppp_synctty.c
+++ b/drivers/net/ppp/ppp_synctty.c
@@ -129,17 +129,13 @@ ppp_print_buffer (const char *name, const __u8 *buf, int count)
  *
  * FIXME: Fixed in tty_io nowadays.
  */
-static DEFINE_RWLOCK(disc_data_lock);
 
 static struct syncppp *sp_get(struct tty_struct *tty)
 {
-	struct syncppp *ap;
+	struct syncppp *ap = tty->disc_data;
 
-	read_lock(&disc_data_lock);
-	ap = tty->disc_data;
 	if (ap != NULL)
 		refcount_inc(&ap->refcnt);
-	read_unlock(&disc_data_lock);
 	return ap;
 }
 
@@ -213,12 +209,9 @@ ppp_sync_open(struct tty_struct *tty)
 static void
 ppp_sync_close(struct tty_struct *tty)
 {
-	struct syncppp *ap;
+	struct syncppp *ap = tty->disc_data;
 
-	write_lock_irq(&disc_data_lock);
-	ap = tty->disc_data;
 	tty->disc_data = NULL;
-	write_unlock_irq(&disc_data_lock);
 	if (!ap)
 		return;
 
-- 
2.17.1

