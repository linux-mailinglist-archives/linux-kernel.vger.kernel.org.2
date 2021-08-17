Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2BED3EE9E4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 11:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239369AbhHQJcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 05:32:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59188 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbhHQJcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 05:32:09 -0400
Date:   Tue, 17 Aug 2021 11:31:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629192695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3v+oc/bqZeg96prM4rS81EqaAVykZtsx4aWLCDpAyV8=;
        b=1Bs85gkppe3FSji0BN/4h7mU2N+Z2N4xFGB6NWpWjwXCpPfOiuAQ50qmpo6seVsYyXtFm5
        uf8rfEbpSOTCoWEOOew+Eq5U7wFc+rUPFZNcJH6L6uZnO6fAofNRCil+PMRfzmaKxYykFy
        u8e+vtUYt62FheAl8hpNhCzUX8lj93Htg4xzPDeGL3NfLLebA+z60HDFMqOSxawJdwg8JN
        eTLCet6BeIdwkOGkcZEhBoJqm9ONg8CnkmwC+hXXen4L0IHJVf2DnVCoQC14fB72MIvP3S
        oz6TM61l7zxGhQCddvKBPsNfNr6JaGP1YMMgUh4npQ6aMJBU23N0eu6nq87GEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629192695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3v+oc/bqZeg96prM4rS81EqaAVykZtsx4aWLCDpAyV8=;
        b=vxFNw1UOK3Fv+7SupTwdwfCSBxbMsPNTE1Nt8hbP1LMj2iKMTb+SdupS/VnMRXPRE/SySK
        87pUyj0EDr7EtdCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Sven Eckelmann <sven@narfation.org>, akpm@linux-foundation.org,
        brouer@redhat.com, cl@linux.com, efault@gmx.de,
        iamjoonsoo.kim@lge.com, jannh@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mgorman@techsingularity.net, penberg@kernel.org,
        rientjes@google.com, tglx@linutronix.de,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 35/35] mm, slub: convert kmem_cpu_slab protection to
 local_lock
Message-ID: <20210817093133.kzwq2vx5gtrwevih@linutronix.de>
References: <2666777.vCjUEy5FO1@sven-desktop>
 <7329198a-2a4e-ebc2-abf8-f7f38f00d5e1@suse.cz>
 <20210817091224.nqnrro34cyb67chj@linutronix.de>
 <b1e88f8a-ddf1-67d2-52a3-9e57eac01406@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b1e88f8a-ddf1-67d2-52a3-9e57eac01406@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-17 11:17:18 [+0200], Vlastimil Babka wrote:
> On 8/17/21 11:12 AM, Sebastian Andrzej Siewior wrote:
> > On 2021-08-17 10:37:48 [+0200], Vlastimil Babka wrote:
> >> OK reproduced. Thanks, will investigate.
> > 
> > With the local_lock at the top, the needed alignment gets broken for dbl
> > cmpxchg. On RT it was working ;)
> 
> I'd rather have page and partial in the same cacheline as well, is it ok
> to just move the lock as last and not care about whether it straddles
> cachelines or not? (with CONFIG_SLUB_CPU_PARTIAL it will naturally start
> with the next cacheline).

Moving like you suggested appears to be more efficient and saves a bit
of memory:

RT+ debug:
struct kmem_cache_cpu {
        void * *                   freelist;             /*     0     8 */
        long unsigned int          tid;                  /*     8     8 */
        struct page *              page;                 /*    16     8 */
        struct page *              partial;              /*    24     8 */
        local_lock_t               lock;                 /*    32   144 */

        /* size: 176, cachelines: 3, members: 5 */
        /* last cacheline: 48 bytes */
};

RT no debug:
struct kmem_cache_cpu {
        void * *                   freelist;             /*     0     8 */
        long unsigned int          tid;                  /*     8     8 */
        struct page *              page;                 /*    16     8 */
        struct page *              partial;              /*    24     8 */
        local_lock_t               lock;                 /*    32    32 */

        /* size: 64, cachelines: 1, members: 5 */
};

no-RT, no-debug:
struct kmem_cache_cpu {
        void * *                   freelist;             /*     0     8 */
        long unsigned int          tid;                  /*     8     8 */
        struct page *              page;                 /*    16     8 */
        struct page *              partial;              /*    24     8 */
        local_lock_t               lock;                 /*    32     0 */

        /* size: 32, cachelines: 1, members: 5 */
        /* last cacheline: 32 bytes */
};

no-RT, debug:
struct kmem_cache_cpu {
        void * *                   freelist;             /*     0     8 */
        long unsigned int          tid;                  /*     8     8 */
        struct page *              page;                 /*    16     8 */
        struct page *              partial;              /*    24     8 */
        local_lock_t               lock;                 /*    32    56 */

        /* size: 88, cachelines: 2, members: 5 */
        /* last cacheline: 24 bytes */
};

Sebastian
