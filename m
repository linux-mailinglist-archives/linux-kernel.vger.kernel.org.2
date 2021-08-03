Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54373DF00B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 16:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236562AbhHCOSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 10:18:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56910 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236546AbhHCORV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:17:21 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628000229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VREIiyPB44EOoA48Hgenjjr9/qg/9YBkMbLcGe4Ifxc=;
        b=MP/FrbkMnSZirNvCz/eSh7rmt6Kfps13//1GT/d1sUGObeQ3IJZBLz4iP53RsSGViwMqf9
        DQfh2eR8o/jsNjd6MIIFpOX0tTOosCzq8JY3Ed1Bp1BMYwhnOSnJSZI4gmF1Jg9rNtsMUy
        gQZAHOTTRzziBQ7s7RW0XMcxjGtmL50f9Q9p7wqMo3O7W2XSTQj8mTVDxOXq4tYFe1tBTf
        SDRFCo5pCqj1qErhihHyvIO7sZXBHXQhRhksFAbiwuxSHMMX1qci00vLOlfxjYbIGne6HH
        k59GKVAr/9tDkHel1yBwp8MxBlvFtkFOrUO1rC7zB+Z/sNuVL2v4keCuOUbpTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628000229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VREIiyPB44EOoA48Hgenjjr9/qg/9YBkMbLcGe4Ifxc=;
        b=7LMkNTETBbeh+KxxNNf7KJWthuJ3w788acZientu0FcEkqE8rzIAxWZnDZJVmfMdyXXx3S
        FwhX492j4K0VsRCg==
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Robin Holt <robinmholt@gmail.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 16/38] sgi-xpc: Replace deprecated CPU-hotplug functions.
Date:   Tue,  3 Aug 2021 16:15:59 +0200
Message-Id: <20210803141621.780504-17-bigeasy@linutronix.de>
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

Cc: Robin Holt <robinmholt@gmail.com>
Cc: Steve Wahl <steve.wahl@hpe.com>
Cc: Mike Travis <mike.travis@hpe.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/misc/sgi-xp/xpc_uv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/sgi-xp/xpc_uv.c b/drivers/misc/sgi-xp/xpc_uv.c
index 7791bde81a368..ba9ae0e2df0fe 100644
--- a/drivers/misc/sgi-xp/xpc_uv.c
+++ b/drivers/misc/sgi-xp/xpc_uv.c
@@ -1742,7 +1742,7 @@ xpc_init_mq_node(int nid)
 {
 	int cpu;
=20
-	get_online_cpus();
+	cpus_read_lock();
=20
 	for_each_cpu(cpu, cpumask_of_node(nid)) {
 		xpc_activate_mq_uv =3D
@@ -1753,7 +1753,7 @@ xpc_init_mq_node(int nid)
 			break;
 	}
 	if (IS_ERR(xpc_activate_mq_uv)) {
-		put_online_cpus();
+		cpus_read_unlock();
 		return PTR_ERR(xpc_activate_mq_uv);
 	}
=20
@@ -1767,11 +1767,11 @@ xpc_init_mq_node(int nid)
 	}
 	if (IS_ERR(xpc_notify_mq_uv)) {
 		xpc_destroy_gru_mq_uv(xpc_activate_mq_uv);
-		put_online_cpus();
+		cpus_read_unlock();
 		return PTR_ERR(xpc_notify_mq_uv);
 	}
=20
-	put_online_cpus();
+	cpus_read_unlock();
 	return 0;
 }
=20
--=20
2.32.0

