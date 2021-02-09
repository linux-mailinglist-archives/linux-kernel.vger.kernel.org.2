Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3D5315271
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 16:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbhBIPOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 10:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbhBIPN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 10:13:58 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B101C061788
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 07:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dUYN0boWBMMs1TlxAWQArWnMpuyrkLnX1B19yQ7qg60=; b=lLgHTy5av/y2qcVDW7+wONJvFt
        cjUxSI9ADN1FwpSpBt1Z3K+6aj4N0AYriEtuqVgyQCNaEB5OHSA154Jwv2g10uU2/0x46X/mEtJIf
        FAqiV0kbCJIKIc7boMR0wiUpnYmfZvqAL9CRl8CGjNgFmPSUFw0Z6hxfyd+ckwdlFNjcsMg0RAfbh
        bMfeEmWiJyUEbIbK72poTcYTJHBvwQ9n/aMXawHnJKZ4OLYxMBP5wvHKhhslKNGePvMN0wSlPuLEf
        2X0XSP5nTQlvxt0wwz1DoYywUmUzL8/nSHc2QW9Q1mZNfjg3CarcIH2/Fpiyxw7sGwW0fJ3tE4tdB
        ep1Hegyw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l9UhV-000524-Sh; Tue, 09 Feb 2021 15:13:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7D5AF304BAE;
        Tue,  9 Feb 2021 16:13:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 69EB22BC93529; Tue,  9 Feb 2021 16:13:10 +0100 (CET)
Date:   Tue, 9 Feb 2021 16:13:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mike Galbraith <efault@gmx.de>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch] preempt: select PREEMPT_DYNAMIC under PREEMPTION instead
 of PREEMPT
Message-ID: <YCKmhnoSKgdYqxOL@hirez.programming.kicks-ass.net>
References: <7d129a84b0858fd7fbc3e38ede62a848fbec536e.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d129a84b0858fd7fbc3e38ede62a848fbec536e.camel@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 02:45:37PM +0100, Mike Galbraith wrote:
> 
> PREEMPT_RT and PREEMPT both needs PREEMPT_DYNAMIC to build, so move
> selection of PREEMPT_DYNAMIC to the common denominator, PREEMPTION.

I'm confused, why would you want PREEMPT_DYNAMIC for PREEMPT_RT ?

PREEMPT_RT without full preemption is just plain daft, no?
