Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052983D7265
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 11:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbhG0Jyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 05:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235993AbhG0Jyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 05:54:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19B5C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 02:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xHaIGZcgG1l1kYUR2GlnOuG/Etl6l+xUZifRAQb39Gw=; b=UsBXcQCQt/4qmULQixZYqdaiMK
        Vz5tVXBIJXmZR3A6sMkznpYugzmqj+STI5HmCCNZ3AHgqalLaT4BoGF6g5xXooERbo6fMlqqHTKv8
        +zZ/NLY/WB9B3IwJKwFpXJ4JnPjcn+UtkJicIYgwFWzj+ZaGYfUUmpXJXVzm0xoFsGQbTRTULSl6V
        UY44pgpPhLaESAD5FZ2HDyOQB4hV/sdfSEK6PHHeHHX7uhcyaz11y9BM8gu+kN5Ta8zjsQBcBek5M
        dCXB8cUcyuzbW6/Hc+a5xGUvHraXltDeYIacVIksIjrMeTMahAAEWJ06gYOseUauYCxNraknK+H1k
        86tmBUGw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8JnM-003PQA-8u; Tue, 27 Jul 2021 09:54:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CCDDA300233;
        Tue, 27 Jul 2021 11:54:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BA9CB202492DB; Tue, 27 Jul 2021 11:54:38 +0200 (CEST)
Date:   Tue, 27 Jul 2021 11:54:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joelaf@google.com>
Cc:     "Rajendran, Jaishankar" <jaishankar.rajendran@intel.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Vineeth Pillai <vineethrp@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mallikarjun Chegaraddi, Raju" 
        <raju.mallikarjun.chegaraddi@intel.com>
Subject: Re: Core Scheduling - Concurrent VMs
Message-ID: <YP/X3nSGBfkZ1/c3@hirez.programming.kicks-ass.net>
References: <PH0PR11MB51748333769D9002912FF63C84E89@PH0PR11MB5174.namprd11.prod.outlook.com>
 <CAJWu+oq98Yh4kknze7u6SOYZNw6hR5aFkj61aXbTV3JPq=7RNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+oq98Yh4kknze7u6SOYZNw6hR5aFkj61aXbTV3JPq=7RNg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 11:57:21AM -0400, Joel Fernandes wrote:
> Hi,
> +Dario Faggioli and +Vineeth Pillai as well.
> 
> On Mon, Jul 26, 2021 at 1:41 AM Rajendran, Jaishankar
> <jaishankar.rajendran@intel.com> wrote:
> >
> > Refer to the below experiments performed using Core Scheduling for Concurrent VMs and we found the benchmark scores executed in different VMs are
> > degrading after enablement of Core Scheduling. Both the host and guest are enabled with Core Scheduler
> 
> Why are you running core scheduling within the guest? Only the host
> needs it and you tag vCPU threads in the host. Within the guest you
> don't need it (and it probably doesn't make sense unless you pin the
> vCPU threads to individual physical hardware threads).

Correct, in-guest core-scheduling only works if there's an in-guest
topology, which requires pinning vcpu threads and sacrificing a chicken
on the altar of qemu to get the right incantation such that the guest
actually receives the right topology.

Nested core scheduling hurts my head.

> I don't think these commands can really tell you that core scheduler
> is working or not. They are too coarse grained. You would need to look
> at it through ftrace scheduling events. Core scheduling will still
> allow differently tagged threads to use a core, it is just that it
> wont allow it simultaneously.

Right, you need tracing to verify it actually works, no real alternative
there.
