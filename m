Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E763BA947
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 17:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhGCPuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 11:50:13 -0400
Received: from mout.gmx.net ([212.227.17.20]:53541 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229818AbhGCPuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 11:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625327224;
        bh=EZR4P3ADpNABWwkDJID+NKWO9cUa0tCYRwghj00Chi8=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=MAvkhFXnCHe/R1oXpQ7GXy01FjzeWlwMru/Q0xUK1btGUKCeTiKbuTo6VMkxvY3Sy
         JTVw4aA7kzfBXmbt8T5oB8rRikBW4aH89YtPOOz0BxnCUMprLOovXwl5yKkOo3hpoc
         ljd06UuY2C2JEdK7rkyj/gQo6EMHzr/HTMI9Fde0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.146.50.218]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7K3Y-1m7QYV3NSG-007iHA; Sat, 03
 Jul 2021 17:47:03 +0200
Message-ID: <ca0474137c1e5a16a1215693298c9cd93218e24c.camel@gmx.de>
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
Date:   Sat, 03 Jul 2021 17:47:01 +0200
In-Reply-To: <891dc24e38106f8542f4c72831d52dc1a1863ae8.camel@gmx.de>
References: <20210609113903.1421-1-vbabka@suse.cz>
         <20210702182944.lqa7o2a25to6czju@linutronix.de>
         <891dc24e38106f8542f4c72831d52dc1a1863ae8.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wHIYTqbMbNJ0KqPPWwh+O0cNNKKXowBc0qettTCN98G59gh0j/o
 +aFM6uDqiO86Kr8SOmDCle+h5NkSuM4eNekxdJK2ItHKx5nGilhdR09ffvihhAKxZYKLMTI
 U23k6hogNE5is69g80b1vuaxTl9Y87sgxJsN5pVjR8rUKSYehtnQopiMeX0Ro4Vb+f6Lgkt
 JNdVUbeiX+sAjXJDfGn1g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9CGdzv/Vcf0=:Kk7OK4DmN12xYzt5vnHl6d
 0actNmhgLZdXa/j/0ZD4+QfnvxjFX3rDXbhc/J7kC7b7zDZChyWyTcySu/CtdBo113L9gjVEP
 AhZJsaV25bRWDSSSyNcQVUAF6vvM/i3Mp3q2HGE6AlPczHxfAYyGhg5iXyKLeuv8ctsivdmtF
 sD6g+dr308dL5nikcFTFfVpV7cu1I3hrFzX1vGjC8wZr07OLAoKiB4d9HvIY34PGwvj6l8pVM
 s4IRcZKCz6B2hMkNbNpsJb8dNRhhFXtWhPRKCxf1JhSmk1r4NETqveRAbk3ph59CBgXcBrIGt
 AlI3gnHDOlrRc72IuNx+9qQngE0lQ5b0Y91qJjrxILOnTr6Opk2pHGHeeI6c5WsjJ8Ff9aop8
 ihe1kZD39obdNXS6epsBlmjDiA9mjUx1JKXxlgJj/0GEPfRpGLMK1oIFHdUamVBqfB7CcH6Eo
 DNUUpkPflETL0AvXFjYwC07lxH4PbOr5ea6Q7PfrPwDt2TLlPKDbs/4Vjd3dZp5GQP3SP/5E9
 UhoTfodVVyKdYYqbeC6omSdwxFc9uU3iFp2btyvUUq+3/wEKh6pW0ckzZn4IIcqyBoZm1+swD
 cB6oQflaWVjseNm7EJAwvBkxHj1cwTITAvcgqjJhLXMQufukfeV/yisHIoskr2Hzo7/2tX+Q8
 xjRLbgur4BP3PUNfuk/zDi+zhKoNe3R+URWQiHESz1V+Dkoee9QJRI+qGJby2x3FRPUK6PUit
 IbccK+w5n5m5gtx4PlkGBZ0AH+dkJ0eY1tk+w4OMPlpQjaODSVyKDgqC8IvW2qagmmr4lPkbf
 ksfgk6MAjUx42WbhPbcGIktnVdcsME7qxZgzdOvPwO9eJ8qi8ATYqkWB1NcTkNyPQWuQEFzqB
 W8rw25Oj0xB14ekdrvDJ3F5t4H3u9jW/CI0iB1aTHEw6el0T4zapo4AFtGe/ymClhWMa94/kL
 mVAtC7swSpwIsd2ZphMK5dqJ8x/ly8GUScmerzBzYBU1StgsGF0DlQuBPACoFl6wmr5DzDYoT
 In8K7jViLSp3kIypcLEoK8q6xSaczxTLDawzvcqYk18jtR6TvEGcmO2xCzF0SYdTbOH+pExxg
 qvnKcPXc4lT5Ehu7NBignOQ+kUVradYgzwF
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-07-03 at 09:24 +0200, Mike Galbraith wrote:
>
> It also appears to be saying that there's something RT specific to
> stare at in addition to the list_lock business.

The what is ___slab_alloc() consuming 3.9% CPU in tip-rt-slub whereas
it consumes < 1% in both tip-rt (sans slub patches) and tip-slub.

The why remains to ponder.

            5.13.0.g60ab3ed-tip-rt           5.13.0.g60ab3ed-tip-rt-slub  =
    5.13.0.g60ab3ed-tip-slub
    25.18%  copy_user_enhanced_fast_string   copy_user_enhanced_fast_strin=
g   copy_user_enhanced_fast_string
     5.08%  unix_stream_read_generic         unix_stream_read_generic     =
    unix_stream_read_generic
     3.39%  rt_spin_lock                 *** ___slab_alloc ***            =
    __skb_datagram_iter
     2.80%  __skb_datagram_iter              rt_spin_lock                 =
    _raw_spin_lock
     2.11%  get_page_from_freelist           __skb_datagram_iter          =
    __alloc_skb
     2.01%  skb_release_data                 rt_spin_unlock               =
    skb_release_data
     1.94%  rt_spin_unlock                   get_page_from_freelist       =
    __alloc_pages
     1.85%  __alloc_skb                      migrate_enable               =
    unix_stream_sendmsg
     1.68%  __schedule                       skb_release_data             =
    _raw_spin_lock_irqsave
     1.67%  unix_stream_sendmsg              __schedule                   =
    free_pcppages_bulk
     1.50%  free_pcppages_bulk               unix_stream_sendmsg          =
    __slab_free
     1.38%  migrate_enable                   free_pcppages_bulk           =
    __fget_light
     1.24%  __fget_light                     __alloc_pages                =
    vfs_write
     1.16%  __slab_free                      migrate_disable              =
    __schedule
     1.14%  __alloc_pages                    __fget_light                 =
    get_page_from_freelist
     1.10%  fsnotify                         __slab_free                  =
    new_sync_write
     1.07%  kfree                            fsnotify                     =
    fsnotify

5.13.0.g60ab3ed-tip-rt-slub ___slab_alloc() consumes 3.90%
  0.40 =E2=94=82       mov    0x28(%r13),%edx
  0.42 =E2=94=82       add    %r15,%rdx
       =E2=94=82     __swab():
       =E2=94=82     #endif
       =E2=94=82
       =E2=94=82     static __always_inline unsigned long __swab(const uns=
igned long y)
       =E2=94=82     {
       =E2=94=82     #if __BITS_PER_LONG =3D=3D 64
       =E2=94=82     return __swab64(y);
  0.05 =E2=94=82       mov    %rdx,%rax
  1.14 =E2=94=82       bswap  %rax
       =E2=94=82     freelist_ptr():
       =E2=94=82     return (void *)((unsigned long)ptr ^ s->random ^  <=
=3D=3D CONFIG_SLAB_FREELIST_HARDENED
  0.72 =E2=94=82       xor    0xb0(%r13),%rax
 65.41 =E2=94=82       xor    (%rdx),%rax                              <=
=3D=3D huh? miss =3D 65% of that 3.9% kernel util?
       =E2=94=82     next_tid():
       =E2=94=82     return tid + TID_STEP;
  0.09 =E2=94=82       addq   $0x200,0x48(%r12)
       =E2=94=82     ___slab_alloc():
       =E2=94=82     * freelist is pointing to the list of objects to be u=
sed.
       =E2=94=82     * page is pointing to the page from which the objects=
 are obtained.
       =E2=94=82     * That page must be frozen for per cpu allocations to=
 work.
       =E2=94=82     */
       =E2=94=82     VM_BUG_ON(!c->page->frozen);
       =E2=94=82     c->freelist =3D get_freepointer(s, freelist);
  0.05 =E2=94=82       mov    %rax,0x40(%r12)
       =E2=94=82     c->tid =3D next_tid(c->tid);
       =E2=94=82     local_unlock_irqrestore(&s->cpu_slab->lock, flags);

5.13.0.g60ab3ed-tip-rt ___slab_alloc() consumes < 1%
Percent=E2=94=82     }
       =E2=94=82
       =E2=94=82     /* must check again c->freelist in case of cpu migrat=
ion or IRQ */
       =E2=94=82     freelist =3D c->freelist;
  0.02 =E2=94=82 a1:   mov    (%r14),%r13
       =E2=94=82     if (freelist)
       =E2=94=82       test   %r13,%r13
  0.02 =E2=94=82     =E2=86=93 je     460
       =E2=94=82     get_freepointer():
       =E2=94=82     return freelist_dereference(s, object + s->offset);
  0.23 =E2=94=82 ad:   mov    0x28(%r12),%edx
  0.18 =E2=94=82       add    %r13,%rdx
       =E2=94=82     __swab():
       =E2=94=82     #endif
       =E2=94=82
       =E2=94=82     static __always_inline unsigned long __swab(const uns=
igned long y)
       =E2=94=82     {
       =E2=94=82     #if __BITS_PER_LONG =3D=3D 64
       =E2=94=82     return __swab64(y);
  0.06 =E2=94=82       mov    %rdx,%rax
  1.16 =E2=94=82       bswap  %rax
       =E2=94=82     freelist_ptr():
       =E2=94=82     return (void *)((unsigned long)ptr ^ s->random ^
  0.23 =E2=94=82       xor    0xb0(%r12),%rax
 35.25 =E2=94=82       xor    (%rdx),%rax              <=3D=3D 35% of < 1%=
 kernel util
       =E2=94=82     next_tid():
       =E2=94=82     return tid + TID_STEP;
  0.28 =E2=94=82       addq   $0x200,0x8(%r14)
       =E2=94=82     ___slab_alloc():
       =E2=94=82     * freelist is pointing to the list of objects to be u=
sed.
       =E2=94=82     * page is pointing to the page from which the objects=
 are obtained.
       =E2=94=82     * That page must be frozen for per cpu allocations to=
 work.
       =E2=94=82     */
       =E2=94=82     VM_BUG_ON(!c->page->frozen);
       =E2=94=82     c->freelist =3D get_freepointer(s, freelist);

5.13.0.g60ab3ed-tip-slub ___slab_alloc() also consumes < 1%
Percent=E2=94=82     load_freelist:
       =E2=94=82
       =E2=94=82     lockdep_assert_held(this_cpu_ptr(&s->cpu_slab->lock))=
;
  0.28 =E2=94=82 84:   add    this_cpu_off,%rax
       =E2=94=82     get_freepointer():
       =E2=94=82     return freelist_dereference(s, object + s->offset);
  0.14 =E2=94=82       mov    0x28(%r14),%eax
       =E2=94=82     ___slab_alloc():
       =E2=94=82     * freelist is pointing to the list of objects to be u=
sed.
       =E2=94=82     * page is pointing to the page from which the objects=
 are obtained.
       =E2=94=82     * That page must be frozen for per cpu allocations to=
 work.
       =E2=94=82     */
       =E2=94=82     VM_BUG_ON(!c->page->frozen);
       =E2=94=82     c->freelist =3D get_freepointer(s, freelist);
 34.36 =E2=94=82       mov    0x0(%r13,%rax,1),%rax
       =E2=94=82     next_tid():
       =E2=94=82     return tid + TID_STEP;
  0.10 =E2=94=82       addq   $0x1,0x8(%r12)
       =E2=94=82     ___slab_alloc():
       =E2=94=82     c->freelist =3D get_freepointer(s, freelist);
  0.04 =E2=94=82       mov    %rax,(%r12)
       =E2=94=82     c->tid =3D next_tid(c->tid);
       =E2=94=82     local_unlock_irqrestore(&s->cpu_slab->lock, flags);
  0.12 =E2=94=82       mov    (%r14),%rax
  0.03 =E2=94=82       add    this_cpu_off,%rax
       =E2=94=82     arch_local_irq_restore():
       =E2=94=82     return arch_irqs_disabled_flags(flags);
       =E2=94=82     }


