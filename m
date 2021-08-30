Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529573FBAEB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 19:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238066AbhH3R1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 13:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238010AbhH3R1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 13:27:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C53C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 10:26:38 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630344397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u95bLI4q4WJi0Y0q765P3HlxxgiU6jgiCxI29+0MUC0=;
        b=1yWhNjZtuwlVRtsHtBmBagxF59AlbCfQHTi1nsPi/Iwr1KKrgM4ykxJh2tnTwOw+3Jq8az
        VaYdjk8Od+SSysPp52NzZ8VWuwt5IeViMfKr211q+oV8cOXMV4TOHiNUUAaVGojN8rYjL4
        yRSNLngdR4RLZg8uE7W4TEO0Rfu6GUIPw+ylifp3dSBJ7oYDYD38VJJthf5OCUEU2WmB/d
        9cs8m4CBApH90nKi76dcMa+KKSG85MepJ3makBToObkBkVdcIepju5bteGNyqlLZa6nEoL
        eQkv/HHc07PL+WNEjzhHmu5yEpbezN/13LQ47oTk5QmeiOm1IRlxNbQv5Pw57Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630344397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u95bLI4q4WJi0Y0q765P3HlxxgiU6jgiCxI29+0MUC0=;
        b=UdJFO0ZFUd+c3koVuCcvjio40OEQ53KpNfE+1GsBXBM3uhnWkcsbhV55OdXjw8LE0J1eKe
        DuAzj0IyjcF+8pBw==
To:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marco Elver <elver@google.com>,
        Clark Williams <williams@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/5] Documentation/kcov: Include types.h in the example.
Date:   Mon, 30 Aug 2021 19:26:23 +0200
Message-Id: <20210830172627.267989-2-bigeasy@linutronix.de>
In-Reply-To: <20210830172627.267989-1-bigeasy@linutronix.de>
References: <20210830172627.267989-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first example code has includes at the top, the following two
example share that part. The last example (remote coverage collection)
requires the linux/types.h header file due its __aligned_u64 usage.

Add the linux/types.h to the top most example and a comment that the
header files from above are required as it is done in the second
example.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 Documentation/dev-tools/kcov.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/dev-tools/kcov.rst b/Documentation/dev-tools/kco=
v.rst
index d2c4c27e1702d..347f3b6de8d40 100644
--- a/Documentation/dev-tools/kcov.rst
+++ b/Documentation/dev-tools/kcov.rst
@@ -50,6 +50,7 @@ The following program demonstrates coverage collection fr=
om within a test
     #include <sys/mman.h>
     #include <unistd.h>
     #include <fcntl.h>
+    #include <linux/types.h>
=20
     #define KCOV_INIT_TRACE			_IOR('c', 1, unsigned long)
     #define KCOV_ENABLE			_IO('c', 100)
@@ -251,6 +252,8 @@ selectively from different subsystems.
=20
 .. code-block:: c
=20
+    /* Same includes and defines as above. */
+
     struct kcov_remote_arg {
 	__u32		trace_mode;
 	__u32		area_size;
--=20
2.33.0

