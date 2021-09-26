Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC72341881C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 12:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhIZKbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 06:31:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50900 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhIZKbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 06:31:45 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632652208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=+3GPTcPfXcV7+/seVO3xrBDQL6hUYqLGyeuyJHeSnwk=;
        b=Ww4a5DbdYInx5rTedp+Pchf0Hzgh/I2V581BhP5TKVEv91nc14Wdi+R7sHZQn4lr1nbJBV
        t5gr8hYpn92m+QfbOOaUz85qjpeAUOg3OZIkzggTQHZKVZ26544JSgib4mPbWyPy8puZfJ
        RrQnvbEqeEJ2oZ5ZTn4PM+CnYvf+dSDYNYCZzyUh6vLJjiDaVMR+/6Jom4Dc6tYIoLCCNv
        OdKDAkv1/p0qgTb6qdSkwiq+h3MdVdBp1ee7zYWU1WsarB7fgVaJuqfFlIf3wEyG2Mp7Wv
        i8SLRcQFOZjBiTuMWaoJBVT9Os9ddDiYn2BDfxzj6LhWk4bVBAXYU2+La0Hszg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632652208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=+3GPTcPfXcV7+/seVO3xrBDQL6hUYqLGyeuyJHeSnwk=;
        b=eAthlxuY7N2VQP5Z9TkN1jVPeMDclBYxFTw31OjUBCy/4ZUA2tZ+WZFAFGdoomvB//dAQ2
        hyLeXEC+1JLMtjCw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/urgent for v5.15-rc3
References: <163265189226.178609.9712455554034472888.tglx@xen13>
Message-ID: <163265189373.178609.1258692845178002939.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 26 Sep 2021 12:30:07 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-20=
21-09-26

up to:  8cd9da85d2bd: posix-cpu-timers: Prevent spuriously armed 0-value itim=
er


A single fix for the recently introduced regression in posix CPU timers
which failed to stop the timer when requested. That caused unexpected
signals to be sent to the process/thread causing malfunction.

Thanks,

	tglx

------------------>
Frederic Weisbecker (1):
      posix-cpu-timers: Prevent spuriously armed 0-value itimer


 kernel/time/posix-cpu-timers.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index ee736861b18f..643d412ac623 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1404,7 +1404,8 @@ void set_process_cpu_timer(struct task_struct *tsk, uns=
igned int clkid,
 			}
 		}
=20
-		*newval +=3D now;
+		if (*newval)
+			*newval +=3D now;
 	}
=20
 	/*

