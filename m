Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27D03150BE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 14:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbhBINsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 08:48:52 -0500
Received: from mout.gmx.net ([212.227.15.19]:58149 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231673AbhBINra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 08:47:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612878338;
        bh=admcaJp4Uz3+ZJbxtH/AqGs9NeOjaajOjE/h3qJZBzE=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
        b=B2BXdSVO2bNIJP9MYxe7JXCnMf3HEfk2m1GGcIQ7HTppJgektB23wwJVjuD6OOE+U
         xez6enuFuwdae7ZgaceWgAnMfg4EgvIV70G10rPD4iCLLKa/bAfbNcIHMeus2HMSkE
         neNxIZrkG4RZchsiluokPW5EvnfqoQxU6jFz87yg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.148.88]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOzOw-1lYpqw0g2u-00PP0Z; Tue, 09
 Feb 2021 14:45:38 +0100
Message-ID: <7d129a84b0858fd7fbc3e38ede62a848fbec536e.camel@gmx.de>
Subject: [patch] preempt: select PREEMPT_DYNAMIC under PREEMPTION instead of
 PREEMPT
From:   Mike Galbraith <efault@gmx.de>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@kernel.org>
Date:   Tue, 09 Feb 2021 14:45:37 +0100
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0VCliuVaMqfWwF8P1IJO7Y+n2JoVcpThqT7JcUoIHIZwO60ELMU
 uhhf6oxIufRGr3loYeNylEP4sfybBKqutKBsuow2MCoonKSm/EwouokP1zn7Jz2yblbjuOc
 1QxYMDP5MLFtdegSTSyFFIY7GJ/S6e8Bv2r7m1995fSchXMvpbTUb6t5vipykfahrmOIACk
 P+4retBriPJXqgciG5+pA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nGqcZDAQhj4=:u3p65axHNVTieljjMwCloC
 1zOprnq79CFsLv3JJ2UfLaIOlodoWEhZnzCuHhngz3Jzza1hKQ+pkypu3sJUYJeZaJ5cmTBy4
 nlYBXZ/zO0z1W7tI0f7j1JzPOTtGLc6MeY7rHZe5F3coahmqc1UF0ZMoMkskyK2XkYFIYW1/h
 OzXUoeVuhQo/GOWgL0Ed1qTE7xd5BgtyZpaq/EMfN6bTXebkJWS/RoF7I5msQBk9i3bXsRU96
 ncBbFGmg25DsRV2ZF7X72z6F6/jXfAp0/dbtiG1/BzlVcbIOWfyD5VzsKGzy1pdTZbjEDAUwI
 GLCgP1JEi3k8627asInO5QJled9z465tUGpcje0iZPxNbRxAtPSFUMp9gDTwdcOcF/di7yoxo
 wiL8nmF1ho0HDIwo561NRlxxUVuH15em4KAc0OcOg6JbBXHpH2VTirlMEWuPXWmHZ23pdaRlO
 Mnn7uEiS4K74X3M6fXLxXUbDaVA+onHOMWkYkeur+7rtbwAXJGgRofNRBoahIWqiKmaDo5a1j
 IsqtIturpsMZVHvttrhaouI9juoXUatK5IcDDo0xQuJPlDuHA2FJ/5kE9U7eCHjvGnEt06Z3Q
 DHqotkmFEW+F9NYzXCMVBYxn9wb7uIFACINuxKUp1kyyS8y5Kh7gv2eOKJbQYbaowYxFRZUkO
 O00qp5fMX8N6ovKoVhfNOymHHiEKnrKmFt5EXu2IGmV9o3QDbBv/ZRNYcOSKILp85g3gHIoae
 2iwFpbrxkDDGYBRbfbWDMAcAhavyscKz4q8Qddf8Sf6RJBYMGSG1VNH7hXwVBiCXbpiTjHXPJ
 ShiCWS7b/s3jier1iiE30slIPCLtu3bDUSiuvvg/RmP9puYjgxO00UAOskD2tn0VBsCzYAxba
 KqGKMAxAyvXFOs4LVi3g==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


PREEMPT_RT and PREEMPT both needs PREEMPT_DYNAMIC to build, so move
selection of PREEMPT_DYNAMIC to the common denominator, PREEMPTION.

Signed-off-by: Mike Galbraith <efault@gmx.de>
=2D--
 kernel/Kconfig.preempt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

=2D-- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -40,7 +40,6 @@ config PREEMPT
 	depends on !ARCH_NO_PREEMPT
 	select PREEMPTION
 	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
-	select PREEMPT_DYNAMIC if HAVE_PREEMPT_DYNAMIC
 	help
 	  This option reduces the latency of the kernel by making
 	  all kernel code (that is not executing in a critical section)
@@ -81,6 +80,7 @@ config PREEMPT_COUNT
 config PREEMPTION
        bool
        select PREEMPT_COUNT
+       select PREEMPT_DYNAMIC if HAVE_PREEMPT_DYNAMIC

 config PREEMPT_DYNAMIC
 	bool

