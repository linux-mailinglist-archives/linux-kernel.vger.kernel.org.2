Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8CA43EEC6B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 14:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237231AbhHQM27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 08:28:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234866AbhHQM2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 08:28:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1911B6023F;
        Tue, 17 Aug 2021 12:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629203301;
        bh=geigma0GEh1kh7nbZKs6FoG3y8PjVJoUk2XewbAE77w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fZN234TlSJyxnfsm69zZNuAlqAr3lp2I0aAC1hlU2HCo16Gw58H43KlDSziVtmzca
         4LMdH6HOUw8+LIyW7Rmd0s9pCCL08YoWjJ7PAxZXIsJnDn7qyGnQQtZptmvKWi3BBX
         spvV/9oeJbyhoy5bVh+Wp9DBO9YsZ1lGkrvefDQAXgfIF628qM/LfNeVxAhofjONQw
         AS+fINbXHFf8zhre0/0L0ozEIxgR7vuzfPTRNq7lBfnHoB/TRBKm2eZKLeFcDuc9Wy
         05g/Gsi9roF2yzxZ347ctkTW71SeJavolcLhlWPzGZq1obNurrA746BOAApikkPLZw
         Am+qFseWF/6tA==
Date:   Tue, 17 Aug 2021 13:28:16 +0100
From:   Will Deacon <will@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Marco Elver <elver@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: LKMM: Read dependencies of writes ordered by dma_wmb()?
Message-ID: <20210817122816.GA12746@willie-the-truck>
References: <YRo58c+JGOvec7tc@elver.google.com>
 <20210816145945.GB121345@rowland.harvard.edu>
 <YRqfJz/lpUaZpxq7@elver.google.com>
 <20210816192109.GC121345@rowland.harvard.edu>
 <20210816205057.GN4126399@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816205057.GN4126399@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just on this bit...

On Mon, Aug 16, 2021 at 01:50:57PM -0700, Paul E. McKenney wrote:
> 5.	The dma_mb(), dma_rmb(), and dma_wmb() appear to be specific
> 	to ARMv8.

These are useful on other architectures too! IIRC, they were added by x86 in
the first place. They're designed to be used with dma_alloc_coherent()
allocations where you're sharing something like a ring buffer with a device
and they guarantee accesses won't be reordered before they become visible
to the device. They _also_ provide the same ordering to other CPUs.

I gave a talk at LPC about some of this, which might help (or might make
things worse...):

https://www.youtube.com/watch?v=i6DayghhA8Q

Ignore the bits about mmiowb() as we got rid of that.

Will
