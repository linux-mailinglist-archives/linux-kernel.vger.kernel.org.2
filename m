Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43DD43D8A90
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 11:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbhG1J1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 05:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbhG1J1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 05:27:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9D1C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 02:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QWgqXvGn7ERvUnYT3SkaewzclE8rix70gP3rgviSeKE=; b=ajddRfeMrubaIx5emf4FxaCxk1
        Fru/MFd/duQYV7Ceor3cagi9iGgzbam1i/vM3MIooo6KaUPt48J/ZkFVNbcfbLg+nZoZeuJA2fzv7
        WEYqbeqEVK+UoMmAxTvp5rpZBR7oIQdzCwZufOuybHiyg83au2xl20v5fadcLwLgJGKf092IPfjEf
        4HeE32iDGtQJDOA8GOW5kf09onhvAeGqaXX5bocdYus9eEiR/z7ZszXvkyPLOSUojgX/zJQJvB6UU
        K7F/sO4pUXnB56LZv3aPQuQn77igsTjE1XZeXCv3rxVeUSMwp1HkhThnWWNf2mEJDjSjMopZrTYOO
        lJq2gu4A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8fpG-00FtyZ-P0; Wed, 28 Jul 2021 09:26:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4039B300056;
        Wed, 28 Jul 2021 11:26:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 280022028E9B4; Wed, 28 Jul 2021 11:26:05 +0200 (CEST)
Date:   Wed, 28 Jul 2021 11:26:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, elver@google.com
Subject: Re: [PATCH] locking/atomic: simplify non-atomic wrappers
Message-ID: <YQEirdfntQMUlpug@hirez.programming.kicks-ass.net>
References: <20210721155813.17082-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721155813.17082-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 04:58:13PM +0100, Mark Rutland wrote:
> Since the non-atomic arch_*() bitops use plain accesses, they are
> implicitly instrumnted by the compiler, and we work around this in the
> instrumented wrappers to avoid double instrumentation.
> 
> It's simpler to avoid the wrappers entirely, and use the preprocessor to
> alias the arch_*() bitops to their regular versions, removing the need
> for checks in the instrumented wrappers.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Suggested-by: Marco Elver <elver@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>  .../asm-generic/bitops/instrumented-non-atomic.h    | 21 +++++++--------------
>  include/asm-generic/bitops/non-atomic.h             | 16 +++++++---------
>  2 files changed, 14 insertions(+), 23 deletions(-)
> 
> Hi Peter,
> 
> Are you happy to take this atop your queue/locking/core branch?
> 

Will do, thanks!
