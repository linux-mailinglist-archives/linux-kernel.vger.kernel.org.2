Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B7C35A13C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 16:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbhDIOhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 10:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhDIOhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 10:37:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C385C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 07:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+K3RMGrwBpTT6UMZAxwuKE/mfBnKMr0kMABeiMthIw0=; b=IrFySA2e2ZVfvgkVhNbb9+AqKF
        nzn/+JxTXwk30j1doW/l4rfjI0c9HEKteKS/g/wI9Lv0CL6tpDjO/hSN+DTrbeOJgL/Qk3N+I+tza
        5hYpc0L0KBM+zBf1Gc2WjM5iUAW7Z7pzOwu4fbybxZew6VVChx3p9ycuf9bZeJmKrib2sodqXb/l3
        lHgbBEXwo6eYKlJyEr6TDzg5Tb66bRja8DktiPYKb3+P//36JiuGJQJPOEMf51Vt1+AWvoeLNtYOZ
        DdtX66+bdvWGrZ7UDzH+Mb6UE4qjHN5PdZmubqrC16GzG+XV4wJSqsc/z9ml+wWOXRWRljVD5DqUP
        dAZWcWWA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUsEl-000V6O-3S; Fri, 09 Apr 2021 14:36:18 +0000
Date:   Fri, 9 Apr 2021 15:35:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     neilb@suse.de, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/17] bit_spinlock: Prepare for split_locks
Message-ID: <20210409143555.GV2531743@casper.infradead.org>
References: <20210409025131.4114078-1-willy@infradead.org>
 <20210409025131.4114078-4-willy@infradead.org>
 <YHBlj3AjYbQHfsc0@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHBlj3AjYbQHfsc0@mit.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 10:32:47AM -0400, Theodore Ts'o wrote:
> On Fri, Apr 09, 2021 at 03:51:17AM +0100, Matthew Wilcox (Oracle) wrote:
> > Make bit_spin_lock() and variants variadic to help with the transition.
> > The split_lock parameter will become mandatory at the end of the series.
> > Also add bit_spin_lock_nested() and bit_spin_unlock_assign() which will
> > both be used by the rhashtable code later.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> This changes the function signature for bit_spin_lock(), if I'm
> reading this correctly.  Hence, this is going to break git
> bisectability; was this patch series separated out for easy of review,
> and you were planning on collapsing things into a single patch to
> preserve bisectability?

It's perfectly bisectable.

Before: bit_spin_lock takes two arguments
During: bit_spin_lock takes at least two arguments, ignores all but the first two
After: bit_spin_lock takes three arguments
