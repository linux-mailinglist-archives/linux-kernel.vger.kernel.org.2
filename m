Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA363BDE44
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 22:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhGFUKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 16:10:19 -0400
Received: from mout.gmx.net ([212.227.15.19]:59881 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229781AbhGFUKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 16:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625602048;
        bh=1XW4QZUxLpFU4VF+uKupXJzAACbI5Ar5k3bwRpoIlt4=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=VlWxhhV85iaV8MR4pMaByPrCBvpJwPDbBIsgC24N0y73Q0hpopw4GxU53Se9e5/AE
         4HRhUlGrqmUfLLPNHuavLAaA9JErcX5+Tm72Om8j/UmfS50pzTafUOE4HSjy2pMTal
         g+YJBKxAOHKQvaj+X2izW20twA4wPgu6XY0OoPOM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.216.125]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYeMj-1lfjvP0nyd-00ViSa; Tue, 06
 Jul 2021 19:56:32 +0200
Message-ID: <289873432407e0569401c8894843d7004b59d90b.camel@gmx.de>
Subject: Re: [RFC v2 00/34] SLUB: reduce irq disabled scope and make it RT
 compatible
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>
Date:   Tue, 06 Jul 2021 19:56:29 +0200
In-Reply-To: <206d6a81e08cb23a2c97e67335be6017e938bac5.camel@gmx.de>
References: <20210609113903.1421-1-vbabka@suse.cz>
         <20210702182944.lqa7o2a25to6czju@linutronix.de>
         <206d6a81e08cb23a2c97e67335be6017e938bac5.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Pyc2JwVoSC5bEXh9SltN3cjAdn1IIP3fzD+eYhnrLmjmsRO/VLP
 7FqwdgZRZaAvAxWbRkL0qV99b8uJ7dPz4XXCl9v91XLPtGuG89T+alvMs/7LoTW0DzEI/Un
 RXJw4tYegxY7Y+QlSTKEqdYOEKP30HCVIOwwLrLAFPl4jf6ETUdEePuPOqW5/M91BJtfHj8
 F7n0nRl3/9868p+n/SL5Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JBolOfj4P2M=:8a7COoJT3GfYPhAuXFoUX9
 lXlsIpUyDLE+VHD16pAoSoPYtHIUHIGnkyMnfOx5GbS5dzE4wozl+cHPKZ18fxG0wqugfhLZj
 CJ5sQDQ8mCoFuEMWA3zSQ7fTDbpfM/p31OC+LTCrj+eNS0MLoblu17ICtsyWId8gWwtO9arRr
 K+NRe082fQMaUSZR1KMgW84slvtoJSOSxPPfclDZxIqVtVQZ3ajA7YE5xQlqDi2EYb2CCHINO
 XHv8R2D70t0uLZguxd3t1d1AfjvkKKGffUlPl4hJyuTgkFRNrqDJpzpN6WsrtnMFB7loTpfUs
 XEOfoCUt3sRBs2IYfgiG1GZWh3/NDbN4uYOcEYrUtsSGMYS/KT4CI0aWxxC7jZ4NGuPVNtgAT
 cpbIojFLcvLpoiHAKKzB3rOLhbZl58O7Vnh4y1PJ45DR7ERLeQuVsc/I+THTF8k6rAGTDJciI
 5JC6ywOVG4hI6wFIuNuEXeY2xsmfUuDOdPOcY8s1HJAcz2xmFMKcgqIG2o1TnwJimwXBCrn9k
 KNxZELbsM8fsXYqAzAKuBtGL+qzg0ea3GLoQ7xnErfaYt6dEVl7ZSCV7xKamtev7A+dnn5bx3
 84DY3O2VaJr5qKug5XCA7JZ/9FYavcesFGjIAqm/97ecgMRGs+fhpLjLpR7vCvpNRLI1kLrz1
 lbizix3ajtlNO4L+7J0NqRniSOekyhlOrzyRpaj3GqkPpe0XVF01XEoWmoTu7mhCd/SjDx7ev
 j4k7OB3VRZy0GCxRYu1ffu5oZOifLU3kLa1gwZh2I8m+KD322vDJQpXkP5/rv6N4IYROlX7f1
 tJs7IGHndCSUD0N2rFYZtJj1MpR7UOtKI9fHpl3dhEUA38AqcafXMCWPPDQlmLpuKcR++Wtlq
 xnWPEAgsFaJ1AvL3/yjrgaOuBYxwjQjEbo2kIrkbgfs32MTpW2PikTgwI5hg1LMa2S51yppya
 wAGo5dnypU6c6TQ/SVkBfDD1KSlfq0zK4wUDe5Sm9sKgekDRvXQ8o/fXxb4H9nvPB9fnY9wXG
 Jx/Tt/OKuXRum1wtcT2M5bhT0OJtB9svj2T9Xqt1ivh8AHlJ4tnSeUIZjfZqZGwZOvyW7Mh2p
 06sMYpmegzqmO93BuO76UXhZEGqvybCcD4G
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-07-05 at 18:00 +0200, Mike Galbraith wrote:
> On Fri, 2021-07-02 at 20:29 +0200, Sebastian Andrzej Siewior wrote:
> >
> > > The remaining patches to upstream from the RT tree are small ones
> > > related to KConfig. The patch that restricts PREEMPT_RT to SLUB
> > > (not SLAB or SLOB) makes sense. The patch that disables
> > > CONFIG_SLUB_CPU_PARTIAL with PREEMPT_RT could perhaps be re-
> > > evaluated as the series also addresses some latency issues with
> > > percpu partial slabs.
> >
> > With that series the PARTIAL slab can be indeed enabled. I have
> > (had)
> > a half done series where I had PARTIAL enabled and noticed a slight
> > increase in latency so made it "default y on !RT". It wasn't
> > dramatic
> > but appeared to be outside of noise.
>
> I'm seeing warnings/explosions while exercising box IFF PARTIAL slab
> thingy is enabled.  I aborted -PARTIAL after a little over 4 hours,
> whereas the longest survival of 4 +PARTIAL runs was 50 minutes, so
> I'm fairly confident that PARTIAL really really is the trigger.

Resurrecting local exclusion around unfreeze_partials() seems to have
put an end to that.  Guess I can chop these trees down now.

=2D--
 mm/slub.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

=2D-- a/mm/slub.c
+++ b/mm/slub.c
@@ -2497,7 +2497,9 @@ static void put_cpu_partial(struct kmem_
 				 * partial array is full. Move the existing
 				 * set to the per node partial list.
 				 */
+				local_lock(&s->cpu_slab->lock);
 				unfreeze_partials(s);
+				local_unlock(&s->cpu_slab->lock);
 				oldpage =3D NULL;
 				pobjects =3D 0;
 				pages =3D 0;
@@ -2579,7 +2581,9 @@ static void flush_cpu_slab(struct work_s
 	if (c->page)
 		flush_slab(s, c, true);

+	local_lock(&s->cpu_slab->lock);
 	unfreeze_partials(s);
+	local_unlock(&s->cpu_slab->lock);
 }

 static bool has_cpu_slab(int cpu, struct kmem_cache *s)
@@ -3358,13 +3362,12 @@ static __always_inline void do_slab_free
 		 * we need to take the local_lock. We shouldn't simply defer to
 		 * __slab_free() as that wouldn't use the cpu freelist at all.
 		 */
-		unsigned long flags;
 		void **freelist;

-		local_lock_irqsave(&s->cpu_slab->lock, flags);
+		local_lock(&s->cpu_slab->lock);
 		c =3D this_cpu_ptr(s->cpu_slab);
 		if (unlikely(page !=3D c->page)) {
-			local_unlock_irqrestore(&s->cpu_slab->lock, flags);
+			local_unlock(&s->cpu_slab->lock);
 			goto redo;
 		}
 		tid =3D c->tid;
@@ -3374,7 +3377,7 @@ static __always_inline void do_slab_free
 		c->freelist =3D head;
 		c->tid =3D next_tid(tid);

-		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
+		local_unlock(&s->cpu_slab->lock);
 #endif
 		stat(s, FREE_FASTPATH);
 	} else
@@ -3601,7 +3604,7 @@ int kmem_cache_alloc_bulk(struct kmem_ca
 				slab_want_init_on_alloc(flags, s));
 	return i;
 error:
-	local_unlock_irq(&s->cpu_slab->lock);
+	slub_put_cpu_ptr(s->cpu_slab);
 	slab_post_alloc_hook(s, objcg, flags, i, p, false);
 	__kmem_cache_free_bulk(s, i, p);
 	return 0;

