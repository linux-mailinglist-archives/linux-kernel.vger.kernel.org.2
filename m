Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9523E596D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 13:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238279AbhHJLs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 07:48:59 -0400
Received: from mout.gmx.net ([212.227.17.20]:42839 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240317AbhHJLsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 07:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628596065;
        bh=ncC7o600PU/F6DbooXCSVvIEyJUYp2GOXS0HtlDpoPI=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Qcaj5Frqo83OD8IsKGbZpRp4xOGUfKbUYeQT2+/pOe7teISA+wkRCddz/idqYWMRL
         vLlkaoyhdsMLulQJFsPq4HObgLGFgRFWXqDRkccaevi+3npmCH2d7vyaJi/drJphnj
         cUB52Ku0Vdg9PoH3l0UO7UpsTM8IyFjH67vEvLHI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.219.22]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpDJX-1muAN53rCR-00qi60; Tue, 10
 Aug 2021 13:47:45 +0200
Message-ID: <2eb3cf340716c40f03a0a342ab40219b3d1de195.camel@gmx.de>
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
Date:   Tue, 10 Aug 2021 13:47:42 +0200
In-Reply-To: <fbf59e73-8b27-56a8-d863-cfe40457f4df@suse.cz>
References: <20210805152000.12817-1-vbabka@suse.cz>
         <20210805152000.12817-30-vbabka@suse.cz>
         <0b36128c-3e12-77df-85fe-a153a714569b@quicinc.com>
         <fbf59e73-8b27-56a8-d863-cfe40457f4df@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HWZJDEBnwH0bYmROkMYUt7RwI2AZIaNU4dDH1VSPJllWJ+QyfvN
 bnGsnUn1CKEk+wmD2DClIk74WDF1ivBw3A3hSxw/05ZR9jYBpifB3A1FWv9png7KctZwble
 nGmHMwwQMkFEFdc66oHWlLxCo3rupiJIxi3usy3RfKnWOAN9vQ8rWZRZyAu4ZBIGN0jeriO
 MtXr+7L3BFTx3nhOpNwCg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:z28raP9QTO4=:h3NBMR9dCRkjwJ6mNnW0Zq
 4feJjoW2doezBH/NI/MTEW97urzCDBfkjY+9t4a7fJlIStB11tDeMmQReBIpt2ZLSodQNpljJ
 FxKXNXIW5HDkCL2UFHgKBnj2sVdWIcf/0E10oN2SBjwH49zdmwq44kpAKr4CISQ+USOZxf7QM
 qy9eln/KSV9xhIEFgWAHOwMtTIIFlt3UX2YpSuRIKKLRgwicxPXT1RoDXOofyhp7S55jl3y8c
 ayozWIYt9MqoT54BWoXELgxtuSP/uMfnXnEC3tpvUVUwc6HyFZ297huCIhEbGvntDpbRJOz3k
 d72sBHT5hOkhf4fo7kDv9PRNOZUTOqTXKggsq+KPb82DlifwSZRlnTdYHwGyxTpijsy0NvvQi
 /WKo6py71eh76emoe3dBuRzp+kv9UYdCD37vOS0qZ+NF+mqTCyk9RX0DP4S9Ay9ij6Ep/77Pk
 f5OGCKnXK8WCfrDLag+kYx2p7KTFedvqgSiRRG4kHDZYl2E6Jv2vYPY3kigHSUPX1j645WSo6
 OBcGdyUen6wACx9yiI4pftRLQ/5Ye/3ELn4eZRLHgBZe/4dV1ydZfBZDt08D5lqbm3mR32a0e
 WxmvWd7b0z2nuSiMy5Zw3RFRPkYyVv2qDLtBOSYYo8RUCHWLz5njRlp7yjxjFeJcLGqvuvN/W
 eID9lddiUPc5O/8Aig1KG7C234B5cezhUsuueR3wBGas+o5SEpIQmvqsmBaJ5n1DhMedePlob
 fxA6r6CXEut1CIvIJU7IhPPTQSdttsB14m68LjlzRSF6Fm65L3eBzO+5+AEmANFnh3DjSa7eP
 N7U0xhK+HOvDpgj3rSZCK+ocSB8x9RG6s9QpAv9klKADZXeaJZNIbiQrNYm8B/uDvB9Svvtbw
 XPjVwRO82i+2EMCEEQR3f8+mUZxySV4y9bS5CklOPE4+R+gUw5S8hd85CLPRgm7c5SYeu/JMn
 GdUZOF08reNLZY4i5Ts1xMQG7rzgRD2DCDO8KTItQO11RNb7gL4IOnM+AdiDOEzzCi6GJkSL2
 0xXwMK5aPJCsr+XzfWS3jhrS5ColwPyHcCwFYquLpTxET0auAK8yUFLdEgAixCVpF/R6FCaBz
 fusum03CzKCxM+oFrRV/hrx/XzFiPy8KApl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-08-10 at 11:03 +0200, Vlastimil Babka wrote:
> On 8/9/21 3:41 PM, Qian Cai wrote:
> > > =C2=A0
> > > +static DEFINE_MUTEX(flush_lock);
> > > +static DEFINE_PER_CPU(struct slub_flush_work, slub_flush);
> > > +
> > > =C2=A0static void flush_all(struct kmem_cache *s)
> > > =C2=A0{
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0on_each_cpu_cond(has_cpu_=
slab, flush_cpu_slab, s, 1);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct slub_flush_work *s=
fw;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int cpu;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&flush_lock);
> >
> > Vlastimil, taking the lock here could trigger a warning during memory =
offline/online due to the locking order:
> >
> > slab_mutex -> flush_lock
> >
> > [=C2=A0=C2=A0 91.374541] WARNING: possible circular locking dependency=
 detected
> > [=C2=A0=C2=A0 91.381411] 5.14.0-rc5-next-20210809+ #84 Not tainted
> > [=C2=A0=C2=A0 91.387149] ---------------------------------------------=
---------
> > [=C2=A0=C2=A0 91.394016] lsbug/1523 is trying to acquire lock:
> > [=C2=A0=C2=A0 91.399406] ffff800018e76530 (flush_lock){+.+.}-{3:3}, at=
: flush_all+0x50/0x1c8
> > [=C2=A0=C2=A0 91.407425]
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 but task is already holding lock:
> > [=C2=A0=C2=A0 91.414638] ffff800018e48468 (slab_mutex){+.+.}-{3:3}, at=
: slab_memory_callback+0x44/0x280
> > [=C2=A0=C2=A0 91.423603]
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 which lock already depends on the new lock.
> >
>
> OK, managed to reproduce in qemu and this fixes it for me on top of
> next-20210809. Could you test as well, as your testing might be more
> comprehensive? I will format is as a fixup for the proper patch in the s=
eries then.

As it appeared it should, moving cpu_hotplug_lock outside slab_mutex in
kmem_cache_destroy() on top of that silenced the cpu offline gripe.

=2D--
 mm/slab_common.c |    2 ++
 mm/slub.c        |    2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

=2D-- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -502,6 +502,7 @@ void kmem_cache_destroy(struct kmem_cach
 	if (unlikely(!s))
 		return;

+	cpus_read_lock();
 	mutex_lock(&slab_mutex);

 	s->refcount--;
@@ -516,6 +517,7 @@ void kmem_cache_destroy(struct kmem_cach
 	}
 out_unlock:
 	mutex_unlock(&slab_mutex);
+	cpus_read_unlock();
 }
 EXPORT_SYMBOL(kmem_cache_destroy);

=2D-- a/mm/slub.c
+++ b/mm/slub.c
@@ -4234,7 +4234,7 @@ int __kmem_cache_shutdown(struct kmem_ca
 	int node;
 	struct kmem_cache_node *n;

-	flush_all(s);
+	flush_all_cpus_locked(s);
 	/* Attempt to free all objects */
 	for_each_kmem_cache_node(s, node, n) {
 		free_partial(s, n);




