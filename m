Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7379D416393
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240708AbhIWQt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235861AbhIWQtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:49:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2142C061756
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 09:47:50 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632415669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ItPVdW06jesRja28cAhDZ6mhsonko7BV4wLY07tRRTQ=;
        b=pZXzZdc/pZJbAMOGWbbNBVysq7Jzj6W6ETkWTstLFQHsTvMAUdzpRL0gU26glefYvmxZ2L
        9kVm79GMB5574W4x96uOV5Di5K4BOA3s7wNkwhZCZWjsDfpECLUOhKbWeE6AJQpTuHBGn3
        2Wbv+JbQCaccEUw0lLObQmkEajJmoXmirCwjDun1NUn2QXtqR77kLf3Eg9Hnrhc4pS43h6
        Xa1SZ+5FToWYej6Ji7EScASXvmYx488Kq/K6RJZ9Cwz5Gv4iYg8yRvDCS+0PMju73vvYh8
        olgzyqJfY8jrGANpSAh4jaLHRDSutX2eJYDY0YQSRRZZ+xonyXiO/Tv/XlrNiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632415669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ItPVdW06jesRja28cAhDZ6mhsonko7BV4wLY07tRRTQ=;
        b=bziYiaKnQ+THVz/9sIujJQb/kWL9FjjU6ij+XapjiaLuhNsXzb1w8Jlzuw+tkGhK2+PB3s
        BPzvTZrSvO6JqiAQ==
To:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marco Elver <elver@google.com>,
        Clark Williams <williams@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 2/5] Documentation/kcov: Define `ip' in the example.
Date:   Thu, 23 Sep 2021 18:47:38 +0200
Message-Id: <20210923164741.1859522-3-bigeasy@linutronix.de>
In-Reply-To: <20210923164741.1859522-1-bigeasy@linutronix.de>
References: <20210923164741.1859522-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The example code uses the variable `ip' but never declares it.

Declare `ip' as a 64bit variable which is the same type as the array
from which it loads its value.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Marco Elver <elver@google.com>
Tested-by: Marco Elver <elver@google.com>
Link: https://lore.kernel.org/r/20210830172627.267989-3-bigeasy@linutronix.=
de
---
 Documentation/dev-tools/kcov.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/dev-tools/kcov.rst b/Documentation/dev-tools/kco=
v.rst
index 347f3b6de8d40..d83c9ab494275 100644
--- a/Documentation/dev-tools/kcov.rst
+++ b/Documentation/dev-tools/kcov.rst
@@ -178,6 +178,8 @@ Comparison operands collection
 	/* Read number of comparisons collected. */
 	n =3D __atomic_load_n(&cover[0], __ATOMIC_RELAXED);
 	for (i =3D 0; i < n; i++) {
+		uint64_t ip;
+
 		type =3D cover[i * KCOV_WORDS_PER_CMP + 1];
 		/* arg1 and arg2 - operands of the comparison. */
 		arg1 =3D cover[i * KCOV_WORDS_PER_CMP + 2];
--=20
2.33.0

