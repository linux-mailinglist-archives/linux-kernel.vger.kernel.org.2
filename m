Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1367416392
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240392AbhIWQt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:49:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35832 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhIWQtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:49:21 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632415669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mB7jM56vMMnOkxJZosiS0/83k5Pr1jaIkmbtlQVNiLQ=;
        b=cfc5y3MOt3mPdHlynaoCXKV4Vx596udf5y2RfWe8+rm+WhRv3vuC0EPNr5hgescfaA6bBF
        qLYpfNhlxj1t84WFJvs4PwuDB/3OmaLeFcMPZ2U6OF8d3qjM9mdJUiIyJXANLt75xQIQ8t
        3XYBP1jUAuF2TxfX6B3Q0XM2HW5gkgMvYhcHeQO9Cjvk3rV09uw01XPBafJZZMNT9nkXdf
        Y1x/zWcB4ysJUwC2lbz3fKlgbErZ7CG0ZEibipw95/5uQdkEcp4U71dqYlI5m/DFCV4Yro
        r0idyoyhuvhcyrqOejYoUuuXSDEwwnOmthYtx597PFliCohOZAGpv5fsqXv46g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632415669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mB7jM56vMMnOkxJZosiS0/83k5Pr1jaIkmbtlQVNiLQ=;
        b=bQpyUwD2Hdv9J7AC4Y8Kbmy6j9LmONa05DJE3HruwTyN2IwXo55HsYz38Mt/PnhU6WD6Y0
        IhWSLAm1a0YE+dCw==
To:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marco Elver <elver@google.com>,
        Clark Williams <williams@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 1/5] Documentation/kcov: Include types.h in the example.
Date:   Thu, 23 Sep 2021 18:47:37 +0200
Message-Id: <20210923164741.1859522-2-bigeasy@linutronix.de>
In-Reply-To: <20210923164741.1859522-1-bigeasy@linutronix.de>
References: <20210923164741.1859522-1-bigeasy@linutronix.de>
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
Acked-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Marco Elver <elver@google.com>
Tested-by: Marco Elver <elver@google.com>
Link: https://lore.kernel.org/r/20210830172627.267989-2-bigeasy@linutronix.=
de
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

