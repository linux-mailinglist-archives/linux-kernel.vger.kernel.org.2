Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB47E44C490
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 16:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhKJPnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 10:43:32 -0500
Received: from mout.gmx.net ([212.227.17.21]:45637 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231743AbhKJPnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 10:43:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636558813;
        bh=yjmSHFI6HR41s0LCcSV97Y3qSomVbNcpfDPn9zOi5ig=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=C3CZtJ5/0SItl2RlZPxkIAIwAr5RzvNeVvLg64YYBQL7pV4WiUAhkiMddL3Ox91gT
         K/iAVS5GRSp69B0eMfvQkCj+6+jFWdFzXZuvd06FdvxTjqwYZMhaKytWtDB3r7qzSi
         rXVuBAp7xmE+EsBAhxET8d+MAGIEWf6yO9cu/iYE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([212.114.172.107]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRCKC-1n7sKW05DQ-00N8Gj; Wed, 10
 Nov 2021 16:40:12 +0100
Message-ID: <fa57d6f059ba68cbb2d372c7c63f008e2b6a80cf.camel@gmx.de>
Subject: Re: [PATCH 1/2] sched/fair: Couple wakee flips with heavy wakers
From:   Mike Galbraith <efault@gmx.de>
To:     Tao Zhou <tao.zhou@linux.dev>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 10 Nov 2021 16:40:08 +0100
In-Reply-To: <YYuWlxNG+d3G4uTo@geo.homenetwork>
References: <20211028094834.1312-1-mgorman@techsingularity.net>
         <20211028094834.1312-2-mgorman@techsingularity.net>
         <YXrNfHcfhp2LutiL@geo.homenetwork>
         <20211029084219.GV3959@techsingularity.net>
         <YYuWlxNG+d3G4uTo@geo.homenetwork>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uPhu9sfP8RAhy0and1Ot6P8OJrEbuuBMW+U+Tcsi/IshdySuapF
 SpLovwsbNHOhsLoVRtJUaEPG0L1fPYjpiH74lHOwvODqGsVJosLGc+ZFDTJ3b/WYmOdsRbI
 NvxvKNJgi1KPOs15Kt+zWhtme55O7VNIi43xN9XpK2bXbXxuGbCQoQbJE2KLJ8BBw4Y5fMx
 Yc1OthkF569cqVjwMFcDg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PFLO5LvT4Pw=:yg71m3TETusVL4GmyhiEj0
 qS8SV/QizN1dauwoQ2cYWZeONyTxkMrYcB8cIToE3xRLSvii2q7Wj262UGSM2KKX7nfHbXMp2
 VtcjHIkDF4bk92tfQpE67PshmQ9Gk3VHhMG14goni2xrsVGlmvA8Y6TnaMM80XhLqo1jHDQkW
 fIzkvdduT/bR8WXqGTxTqSeBq/l75rsqWR4zZe6SfCps4grMjODHRxb+09AB2i3RSU9dtJcX0
 U3a1YT9fse7W0V3B26kYDjEUdhhsB0VjlhcMkQ4WCtXfviDffpoIatzA7HoEdlPm5+j7kwSDj
 1jObsoMZrEsbn6QSo52guAHeJ+Cpa9GWj34YGgLZMRvtF7g5b9Ao8Ps4I2fWohZtlrWgodON+
 sf/YaeaqHuiQzRCBXSpc5+QD6D5aZ576sHUsz4vFRzJHGNKfhUWPR+DOaAm3zc/247K8MplEx
 LqmQndfbDweR306L64zMiKjPRiY1erQIyr1PDpnK3pKSFG39rYiUSj7//t6wkidbeaMqSqjEJ
 93Oxbj9a66pjXMXR/4qpFj/bjSxAxFpPE03fH6B8ObIJWGKwoKYkgTXtSF4L2frAHgY4CRwu4
 jg5bdVgbo9xc62/sXGBMzNIsw0EQEWYwk2oq5wPj1BuISnUX69E38tz9jKDqFbq0GWm0Cn7RN
 fLM1TmrOV/GQ85vCj7Noxc50OgS6dZDNgPXQlNwdL+Xg5nhgkVNeanh4VHbF2FZGS8OSiQTbx
 UtQjY96m0sLiyp/T1MyBchkUiVBAE7ugu8DRKPhGAkkuBF4pDCNztEyfzKVa+yvJe7mPOkKWi
 qnI/QHf9p2QbLOffyNd4jbt6h/4ss77ZTacGkpuMj2Pq2udCjJQORaHD2WvNRlrUC9zaIg1jb
 NhyU7i7UXxIJ1S3nh4E9lvcxL2+Xj60xSHrE53KClLdmRezl9blviEZKuB5050cbgbGc2BYb3
 88NGtpOerz0kvTuyxjkNvZSgTx+Uq7F9CDeY4w0xyui+fyeBq6vrjIZS+mxHaomaz1YJ5JqrP
 SHJGgsovZhtPQZ3YIVKCn3uragKC61Toms3U7Rg/ozl5p1+hQzh416ogVv/HBExjBOcnRXObI
 6TuzJKRQ1DXnp8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-11-10 at 17:53 +0800, Tao Zhou wrote:
> On Fri, Oct 29, 2021 at 09:42:19AM +0100, Mel Gorman wrote:
> > On Fri, Oct 29, 2021 at 12:19:48AM +0800, Tao Zhou wrote:
> > > Hi Mel,
> > >
> > > On Thu, Oct 28, 2021 at 10:48:33AM +0100, Mel Gorman wrote:
> > >
> > > > @@ -5865,6 +5865,14 @@ static void record_wakee(struct task_struct=
 *p)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > > =C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (current->last_=
wakee !=3D p) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0int min =3D __this_cpu_read(sd_llc_size) << 1;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Couple the wakee flips to the waker for the =
case where it
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * doesn't accrue flips, taking care to not pus=
h the wakee
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * high enough that the wake_wide() heuristic f=
ails.
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0if (current->wakee_flips > p->wakee_flips * min=
)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0p->wakee_flips++;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0current->last_wakee =3D p;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0current->wakee_flips++;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > > @@ -5895,7 +5903,7 @@ static int wake_wide(struct task_struct *p)
> > > > =C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (master < slave=
)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0swap(master, slave);
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (slave < factor || m=
aster < slave * factor)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if ((slave < factor && =
master < (factor>>1)*factor) || master < slave * factor)
> > >
> > > So, the check like this include the above range:
> > >
> > > =C2=A0 if ((slave < factor && master < slave * factor) ||
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 master < slave * factor)
> > >
> > > That "factor>>1" filter some.
> > >
> > > If "slave < factor" is true and "master < (factor>>1)*factor" is fal=
se,
> > > then we check "master < slave * factor".(This is one path added by t=
he
> > > check "&&=C2=A0 master < (factor>>1)*factor").
> > > In the latter check "slave < factor" must be true, the result of thi=
s
> > > check depend on slave in the range [factor, factor>>1] if there is p=
ossibility
> > > that "master < slave * factor". If slave in [factor>>1, 0], the chec=
k of
> > > "master < slave * factor" is absolutly false and this can be filtere=
d if
> > > we use a variable to load the result of master < (factor>>1)*factor.
> > >
> > > My random random inputs and continue confusing to move on.
> > >
> >
> > I'm not sure what point you're trying to make.
>
> Ok, some days later even can not understand what my saying myself. After
> wrong and right aross with my wreck head I just try to make this:
>
> if ((slave < factor && master < (factor>>1)*factor) || (slave >=3D facto=
r>>1) && master < slave * factor)
>
> check "slave > factor>>1" for filter the cases that is calculated if I
> am not wrong. If this have a little effect that will be to not need to
> do "master < slave * factor" for some time not sure.

Take the original:

if (slave < factor || master < slave * factor)
	return 0;

That is looking for a waker:wakees ratio of sd_llc_size, and does it
the way it does because you can create "flips" galore by waking only
two tasks, but using the two comparisons together makes it more likely
that you're waking sd_llc_size tasks.  Take my box's 8 rq servicing
LLC, if wakee is 8, multi-waker being 8 times that suggests 8 wakees,
each having been awakened 8 times by our multi-waker, qualifying the
pair to be considered part of a load too large to restrict to one LLC.

But what happens when our multi-waker isn't always waking a uniformly
growing/shrinking set of workers, it's a bit chaotic, and the flip
count of some wakees decay below our magic 8?  The right side can be
happy as a clam because the multi-waker is flipping madly enough to
make wakee * llc_size nothing remotely resembling a hurdle, but there
sits a deal breaker on the left.. so we should wake these threads
affine?  I should have left that alone, or at least picked a big
arbitrary stopper, but picked half of our magic "I might be waking a
herd" number to say nah, as long as the ratio on the right looks herd
like AND our multi-waker appears to be waking at least half a herd,
wake it wide.

That not-a-noop probably should die despite having not (yet) shown an
evil side because it dings up an already questionable enough heuristic.

	-Mike
