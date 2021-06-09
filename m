Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056E03A2005
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 00:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhFIWbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 18:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhFIWbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 18:31:15 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AAFC061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 15:29:19 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id e2so1897919ljk.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 15:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M7Xu6kMcR2et3beJeKJaJObrep7udVBP5n2divRH1FM=;
        b=rdDQNK6m4jBlvDuU6bj+Gzw97BzicOCqW2SQgUTxN1TGC40Fw2yss+gJi6MWcOVsJS
         OvFg0w6wS/wmMV+DrcCRYgKAA+zxaPqdQO3BWMYzShEAJg1JTIhfR1ZGyomrmeHMHR6G
         lhQUGQczHRk25hSA8nsRCpR4Ii5BNqkPyzHr1wGVP1nvx0j83DvMLqohL50E8WXDzmSb
         pi7rUsuA13cgqqGUb1J+ZgVqql3wtd61RW49VTj5u6VGEoabJ6F3SezzuSfRJZekONzQ
         OSIkWKfQz2H9BE4pdc+XaUYbzwjOxV7pQtN2cCF/jPNi3RlZWKCRfQCwWLnrhE7z+SDe
         SSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M7Xu6kMcR2et3beJeKJaJObrep7udVBP5n2divRH1FM=;
        b=Dbq2RF9OeIw4xuNup6cnHh2QBuYiBRiFx9Pr/VGKNy4CtD5AhUeExrocg5yTc6wtBl
         SvyrI7UvrQS64OgeoIhe1Fnbk+GPQEcKazzKHbB4o11cGGVf8EUudAV3tUmNHXwntB4i
         nSm8WYM7BcSfhYcCBUFk8x7el25/8nl7jYE+iFrP4TAC9N9FNh/13LsJ991CdcaipjtD
         n5cn/fOqZdCQlYxZYqzsjxeV4GwOLRnL2sRNMxIDRDp21SVmqbMsP2kxPYUtDOwtEkTM
         fSsk1hIeYXf9wc4487iKAtGTdn73gj3jQddcXuQpgCpfGKmIk0fA+hmFGSH5DBhAozQW
         NxEQ==
X-Gm-Message-State: AOAM5306JCDIjKQHkJAKXbyr+0HVPgmNkNn+aYWIJ9QW7k7bydbqFKAk
        AdsSGrWmRTrzLtq73AKjTx+wp0ceAbI=
X-Google-Smtp-Source: ABdhPJwjAK958nvDVvTjhGuLwBhggZDV71YKEl5Amb+3n969qP4LK47e6wnU+Vn5pI7X+hBVp7xxhA==
X-Received: by 2002:a05:651c:1057:: with SMTP id x23mr1382097ljm.467.1623277758099;
        Wed, 09 Jun 2021 15:29:18 -0700 (PDT)
Received: from grain.localdomain ([5.18.171.94])
        by smtp.gmail.com with ESMTPSA id r3sm111100ljc.20.2021.06.09.15.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 15:29:16 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
        id C25C85A0041; Thu, 10 Jun 2021 01:29:15 +0300 (MSK)
Date:   Thu, 10 Jun 2021 01:29:15 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [RFC v2 29/34] mm: slub: Move flush_cpu_slab() invocations
 __free_slab() invocations out of IRQ context
Message-ID: <YMFAu5kuhZbZquiI@grain>
References: <20210609113903.1421-1-vbabka@suse.cz>
 <20210609113903.1421-30-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609113903.1421-30-vbabka@suse.cz>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 01:38:58PM +0200, Vlastimil Babka wrote:
> +static DEFINE_MUTEX(flush_lock);
> +static DEFINE_PER_CPU(struct slub_flush_work, slub_flush);
> +
>  static void flush_all(struct kmem_cache *s)
>  {
> -	on_each_cpu_cond(has_cpu_slab, flush_cpu_slab, s, 1);
> +	struct slub_flush_work *sfw;
> +	unsigned int cpu;
> +
> +	cpus_read_lock();
> +	mutex_lock(&flush_lock);
> +

Hi, Vlastimil! Could you please point why do you lock cpus first and
mutex only after? Why not mutex_lock + cpus_read_lock instead?
