Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F402130E1CB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 19:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbhBCSDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 13:03:40 -0500
Received: from mail.efficios.com ([167.114.26.124]:57972 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbhBCR62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 12:58:28 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id CA6822E156D;
        Wed,  3 Feb 2021 12:57:46 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id cz6j4qh-4907; Wed,  3 Feb 2021 12:57:46 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 735CC2E16F5;
        Wed,  3 Feb 2021 12:57:46 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 735CC2E16F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1612375066;
        bh=eBUJaqfV2UW2Ob4Bvu50jTCHuc1hDcJt6nquQMk4gEw=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=OG9vfN0HpNb1IAese6IM0ipEH0T6p3B5vKPd1Whz5zLuSVrfXtt0KBhmiymNEXV6E
         +f2AQpo/gQ94RogzW3VawMYcItWOTqSFgtp5F8D3D8DxnebRKI+5j2Qvf3fnhNa8/P
         hqhvVOCocBRCqfY2aBDodEkdLdbcfh4XhJNv6wrukT6gcbu/B8KCcBLJUMSz432FlX
         Ph8eSQC2+B3ZJ5cjbPoihrfSFVc8UUZ7LFCoLUqOXgrUB5uLhZLdrP82JDiZSbYBdd
         0wX9y9gjanr6H+kyUS+2CFbjvIN0ZG0k5b5fwG6nofolfOb2/xLBs7bnBi7R0dVW03
         Dq/uP9cTlhoTA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qRiv_J2Rp7hO; Wed,  3 Feb 2021 12:57:46 -0500 (EST)
Received: from thinkos.etherlink (unknown [192.222.236.144])
        by mail.efficios.com (Postfix) with ESMTPSA id 50E4E2E167B;
        Wed,  3 Feb 2021 12:57:46 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 1/1] tracepoint: cleanup: do not fail unregistration
Date:   Wed,  3 Feb 2021 12:57:41 -0500
Message-Id: <20210203175741.20665-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210203160550.710877069@goodmis.org>
References: <20210203160550.710877069@goodmis.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is only compile-tested.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/linux/tracepoint.h |  2 +-
 kernel/tracepoint.c        | 80 +++++++++++++-------------------------
 2 files changed, 28 insertions(+), 54 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 0f21617f1a66..fae8d6d9588c 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -308,7 +308,7 @@ static inline struct tracepoint *tracepoint_ptr_deref=
(tracepoint_ptr_t *p)
 		it_func_ptr =3D						\
 			rcu_dereference_raw((&__tracepoint_##_name)->funcs); \
 		do {							\
-			it_func =3D (it_func_ptr)->func;			\
+			it_func =3D READ_ONCE((it_func_ptr)->func);	\
 			__data =3D (it_func_ptr)->data;			\
 			((void(*)(void *, proto))(it_func))(__data, args); \
 		} while ((++it_func_ptr)->func);			\
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 3e261482296c..b1bec710f68a 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -136,9 +136,10 @@ func_add(struct tracepoint_func **funcs, struct trac=
epoint_func *tp_func,
 	 int prio)
 {
 	struct tracepoint_func *old, *new;
-	int nr_probes =3D 0;
-	int stub_funcs =3D 0;
-	int pos =3D -1;
+	int iter_probes =3D 0;	/* Iterate over old probe array. */
+	int nr_old_probes =3D 0;	/* Count non-stub functions in old. */
+	int nr_new_probes =3D 0;	/* Count functions in new. */
+	int pos =3D -1;		/* Insert position in new. */
=20
 	if (WARN_ON(!tp_func->func))
 		return ERR_PTR(-EINVAL);
@@ -147,54 +148,34 @@ func_add(struct tracepoint_func **funcs, struct tra=
cepoint_func *tp_func,
 	old =3D *funcs;
 	if (old) {
 		/* (N -> N+1), (N !=3D 0, 1) probes */
-		for (nr_probes =3D 0; old[nr_probes].func; nr_probes++) {
-			/* Insert before probes of lower priority */
-			if (pos < 0 && old[nr_probes].prio < prio)
-				pos =3D nr_probes;
-			if (old[nr_probes].func =3D=3D tp_func->func &&
-			    old[nr_probes].data =3D=3D tp_func->data)
+		for (iter_probes =3D 0; old[iter_probes].func; iter_probes++) {
+			if (old[iter_probes].func =3D=3D tp_stub_func)
+				continue;	/* Skip stub functions. */
+			if (old[iter_probes].func =3D=3D tp_func->func &&
+			    old[iter_probes].data =3D=3D tp_func->data)
 				return ERR_PTR(-EEXIST);
-			if (old[nr_probes].func =3D=3D tp_stub_func)
-				stub_funcs++;
+			/* Insert before probes of lower priority */
+			if (pos < 0 && old[iter_probes].prio < prio)
+				pos =3D nr_old_probes;
+			nr_old_probes++;
 		}
 	}
-	/* + 2 : one for new probe, one for NULL func - stub functions */
-	new =3D allocate_probes(nr_probes + 2 - stub_funcs);
+	/* + 2 : one for new probe, one for NULL func */
+	new =3D allocate_probes(nr_old_probes + 2);
 	if (new =3D=3D NULL)
 		return ERR_PTR(-ENOMEM);
 	if (old) {
-		if (stub_funcs) {
-			/* Need to copy one at a time to remove stubs */
-			int probes =3D 0;
-
-			pos =3D -1;
-			for (nr_probes =3D 0; old[nr_probes].func; nr_probes++) {
-				if (old[nr_probes].func =3D=3D tp_stub_func)
-					continue;
-				if (pos < 0 && old[nr_probes].prio < prio)
-					pos =3D probes++;
-				new[probes++] =3D old[nr_probes];
-			}
-			nr_probes =3D probes;
-			if (pos < 0)
-				pos =3D probes;
-			else
-				nr_probes--; /* Account for insertion */
-
-		} else if (pos < 0) {
-			pos =3D nr_probes;
-			memcpy(new, old, nr_probes * sizeof(struct tracepoint_func));
-		} else {
-			/* Copy higher priority probes ahead of the new probe */
-			memcpy(new, old, pos * sizeof(struct tracepoint_func));
-			/* Copy the rest after it. */
-			memcpy(new + pos + 1, old + pos,
-			       (nr_probes - pos) * sizeof(struct tracepoint_func));
+		for (iter_probes =3D 0; old[iter_probes].func; iter_probes++) {
+			if (old[iter_probes].func =3D=3D tp_stub_func)
+				continue;		/* Skip stub functions. */
+			if (nr_new_probes !=3D pos)
+				new[nr_new_probes] =3D old[iter_probes];
+			nr_new_probes++;
 		}
 	} else
 		pos =3D 0;
 	new[pos] =3D *tp_func;
-	new[nr_probes + 1].func =3D NULL;
+	new[nr_new_probes + 1].func =3D NULL;
 	*funcs =3D new;
 	debug_print_probes(*funcs);
 	return old;
@@ -238,9 +219,9 @@ static void *func_remove(struct tracepoint_func **fun=
cs,
 		new =3D allocate_probes(nr_probes - nr_del + 1);
 		if (new) {
 			for (i =3D 0; old[i].func; i++)
-				if ((old[i].func !=3D tp_func->func
-				     || old[i].data !=3D tp_func->data)
-				    && old[i].func !=3D tp_stub_func)
+				if ((old[i].func !=3D tp_func->func ||
+				     old[i].data !=3D tp_func->data) &&
+				    old[i].func !=3D tp_stub_func)
 					new[j++] =3D old[i];
 			new[nr_probes - nr_del].func =3D NULL;
 			*funcs =3D new;
@@ -251,15 +232,8 @@ static void *func_remove(struct tracepoint_func **fu=
ncs,
 			 */
 			for (i =3D 0; old[i].func; i++)
 				if (old[i].func =3D=3D tp_func->func &&
-				    old[i].data =3D=3D tp_func->data) {
-					old[i].func =3D tp_stub_func;
-					/* Set the prio to the next event. */
-					if (old[i + 1].func)
-						old[i].prio =3D
-							old[i + 1].prio;
-					else
-						old[i].prio =3D -1;
-				}
+				    old[i].data =3D=3D tp_func->data)
+					WRITE_ONCE(old[i].func, tp_stub_func);
 			*funcs =3D old;
 		}
 	}
--=20
2.20.1

