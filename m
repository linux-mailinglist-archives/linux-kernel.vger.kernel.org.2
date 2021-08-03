Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB303DEFFC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 16:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbhHCORj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 10:17:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56910 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236503AbhHCORS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:17:18 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628000226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SXMykmwe09SoyuPYXw7zPlgWubEwNQMkAObS4tNxXwU=;
        b=KUj7K/lz7RGSA4lvpp9ny0DFJOUreLDfeBsAYUDd0JvdBVxPZPlGFUpUb2m0Yhm4/dtB/R
        0x5Gcg7lThSpNIdlm+cxUhv8XYXGiUdIbtCIHz/Vv8JabmCFUKrqvzOv2+bIGKt5K2os8H
        BFVBqBUjyPjcZtMNgmZThkb6egWAYYzmMKxQEUPUsTWjymxWDR+IbB1xV5E7fVErh7cJln
        2q4gYi+kED09KW9i0Gm1e79fh5drjNbsrIiTMe9CCa7+ZJ2frFBLwWylHT0/syXHjnlgFD
        0cnjeQQIUZSCLBrB0J1q9caWjsMFko7jnJn8PnsaTCseKTrzQVynDuT/bQRFDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628000226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SXMykmwe09SoyuPYXw7zPlgWubEwNQMkAObS4tNxXwU=;
        b=RTCW4iRqOXlPxF44FEsfc7iVnWT5OnK4bQag/Ioo/sdMsAjRP3ZWGUTAgvqiPDYNBOVKM3
        N5Ui/kUr5MCvFjBw==
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 07/38] x86/mtrr: Replace deprecated CPU-hotplug functions.
Date:   Tue,  3 Aug 2021 16:15:50 +0200
Message-Id: <20210803141621.780504-8-bigeasy@linutronix.de>
In-Reply-To: <20210803141621.780504-1-bigeasy@linutronix.de>
References: <20210803141621.780504-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions get_online_cpus() and put_online_cpus() have been
deprecated during the CPU hotplug rework. They map directly to
cpus_read_lock() and cpus_read_unlock().

Replace deprecated CPU-hotplug functions with the official version.
The behavior remains unchanged.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kernel/cpu/mtrr/mtrr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtr=
r.c
index a76694bffe86a..2746cac9d8a94 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -336,7 +336,7 @@ int mtrr_add_page(unsigned long base, unsigned long siz=
e,
 	replace =3D -1;
=20
 	/* No CPU hotplug when we change MTRR entries */
-	get_online_cpus();
+	cpus_read_lock();
=20
 	/* Search for existing MTRR  */
 	mutex_lock(&mtrr_mutex);
@@ -398,7 +398,7 @@ int mtrr_add_page(unsigned long base, unsigned long siz=
e,
 	error =3D i;
  out:
 	mutex_unlock(&mtrr_mutex);
-	put_online_cpus();
+	cpus_read_unlock();
 	return error;
 }
=20
@@ -485,7 +485,7 @@ int mtrr_del_page(int reg, unsigned long base, unsigned=
 long size)
=20
 	max =3D num_var_ranges;
 	/* No CPU hotplug when we change MTRR entries */
-	get_online_cpus();
+	cpus_read_lock();
 	mutex_lock(&mtrr_mutex);
 	if (reg < 0) {
 		/*  Search for existing MTRR  */
@@ -520,7 +520,7 @@ int mtrr_del_page(int reg, unsigned long base, unsigned=
 long size)
 	error =3D reg;
  out:
 	mutex_unlock(&mtrr_mutex);
-	put_online_cpus();
+	cpus_read_unlock();
 	return error;
 }
=20
--=20
2.32.0

