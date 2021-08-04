Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEB63DFAEF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 07:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbhHDFKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 01:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhHDFKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 01:10:35 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073C0C06179A
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 21:59:30 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d17so1676571plr.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 21:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=8Kp8HW8FgLPZQe0dU1A61MbUqUtNRuzxvKPE9iCUH2Y=;
        b=kBFM5u1r4zuTpJn9FP6iYpMKGwEif7RMkAQUu2AsYhwiAW/3oQa5WUJskrhlW+iDYm
         T9T3Nv9fDNZm1a1sQnyRIs1frsR7WKRNkudRd40LYJJVCZGBTZF8savDGdvEfMwZ9MTA
         wKEIvYu8QFNz05SNLzstwaK1DhNGpKh2p2ESU4+ivZf9FuTRxLBIUiASJIxCBkVlYgKS
         j0pdRbVwUSkoUNCP9t2JHPWMZ9rO/y5oWdVuJoyLXv+pt7Jpu8aLI/hi/fySW3Bxwi0R
         SLSJROWh0OFciwsraemYHaactL/ueoZewR4cb3hq34GxZj1Skk6LKlOjNp9etXi1DeAd
         +ReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=8Kp8HW8FgLPZQe0dU1A61MbUqUtNRuzxvKPE9iCUH2Y=;
        b=Bk1+YH3uZqvD+OvFECx5XXcz+PycY7sCo5nCEb0mmJpi3nHAvH0eArlVjHB6/T7cwx
         ln6J26pMz6BlYxVttXOPTZf8uGsQ8r8ywWZ29lcCxWGMLAfyEz8zmV1ohHkuodOjdlyD
         efFg+kRk62meGWj7Z3EOMUwJrneLb4uL9PoEwci/e2x0eGXbXRbcuIiS1sYYrA3C0Ekl
         OLaAtLYRwIOEHSRKeef86tL8gDF1M4368wjgchNzzThzVxztqyk+FB442tOaBlKlkS8T
         wMkT7PVhGGycI6V5dYyrt5bZ56XmidUzIVgFegKc59RuoYoRH30aMinvNjTUuWFmuuQ4
         qYSg==
X-Gm-Message-State: AOAM530jVoZ6FWkCSVfVE6VHtEAER/3JBWSxDpGxR2ydMj43Bif+iYbR
        pmEMjkuZmkNtF6tWt7hsBOhvGcEEOM0=
X-Google-Smtp-Source: ABdhPJy4dxIoKa6iRTA00+YduiTGADWUl3v5SmnSPppS1VZjtjwg/zgdJklsOJ8ujWv+ss/Od6QEJQ==
X-Received: by 2002:a63:dd51:: with SMTP id g17mr4241687pgj.47.1628053169477;
        Tue, 03 Aug 2021 21:59:29 -0700 (PDT)
Received: from localhost (60-242-181-102.static.tpgi.com.au. [60.242.181.102])
        by smtp.gmail.com with ESMTPSA id d15sm900611pfu.45.2021.08.03.21.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 21:59:29 -0700 (PDT)
Date:   Wed, 04 Aug 2021 14:59:23 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH -next/-mmotm] kernel/user.c: fix build when POLL not
 enabled
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>
References: <20210803204609.32329-1-rdunlap@infradead.org>
In-Reply-To: <20210803204609.32329-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-Id: <1628051945.fens3r99ox.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Randy Dunlap's message of August 4, 2021 6:46 am:
> Fix build errors in kernel/user.c when CONFIG_EPOLL is not set/enabled.
>=20
> ../kernel/user.c: In function =E2=80=98free_user=E2=80=99:
> ../kernel/user.c:141:30: error: =E2=80=98struct user_struct=E2=80=99 has =
no member named =E2=80=98epoll_watches=E2=80=99; did you mean =E2=80=98nr_w=
atches=E2=80=99?
>   percpu_counter_destroy(&up->epoll_watches);
>                               ^~~~~~~~~~~~~
> In file included from ../include/linux/sched/user.h:7:0,
>                  from ../kernel/user.c:17:
> ../kernel/user.c: In function =E2=80=98alloc_uid=E2=80=99:
> ../kernel/user.c:189:33: error: =E2=80=98struct user_struct=E2=80=99 has =
no member named =E2=80=98epoll_watches=E2=80=99; did you mean =E2=80=98nr_w=
atches=E2=80=99?
>    if (percpu_counter_init(&new->epoll_watches, 0, GFP_KERNEL)) {
>                                  ^
> ../kernel/user.c:203:33: error: =E2=80=98struct user_struct=E2=80=99 has =
no member named =E2=80=98epoll_watches=E2=80=99; did you mean =E2=80=98nr_w=
atches=E2=80=99?
>     percpu_counter_destroy(&new->epoll_watches);
>                                  ^~~~~~~~~~~~~
> In file included from ../include/linux/sched/user.h:7:0,
>                  from ../kernel/user.c:17:
> ../kernel/user.c: In function =E2=80=98uid_cache_init=E2=80=99:
> ../kernel/user.c:225:37: error: =E2=80=98struct user_struct=E2=80=99 has =
no member named =E2=80=98epoll_watches=E2=80=99; did you mean =E2=80=98nr_w=
atches=E2=80=99?
>   if (percpu_counter_init(&root_user.epoll_watches, 0, GFP_KERNEL))
>                                      ^
> Also fix type: "cpunter" -> "counter" in a panic message.

Gah, thanks Randy. The ifdefs aren't horrible but could I suggest a=20
slight tweak?

--
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] kernel/user.c: fix build when EPOLL not enabled

Fix build errors in kernel/user.c when CONFIG_EPOLL is not set/enabled.

../kernel/user.c: In function =E2=80=98free_user=E2=80=99:
../kernel/user.c:141:30: error: =E2=80=98struct user_struct=E2=80=99 has no=
 member named =E2=80=98epoll_watches=E2=80=99; did you mean =E2=80=98nr_wat=
ches=E2=80=99?
  percpu_counter_destroy(&up->epoll_watches);
                              ^~~~~~~~~~~~~
In file included from ../include/linux/sched/user.h:7:0,
                 from ../kernel/user.c:17:
../kernel/user.c: In function =E2=80=98alloc_uid=E2=80=99:
../kernel/user.c:189:33: error: =E2=80=98struct user_struct=E2=80=99 has no=
 member named =E2=80=98epoll_watches=E2=80=99; did you mean =E2=80=98nr_wat=
ches=E2=80=99?
   if (percpu_counter_init(&new->epoll_watches, 0, GFP_KERNEL)) {
                                 ^
../kernel/user.c:203:33: error: =E2=80=98struct user_struct=E2=80=99 has no=
 member named =E2=80=98epoll_watches=E2=80=99; did you mean =E2=80=98nr_wat=
ches=E2=80=99?
    percpu_counter_destroy(&new->epoll_watches);
                                 ^~~~~~~~~~~~~
In file included from ../include/linux/sched/user.h:7:0,
                 from ../kernel/user.c:17:
../kernel/user.c: In function =E2=80=98uid_cache_init=E2=80=99:
../kernel/user.c:225:37: error: =E2=80=98struct user_struct=E2=80=99 has no=
 member named =E2=80=98epoll_watches=E2=80=99; did you mean =E2=80=98nr_wat=
ches=E2=80=99?
  if (percpu_counter_init(&root_user.epoll_watches, 0, GFP_KERNEL))
                                     ^
Also fix type: "cpunter" -"counter" in a panic message.

Fixes: e75b89477811 ("fs/epoll: use a per-cpu counter for user's watches co=
unt")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
[np: move ifdefs into wrapper functions, slightly improve panic message]
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
---
 kernel/user.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/kernel/user.c b/kernel/user.c
index a2673f940506..57d53568cb33 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -129,6 +129,21 @@ static struct user_struct *uid_hash_find(kuid_t uid, s=
truct hlist_head *hashent)
 	return NULL;
 }
=20
+static int user_epoll_alloc(struct user_struct *up)
+{
+#ifdef CONFIG_EPOLL
+	return percpu_counter_init(&up->epoll_watches, 0, GFP_KERNEL);
+#endif
+	return 0;
+}
+
+static void user_epoll_free(struct user_struct *up)
+{
+#ifdef CONFIG_EPOLL
+	percpu_counter_destroy(&up->epoll_watches);
+#endif
+}
+
 /* IRQs are disabled and uidhash_lock is held upon function entry.
  * IRQ state (as stored in flags) is restored and uidhash_lock released
  * upon function exit.
@@ -138,7 +153,7 @@ static void free_user(struct user_struct *up, unsigned =
long flags)
 {
 	uid_hash_remove(up);
 	spin_unlock_irqrestore(&uidhash_lock, flags);
-	percpu_counter_destroy(&up->epoll_watches);
+	user_epoll_free(up);
 	kmem_cache_free(uid_cachep, up);
 }
=20
@@ -186,7 +201,7 @@ struct user_struct *alloc_uid(kuid_t uid)
=20
 		new->uid =3D uid;
 		refcount_set(&new->__count, 1);
-		if (percpu_counter_init(&new->epoll_watches, 0, GFP_KERNEL)) {
+		if (user_epoll_alloc(new)) {
 			kmem_cache_free(uid_cachep, new);
 			return NULL;
 		}
@@ -200,7 +215,7 @@ struct user_struct *alloc_uid(kuid_t uid)
 		spin_lock_irq(&uidhash_lock);
 		up =3D uid_hash_find(uid, hashent);
 		if (up) {
-			percpu_counter_destroy(&new->epoll_watches);
+			user_epoll_free(new);
 			kmem_cache_free(uid_cachep, new);
 		} else {
 			uid_hash_insert(new, hashent);
@@ -222,8 +237,8 @@ static int __init uid_cache_init(void)
 	for(n =3D 0; n < UIDHASH_SZ; ++n)
 		INIT_HLIST_HEAD(uidhash_table + n);
=20
-	if (percpu_counter_init(&root_user.epoll_watches, 0, GFP_KERNEL))
-		panic("percpu cpunter alloc failed");
+	if (user_epoll_alloc(&root_user))
+		panic("root_user epoll percpu counter alloc failed");
=20
 	/* Insert the root user immediately (init already runs as root) */
 	spin_lock_irq(&uidhash_lock);
--=20
2.23.0

