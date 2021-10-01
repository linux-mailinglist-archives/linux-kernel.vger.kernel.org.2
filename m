Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA3941EE9A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 15:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhJANc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 09:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbhJANc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 09:32:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BFDC061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 06:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LsEowLyh+XDnn2t+V7KKl/KkGlcM7KUzAyO5EF9PelU=; b=KHtf6VZTQ2V5Ue4llu9QH1ZCEA
        1RPA2NF523PAZ6zJyOEIC2axBkQIiH+pHOOvxiqbmRN+97Q5qO2dTE2Yp9K5IF3SjaaSZMsYf3VbZ
        wuFgxQ+3amELNgoKIQPBsVV9OIAjofy70Nhi8kJFaExv+/7nVrE1hhRrMRnu0jO8MZ1qGkZPULxgG
        ogqlpjs6RCa+OtYm8i08dzHNQ4iBLYuK94E3HmAnkOyag/FsopG07/qGPHdqyHv6q9zcjuCpJ++yV
        +KAHzUvwrBdcVDy8uIS+dhMgL6aEvw1n9CKA+Mf4gqI5S8j2HjKFtGnYzZZcQNPLEHg7RdCYyl8So
        UUE+kpNg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mWIbs-00Dvnw-SL; Fri, 01 Oct 2021 13:30:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DAEAB30214E;
        Fri,  1 Oct 2021 15:29:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C66692C53BFE3; Fri,  1 Oct 2021 15:29:55 +0200 (CEST)
Date:   Fri, 1 Oct 2021 15:29:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH] x86/sev: Fully map the #VC exception stacks
Message-ID: <YVcNUzrtRqnsH6yj@hirez.programming.kicks-ass.net>
References: <113eca80a14cd280540c38488fd31ac0fa7bf36c.1633063250.git.thomas.lendacky@amd.com>
 <YVbNlXwiASQEsG+x@zn.tnic>
 <YVb2AGXAwYx/OI6J@suse.de>
 <YVcF9ENTfLAGaLec@zn.tnic>
 <YVcGdpVuSsieFL8W@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVcGdpVuSsieFL8W@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 03:00:38PM +0200, Joerg Roedel wrote:
> On Fri, Oct 01, 2021 at 02:58:28PM +0200, Borislav Petkov wrote:
> > On Fri, Oct 01, 2021 at 01:50:24PM +0200, Joerg Roedel wrote:
> > > Yeah, I think the right fix is to export cea_map_percpu_pages() and move
> > > the cea_map_stack() macro to a header and use it to map the VC stacks.
> > 
> > I'll do you one better: Put the #VC stack mapping into
> > percpu_setup_exception_stacks(), where it naturally belongs and where
> > the other stacks are being mapped instead of doing everything "by hand"
> > like now and exporting random helpers.
> 
> The VC stack is only allocated and mapped when SEV-ES is detected, so
> they can't always be mapped by generic code.

It's just a few pages per cpu, is that worth it? Why not have it
unconditinoally allocated in the right place when it finds the CPU is
SEV capable?
