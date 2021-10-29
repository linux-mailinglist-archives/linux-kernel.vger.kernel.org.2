Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C7343F90C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 10:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbhJ2IlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 04:41:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53488 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbhJ2IlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 04:41:09 -0400
Date:   Fri, 29 Oct 2021 10:38:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635496720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zJHddUlI46Qff30zfi3fJqY8SclNQ5Xl5lYf2O4sTWc=;
        b=OhB3PuaNC6oHKH2VZie4clXTUTSDipnanrL8fKfUT2A2JAnYvO6det9QI574c/UAdRCi21
        lyxuMMSgbrxETQU0mNCAdkrm33gBLXijZjjj3MOuouI4ZoV7bKnx5pC5WZYjJN85oHJkp2
        IZj3cp0N65iZsz+4r/D9xagHUDKPnXGG3+GHTJfyDoDVKK00FD5JtRTJNPG049VG6ZYp/Z
        l1SjAuRusKqWn6hHtDg60IdZswXJSWcxKreNyd9G0g/czlHK7tCycAKiOzFe/bo+FdhCsG
        li0+HCNnJ2+y9FDbuGkBwIimSuof1ngiazjJm3MlLqsAW0VTui7FfPJcbXTKiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635496720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zJHddUlI46Qff30zfi3fJqY8SclNQ5Xl5lYf2O4sTWc=;
        b=4RL1focKw2Sxw3+0gm897f09RZlcwNaoGBoS76qvCcQkGHnw6py3I6iatv+e4QoGa7b3Ji
        pj/ZGQIpIEeaQHAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-cachefs@redhat.com, linux-kernel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>, Tejun Heo <tj@kernel.org>,
        Gregor Beck <gregor.beck@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2] fscache: Use only one fscache_object_cong_wait.
Message-ID: <20211029083839.xwwt7jgzru3kcpii@linutronix.de>
References: <20211028160628.czwdzjjjhtqywasw@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211028160628.czwdzjjjhtqywasw@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the commit mentioned below, fscache was converted from slow-work to
workqueue. slow_work_enqueue() and slow_work_sleep_till_thread_needed()
did not use a per-CPU workqueue. They choose from two global waitqueues
depending on the SLOW_WORK_VERY_SLOW bit which was not set so it always
one waitqueue.

I can't find out how it is ensured that a waiter on certain CPU is woken
up be the other side. My guess is that the timeout in schedule_timeout()
ensures that it does not wait forever (or a random wake up).

fscache_object_sleep_till_congested() must be invoked from preemptible
context in order for schedule() to work. In this case this_cpu_ptr()
should complain with CONFIG_DEBUG_PREEMPT enabled except the thread is
bound to one CPU.

wake_up() wakes only one waiter and I'm not sure if it is guaranteed
that only one waiter exists.

Replace the per-CPU waitqueue with one global waitqueue.

Fixes: 8b8edefa2fffb ("fscache: convert object to use workqueue instead of =
slow-work")
Reported-by: Gregor Beck <gregor.beck@gmail.com>
Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1=E2=80=A6v2:
  - Also remove the put_cpu_var() statement.

 fs/fscache/internal.h |  1 -
 fs/fscache/main.c     |  6 ------
 fs/fscache/object.c   | 13 +++++--------
 3 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index c3e4804b8fcbf..9edb87e11680b 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -81,7 +81,6 @@ extern unsigned fscache_debug;
 extern struct kobject *fscache_root;
 extern struct workqueue_struct *fscache_object_wq;
 extern struct workqueue_struct *fscache_op_wq;
-DECLARE_PER_CPU(wait_queue_head_t, fscache_object_cong_wait);
=20
 extern unsigned int fscache_hash(unsigned int salt, unsigned int *data, un=
signed int n);
=20
diff --git a/fs/fscache/main.c b/fs/fscache/main.c
index 4207f98e405fd..85f8cf3a323d5 100644
--- a/fs/fscache/main.c
+++ b/fs/fscache/main.c
@@ -41,8 +41,6 @@ struct kobject *fscache_root;
 struct workqueue_struct *fscache_object_wq;
 struct workqueue_struct *fscache_op_wq;
=20
-DEFINE_PER_CPU(wait_queue_head_t, fscache_object_cong_wait);
-
 /* these values serve as lower bounds, will be adjusted in fscache_init() =
*/
 static unsigned fscache_object_max_active =3D 4;
 static unsigned fscache_op_max_active =3D 2;
@@ -138,7 +136,6 @@ unsigned int fscache_hash(unsigned int salt, unsigned i=
nt *data, unsigned int n)
 static int __init fscache_init(void)
 {
 	unsigned int nr_cpus =3D num_possible_cpus();
-	unsigned int cpu;
 	int ret;
=20
 	fscache_object_max_active =3D
@@ -161,9 +158,6 @@ static int __init fscache_init(void)
 	if (!fscache_op_wq)
 		goto error_op_wq;
=20
-	for_each_possible_cpu(cpu)
-		init_waitqueue_head(&per_cpu(fscache_object_cong_wait, cpu));
-
 	ret =3D fscache_proc_init();
 	if (ret < 0)
 		goto error_proc;
diff --git a/fs/fscache/object.c b/fs/fscache/object.c
index 6a675652129b2..7a972d144b546 100644
--- a/fs/fscache/object.c
+++ b/fs/fscache/object.c
@@ -798,6 +798,8 @@ void fscache_object_destroy(struct fscache_object *obje=
ct)
 }
 EXPORT_SYMBOL(fscache_object_destroy);
=20
+static DECLARE_WAIT_QUEUE_HEAD(fscache_object_cong_wait);
+
 /*
  * enqueue an object for metadata-type processing
  */
@@ -806,16 +808,12 @@ void fscache_enqueue_object(struct fscache_object *ob=
ject)
 	_enter("{OBJ%x}", object->debug_id);
=20
 	if (fscache_get_object(object, fscache_obj_get_queue) >=3D 0) {
-		wait_queue_head_t *cong_wq =3D
-			&get_cpu_var(fscache_object_cong_wait);
=20
 		if (queue_work(fscache_object_wq, &object->work)) {
 			if (fscache_object_congested())
-				wake_up(cong_wq);
+				wake_up(&fscache_object_cong_wait);
 		} else
 			fscache_put_object(object, fscache_obj_put_queue);
-
-		put_cpu_var(fscache_object_cong_wait);
 	}
 }
=20
@@ -833,16 +831,15 @@ void fscache_enqueue_object(struct fscache_object *ob=
ject)
  */
 bool fscache_object_sleep_till_congested(signed long *timeoutp)
 {
-	wait_queue_head_t *cong_wq =3D this_cpu_ptr(&fscache_object_cong_wait);
 	DEFINE_WAIT(wait);
=20
 	if (fscache_object_congested())
 		return true;
=20
-	add_wait_queue_exclusive(cong_wq, &wait);
+	add_wait_queue_exclusive(&fscache_object_cong_wait, &wait);
 	if (!fscache_object_congested())
 		*timeoutp =3D schedule_timeout(*timeoutp);
-	finish_wait(cong_wq, &wait);
+	finish_wait(&fscache_object_cong_wait, &wait);
=20
 	return fscache_object_congested();
 }
--=20
2.33.1

