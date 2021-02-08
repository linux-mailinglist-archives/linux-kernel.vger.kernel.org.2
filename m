Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33AD0313EC2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 20:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236106AbhBHTVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 14:21:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38158 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbhBHSAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 13:00:06 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612807155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=d/K1nflfjUlbsBR3cGwm/oQjA++u+sJaiD0qsOu7S2s=;
        b=CHIBhRcS9EzzfV/puEcjPtfyZq14OpnWy94x/5xqEeK0HD9eFrDljq/dTT6dy9ZKTjviFQ
        MGHzHOyVpa+QPrQiyqsLPjFWCxz57fKJcRkuSQ3TbSfeA8aC4CEMg63jOGQy36tON9WnhH
        FXCPhxIkc1tjeFdI1nWXgbFNmAqSIg3Gf5rxY58W12Ogf3RrKvmv5LNEl0Exa1gbdGVtE2
        /FUi6oQ+L25oJhzHFKLgX2xd+fgMgs6Io1bEFCOnsDAaM0QaxgGZqHXkqxNVDdkrufn0Jx
        1y60ALM6UeklQge91NhzcJ4O/AqhCekCvRCVLJwGTk/0KnOBa4Nc34PWbgbnag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612807155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=d/K1nflfjUlbsBR3cGwm/oQjA++u+sJaiD0qsOu7S2s=;
        b=4wR+m38B5LyACURm932IzQakUfaUt5rUysmpS8y054un9uavzWSlLGMvv9GSXfneHTzHA6
        a3f2+iCqIeMEA0BQ==
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH] auxdisplay: Remove in_interrupt() usage.
Date:   Mon,  8 Feb 2021 18:58:24 +0100
Message-Id: <20210208175824.381484-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

charlcd_write() is invoked as a VFS->write() callback and as such it is
always invoked from preemptible context and may sleep.

charlcd_puts() is invoked from register/unregister callback which is
preemtible. The reboot notifier callback is also invoked from
preemptible context.

Therefore there is no need to use `in_interrupt()' to figure out if it
is save to sleep because it always is.
Using `schedule()' to schedule (an be friendly to others) is
discouraged and `cond_resched()' should be used instead.

Remove `in_interrupt()' and use `cond_resched()' to schedule every 32
iteration if needed.

Cc: Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/auxdisplay/charlcd.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index f43430e9dceed..fbfce95919f72 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -470,12 +470,8 @@ static ssize_t charlcd_write(struct file *file, const =
char __user *buf,
 	char c;
=20
 	for (; count-- > 0; (*ppos)++, tmp++) {
-		if (!in_interrupt() && (((count + 1) & 0x1f) =3D=3D 0))
-			/*
-			 * let's be a little nice with other processes
-			 * that need some CPU
-			 */
-			schedule();
+		if (((count + 1) & 0x1f) =3D=3D 0)
+			cond_resched();
=20
 		if (get_user(c, tmp))
 			return -EFAULT;
@@ -537,12 +533,8 @@ static void charlcd_puts(struct charlcd *lcd, const ch=
ar *s)
 	int count =3D strlen(s);
=20
 	for (; count-- > 0; tmp++) {
-		if (!in_interrupt() && (((count + 1) & 0x1f) =3D=3D 0))
-			/*
-			 * let's be a little nice with other processes
-			 * that need some CPU
-			 */
-			schedule();
+		if (((count + 1) & 0x1f) =3D=3D 0)
+			cond_resched();
=20
 		charlcd_write_char(lcd, *tmp);
 	}
--=20
2.30.0

