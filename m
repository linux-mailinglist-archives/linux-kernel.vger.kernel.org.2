Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F60831618B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 09:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhBJIz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 03:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbhBJIxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:53:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447EEC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 00:52:57 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612947175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eaL55WDEu5En7gCivD02gQJ8keMVutHEZeJruCL7b2s=;
        b=p+rxMZyqoBFKkrGrCKmrN1HymV8CtGLigN4eaip9dxben7I0GZ4oQ6llCJyDx0yfLJ906o
        YMJlGOuDcCpH4VvTOO36bNaT2d0z2tJYUGRvOPF89MwKLVzgMYJ/XXKiOUonQjrrWDm9ui
        8zoozEYQK7MnZuYUpC+NX4W5Gm920D+dd8DEDNUigui974W5BrzgFDm3dmTZj2Fk575WLb
        2MQIwtiWOf1X0WHDA5xHkpyiPWw9GxBBBEUMHMk3mEew4saAS+gMZIekIYB5cuxuHxJIFN
        hj+yqY/AlYl1tL//khJkyjhpaOaAJlQFXWF6G0AkXMkhcKKN9d7/mQZ8/q/Mpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612947175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eaL55WDEu5En7gCivD02gQJ8keMVutHEZeJruCL7b2s=;
        b=Tg0MmEmwjRIcsRbhH2YSa5ldweQZqllUmsyeao7MXTDPxNUmG6FhEYoWYfRf3hBMPJj7VW
        vOCI5F8E/HKDMOBA==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/2] checkpatch: Don't check for mutex_trylock_recursive()
Date:   Wed, 10 Feb 2021 09:52:48 +0100
Message-Id: <20210210085248.219210-3-bigeasy@linutronix.de>
In-Reply-To: <20210210085248.219210-1-bigeasy@linutronix.de>
References: <20210210085248.219210-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mutex_trylock_recursive() has been removed from the tree, there is no
need to check for it.

Remove traces of mutex_trylock_recursive()'s existence.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 scripts/checkpatch.pl | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1afe3af1cc097..4b2775fd31d9d 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7062,12 +7062,6 @@ sub process {
 			}
 		}
=20
-# check for mutex_trylock_recursive usage
-		if ($line =3D~ /mutex_trylock_recursive/) {
-			ERROR("LOCKING",
-			      "recursive locking is bad, do not use this ever.\n" . $herecurr);
-		}
-
 # check for lockdep_set_novalidate_class
 		if ($line =3D~ /^.\s*lockdep_set_novalidate_class\s*\(/ ||
 		    $line =3D~ /__lockdep_no_validate__\s*\)/ ) {
--=20
2.30.0

