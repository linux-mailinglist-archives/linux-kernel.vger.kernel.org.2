Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5BD30BE0F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 13:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhBBMTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 07:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhBBMR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 07:17:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AB3C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 04:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k2RaVcotdcFu8XtC0FHhOwZVl2mL0n0CI/DzN9Tnq0k=; b=Mlq/Kbsh9al83KXXilK1z+etHY
        Y8n56IRFwIVfPokruVKN9TPIMY+alFEyb5SDyf2oq+QFJX1LYSKwSvAE2/Nuc0bBlJHVhvr2Mu6iL
        CzDdpFw6bUhbC4FIdH2Vmo/2wdUWTSfo14IT/T8jCQVFVUwotOw1dYQat1LoBFb3GXaOpr75PASZa
        fSS5JO5CtZcfTX0s5TD5B6hcRcUe+DWp7GconOLA+4YNrBzZYbeVPvX3aDg0/bdAm70WKKjcy5mu/
        kdmYkykXP/KM/jqOjdhGPp+29FyM6S5jVVqJlb7jMj6JMK2wAFs3QdUFlsnHPJ37ZoGcYgH3l/poc
        ljrJKQmQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l6ucG-00FAbn-Al; Tue, 02 Feb 2021 12:17:10 +0000
Date:   Tue, 2 Feb 2021 12:17:08 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        page-reclaim@google.com
Subject: Re: Augmented Page Reclaim
Message-ID: <20210202121708.GT308988@casper.infradead.org>
References: <YBkT6175GmMWBvw3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBkT6175GmMWBvw3@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


It's hard to know which 'note' refers to which reference.  Here's
my attempt to figure that out.

On Tue, Feb 02, 2021 at 01:57:15AM -0700, Yu Zhao wrote:

> Versatility
> ===========
> Userspace can trigger aging and eviction independently via the
> ``debugfs`` interface [note]_ for working set estimation, proactive

1. `Long-term SLOs for reclaimed cloud computing resources
   <https://research.google/pubs/pub43017/>`_

> reclaim, far memory tiering, NUMA-aware job scheduling, etc. The
> metrics from the interface are easily interpretable, which allows
> intuitive provisioning and discoveries like the Borg example above.
> For a warehouse-scale computer, the interface is intended to be a
> building block of a closed-loop control system, with a machine
> learning algorithm being the controller.
> 
> Simplicity
> ==========
> The workflow [note]_ is well defined and each step in it has a clear

2. `Profiling a warehouse-scale computer
   <https://research.google/pubs/pub44271/>`_

> meaning. There are no magic numbers or heuristics involved but a few
> basic data structures that have negligible memory footprint. This
> simplicity has served us well as the scale and the diversity of our
> workloads constantly grow.
[...]
> FAQ
> ===
> What is the motivation for this work?
> -------------------------------------
> In our case, DRAM is a major factor in total cost of ownership, and
> improving memory overcommit brings a high return on investment.
> Moreover, Google-Wide Profiling has been observing the high CPU
> overhead [note]_ from page reclaim.

3. `Evaluation of NUMA-Aware Scheduling in Warehouse-Scale Clusters
   <https://research.google/pubs/pub48329/>`_

> Why not try to improve the existing code?
> -----------------------------------------
> We have tried but concluded the two limiting factors [note]_ in the

4. `Software-defined far memory in warehouse-scale computers
   <https://research.google/pubs/pub48551/>`_

> existing code are fundamental, and therefore changes made atop them
> will not result in substantial gains on any of the aspects above.
> 
> What particular workloads does it help?
> ---------------------------------------
> This work optimizes page reclaim for workloads that are not IO bound,
> because we find they are the norm on servers and clients in the cloud
> era. It would most likely help any workloads that share the common
> characteristics [note]_ we observed.

5. `Borg: the Next Generation
   <https://research.google/pubs/pub49065/>`_

