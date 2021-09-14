Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B6440B954
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 22:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbhINUfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 16:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbhINUfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 16:35:36 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A54C061574;
        Tue, 14 Sep 2021 13:34:18 -0700 (PDT)
Received: from zn.tnic (p200300ec2f104800104a7ca086fcfa54.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:4800:104a:7ca0:86fc:fa54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D40BA1EC0298;
        Tue, 14 Sep 2021 22:34:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631651657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=ho0dIkyXb9rhQ4ltF8xF/Fh/kKjZFTuUyHYcmevz7B4=;
        b=mFAnc9V6M98Xy3oMHBpkH8puEf9GQ4HT6tCOMvcz22KIL9BnyevbDohEJ8tTUH/g+OODfq
        O5n3/1zLTzv7YcAnB3qfsu3R3UndsBwSi//8U3d2kzNDuiLtaIU6Ie853ibz75ZxPnPblM
        zft0USk3XtqZ/+D7z+UBI6J0V6jmh1k=
From:   Borislav Petkov <bp@alien8.de>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Documentation/no_hz: Introduce "dyntick-idle mode" before using it
Date:   Tue, 14 Sep 2021 22:33:55 +0200
Message-Id: <20210914203355.21360-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

The CONFIG_NO_HZ_IDLE paragraph is using "dyntick-idle mode" before
having defined it while the definition comes a couple of paragraphs
later.

That is leaving the reader with scratching head what that dyntick-idle
mode might be. Pull its definition up so that it is clear.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 Documentation/timers/no_hz.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/timers/no_hz.rst b/Documentation/timers/no_hz.rst
index 6cadad7c3aad..20ad23a6c618 100644
--- a/Documentation/timers/no_hz.rst
+++ b/Documentation/timers/no_hz.rst
@@ -70,6 +70,10 @@ interrupt.  After all, the primary purpose of a scheduling-clock interrupt
 is to force a busy CPU to shift its attention among multiple duties,
 and an idle CPU has no duties to shift its attention among.
 
+An idle CPU that is not receiving scheduling-clock interrupts is said to
+be "dyntick-idle", "in dyntick-idle mode", "in nohz mode", or "running
+tickless".  The remainder of this document will use "dyntick-idle mode".
+
 The CONFIG_NO_HZ_IDLE=y Kconfig option causes the kernel to avoid sending
 scheduling-clock interrupts to idle CPUs, which is critically important
 both to battery-powered devices and to highly virtualized mainframes.
@@ -91,10 +95,6 @@ Therefore, systems with aggressive real-time response constraints often
 run CONFIG_HZ_PERIODIC=y kernels (or CONFIG_NO_HZ=n for older kernels)
 in order to avoid degrading from-idle transition latencies.
 
-An idle CPU that is not receiving scheduling-clock interrupts is said to
-be "dyntick-idle", "in dyntick-idle mode", "in nohz mode", or "running
-tickless".  The remainder of this document will use "dyntick-idle mode".
-
 There is also a boot parameter "nohz=" that can be used to disable
 dyntick-idle mode in CONFIG_NO_HZ_IDLE=y kernels by specifying "nohz=off".
 By default, CONFIG_NO_HZ_IDLE=y kernels boot with "nohz=on", enabling
-- 
2.29.2

