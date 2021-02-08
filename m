Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7563140FD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbhBHUxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbhBHThq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 14:37:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9AEC06178A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 11:37:06 -0800 (PST)
Date:   Mon, 8 Feb 2021 20:37:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612813025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LqF6bQgSoF34yUGpX/VClqMZiels7BPo/3e29mGH6L4=;
        b=XbUZ3JNC2dWjtgrsV0OZ2XCyv3oI+wTxXCarW+kJ9XmEKMlMoBx0GOlTQLxp+mi+JXI5iL
        ackrCsUKBKKnupeUCDHRB7T2CVg9ful7wD2b/03vAcH1WI4L4SGfJp4SKC0wqobtgXE43E
        T6LR3Uh04LiWgTy6fZxE4ApYaUgiLl2bHIxna+5/FHHMqSDWol0jWnJnt9P3N+TljiT0j6
        LVts7JpW3MV6xMFYiAHCslIoefUYeT8F53pyJgKtwhCCxxtBbQJIWKpuUBivNhW7rcWUGN
        mNn1dKEyj0Vs6Vd/G3Qb5p5xAvFm0GXtvr1KtmeGALJbedaJpMHoy9rPOMU6kQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612813025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LqF6bQgSoF34yUGpX/VClqMZiels7BPo/3e29mGH6L4=;
        b=2hxyhNnQ3E6ZjhUtY9S10wKUb9vd2sVeksQYOcFZzGvV9bcZ202bAAOSzzN+x5tZsbhV06
        t2E7ewKv166XWWDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH v2] auxdisplay: Remove in_interrupt() usage.
Message-ID: <20210208193703.lzuhhquhig2vfq3t@linutronix.de>
References: <20210208175824.381484-1-bigeasy@linutronix.de>
 <CANiq72kqfPOpgwvNo3hTesCJztODxVGonJXpeeX=S+O4roNZsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANiq72kqfPOpgwvNo3hTesCJztODxVGonJXpeeX=S+O4roNZsw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

charlcd_write() is invoked as a VFS->write() callback and as such it is
always invoked from preemptible context and may sleep.

charlcd_puts() is invoked from register/unregister callback which is
preemptible. The reboot notifier callback is also invoked from
preemptible context.

Therefore there is no need to use `in_interrupt()' to figure out if it
is safe to sleep because it always is.
Using `schedule()' to schedule (and be friendly to others) is
discouraged and `cond_resched()' should be used instead.

Remove `in_interrupt()' and use `cond_resched()' to schedule every 32
iteration if needed.

Cc: Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

v1=E2=80=A6v2: Spelling fixes.

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

