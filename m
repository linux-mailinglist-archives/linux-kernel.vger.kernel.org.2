Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7DB44AC2F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 12:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241477AbhKILDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 06:03:40 -0500
Received: from mout.gmx.net ([212.227.15.18]:54537 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245558AbhKILDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 06:03:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636455640;
        bh=62ftpv2VMnexWpmR2fpAxm+6oGbrF+UemsQVFhDCY6g=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=BcdncYqApOrg01Riy/Zgl7nRjTAalLcXCgS7Sbe1tUG2jCacR+p48vymmEDdVJz+g
         tnCHPChaXT1X5zOKVUrKKGgJiAIVoSbpLiNg9iibGNzvrrJD+7o63zwJm6UgNrA0mT
         wmBtqIhKm28CL+1f3KkpJpuw2+sVy25/R/UwdvIU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([212.114.172.107]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNbkv-1n3qip09DH-00P25B; Tue, 09
 Nov 2021 12:00:40 +0100
Message-ID: <1905cf613576d04f585d752d85ce21a3504a40d6.camel@gmx.de>
Subject: Re: [PATCH] sched: Tweak default dynamic preempt mode selection
From:   Mike Galbraith <efault@gmx.de>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Date:   Tue, 09 Nov 2021 12:00:39 +0100
In-Reply-To: <87wnlhsljd.mognet@arm.com>
References: <20211105104035.3112162-1-valentin.schneider@arm.com>
         <ff53a94401f8d6abe0303ee381f86bfb475ad354.camel@gmx.de>
         <8735o6uca5.mognet@arm.com>
         <5543627ee8ac5337a74de4b9671240d617273607.camel@gmx.de>
         <87zgqesmej.mognet@arm.com>
         <a8540176424035960b12529c06d5a3dcedd57c77.camel@gmx.de>
         <87wnlhsljd.mognet@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S2ChmoqAhF/wSZmH/+1g4gGArq0DafgLj7kW1ENXCr3Y8GXmlCy
 SID41GEHJ2XzQKgHe5+tbGY5zPRnrVzdh9pbMRbKkvSkItfJB6lgJlJiObgVj5akzwygytq
 bTM1K7FpvSDujVgfxknR/bPzdOpHD2E8BBY+p3SwtVwUdyZVysIE9zHLaHlOD/ya90tSBj5
 kF81DuMnqe/12+qk1P0YQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wTaGWMbwtII=:wR2mQFDRHNKqw8vpugLpe7
 ee2EiMVRHx2u86u7lthcHXgJYJaz177A/d/7fAx84wUcZ4n8hGPTW4hn6KHO5/OC+4+rTqobK
 emLHE0F8+HeBZrFMklPbAhfXHRDfQIPHjOxbffFxJVQ8zEbOr4pke8Ein8iPb18HbCb5N0TCh
 c5oSfdDIRDH5C4wakSGlJB8QkHwa8JF/uALxZ09ppYKj3naN22SLqc7aodALlyXGVEH1Xpt4E
 iIG0v4uDV5bfuDObEMJt0algyo//mjBc3pTrsdLdny4ktfzsGiiyYYkABcLfHPjsFpYlKluuS
 vvvdcAJYTK6CuJE/OWpShIN56TV7pnklr7cB+D8HJ8Rtemo4/SkBWxxmmrFMLOTNnA/F3ogjY
 GszJZKM1bVEtM81smi8RuYDHD51sPpxMmZfuSBuiU0w1sVeGXi1cu7OyERpoj8dBkJ+ZO76f5
 NhdaYzF0oL9PUmsOS+VA7kntb3hsxvKDN0DIbAICpetRiC95Kv0SknsGCjKNG3sSpWtktTAvt
 mrWmwBDeDNA01ng/iiT3fjerVJBWqn3Ia4Li2x3/CSE8fSXalVskZOOkyrPsnOkhjeacWaRnl
 b69jbuM9DRfQACjhT/2aVzWZl/9mmpoPYs6spiPkvVpBUE7YcxdZcihRH3jwM1mEN0tXN7Rsh
 F95U7DVl1K1rhbBh5XwPgov1y1tpKML7fN+RENfoA29GTob9V4NWyv/X8FYuPamEiRSWtaDKg
 4LBdUeFjLkN9qJxdDz/0fzKqiPlGGs1X8Ml/sLkHhuDHMpbaSL5rgmcZAZgDXQgD0fyi3V/mz
 ZqJfjIHrYiMaDahkFxS0mxRxfCwEDyq252IawmSLreY1qiQUp75mnMj+cyLgxUZ0u5vqkdpLt
 M+oam5R3Xxyp78304Hf4P840OnPZfxWm8gRWgR2DzJelhgYgGA5hnHhJf7Mapi5ooXLVoCH/k
 KhVQutoIopVfcSlgr2PEPyWo676XwvqPAe4mrvn8QHojzNSk/HlG0EnWKhW/DOd0PQpLm5Ezs
 8nZEy1UN0KAixPX0WmFLEvLUuB2TeG7LnXvO31EBqMRw9trYk0n55oHonVakAEybR4xa5o5of
 k6FZ07AMwNr/io=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-11-09 at 09:52 +0000, Valentin Schneider wrote:
> On 09/11/21 06:30, Mike Galbraith wrote:
> > Not seeing your v2 land yet, I grabbed my mallet and had a go at goal
> > reconciliation over morning java.=C2=A0 Non-lovely result seems to wor=
k.
> >
>
> Yeah so I went down a debatable path, gave up on that and started someth=
ing
> different, and gave up on that because it was late :-)
>
> Now interestingly my second attempt is pretty close to what you have
> below.

Well that's a shame, because while it seems to function, it also puts
PREEMPT_DYNAMIC in a pretty darn similar spot to the one PREEMPT_RT was
in.  Drat.

> > sched, Kconfig: Fix preemption model selection
> >
> > Switch PREEMPT_DYNAMIC/PREEMPT_RT dependency around so PREEMPT_RT
> > can be selected during the initial preemption model selection.
> > Further, since PREEMPT_DYNAMIC requires PREEMPT, make it depend
> > upon it instead of selecting it, and add a menu to allow selection
> > of the boot time behavior, this to allow arches that do not support
> > PREEMPT_DYNAMIC to retain their various configs untouched.
> >
>
> Have some nits below, but otherwise where I stand right now I think it's
> the least ugly way of tackling this :)

We're supposed to be going for _least_ ugly?  Oh ;)  This is really a
job for someone who knows their way around Kconfig-land, but since I'm
not hearing "Yawn, here ya go", it gets whacked with a mallet until one
of us gives up.

I'm looking at two straight up choice sets, one for those who have and
want PREEMPT_DYNAMIC, and another for the rest of us.  Unfortunately,
there's no "else", so I end up with this mess, which would likely be
better served by "source foo/bar".

=2D--
 kernel/Kconfig.preempt |   90 +++++++++++++++++++++++++++++--------------=
------
 1 file changed, 54 insertions(+), 36 deletions(-)

=2D-- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -2,11 +2,41 @@

 choice
 	prompt "Preemption Model"
-	default PREEMPT_NONE_BEHAVIOUR
+	default PREEMPT_STATIC

-config PREEMPT_NONE_BEHAVIOUR
+config PREEMPT_STATIC
+	bool "Preemption behaviour defined at build"
+
+config PREEMPT_DYNAMIC
+	bool "Preemption behaviour defined on boot"
+	depends on HAVE_PREEMPT_DYNAMIC && !ARCH_NO_PREEMPT
+	select PREEMPT
+	select PREEMPTION
+	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
+	help
+	  This option allows to define the preemption model on the kernel
+	  command line parameter and thus override the default preemption
+	  model defined during compile time.
+
+	  The feature is primarily interesting for Linux distributions which
+	  provide a pre-built kernel binary to reduce the number of kernel
+	  flavors they offer while still offering different usecases.
+
+	  The runtime overhead is negligible with HAVE_STATIC_CALL_INLINE enable=
d
+	  but if runtime patching is not available for the specific architecture
+	  then the potential overhead should be considered.
+
+	  Interesting if you want the same pre-built kernel should be used for
+	  both Server and Desktop workloads.
+endchoice
+
+if PREEMPT_STATIC
+choice
+	prompt "Preemption Flavor"
+	default PREEMPT_NONE
+
+config PREEMPT_NONE
 	bool "No Forced Preemption (Server)"
-	select PREEMPT_NONE if !PREEMPT_DYNAMIC
 	help
 	  This is the traditional Linux preemption model, geared towards
 	  throughput. It will still provide good latencies most of the
@@ -18,10 +48,9 @@ config PREEMPT_NONE_BEHAVIOUR
 	  raw processing power of the kernel, irrespective of scheduling
 	  latencies.

-config PREEMPT_VOLUNTARY_BEHAVIOUR
+config PREEMPT_VOLUNTARY
 	bool "Voluntary Kernel Preemption (Desktop)"
 	depends on !ARCH_NO_PREEMPT
-	select PREEMPT_VOLUNTARY if !PREEMPT_DYNAMIC
 	help
 	  This option reduces the latency of the kernel by adding more
 	  "explicit preemption points" to the kernel code. These new
@@ -37,10 +66,11 @@ config PREEMPT_VOLUNTARY_BEHAVIOUR

 	  Select this if you are building a kernel for a desktop system.

-config PREEMPT_BEHAVIOUR
+config PREEMPT
 	bool "Preemptible Kernel (Low-Latency Desktop)"
 	depends on !ARCH_NO_PREEMPT
-	select PREEMPT
+	select PREEMPTION
+	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
 	help
 	  This option reduces the latency of the kernel by making
 	  all kernel code (that is not executing in a critical section)
@@ -58,7 +88,7 @@ config PREEMPT_BEHAVIOUR

 config PREEMPT_RT
 	bool "Fully Preemptible Kernel (Real-Time)"
-	depends on EXPERT && ARCH_SUPPORTS_RT && !PREEMPT_DYNAMIC
+	depends on EXPERT && ARCH_SUPPORTS_RT
 	select PREEMPTION
 	help
 	  This option turns the kernel into a real-time kernel by replacing
@@ -74,17 +104,26 @@ config PREEMPT_RT
 	  require real-time guarantees.

 endchoice
+endif # PREEMPT_STATIC

-config PREEMPT_NONE
+if PREEMPT_DYNAMIC
+config PREEMPT
 	bool

-config PREEMPT_VOLUNTARY
-	bool
+choice
+	prompt "Boot Time Preemption Flavor"
+	default PREEMPT_NONE_BEHAVIOR

-config PREEMPT
-	bool
-	select PREEMPTION
-	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
+config PREEMPT_NONE_BEHAVIOR
+	bool "No Forced Preemption (Server)"
+
+config PREEMPT_VOLUNTARY_BEHAVIOR
+	bool "Voluntary Kernel Preemption (Desktop)"
+
+config PREEMPT_BEHAVIOR
+	bool "Preemptible Kernel (Low-Latency Desktop)"
+endchoice
+endif # PREEMPT_DYNAMIC

 config PREEMPT_COUNT
        bool
@@ -93,27 +132,6 @@ config PREEMPTION
        bool
        select PREEMPT_COUNT

-config PREEMPT_DYNAMIC
-	bool "Preemption behaviour defined on boot"
-	depends on HAVE_PREEMPT_DYNAMIC
-	select PREEMPT
-	default y
-	help
-	  This option allows to define the preemption model on the kernel
-	  command line parameter and thus override the default preemption
-	  model defined during compile time.
-
-	  The feature is primarily interesting for Linux distributions which
-	  provide a pre-built kernel binary to reduce the number of kernel
-	  flavors they offer while still offering different usecases.
-
-	  The runtime overhead is negligible with HAVE_STATIC_CALL_INLINE enable=
d
-	  but if runtime patching is not available for the specific architecture
-	  then the potential overhead should be considered.
-
-	  Interesting if you want the same pre-built kernel should be used for
-	  both Server and Desktop workloads.
-
 config SCHED_CORE
 	bool "Core Scheduling for SMT"
 	depends on SCHED_SMT




