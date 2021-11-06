Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A864446C58
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 05:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbhKFEnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 00:43:45 -0400
Received: from mout.gmx.net ([212.227.17.21]:38431 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229485AbhKFEno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 00:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636173633;
        bh=GsHnJYbMlop1D6SFyQfgaVcGQxyV8lVPgvWwISk6Zco=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Ug/JtvJ7ozpWTSEqwD/GRnpQrvf5wtnk3jTktrKrfvm4yZR4ztNjgxDC7IphKbi+1
         297S+4r6xJjdGlRkWWAaGCRt5IAn/3xU87iK3N4wkCPHDC1KO3FilQ7XHDfXxIIqDK
         eA3kNrpvMVY8GNDlUCCusZkLd2ZDqvl1gX/ILQ4Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.219.101]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWzjt-1nGcLQ1At7-00XHvc; Sat, 06
 Nov 2021 05:40:33 +0100
Message-ID: <ff53a94401f8d6abe0303ee381f86bfb475ad354.camel@gmx.de>
Subject: Re: [PATCH] sched: Tweak default dynamic preempt mode selection
From:   Mike Galbraith <efault@gmx.de>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Date:   Sat, 06 Nov 2021 05:40:30 +0100
In-Reply-To: <20211105104035.3112162-1-valentin.schneider@arm.com>
References: <20211105104035.3112162-1-valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:djYVkGpAEcGX1a+DfHSdvxLBhv31aBvsC60zkktbq6J9nX0nxzn
 XbN2TFJtE949K3hpM7h3PoPDXbbggXvb+ELf7TVysrmBH45jRta67xCWSbtcdxhfMMkAbTO
 bme7qoXKroFkr1uddC0RGFMMaRwgX7Jztir5V4fwLYpoNmGLmvRjcTMs+IQ2v8eD3vrStz4
 9DBzcnK/EE4zn2Ptq68LA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lW4PAGjNHgg=:2owPdIjrS6UaWOgQVvSDk7
 9a7G71Yw21CPdZQjsVhDiErzxjGo6lVeBFHqT0X3KrXLRC9ElooEDvBDo20ezIvn1sJ5z4IPi
 PyYOg+zfmPaweP5hcQti8e5Im8wRMjj722deYY+MbwxlTi9KY2x9xBFsUcseXcHP6MmbuFtaZ
 vj5jkVYDKAXuRtLPCDMAHrkM+PbqGFy7AUKGlC3pfT6a0hfjqCt0s2NFV9X9TXkHOuObB+/ek
 qqymzRtoCYJBeru1gczyYbrmqj/REEFE6uXHdkC7rJJdOPaXVx/LUOQQSWkBGyNTN4rGdvjIF
 HU6ll8sr8Ely+FM9oGh/w2Sbl3Dv+EAWcLP/r6cTe/W/+hyZqQ1Swu8yakov/6Xyz+hDcqDNP
 JhhfzryckoQSgCiCxcnnkruaxpElev8oFGXtBBAcavnaN2rKXtWoxIDwWtpGMk8F6yIf6Qur5
 4k1kCCJX7y7ZVxVlkabbC+mVKm5rBZ1DA5fbV9RULQtOeq/nxIPOzBhnZ5T8AZO2ud67vOVlC
 l7Z5JboGg/CifeAGL4crNH70aeMZA8pW06EIZZZOGLke2KeGi5Gtn3q968r5yfjTZIEfVvnPu
 2mrKkkK9p27AiALCaQJLJRHV01pHNS+xTA3zad2Nqqr51fu4/tD9ttvu4RmeBMoInIIsb25Gs
 ESnTZnPrMVhzTVeZev06qRFqRb1IJebx+FDIVvUSJwK3z87g6fzukF30i9pQVnND74SipTh0N
 Fl6QWRJ1dKouwvNVWQoeFL1zjzJhNoPrUgEpHDT2axndD2v4cCWFvXaZbvez9KG2UcsHOJnK9
 gRZ9jVL7noRXlDgXL6diunkRE+RDXWB6v6liP9Nth4g+tqKQIPQDC7P6uyT9QlEI1l0xZPoAd
 LHRkU5Kqa3NZvvSO+A4mYTs66h2yf0QOqzTh/g7XkpgnyqKpNZhr1eAQ0bXCPwptZz+9u+iSR
 WPtFQ8XCsW0YhXNla0C46Ais/3xj8uUCLsPk94/zNkh+4FU9inOAKbYa89IOJA3ykyOEtLqSd
 dEO+dCZoZG7IvV4D9J2VJpos2PmwLS41annBamJjUOdzhxVFj+8yHvZf8GdWXtq3lIN/z7GxZ
 7P95Ls82QFQmGI=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-11-05 at 10:40 +0000, Valentin Schneider wrote:
> Commit c597bfddc9e9 ("sched: Provide Kconfig support for default dynamic
> preempt mode") changed the selectable config names for the preemption
> model. This means a config file must now select
>
> =C2=A0 CONFIG_PREEMPT_BEHAVIOUR=3Dy
>
> rather than
>
> =C2=A0 CONFIG_PREEMPT=3Dy
>
> to get a preemptible kernel. This means all arch config files need to be
> updated - right now arm64 defconfig selects CONFIG_PREEMPT=3Dy but ends =
up
> with CONFIG_PREEMPT_NONE_BEHAVIOUR=3Dy.
>
> Instead, have CONFIG_*PREEMPT be the selectable configs again, and make
> them select their _BEHAVIOUR equivalent if CONFIG_PREEMPT_DYNAMIC is set=
.


Is there any way to get to PREEMPT_RT in the first selection again as
well?  I had created a behavior entry for RT (below) and inverted the
dependency to make it appear in the initial selection again, but that's
clearly not gonna fly.

Starting with a 5.15 config, to select RT you currently must first
select a model you don't want, then reject PREEMPT_DYNAMIC and you'll
be offered the full menu of models immediately. With your patch added,
that became worse.  After rejecting PREEMPT_DYNAMIC, I had to go
through new 5.15+ options before finally being offered the full menu.

	-Mike

=2D-- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -56,10 +56,10 @@ config PREEMPT_BEHAVIOUR
 	  embedded system with latency requirements in the
milliseconds
 	  range.

-config PREEMPT_RT
+config PREEMPT_RT_BEHAVIOR
 	bool "Fully Preemptible Kernel (Real-Time)"
-	depends on EXPERT && ARCH_SUPPORTS_RT && !PREEMPT_DYNAMIC
-	select PREEMPTION
+	depends on EXPERT && ARCH_SUPPORTS_RT
+	select PREEMPT_RT
 	help
 	  This option turns the kernel into a real-time kernel by
replacing
 	  various locking primitives (spinlocks, rwlocks, etc.) with
@@ -86,6 +86,10 @@ config PREEMPT
 	select PREEMPTION
 	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK

+config PREEMPT_RT
+	bool
+	select PREEMPTION
+
 config PREEMPT_COUNT
        bool

@@ -101,7 +105,7 @@ config PREEMPT_LAZY

 config PREEMPT_DYNAMIC
 	bool "Preemption behaviour defined on boot"
-	depends on HAVE_PREEMPT_DYNAMIC
+	depends on HAVE_PREEMPT_DYNAMIC && !PREEMPT_RT
 	select PREEMPT
 	default y
 	help



