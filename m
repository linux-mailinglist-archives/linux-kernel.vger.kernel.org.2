Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0F13A2737
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 10:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhFJIji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 04:39:38 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:33535 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhFJIjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 04:39:35 -0400
Received: by mail-lj1-f171.google.com with SMTP id r16so3795754ljc.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 01:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RKWJTh1c4B+K9jthsubjXAYur+C7YK5A1irCzOvOKyA=;
        b=LM2IOt13yybtCqCtXJArr3bBh4isN4aJ3vwtKFY3fwunPosYkia/k8LOhv6O9sgkZd
         3orr4Y1FQ+EFZcSYosm28QbK3PsBcUYAosXQFRTVb0gi+C3ESmcA0ovvB1vH1hSZp+yA
         xnhMnjDC5VQb+h1xWOvx5Sf0DIpqYrSNN8JaE03/MuE1NWj1Sbf9WddjwvqriugvU05U
         a3eIsYP2n7wC/cO0KvmhdzIZYz5AAgBuhJDAHNfpPWbplk1LD7Ccpk/bNaFjK7tOqiDO
         0fOrW18odbHqsNeX8iEHQwFwgHnZpPbp/eDhV817MNNyWjxTPerrDNbojFcSRbSbqCFY
         qtxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RKWJTh1c4B+K9jthsubjXAYur+C7YK5A1irCzOvOKyA=;
        b=psyNMhm5OSLJlzlkdLvV5ZXJUtL4mbsZZMg4tSOqGiU98xAvM2f2y5j1GQP5VaAZuO
         RUnIoH5Sx9HNwtbK9grVsR1fKmQdL1fK0VRWy0THtzk42br15AeDI4LLqMP8hTg60s2F
         0oxfklqdiNnVZl5DMj71Ap1EV7kIyeKp74wLS6zEJ90tV+5Z2vP/e194RedDvoqcJmO2
         YLMjbE1XEMifRuGiAbCe6lHiaWKh/p+0OWSGuRNaTS5uG83mr0HJUjUVbwvuYBPa/Cc2
         GXYiP8MtlXk98Re+8NRYCx2O9dTOYQtx/aRn+oKT2IgWArG0V7j1putElUTHF8l/5B55
         h9yg==
X-Gm-Message-State: AOAM531NyxRFEiOE61IOijF9ky3mbCQVsPG6XSAAlMlt6UP0DMfMpzju
        PfdPmpSvH6TlMFrX4qzHkFk=
X-Google-Smtp-Source: ABdhPJwQUSaksEUnoWha3KRfVI2OmYnlLhxjC5GApbT/Gt99Bw3Jq5jVDFxUByNb3QlgHaR/lAc3DA==
X-Received: by 2002:a2e:9192:: with SMTP id f18mr1279013ljg.77.1623314198417;
        Thu, 10 Jun 2021 01:36:38 -0700 (PDT)
Received: from grain.localdomain ([5.18.171.94])
        by smtp.gmail.com with ESMTPSA id z4sm95628lji.61.2021.06.10.01.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 01:36:37 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 651DE5A0041; Thu, 10 Jun 2021 11:36:36 +0300 (MSK)
Date:   Thu, 10 Jun 2021 11:36:36 +0300
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
Message-ID: <YMHPFNdy4IEUsveD@grain>
References: <20210609113903.1421-1-vbabka@suse.cz>
 <20210609113903.1421-30-vbabka@suse.cz>
 <YMFAu5kuhZbZquiI@grain>
 <ea99ecc5-365d-95d5-df88-e32a07b67b3a@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea99ecc5-365d-95d5-df88-e32a07b67b3a@suse.cz>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 10:32:14AM +0200, Vlastimil Babka wrote:
> >>  static void flush_all(struct kmem_cache *s)
> >>  {
> >> -	on_each_cpu_cond(has_cpu_slab, flush_cpu_slab, s, 1);
> >> +	struct slub_flush_work *sfw;
> >> +	unsigned int cpu;
> >> +
> >> +	cpus_read_lock();
> >> +	mutex_lock(&flush_lock);
> >> +
> > 
> > Hi, Vlastimil! Could you please point why do you lock cpus first and
> > mutex only after? Why not mutex_lock + cpus_read_lock instead?
> 
> Good question! I must admit I didn't think about it much and just followed the
> order that was in the original Sebastian's patch [1]
> But there was a good reason for this order as some paths via
> __kmem_cache_shutdown() and __kmem_cache_shrink() were alreadu called under
> cpus_read_lock. Meanwhile mainline (me, actually) removed those, so now it
> doesn't seem to be a need to keep this order anymore and we could switch it.

I bet we should switch :) But we can do that on top later, once series is
settled down and merged.
