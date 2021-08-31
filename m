Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED583FC2E6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 08:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbhHaGj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 02:39:27 -0400
Received: from mout.gmx.net ([212.227.15.18]:33289 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236085AbhHaGj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 02:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630391900;
        bh=/SoKFDTopah3K8nfdoOpWkB/I1sNrqXnYeTxD8/0A5M=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
        b=Dknu+NnrdoedbDsZy+wD9NpICXR3xPER0GSJsjEIhu50LVGIFuk7uzUBGrEZ3qyfr
         cxVODKSTpAx79K9UR5fmELODAExRdeIvyogEzflvxceIfKA4nmbkLDN7OV2FdaiR4V
         j8ISHzZN6dKs/TToUXbtjk4s7TLNk6woHTOKtkaU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.148.177]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7R1T-1n3c4v1OJB-017n5h; Tue, 31
 Aug 2021 08:38:20 +0200
Message-ID: <50a936b7d8f12277d6ec7ed2ef0421a381056909.camel@gmx.de>
Subject: [patch] locking, rwsem: Add missing __init_rwsem() for PREEMPT_RT
From:   Mike Galbraith <efault@gmx.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>
Date:   Tue, 31 Aug 2021 08:38:19 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.41.2 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JmMFPP8aARLyvJ9I4o6aIiJBOfDa0i8M4svbPL9mC5Sa4r33H20
 FJ4vZuxRr5fnO2UEPd5c33EXtpV0LNG7dG2qie/WvW+bhGK3K+VjxhdxRBOhiz1UiSfg8Si
 ThiMXLF6vFd9yqQ0pWc8zttfaLulbmLff5PzkBpaRxDbH5ZLN5ZRLEyVlTAjazT0TC86bmx
 /3F0+5kSIoPqa7NWuL6vg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WQ7t+Afjly8=:8lCvc8Knr6aDGc2VXlQzzx
 eeqfCtsxX/J6v9ovamIMAQD/LjZI9uKr2Pi1SmxzArRP5ThpMMKHOVlJC8shuh/ytDuxhzurE
 kqxb/dRsjUZUevS7ArY+n9ufSOLB+rfzuHOTjQ6a720eJ7en0iFkBaecO38Rk3gNfhjcu5MxP
 KuUnZBMA6H/vopoP+nYI8CLSSpLzDDAbPcRB4yPuWhrgBWDYpZX6e6gf2Kxk8kC4PyCfs1ftr
 f41AfVGLMAkceDiUjYkvmAO2iQcZtPBc4JTZjZdhd2whWzGbFXsD2nYUb8IQ83OSAdw4wnwv8
 yLwAncEhx0avDGLOY+qgrZ8VPc9cqOluytL23AlJD+4wOdEgEa2D65p1nWuaJhs5QJSYQLULY
 gTYK6geWinrvebpaT9AhmNJO9JrFDmbx3hnDRkzudDhoFmdH3c7WvsxODIbKjVFOqr1XykVrv
 AT5RMWd7OZs54YBzstSb42BnkC5Cg9ba6xJsGeS+98LW+Ee3H2y0weLJzqJdTmjGhc6X86+Yj
 N5ApiGqcxdXokZrdNZZLhRoDw6oWJ3UUWdioTTdRvV820jNS7V3wsmZSLs1SDRDJ/HsmAetYA
 MHQVjq9C7H3Z+yzLUeEzHS6Z3Hp5xi1cXYWiYoEcF2eCKt+9d2aGQg0EVIDQFVZPA1HKdrn3n
 DMY2C0fSQ1488qy9CNVKcv4bxorjTXUIsKMRjMQd/X5/0SxjaYy0U4kMxMXAxfDizq74KOEAh
 EThGqCx+C3HOwtg/xOnkBRAIjnTRsVv4l2fVIY5msZGqO+12Dt9HT5E8it09uUaKjX+2HsCPR
 ge4d+z4WrfYsY+P+l5ons7JEHEzFYjEKA1zsPtWi1Yh5NHYpN328D0qJR5GlWMkoPwmCPxltb
 Hx/0BycvCt6fuAVb+LjHFyR2LtS1KBIljVf0bTPfmKlUE4+r49hxChHNSgPktem0a9VwkIOHW
 M0yr1YawvgypyXJD8fmZb8i0x4iKIFQYwtMjv8EvSJfOlXgASqieyhOG5zwfEAkhBgAHTJttE
 /EdEp7mNbVSN6MnvYcHUyLqPyucwbZgwXxhOO7crD14n/rFNIMr5f8mx2FoCUWQ0dQyejuAwY
 XjV85KC8cgb/M/3uniUpSaNzKg0prHlTY2x
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


730633f0b7f95 became the first direct caller of __init_rwsem() vs the
usual init_rwsem(), exposing PREEMPT_RT's lack thereof.  Add it.

Signed-off-by: Mike Galbraith <efault@gmx.de>
=2D--
 include/linux/rwsem.h |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

=2D-- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -152,12 +152,18 @@ static inline void  __rwsem_init(struct
 }
 #endif

+static inline void __init_rwsem(struct rw_semaphore *sem, const char *nam=
e,
+				struct lock_class_key *key)
+{
+	init_rwbase_rt(&(sem)->rwbase);
+	__rwsem_init(sem, name, key);
+}
+
 #define init_rwsem(sem)						\
 do {								\
 	static struct lock_class_key __key;			\
 								\
-	init_rwbase_rt(&(sem)->rwbase);			\
-	__rwsem_init((sem), #sem, &__key);			\
+	__init_rwsem((sem), #sem, &__key);			\
 } while (0)

 static __always_inline int rwsem_is_locked(struct rw_semaphore *sem)

