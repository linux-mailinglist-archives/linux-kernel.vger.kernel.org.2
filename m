Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5353531D033
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 19:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbhBPS17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 13:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbhBPS15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 13:27:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8DBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 10:27:17 -0800 (PST)
Date:   Tue, 16 Feb 2021 19:27:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613500035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0y5botdvWmcBg2d2KH7POG8NCpfHVSpmENnFKiuKl1s=;
        b=KZGiOGs5Ut7ywyRHSs2nzyVpKLS5RRK8JR94p+BcXfJKhwBz6dr1M/3fQfa2HojeRgdis+
        8/HF1RijPIFWb26wWrbxSj5J2M9n7VYUi9C9en+3WTIXDrXeSHyRHDT7BgGsNPIPqYUIvZ
        d1cRYxfD37/p+q3mQnzN36IKpfkR5AaoMoF6U66L7rmpNi62xeMMJ+bRg5+KyKSwN/d1JO
        AzAhj/zeyiClYJ8getWWVMW/ommahbdg0Sg/hdGaDPMGjRNRgeHMBB53dpHyqu0OrqYsEr
        +12bx22IaY76aYJjn27/HEaWyF9JZ8lxKn8vUH5FaHrtPqGaZz4BNj1XbfDU5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613500035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0y5botdvWmcBg2d2KH7POG8NCpfHVSpmENnFKiuKl1s=;
        b=As84rOyBnBo3DoztYX6sRiLUJnOqhRFZI4FAYe7rcZWAdGg1mDSpqrmwWY+pl4T8gZEiZj
        hmUo3f0NDzLKNXBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH v4] auxdisplay: Remove in_interrupt() usage.
Message-ID: <20210216182714.acvs7koucuc327yf@linutronix.de>
References: <CANiq72kq_d=5TvdhndP9zkyTD1pHF6WQb+qs01D68DEQH6jVjQ@mail.gmail.com>
 <20210208204136.sv4omzms3nadse6e@linutronix.de>
 <CANiq72mw47Qa9M6i23Dp+_3M8juBnv33PJ-6zFk++SV57G2-cQ@mail.gmail.com>
 <20210209090112.lewvvhnc2y7oyr27@linutronix.de>
 <CANiq72mG3zXA7j9KbC74hQ1BMgw713Hm3WDAcQBjKxgg0fLHeg@mail.gmail.com>
 <20210213165040.vzzieegx4aliyosd@linutronix.de>
 <CANiq72mkkSfbnNM_mmXE-TNKO1orsAeyByMKFy1N6hm+EBA40A@mail.gmail.com>
 <20210216102856.dnaycukt3oqxoszp@linutronix.de>
 <CANiq72mge40Uvqf3mb4uof2gi8ktvhjoodfyJY7uLW4guTnvDw@mail.gmail.com>
 <20210216182619.xd7h4uwpqcw5kcup@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210216182619.xd7h4uwpqcw5kcup@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

charlcd_write() is invoked as a VFS->write() callback and as such it is
always invoked from preemptible context and may sleep.

charlcd_puts() is invoked from register/unregister callback which is
preemptible. The reboot notifier callback is also invoked from
preemptible context.

Therefore there is no need to use in_interrupt() to figure out if it
is safe to sleep because it always is. in_interrupt() and related
context checks are being removed from non-core code.
Using schedule() to schedule (and be friendly to others) is
discouraged and cond_resched() should be used instead.

Remove in_interrupt() and use cond_resched() to schedule every 32
iteration if needed.

Link: https://lkml.kernel.org/r/20200914204209.256266093@linutronix.de
Cc: Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v2=E2=80=A6v4: - Spelling fixes got lot.
       - Add a comment before cond_resched() as requested by Miguel Ojeda.
       - Drop the ` ' comments.
v2=E2=80=A6v3: Extend the commit message as suggested by Miguel Ojeda.
v1=E2=80=A6v2: Spelling fixes.

 drivers/auxdisplay/charlcd.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index f43430e9dceed..95accc941023a 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -470,12 +470,14 @@ static ssize_t charlcd_write(struct file *file, const=
 char __user *buf,
 	char c;
=20
 	for (; count-- > 0; (*ppos)++, tmp++) {
-		if (!in_interrupt() && (((count + 1) & 0x1f) =3D=3D 0))
+		if (((count + 1) & 0x1f) =3D=3D 0) {
 			/*
-			 * let's be a little nice with other processes
-			 * that need some CPU
+			 * charlcd_write() is invoked as a VFS->write() callback
+			 * and as such it is > always invoked from preemptible
+			 * context and may sleep.
 			 */
-			schedule();
+			cond_resched();
+		}
=20
 		if (get_user(c, tmp))
 			return -EFAULT;
@@ -537,12 +539,8 @@ static void charlcd_puts(struct charlcd *lcd, const ch=
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

