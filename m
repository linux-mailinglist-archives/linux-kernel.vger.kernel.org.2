Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2003DF016
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 16:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbhHCOSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 10:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236614AbhHCOR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:17:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C8AC06179A
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 07:17:13 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628000232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bfxZiNldPepJ7Rqo+8epiZj524jWZLUPNw0ku3jMnp0=;
        b=BY1FoGiw0wVOv2SFMb4myN1pM8JlgfmGuV1efeazX1l6RAlFsOSvxSZXJtOXeF1PkY1sqi
        epBjMWtyxsG4hOfrHt1qlm5/lFfutkzVA4MQMXY5s7J7IMvuonTlHANdDwnJuYr9/g6Ykb
        r7C2cNdlUmyjP0rO9k/NUFvDMRikwiMTGVDWBKhTY3mJsEk6NAsuOIaiEeo3rAhQGOeYxE
        erxnrjJec1EhC6p3Z/mkVajq1b3pmkiRBGUEjlOzI5GOyiX4B9kjFWr4fkheHE5MkYWn4c
        Seoax97iqGJP1IcWjAWI0/1ThjOaqn27H3AXxWGWJWpNtih5LIgPCihpxKUkxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628000232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bfxZiNldPepJ7Rqo+8epiZj524jWZLUPNw0ku3jMnp0=;
        b=9H8KMO24qDxpfI2H1WuHsGU3JlSZjJ1MfdHYRmPe6VEAJjvFf6cxZrAaeFG8wtmr5YxWkU
        a3HGunNnxbOY3aCg==
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 25/38] genirq/affinity: Replace deprecated CPU-hotplug functions.
Date:   Tue,  3 Aug 2021 16:16:08 +0200
Message-Id: <20210803141621.780504-26-bigeasy@linutronix.de>
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
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/irq/affinity.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 4d89ad4fae3bb..f7ff8919dc9bb 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -355,7 +355,7 @@ static int irq_build_affinity_masks(unsigned int startv=
ec, unsigned int numvecs,
 		goto fail_npresmsk;
=20
 	/* Stabilize the cpumasks */
-	get_online_cpus();
+	cpus_read_lock();
 	build_node_to_cpumask(node_to_cpumask);
=20
 	/* Spread on present CPUs starting from affd->pre_vectors */
@@ -384,7 +384,7 @@ static int irq_build_affinity_masks(unsigned int startv=
ec, unsigned int numvecs,
 		nr_others =3D ret;
=20
  fail_build_affinity:
-	put_online_cpus();
+	cpus_read_unlock();
=20
 	if (ret >=3D 0)
 		WARN_ON(nr_present + nr_others < numvecs);
@@ -505,9 +505,9 @@ unsigned int irq_calc_affinity_vectors(unsigned int min=
vec, unsigned int maxvec,
 	if (affd->calc_sets) {
 		set_vecs =3D maxvec - resv;
 	} else {
-		get_online_cpus();
+		cpus_read_lock();
 		set_vecs =3D cpumask_weight(cpu_possible_mask);
-		put_online_cpus();
+		cpus_read_unlock();
 	}
=20
 	return resv + min(set_vecs, maxvec - resv);
--=20
2.32.0

