Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5896A425506
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 16:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241958AbhJGOKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 10:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240542AbhJGOKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 10:10:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB15DC061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 07:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NiKb7IlNuU96s12SmMknLIyyo2Hv/TtD6I5V5lfo/UU=; b=mailEgdF25frHHDRYlc7T9Reru
        UhEhiKh3piSw8aPUEYMlJbQpq13sldVzJtFSjivqa/yAizGnM209LquVJuA1lZjpeRH2MAGEbXTSL
        5toYcuGwKnvPQ4z9H+7rt7P01QqNfs8E+f5R7ESQoVG4O+bjYf/HW0N/YF8jfLTy0fCrF9oTJjqLd
        v47OSxby1s7knnVn130ton+nNFDNdnRXHrGORygLx8Pc8jJm5tjlCCnEbMvsphRticq4suZgnY2Fh
        5zt/pCG+rm8alV1Jhhg8IfyknSqrQpM3WRwGkmfhgmRvpcsXgLSd8/Dw2mZO0tOFFzlXyf1fTwIHm
        0Gaoxgwg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYU2z-001urb-Ax; Thu, 07 Oct 2021 14:07:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CF651300347;
        Thu,  7 Oct 2021 16:06:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B864F2C693FB9; Thu,  7 Oct 2021 16:06:55 +0200 (CEST)
Date:   Thu, 7 Oct 2021 16:06:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] x86/apic: reduce cache line misses in
 __x2apic_send_IPI_mask()
Message-ID: <YV7+/0+Q1n67wCF8@hirez.programming.kicks-ass.net>
References: <20211007031756.345269-1-eric.dumazet@gmail.com>
 <20211007072917.GN174703@worktop.programming.kicks-ass.net>
 <CANn89iKOa+tqerm80vHvHEurc2UxTq_heQuOUE0KnVuJht8AKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iKOa+tqerm80vHvHEurc2UxTq_heQuOUE0KnVuJht8AKA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 07:04:09AM -0700, Eric Dumazet wrote:
> On Thu, Oct 7, 2021 at 12:29 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Oct 06, 2021 at 08:17:56PM -0700, Eric Dumazet wrote:
> > > +/* __x2apic_send_IPI_mask() possibly needs to read
> > > + * x86_cpu_to_logical_apicid for all online cpus in a sequential way.
> > > + * Using per cpu variable would cost one cache line per cpu.
> > > + */
> >
> > Broken comment style..
> 
> I was not sure and ran checkpatch.pl before submission, but sure.
> 
> >
> > > +static u32 x86_cpu_to_logical_apicid[NR_CPUS] __read_mostly;
> >
> > NR_CPUS is really sad, could this at all be dynamically allocated? Say
> > in x2apic_cluster_probe() ?
> 
> Good idea, I will try this.
> Hopefully nr_cpu_ids is populated there ?

Lets hope :-), I'm always terminally lost in early bringup. I figure it
should be painfully obvious if it goes wrong.
