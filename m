Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3CA53FBAED
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 19:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238059AbhH3R1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 13:27:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53442 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237997AbhH3R1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 13:27:32 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630344397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0+iCVw2IvZlDKvXr97WaRJSIP+szLJCPLi2TohXxcYQ=;
        b=rMgybfzVZDtj0ekFPTCDVBvyYcvo9MVUoVhxHDpYCLmDzoL0J0K+yYZxmDmrAj3pzPHLmK
        s+JDkv1OOcO3pCV4OG7ypAv52Kw/YNMnHK60AbYFGctWS7yXOF0odBfNR0pIunHASL52z7
        lfCjs7Wvehh6OHuELC87rrl0IYeNFNzV8GQhCzoq8Drjyfv2YKFuIDQzBhoe6bHI37OuPG
        xQ8Q8Jb6HMK7moI88WEwKzPA1wgsUWqsrPZwYD/JlP8mhcNL5fizq2czDVDbsfEqoAp5cG
        XUsNgAUGmhpJA4EyvC7v43aY5PTQkNuSniUzymEFJyDw3Tzte8bihQfbB5Swtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630344397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0+iCVw2IvZlDKvXr97WaRJSIP+szLJCPLi2TohXxcYQ=;
        b=tGnIZWk5qeRlyrYi0RBmFIJd/cdidkUyeQw0w46HA6fFdfQzJz2PokwFcTNlZ4UFvb9vSt
        DwBIpvfjO81MMwDg==
To:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marco Elver <elver@google.com>,
        Clark Williams <williams@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/5] Documentation/kcov: Define `ip' in the example.
Date:   Mon, 30 Aug 2021 19:26:24 +0200
Message-Id: <20210830172627.267989-3-bigeasy@linutronix.de>
In-Reply-To: <20210830172627.267989-1-bigeasy@linutronix.de>
References: <20210830172627.267989-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The example code uses the variable `ip' but never declares it.

Declare `ip' as a 64bit variable which is the same type as the array
from which it loads its value.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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

