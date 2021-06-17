Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4276A3AB719
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 17:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbhFQPQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 11:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbhFQPQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 11:16:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2377C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 08:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GXlfWx9JUbP9b8gxj5LZ7fqJzEAeMsow2tbZ3FScmGI=; b=Dd2DRPf8zwHWhsHi+D/Xh1yD9J
        vCRzuhMpjvfQ0ih4Al0suioKYF6scvJqkrDHWKfvJiYVUggKi1LyCWO802Gb+BVQiVEfFIf0OPVMI
        A6+Excr1zXAbyAyDvL3+e7AwLap+P3VMe3u9i8VhARA3GUM+5NZx2bEVimsBvKJFfsybfzv6Q4gmJ
        XNsAEqWBXD47IJ/wsRFhRumGQYNBdciil39xyWkAcEe+xFtjsbH1CftWFoelhMPop0ymDVQlL7hXg
        TD1kwcEz/Iqh5BjVOLde8AUoIPA9w9g2bd/qrG90L3M1dPxOPbPMAbDTxaeXfFspvrO3spYhUk3lV
        0H26fPEQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltthn-009Ge2-OG; Thu, 17 Jun 2021 15:13:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4A966300204;
        Thu, 17 Jun 2021 17:13:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0CD832BD52F2E; Thu, 17 Jun 2021 17:13:17 +0200 (CEST)
Date:   Thu, 17 Jun 2021 17:13:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        the arch/x86 maintainers <x86@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 7/8] membarrier: Remove arm (32) support for SYNC_CORE
Message-ID: <YMtmjUzmv5QW9b7x@hirez.programming.kicks-ass.net>
References: <cover.1623813516.git.luto@kernel.org>
 <2142129092ff9aa00e600c42a26c4015b7f5ceec.1623813516.git.luto@kernel.org>
 <20210617103524.GA82133@C02TD0UTHF1T.local>
 <20210617112305.GK22278@shell.armlinux.org.uk>
 <20210617113349.GB82133@C02TD0UTHF1T.local>
 <394219d4-36a6-4e7f-a03c-8590551b099a@www.fastmail.com>
 <20210617135133.GA86101@C02TD0UTHF1T.local>
 <33241b25-4d45-4278-a4e6-ec9c12b0e1f3@www.fastmail.com>
 <YMtj4Xoo5lh4fGSx@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMtj4Xoo5lh4fGSx@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 05:01:53PM +0200, Peter Zijlstra wrote:
> On Thu, Jun 17, 2021 at 07:00:26AM -0700, Andy Lutomirski wrote:
> > On Thu, Jun 17, 2021, at 6:51 AM, Mark Rutland wrote:
> 
> > > It's not clear to me what "the right thing" would mean specifically, and
> > > on architectures with userspace cache maintenance JITs can usually do
> > > the most optimal maintenance, and only need help for the context
> > > synchronization.
> > > 
> > 
> > This I simply don't believe -- I doubt that any sane architecture
> > really works like this.  I wrote an email about it to Intel that
> > apparently generated internal discussion but no results.  Consider:
> > 
> > mmap(some shared library, some previously unmapped address);
> > 
> > this does no heavyweight synchronization, at least on x86.  There is
> > no "serializing" instruction in the fast path, and it *works* despite
> > anything the SDM may or may not say.
> 
> I'm confused; why do you think that is relevant?
> 
> The only way to get into a memory address space is CR3 write, which is
> serializing and will flush everything. Since there wasn't anything
> mapped, nothing could be 'cached' from that location.
> 
> So that has to work...

Ooh, you mean mmap where there was something mmap'ed before. Not virgin
space so to say.

But in that case, the unmap() would've caused a TLB invalidate, which on
x86 is IPIs, which is IRET.

Other architectures include I/D cache flushes in their TLB
invalidations -- but as elsewhere in the thread, that might not be
suffient on its own.

But yes, I think TLBI has to imply flushing micro-arch instruction
related buffers for any of that to work.
