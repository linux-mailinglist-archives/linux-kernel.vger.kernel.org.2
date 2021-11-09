Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E7B44A64E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 06:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240204AbhKIFds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 00:33:48 -0500
Received: from mout.gmx.net ([212.227.17.22]:55275 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232345AbhKIFdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 00:33:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636435849;
        bh=ZMrkrBpKvxlczxXVj4vNL0N8tOeMjAJbOSxcqrr8MNU=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=huDwumy6/Dao7iXXeSlcYLzDW5pBxNRE1kVHn6rmP8Wd2uFUD2hLvO40EqcHaseRh
         TyAO35k8znkiy9PJq4WfzGIHAT1i4HlUuOpTHeTcei0P98Pq3FICAp44yN8EE8W/O4
         FGPllxoYlfBIKYoZNoImidyjfIQAA0It6EKosaoQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([212.114.172.107]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMobU-1n353d0dVc-00Ikzy; Tue, 09
 Nov 2021 06:30:49 +0100
Message-ID: <a8540176424035960b12529c06d5a3dcedd57c77.camel@gmx.de>
Subject: Re: [PATCH] sched: Tweak default dynamic preempt mode selection
From:   Mike Galbraith <efault@gmx.de>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Date:   Tue, 09 Nov 2021 06:30:47 +0100
In-Reply-To: <87zgqesmej.mognet@arm.com>
References: <20211105104035.3112162-1-valentin.schneider@arm.com>
         <ff53a94401f8d6abe0303ee381f86bfb475ad354.camel@gmx.de>
         <8735o6uca5.mognet@arm.com>
         <5543627ee8ac5337a74de4b9671240d617273607.camel@gmx.de>
         <87zgqesmej.mognet@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yFcETMee3mvpRFSnQPqt/dgPIKCbir+pQFkoMQPUv+nRTNVH2Uj
 hRwNxIkwrx0q21lHgbw5T976LIX7ddFjQris3B9Uh4bJCX3wyXip4ifB9xyD02fUtijFSRm
 cE4LIDClQAKHxR3u8TmkxW9PEkVBg/GNLBChIVybeRjeX0H5HrIiIVjCX8t83d/4lqhaSXS
 ir/g8dEE9s54N00Kaqdgg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VHx6FxrwtFM=:ed2L6EZhLCV0nl2E/lrcNY
 QnNo9Lbj7G5Wp+4sm/CzaY5cYUO3ml0vt/GrGV/Zjq8qiP6m0tpEm3ENAUeSBQDmg7hQd7LU+
 +y2D70bcMxXAbamLpzCKSulJVvjUL9I254jYfQcYcfV43eG7kQrSdJLojyMjTUKPGGvQVGEnq
 YWwbit81NXWTtSlZJES6x/KI895tVu4/kHnjvcntUPJoPbGPqJi9rgsyzmi+szPVrmVJFjj5T
 JDqpwoG1AfFb0ufSxaixyZLhjSD2BX42jS6HhQOlRA7Cwv9SOJ4SXyZcupY3CP5LxHx3/CD5s
 D4qxQVlmhKwfyW9kGmfc8+iDSJj4zdJq9GjDoaSlZqd0BeRNS6RKDNpVZyvmDNUOqD91pPuZP
 Mdu+Uj7sADKOgoZaF+lMspeB/R5IRo5QJL9mAFJ/2d1mC9dqD/2sOtaekRhDoME/RRwvP9Tm2
 bPvRomzvIDpbyVSz/gYa/1HJFbWM/9qVva15l6UBQQpGZBNXQE3Pw4+XRLL4ZFIS2pewwHB7e
 N5XloaLdBkofvzCjrR4/aHzysyqmpauh+l5LKfGB4jNeFDQY7PM8iqJnkMgSgoPqZhHVBHYRl
 GOG9sI2cZYzdoSwOhpjy38rCge8lQX+y811nBTVx+d20qFe3rs9j4gesSLzvhbEW74VnNrAAt
 69bwX5AgOEAfyz9ytXl39MDCc0UNesIX9715ge39/vKxeeicw0oCIy1t7EP1cMSgPdLx3U0uj
 Q0EPcJAaNwFOGUSQGr4dX13MGQnpS2IiF/W6aoUkKqhFjPvjXUV7O7zxLvRCeFTGHdtcThTGw
 mKW5lZtYhAW0oZdk9BnZN8OKzso3qxn5Y7QAmQvknq/BXE5pYRSmFO8PMcbhiU7oPozTAbsYW
 i+0/OIMoUm5QfxpJSL3UXsZh4ESDzdPR2YaAGKafOr9PwfXGbR/PefQWruDvJtMJbwSfk4AoU
 ZrvVamkzv10k/v6fj2SRJ4bQjLFi7KUSmLdPLEOoEaYo2qEXXHOsczA2zZrDzorCAsrCRyo7I
 KCDzvCwxDIV0F/JYpIDwMN6uPSAj1quN/kHWT4cmKQxYdBNpXBlqzUQx8zF9jGwIsTAphiHb6
 zyKmzokNTCIKeM=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-11-08 at 15:21 +0000, Valentin Schneider wrote:
> On 08/11/21 13:27, Mike Galbraith wrote:
> >
> > As long as RT depends on EXPERT it'll be a bit annoying regardless.=C2=
=A0 I
> > just thought it worth mention that what you want now and what RT will
> > presumably want upon merge completion appear to be mutually exclusive.
> >
>
> Hmm actually I think your approach should work, i.e. have
>
> =C2=A0 config PREEMPT_DYNAMIC
> =C2=A0=C2=A0=C2=A0 depends on [...] && !PREEMPT_RT
>
> rather than
>
> =C2=A0 config PREEMPT_RT
> =C2=A0=C2=A0=C2=A0 depends on [...] && !PREEMPT_DYNAMIC
>
> This essentially gives priority to the preemption model type over the
> preemption model dynamicness, which I think makes sense. I can fold that=
 in
> v2.

Not seeing your v2 land yet, I grabbed my mallet and had a go at goal
reconciliation over morning java.  Non-lovely result seems to work.

sched, Kconfig: Fix preemption model selection

Switch PREEMPT_DYNAMIC/PREEMPT_RT dependency around so PREEMPT_RT
can be selected during the initial preemption model selection.
Further, since PREEMPT_DYNAMIC requires PREEMPT, make it depend
upon it instead of selecting it, and add a menu to allow selection
of the boot time behavior, this to allow arches that do not support
PREEMPT_DYNAMIC to retain their various configs untouched.

Signed-off-by: Mike Galbraith <efault@gmx.de>
=2D--
 kernel/Kconfig.preempt |   46 +++++++++++++++++++++++++---------------
=2D-----
 1 file changed, 25 insertions(+), 21 deletions(-)

=2D-- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -2,11 +2,10 @@

 choice
 	prompt "Preemption Model"
-	default PREEMPT_NONE_BEHAVIOUR
+	default PREEMPT_NONE

-config PREEMPT_NONE_BEHAVIOUR
+config PREEMPT_NONE
 	bool "No Forced Preemption (Server)"
-	select PREEMPT_NONE if !PREEMPT_DYNAMIC
 	help
 	  This is the traditional Linux preemption model, geared
towards
 	  throughput. It will still provide good latencies most of the
@@ -18,10 +17,9 @@ config PREEMPT_NONE_BEHAVIOUR
 	  raw processing power of the kernel, irrespective of
scheduling
 	  latencies.

-config PREEMPT_VOLUNTARY_BEHAVIOUR
+config PREEMPT_VOLUNTARY
 	bool "Voluntary Kernel Preemption (Desktop)"
 	depends on !ARCH_NO_PREEMPT
-	select PREEMPT_VOLUNTARY if !PREEMPT_DYNAMIC
 	help
 	  This option reduces the latency of the kernel by adding more
 	  "explicit preemption points" to the kernel code. These new
@@ -37,10 +35,11 @@ config PREEMPT_VOLUNTARY_BEHAVIOUR

 	  Select this if you are building a kernel for a desktop
system.

-config PREEMPT_BEHAVIOUR
+config PREEMPT
 	bool "Preemptible Kernel (Low-Latency Desktop)"
 	depends on !ARCH_NO_PREEMPT
-	select PREEMPT
+	select PREEMPTION
+	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
 	help
 	  This option reduces the latency of the kernel by making
 	  all kernel code (that is not executing in a critical
section)
@@ -58,7 +57,7 @@ config PREEMPT_BEHAVIOUR

 config PREEMPT_RT
 	bool "Fully Preemptible Kernel (Real-Time)"
-	depends on EXPERT && ARCH_SUPPORTS_RT && !PREEMPT_DYNAMIC
+	depends on EXPERT && ARCH_SUPPORTS_RT
 	select PREEMPTION
 	help
 	  This option turns the kernel into a real-time kernel by
replacing
@@ -75,17 +74,6 @@ config PREEMPT_RT

 endchoice

-config PREEMPT_NONE
-	bool
-
-config PREEMPT_VOLUNTARY
-	bool
-
-config PREEMPT
-	bool
-	select PREEMPTION
-	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
-
 config PREEMPT_COUNT
        bool

@@ -95,8 +83,7 @@ config PREEMPTION

 config PREEMPT_DYNAMIC
 	bool "Preemption behaviour defined on boot"
-	depends on HAVE_PREEMPT_DYNAMIC
-	select PREEMPT
+	depends on HAVE_PREEMPT_DYNAMIC && PREEMPT
 	default y
 	help
 	  This option allows to define the preemption model on the
kernel
@@ -114,6 +101,23 @@ config PREEMPT_DYNAMIC
 	  Interesting if you want the same pre-built kernel should be
used for
 	  both Server and Desktop workloads.

+if PREEMPT_DYNAMIC
+choice
+	prompt "Boot Time Preemption Model"
+	default PREEMPT_NONE_BEHAVIOR
+
+config PREEMPT_NONE_BEHAVIOR
+	bool "No Forced Preemption (Server)"
+
+config PREEMPT_VOLUNTARY_BEHAVIOR
+	bool "Voluntary Kernel Preemption (Desktop)"
+
+config PREEMPT_BEHAVIOR
+	bool "Preemptible Kernel (Low-Latency Desktop)"
+
+endchoice
+endif # PREEMPT_DYNAMIC
+
 config SCHED_CORE
 	bool "Core Scheduling for SMT"
 	depends on SCHED_SMT

