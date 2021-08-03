Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009F33DF008
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 16:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236652AbhHCOSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 10:18:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56924 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236558AbhHCORV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:17:21 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628000230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vHabQefH2FPUhUMzFR0iH1dddTvgZu2r+WggUoQp5Qo=;
        b=A4Vwczf3REWTRZnizJgfYUhD6g2AultF+vjUOZktN2aTHIKBZv8liB8+EDUgtAWMBiPdt5
        zK+dK9FlqpnTLw9YZOaYY1L2fjthjIC1u2mg1LTXCcI41IR7arKuzR7JyLKm2W2B9N7Sig
        MOWEWm+ZHC8DE3GbW8IxwrdzCVuBEWkjkNVT1QyOluJnkV0aWs7ZSRsmkruKj7FwTasUCB
        rctfke6TgOnSLjPwlNGBY0GktufR79ppdTi9knNYiKAgIGFoXU6BpemIRtz9umuFRp+F2E
        XegTdoRvSsTgb0TXmON3SR0fIWKME9rb8GSKcmJRxjDKh/fAwW7NLKkXffF5pQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628000230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vHabQefH2FPUhUMzFR0iH1dddTvgZu2r+WggUoQp5Qo=;
        b=aALK883ByLn1nRl09mL4lz7+y8Izjd4TpkT8CSMm4G2TmFYnkdOTSQ4l5VeDLBZzGg2hR0
        Trt5Qg8aLY3v4BDQ==
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 17/38] platform/x86: Replace deprecated CPU-hotplug functions.
Date:   Tue,  3 Aug 2021 16:16:00 +0200
Message-Id: <20210803141621.780504-18-bigeasy@linutronix.de>
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

Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mark Gross <mgross@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/platform/x86/dell/dcdbas.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/dell/dcdbas.c b/drivers/platform/x86/dell=
/dcdbas.c
index 28447c180be88..5e63d62250481 100644
--- a/drivers/platform/x86/dell/dcdbas.c
+++ b/drivers/platform/x86/dell/dcdbas.c
@@ -278,9 +278,9 @@ int dcdbas_smi_request(struct smi_cmd *smi_cmd)
 	}
=20
 	/* SMI requires CPU 0 */
-	get_online_cpus();
+	cpus_read_lock();
 	ret =3D smp_call_on_cpu(0, raise_smi, smi_cmd, true);
-	put_online_cpus();
+	cpus_read_unlock();
=20
 	return ret;
 }
--=20
2.32.0

