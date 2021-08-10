Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F543E5082
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 03:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236732AbhHJBHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 21:07:54 -0400
Received: from mout.gmx.net ([212.227.15.19]:56827 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233980AbhHJBHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 21:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628557623;
        bh=xtqclcPFtKgKjC09LgHdgHK6lA9GAA8mf/LdDlqDWKc=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=a5eJYNxsywhXyve/ZWkD4VSrzwcL8vXcGIf5iip64yfAv1GdsN/vp91kklxJiKWAW
         lNzG1AUXYBa4wMedSYJvkf8dl2T84qGO5EIii4XiC3ZV3gytRzm/SAQiFVB4CdKiig
         NbEriagXSll109PBJadXFMxCigKHLSDa/pcueF3E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.219.22]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N9Mta-1n9NBL2ssO-015KAT; Tue, 10
 Aug 2021 03:07:03 +0200
Message-ID: <4fa0e9016f746e070150f6db78202d744a3f9c4c.camel@gmx.de>
Subject: Re: [PATCH v4 29/35] mm: slub: Move flush_cpu_slab() invocations
 __free_slab() invocations out of IRQ context
From:   Mike Galbraith <efault@gmx.de>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jann Horn <jannh@google.com>
Date:   Tue, 10 Aug 2021 03:07:01 +0200
In-Reply-To: <7d9ac614-f18e-de5d-2d47-f92e618d76fc@suse.cz>
References: <20210805152000.12817-1-vbabka@suse.cz>
         <20210805152000.12817-30-vbabka@suse.cz>
         <0b36128c-3e12-77df-85fe-a153a714569b@quicinc.com>
         <6e3bb54fdf7208f3f86a5d31e1ef2a576d8e7e37.camel@gmx.de>
         <7d9ac614-f18e-de5d-2d47-f92e618d76fc@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Niqhnc4JbukI/xu31QlaECKWCPWeGcI1Q31mG5BLCHlc1J2SvEi
 MRlQUBLMefQTttiMKWz9TGcknwEhTKZeh0KPT3dNMVkSMHXRFNr1uM9Is4z/l31FZeBWO/X
 kR+K6AaP3IVe25umevTV2DN4mrVoI/nQ1AkUP90i+CsCgKVWbmrHHHtFPObabGvFRT+DxI5
 4sB1rg4Xr+P5REMpLnTuA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fEI/fLaXyfc=:UzzMFqSfS1juNk+Pl9Te0r
 mMlX1LT/0RuAAd7yONKHIuYrvBereSaTJYIzy/VDYlst/7ZHH3ZsmkNQ2ymjuxC+95TNN8dIi
 jRyOgQAy33T6HPvO3Wn8FT4C3F8hKQzbWJz4EoKW7/Fj0Nm10+VvQUew1cBoMN1N6hmqRSYSO
 0/dKxzGd1tZ/JTgdVKvJ+xTls4Pvjw45j00iMHMXvGrNiOYwKcWcFofMmwX5uSUfqEVshR7Aq
 HK3W7UjC0AmQzPtOXdGkmfB5ypo/WwMWB1qrwJq+t2aQEznv3UWAqQExrwei8iP0jQxOrP/iv
 WyssiusZYTO+h9dqFLZ9VXoFlVSN2Wc43nTZ4vdkf037gAy6keEc1W+AkXqvqdCWuv27HOr2v
 8dO4yEQgfocJe9wMcUUFC8OQHF6YlDZ1065feJyaSYZX0V1p0uqYvYRpzNpyegI6pvizqfhCs
 cKdj2LXAft40haYpD5mMWI+20enLhuxP35hxmFFpHmIU01sVF2C/Y1j2iHMrHDLGdOIDUR12B
 sjuFaJoXRMZG7YOBIE37T5Lq6X3rxXRNNtOROYOEFDZTkedQGrl6JzqwZLbaSkrrjMyNZ/pFT
 FC5Euxu3K6pi9dihO6fA9xkMRZMolebeuQzA+6jd9UpEEwfgg9iOr2H681TIpQjmm5zDXTcTN
 usICnN42L/oU/rqAshiaRMNLVF+x7uf1Tnh/F9R4lGZoYBYV9JygZILoziRloPmTF/nGEYcPn
 nYJ7KxGhAUKsjdAbiWQV+CGm53f06OV3bq0FqqOvXcx7C7dhT/MZDDSns1f50is+oVw/5GPmE
 4Isxkvj6OcEGA9mjEE53aXDtpwnKZ+QZHo9VPXGjPNNLpRIUlsnS99VvFyi8s+hGbfPq9KmKU
 xekjOnqSYsTZIehMJrh9ptdFvC6u1BpJBOEeOSJ2io/gFiP9tXcsBFnylHeJB4uN2WRV+ZqqS
 ZtT1blPWLMOaYNIzClt7N0dS7xoQG99CVbiUR7oR1h5yN84oo5GEvP23CQ2xfz4py7uaC4wN4
 C5KCxM/oX7gl3MW0Nkjk5RluWlvZSvoOReUfrQFeAvEusZ3zRgyeFTMkzsYqMEPijymeSSQhH
 0JyO54GpAhtog7xClOonsWqECk6y3lL7R0R
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-08-09 at 22:08 +0200, Vlastimil Babka wrote:
> On 8/9/2021 8:44 PM, Mike Galbraith wrote:
> > >
> > > slab_mutex -> flush_lock
> >
> > Bugger.=C2=A0 That chain ending with cpu_hotplug_lock makes slub_cpu_d=
ead()
> > taking slab_mutex a non-starter for cpu hotplug as well.=C2=A0 It's
> > established early by kernel_init_freeable()..kmem_cache_destroy() as
> > well as by slab_mem_going_offline_callback().
>
> I suck at reading the lockdep splats, so I don't see yet how the "existi=
ng
> reverse order" occurs - I do understand the order in the "lsbug".
> What I also wonder is why didn't this occur also in the older RT trees w=
ith this
> patch.

Apparently (oops) nobody got around to hotplug+lockdep testing, RT or
otherwise.  I know I didn't, goldfish like attention span being used up
by explosion testing ;-)

	-Mike

