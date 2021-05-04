Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5234F372802
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 11:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhEDJVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 05:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhEDJVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 05:21:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009F0C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 02:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P3y2DFaDAO2518AHnPLoOuXHnOylXMn+Tq53Ow0ilZE=; b=Z86u6UVjMJU+z8lI+a7gVTfipW
        zxs2IPPrLL/3oYz/rLcT+DqGqLMFUCRtwWRba9iNPTUnOjcNHC7G5Eg4klzYraioF3XZFGmvsXnyl
        E4uixeSwDdJ/NObm5WD0wEbowh1EspAUuOcQCVaryUFQF7gu8GOqRdZkLU+nzgLL8PS3p+/nq9Bhj
        oNT2NANS/5GNVV1O1zvHXL7a1XFQjOMgw2OQToMMhO5YxpPloyjKkuif5bhZ5GkerWElfutDpCHeS
        aYthOMeG2tk+lapZEY0aTXUro4AHK+khS3qDsYDzvGDi18CHeRGma/reHhrtcDuhXOL5l7RGrAO/X
        4BYKnF1Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ldrDZ-00GO1w-Ii; Tue, 04 May 2021 09:19:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 901363001D0;
        Tue,  4 May 2021 11:19:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 72B2820264CB3; Tue,  4 May 2021 11:19:48 +0200 (CEST)
Date:   Tue, 4 May 2021 11:19:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Ali Saidi <alisaidi@amazon.com>,
        Steve Capper <steve.capper@arm.com>
Subject: Re: [PATCH] locking/qrwlock: queued_write_lock_slowpath() cleanup
Message-ID: <YJERtJD012uGlp4C@hirez.programming.kicks-ass.net>
References: <20210426185017.19815-1-longman@redhat.com>
 <20210427075659.GA6675@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427075659.GA6675@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 08:56:59AM +0100, Will Deacon wrote:
> On Mon, Apr 26, 2021 at 02:50:17PM -0400, Waiman Long wrote:
> > Make the code more readable by replacing the atomic_cmpxchg_acquire()
> > by an equivalent atomic_try_cmpxchg_acquire() and change atomic_add()
> > to atomic_or().
> > 
> > For architectures that use qrwlock, I do not find one that has an
> > atomic_add() defined but not an atomic_or().  I guess it should be fine
> > by changing atomic_add() to atomic_or().
> > 
> > Note that the previous use of atomic_add() isn't wrong as only one
> > writer that is the wait_lock owner can set the waiting flag and the
> > flag will be cleared later on when acquiring the write lock.
> 
> Right, there's no functional change here.
> 
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Waiman Long <longman@redhat.com>

> Acked-by: Will Deacon <will@kernel.org>

Thanks!
