Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246D53DF019
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 16:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236960AbhHCOSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 10:18:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57282 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236621AbhHCOR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:17:27 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628000235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cLNYZvkB9oPbv+OYlOENW8vHs/YtcFNEvPRXInFrNxg=;
        b=p2GZgGODoJgV6O1Gt5wTALBKfM1x5S1toYPdWsfoiln/Vm6ICCB4Spgpf9eZaZ5Gldibhs
        fNx5zTfPNm5ES8HG3U13MohTAJfS9IhF5HMGpcX0dS+zz4UJNzTNRcW2zsvSgM51I5lgg6
        YdmgafM72YuB2MzMc+SCAkulBDoqXsavenBFnjjgLIf6KfV9oUjKUbamxIkxNpapTpRruV
        pE7/q37VhZj/tjQsLAx/JiWZCft2NfsvvcjBJ8ZXT7Mb+uAd8wtRocj7XPe/AVK6oeL1qV
        g7+ooeOFptzhPLU50H6c29XlE4zp+Rwn4r6axBnRMb0H0CCF+cymZV1Gv8ML2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628000235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cLNYZvkB9oPbv+OYlOENW8vHs/YtcFNEvPRXInFrNxg=;
        b=1noN6pEqfnuvSl8tJY/49mUUk6dR81B5+AzqH5ftSWwFITHTy9aRXWxDNg7aJ0bkaSPMwv
        G7xdqdeH9hT7ogCA==
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH 35/38] torture: Replace deprecated CPU-hotplug functions.
Date:   Tue,  3 Aug 2021 16:16:18 +0200
Message-Id: <20210803141621.780504-36-bigeasy@linutronix.de>
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

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/torture.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index 0a315c387bedb..bb8f411c974b8 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -521,11 +521,11 @@ static void torture_shuffle_tasks(void)
 	struct shuffle_task *stp;
=20
 	cpumask_setall(shuffle_tmp_mask);
-	get_online_cpus();
+	cpus_read_lock();
=20
 	/* No point in shuffling if there is only one online CPU (ex: UP) */
 	if (num_online_cpus() =3D=3D 1) {
-		put_online_cpus();
+		cpus_read_unlock();
 		return;
 	}
=20
@@ -541,7 +541,7 @@ static void torture_shuffle_tasks(void)
 		set_cpus_allowed_ptr(stp->st_t, shuffle_tmp_mask);
 	mutex_unlock(&shuffle_task_mutex);
=20
-	put_online_cpus();
+	cpus_read_unlock();
 }
=20
 /* Shuffle tasks across CPUs, with the intent of allowing each CPU in the
--=20
2.32.0

