Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD823160AC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 09:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbhBJIMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 03:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbhBJILh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:11:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCD2C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 00:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y3+x3sZzfjZbRLo0keAbiblQakTQ1YAkfrUq7k/BDqM=; b=WtCgZvqezwm2Y+j5p5s1zs+PUI
        HoVEgrcIOzGyRPN1iF2GPUu4PFi9HgO6fJSKB2JQvxlzzrwd3p4G4HY7OYgu7C1IjQD8lTXPfIwJx
        q8VwJ4J5Hq8WbQLOE/veno4JyhYhZfg6bVDcGzRG7hjdq5bryK1og2j4oiyVdJiNWm7Y4nWWXYx6v
        6p3V6b82qtyL8wrVmfRrhsEFablIedqsBoTkLsqPtqI94/r4KbxiIikTPdX4CS8nQpBfvdDmqq1LC
        8Qaue4uynqWtkIhbGZ1W5reOpKQwF86BRM52y1IjhTms34PHksOLfSDzDfOWPo+rZ1vGMv+lwie/B
        JwSaTJYA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l9ka4-008YhV-HN; Wed, 10 Feb 2021 08:10:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A96FA300446;
        Wed, 10 Feb 2021 09:10:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 96C13201D19B1; Wed, 10 Feb 2021 09:10:35 +0100 (CET)
Date:   Wed, 10 Feb 2021 09:10:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Schofield, Alison" <alison.schofield@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>,
        "brice.goglin@gmail.com" <brice.goglin@gmail.com>
Subject: Re: [PATCH] x86, sched: Allow NUMA nodes to share an LLC on Intel
 platforms
Message-ID: <YCOU+1GT4+hxqH5/@hirez.programming.kicks-ass.net>
References: <20210209223943.9834-1-alison.schofield@intel.com>
 <af770863e70340d294c324fd7004f658@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af770863e70340d294c324fd7004f658@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 11:09:27PM +0000, Luck, Tony wrote:
> > +#define X86_BUG_NUMA_SHARES_LLC		X86_BUG(25) /* CPU may enumerate an LLC shared by multiple NUMA nodes */
> 
> During internal review I wondered why this is a "BUG" rather than a "FEATURE" bit.
> 
> Apparently, the suggestion for "BUG" came from earlier community discussions.
> 
> Historically it may have seemed reasonable to say that a cache cannot span
> NUMA domains. But with more and more things moving off the motherboard
> and into the socket, this doesn't seem too weird now.

If you look at the details this SNC LLC span doesn't behave quite right
either.

It really isn't a regular cache, but behaves a bit like a mash-up of the
s390 book caches and a normal LLC.

Did anybody play with adding the book domain to these SNC
configurations? Can we detect SNC other than by this quirk?
