Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50C74207DB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 11:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhJDJIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 05:08:48 -0400
Received: from mout.gmx.net ([212.227.17.21]:42747 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230418AbhJDJIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 05:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633338392;
        bh=9wkXjsVix03q/87pJhFOsiEnG04j6uiTdBvQaTHmb1M=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=EvOZ7h3PayGxz9+8oTBMCB9mTEPBIpYZrTpLXSJ3Iauh9rDgATV2Ie6dge0G9H2My
         s/pMwVFee3vDGhIx9t/nQHzqtx3ZwjreJP/4NhcYlqnr+/eTQysA5g54LLBmXC0VtU
         rSV64C2jMIj4n4SFEnEI2DtuFX0qbJD36X3nBY0Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.146.50.159]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MacSY-1n3dsA0g7m-00cC2q; Mon, 04
 Oct 2021 11:06:32 +0200
Message-ID: <4f571c5c759b9d356d1bb4114fb169181194a780.camel@gmx.de>
Subject: Re: wakeup_affine_weight() is b0rked - was Re: [PATCH 2/2]
 sched/fair: Scale wakeup granularity relative to nr_running
From:   Mike Galbraith <efault@gmx.de>
To:     Barry Song <21cnbao@gmail.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 04 Oct 2021 11:06:30 +0200
In-Reply-To: <f1b421f956fa044b4efa7f5fef015725b27223cf.camel@gmx.de>
References: <20210920142614.4891-1-mgorman@techsingularity.net>
         <20210920142614.4891-3-mgorman@techsingularity.net>
         <22e7133d674b82853a5ee64d3f5fc6b35a8e18d6.camel@gmx.de>
         <20210921103621.GM3959@techsingularity.net>
         <ea2f9038f00d3b4c0008235079e1868145b47621.camel@gmx.de>
         <02c977d239c312de5e15c77803118dcf1e11f216.camel@gmx.de>
         <CAGsJ_4xcRFcDMpuC7vrpHe=aRbDpAnRd1F64aqh2EEcNgmZxCg@mail.gmail.com>
         <f1b421f956fa044b4efa7f5fef015725b27223cf.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UhI0A6t0+vAOjg0fF4zF3UvogpwEF52RWcFxvVZmGi6Vtf9+olf
 9FSpQvS84MxmksYZCj7UtddrPKsAZEURoXuXtuujb5cKqamTknacvig3vmfbdcvCJsxzmab
 0anNsM1hLZpdGXouZHCEHKCHFlDjQhwYmXu51DkOBcWQyV5ICw9l6M6o8asINXF+U/Xh7zV
 WHNf++ymeVNnprPyqaKWg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jKGg4Vl2ugY=:+/s4Q+bxtPgiCjtKhLOGaG
 Ii/luT3yeOhO8cp86GscU2WwJSEUGESjvSJ+FfHW4kYAWRByB/SjKJCGeUJh/Gsu5XU4RGvhd
 niKYQtbeuH6fR57B7W/Jps8AgGLDL6YBuvB66MYy92V1QucjRr2BTmkJvc+HYCUGW02QFgfuU
 uCam5D9ktSrLtRFCxRh5wi32UwL/FUn7TiBaUBynJHX90tf2h5nbWK0CPIFxQOkasPlxU6s2q
 QjNoc9Txexr0GG5cEhWojonpWX9uF/Di3Nm8Z8YZ2Sjm/KUJB3z30abY6VHVEs3VN61SW5HBf
 0mLWZnqo2uAiNOcP6hjltkQGdWxbYm5A1hw2gaPHgMgiIV/mnQKxmrTcx7A5OAZJpYTBiVC6X
 2CKynKWnAJdmgW7o/nO3aVs3uwLiEUQi7PGutUUzPGmQF09qQIQUC1nGOJ/UXwzZn5KhYcxVD
 nZhMa5CBFdPFGMarcNd5CLLkEbY2JbyluoWXA85nAAToTFfCsGJi+J4doIHGMgnG8UcdAp/Nh
 0dPZ9nL66X1Tut0jvT8Y0h1OAUPJvaNk8RXTIJA1oQfK6Sh7a6rrVfxnIkCHpz4vc17ezlp2z
 0Jpczm8yEOyYHxrAVzEJLzTK9U8B8bCSMjAj7xhWMA4G7VWoffVLPFUnE6/clq8OqbZwCazx1
 SmnojN4WjqRuvEVUHWMdr4IDfJ9c2KeYJ8n57c8rp1qYbNm/cRgDk7glHlS432uccM9FV0mu4
 ahHziPzUkYKSxBuQB8XSuYhHD71t3qn8MMJyOTI3bZp7OEjg0/SqwqvHw1YQcuWXAEfGehtvq
 XiYTiX/ksuyiMGnMzziwUFLVlHOT5Kud4nlLOCq6Ns7h4MIBRKWniq63FtASzYEPxhtvWESZu
 nNWlLZHAbS4thYz42TZLenHutizn551J9+r6heGBO6AKGjIoP2/btrjioyBdhHzWQmfhqcCGo
 nxE22uFJVz73FOpXkxKVJlNfHB5s6fbj/6orgT94cQ+I0l6XMcUt5lHR+58IfNhGq/dMwr2hF
 bsufjgA2Dwg0dFtBBb9cpe+hEKQQwzyOwmG8pCnazgXsgYI8z027LHpPM2CK/b7+G5Y5TSBHs
 DpFczFwmQJDv+s=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-10-04 at 06:34 +0200, Mike Galbraith wrote:
> On Sun, 2021-10-03 at 20:34 +1300, Barry Song wrote:
> >
> > I am wondering if this should be the responsibility of wake_wide()?
>
> Those event threads we stacked so high (which are kde minions btw),
> don't generally accrue _any_ wakee_flips, so when X wakes a slew of the
> things, wake_wide()'s heuristic rejects the lot.
>
> So yeah, the blame game for this issue is a target rich environment.
> Shoot either of 'em (or both), and you'll hit the bad guy.

The mallet below convinced wake_wide() that X waking event threads is
something it most definitely should care about.  It's not perfect, can
get caught with its pants down, because behavior changes a LOT, but I
at least have to work at it a bit to stack tasks to the ceiling.

With make -j8 running along with firefox with two tabs, one containing
youtube's suggestions of stuff you probably don't want to watch, the
other a running clip, if I have the idle tab in focus, and don't drive
mouse around, flips decay enough for wake_wide() to lose interest, but
just wiggle the mouse, and it starts waking wide. Focus on the running
clip, and it continuously wakes wide. =C2=A0

Hacky, but way better behavior.. at this particular testcase.. in this
particular box.. at least once :)

=2D--
 kernel/sched/fair.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

=2D-- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5865,6 +5865,14 @@ static void record_wakee(struct task_str
 	}

 	if (current->last_wakee !=3D p) {
+		int min =3D __this_cpu_read(sd_llc_size) << 1;
+		/*
+		 * Couple the wakee flips to the waker for the case where it
+		 * doesn't accrue flips, taking care to not push the wakee
+		 * high enough that the wake_wide() heuristic fails.
+		 */
+		if (current->wakee_flips > p->wakee_flips * min)
+			p->wakee_flips++;
 		current->last_wakee =3D p;
 		current->wakee_flips++;
 	}
@@ -5895,7 +5903,7 @@ static int wake_wide(struct task_struct

 	if (master < slave)
 		swap(master, slave);
-	if (slave < factor || master < slave * factor)
+	if ((slave < factor && master < (factor>>1)*factor) || master < slave * =
factor)
 		return 0;
 	return 1;
 }

