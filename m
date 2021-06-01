Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1957397400
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 15:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbhFANW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 09:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbhFANW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 09:22:28 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A473DC061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 06:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zTqrZmhq51DtZlmMtazWrk9jV/i4Bk4h4IOGLPy/Eso=; b=etOO2Ek7slNxGTycYgex+3MKkw
        nr0LGOg2R8aj19teHfukxrViEYVy0b04wg9m0vRldXT0qDhVdb3doVTygSakN5guMnvnpa2qUVmLP
        xn2Vc/Fxs3SYyO1v70t6t0KhVbVX9WO2SzYyLRQkt83dH3hHWHTwnsQ1PQLqRbfA2ri07wqxvG9tF
        N2qroXr3oOpHYwck40bFG2CiAq99AnOHYyBBFzNkZg3rzCOFx68m+UNX/GDZMI3v2fzw+YaNvdJlG
        Xb58+XzDMPryDtHAP83kZL6LwMp/A0zQFlNux7C/3bFkpu0zlW9pBpLJXFlfz5uB/VATTdpgiySns
        tJa8AOxg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lo4Jn-002ZcU-Mq; Tue, 01 Jun 2021 13:20:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 11070300095;
        Tue,  1 Jun 2021 15:20:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B41FC21228182; Tue,  1 Jun 2021 15:20:32 +0200 (CEST)
Date:   Tue, 1 Jun 2021 15:20:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     mhiramat@kernel.org, ananth@linux.ibm.com,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        mingo@kernel.org, rostedt@goodmis.org, x86@kernel.org
Subject: Re: [PATCH] kprobes: Do not increment probe miss count in the fault
 handler
Message-ID: <YLY0INyDtfjgVrXv@hirez.programming.kicks-ass.net>
References: <20210525073213.561116662@infradead.org>
 <20210601120150.672652-1-naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601120150.672652-1-naveen.n.rao@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 05:31:50PM +0530, Naveen N. Rao wrote:
> Kprobes has a counter 'nmissed', that is used to count the number of
> times a probe handler was not called. This generally happens when we hit
> a kprobe while handling another kprobe.
> 
> However, if one of the probe handlers causes a fault, we are currently
> incrementing 'nmissed'. The comment in fault handler indicates that this
> can be used to account faults taken by the probe handlers. But, this has
> never been the intention as is evident from the comment above 'nmissed'
> in 'struct kprobe':
> 
> 	/*count the number of times this probe was temporarily disarmed */
> 	unsigned long nmissed;
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
> I'm posting this here so that these can go together, if the patch is ok 
> otherwise.

I had the other two queued in perf/core and was about to push then to
tip, Masami are you good with adding this on top?
