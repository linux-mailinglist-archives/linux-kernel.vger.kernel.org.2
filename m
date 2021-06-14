Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BBF3A653A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 13:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbhFNLfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 07:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbhFNLVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 07:21:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED381C0611C6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 04:16:24 -0700 (PDT)
Date:   Mon, 14 Jun 2021 13:16:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623669381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=++e4A/S400E85MA7JQbxrze69YWqU4ooV/kaCLvdV1M=;
        b=LrPKSkXilgXlJ80Tlo2vEln+cxsJ/bOVcQL9pwU4dfucv71qBhsKGEn6/kvL2TPJ/SJlrA
        2bz3ynWqUuT8TYrRp4FNF3WySeWXE4fL7Z5Yp05grcyC+BJIkmEA+hkM3Nfkf+ddCDVMY2
        MjEpGbLZ5Iir4mbVH4FOK/vyVca4vJf6yHyxhokjHm0j/R6B8jPSC5bxZTJ1piZIe6ku1f
        RtRmaUqkRdONvxV38zafFtjdw6QAwA8GgYJQXgz9TnNieTnSwN2VUGgFuEqDZa9Am5TAre
        MYeKV7DAmeHIx5b4HsC3Ueqtld+KPJyCYrVTbr3APyTu8X35cxqXjsZSYqH7OQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623669381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=++e4A/S400E85MA7JQbxrze69YWqU4ooV/kaCLvdV1M=;
        b=7t5RdSbKecVbT7rqp3zRhYOnZm2a/qTFJ9Y569zzdkoOCsTDGP2ZN065AYWGbOAOlmnT+a
        1nBIEkCUO7ty+BAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vlastimil Babka <vbabka@suse.cz>
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
Subject: Re: [RFC v2 33/34] mm, slub: use migrate_disable() on PREEMPT_RT
Message-ID: <20210614111619.l3ral7tt2wasvlb4@linutronix.de>
References: <20210609113903.1421-1-vbabka@suse.cz>
 <20210609113903.1421-34-vbabka@suse.cz>
 <c553c26f-1f9c-e5ab-b71b-b2b5eeb59ad2@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c553c26f-1f9c-e5ab-b71b-b2b5eeb59ad2@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-14 13:07:14 [+0200], Vlastimil Babka wrote:
> > +#ifdef CONFIG_PREEMPT_RT
> > +#define slub_get_cpu_ptr(var)	get_cpu_ptr(var)
> > +#define slub_put_cpu_ptr(var)	put_cpu_ptr(var)
> 
> After Mel's report and bisect pointing to this patch, I realized I got the
> #ifdef wrong and it should be #ifnded

So if you got the ifdef wrong (and kept everything as-is) then you
tested the RT version on !RT. migrate_disable() behaves on !RT as on RT.
As per changelog you don't use migrate_disable() unconditionally because
it increases the overhead on !RT.
I haven't looked at the series and I have just this tiny question: why
did migrate_disable() crash for Mel on !RT and why do you expect that it
does not happen on PREEMPT_RT?

Sebastian
