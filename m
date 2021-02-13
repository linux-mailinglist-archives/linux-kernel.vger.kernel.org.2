Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6BF31AD44
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 17:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhBMQv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 11:51:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52136 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhBMQvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 11:51:25 -0500
Date:   Sat, 13 Feb 2021 17:50:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613235042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7z/aCScthZ9V/mXw68IO9g7+/wd6ZMg71iFmWLok6uI=;
        b=p+npfVySksEqjsJqGXSoZ6qNHMVmv2arXuyZrUORkX6SxYxpRtQ3Zwpzd40Q+TlGNRBCva
        326EjpujBNXcigSnRBBdLIA14Roka3TeyhyvIkA08eyFJ8RMRuKEz1hxJ6umguNdPDCvlH
        BCJmDQUgGqMOzEeembUeiW3kzi5SRSn8o2uSK/9zbWpleMRn/Xe0mvZZFcFLxoBXlzrZdP
        amLL5cZtMxXrCrJcBZmEBxps9y6r1lSHmeVwjH7LpB1Q2ydednxdJGiPjgw/7Hhp35QNJq
        qk1HYhdZ3kB2kZAUyiBaq8VYHwr+zVFqmcPuhJ98cq/ecDL0ZNOwawRjqhlnQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613235042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7z/aCScthZ9V/mXw68IO9g7+/wd6ZMg71iFmWLok6uI=;
        b=x9rjzv1DnlD4an/VdBnhmI1eTAj58Cn56bJqhJx/qx/ru9RD2c+HjIZ1xResbCJm0XhSL/
        vGqC94CIOSe+tEBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH v3] auxdisplay: Remove in_interrupt() usage.
Message-ID: <20210213165040.vzzieegx4aliyosd@linutronix.de>
References: <20210208175824.381484-1-bigeasy@linutronix.de>
 <CANiq72kqfPOpgwvNo3hTesCJztODxVGonJXpeeX=S+O4roNZsw@mail.gmail.com>
 <20210208190735.ibq44r5pc4cwzt7j@linutronix.de>
 <CANiq72kq_d=5TvdhndP9zkyTD1pHF6WQb+qs01D68DEQH6jVjQ@mail.gmail.com>
 <20210208204136.sv4omzms3nadse6e@linutronix.de>
 <CANiq72mw47Qa9M6i23Dp+_3M8juBnv33PJ-6zFk++SV57G2-cQ@mail.gmail.com>
 <20210209090112.lewvvhnc2y7oyr27@linutronix.de>
 <CANiq72mG3zXA7j9KbC74hQ1BMgw713Hm3WDAcQBjKxgg0fLHeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANiq72mG3zXA7j9KbC74hQ1BMgw713Hm3WDAcQBjKxgg0fLHeg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

charlcd_write() is invoked as a VFS->write() callback and as such it is
always invoked from preemptible context and may sleep.

charlcd_puts() is invoked from register/unregister callback which is
preemtible. The reboot notifier callback is also invoked from
preemptible context.

Therefore there is no need to use `in_interrupt()' to figure out if it
is save to sleep because it always is. `in_interrupt()` and related
context checks are being removed from non-core code.
Using `schedule()' to schedule (an be friendly to others) is
discouraged and `cond_resched()' should be used instead.

Remove `in_interrupt()' and use `cond_resched()' to schedule every 32
iteration if needed.

Link: https://lkml.kernel.org/r/20200914204209.256266093@linutronix.de
Cc: Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v2=E2=80=A6v3: Extend the commit message as suggested by Miguel Ojeda.
v1=E2=80=A6v2: Spelling fixes.

On 2021-02-10 22:46:23 [+0100], Miguel Ojeda wrote:
> Hi Sebastian,
Hi Miguel,

> Yeah, it is a bit confusing when reading without the context (it is
> hard to keep up with everything going on unless you work full-time on
> it :-)

Sorry for leaving it out. I though it is not needed since it was not
needed.

> > since this patch was small, simple and removing not required code I kept
> > it out. Is this enough information for you?
>=20
> If you don't mind, please add a quick sentence like (I can do it on my
> side too):
>=20
>     `in_interrupt()` and related context checks are being removed
>     from non-core code.
>=20
> Plus the tag:
>=20
>     Link: https://lore.kernel.org/r/20200914204209.256266093@linutronix.d=
e/

Added as suggested.

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
