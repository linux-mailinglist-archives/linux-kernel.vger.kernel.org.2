Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80ED73FF3C1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 21:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347248AbhIBTFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 15:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243525AbhIBTFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 15:05:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B36C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 12:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0yRZmL5nhWDE48aMzkFfEXo04VyWR0hoUp+NXB3KQqU=; b=ivip0gQES2s93NQsau0LACmosP
        3+/LznRjJzoEg/EoI4FQMR3kFYFIowMcDeSvoOAq3SB1cmH1VIw+C11/mrxiIPyX+x1jfX0jLRuA5
        /mZS8r6dZtIyqPJahh4HTFzl7jAUp58uYsQ80WNzl1YqMR/geDrqosW3kE8K8pDS8O50KE0ZdHvms
        nEGU8+LPWWqkX8Uh/V++DlqwalwuwOnmVS+7zCpmgFOfJZKQ5Qss23gCMf6XJ01br/pubQvT2H1Bo
        Yxu9uol//N1sZPZdASAWs+mdLKa8iovK2Gu+4PZK2BuYW7F846cN4oPlq/VXqWYg1SJOvzWjbpwg0
        qt0AtZpw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLrz6-003kqT-GC; Thu, 02 Sep 2021 19:03:11 +0000
Date:   Thu, 2 Sep 2021 20:02:48 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Lameter <cl@linux.com>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: slub: BUG: Invalid wait context
Message-ID: <YTEf2MEkEdMVAuRF@casper.infradead.org>
References: <3b7661a1-dbde-ea54-f880-99777c95ae22@kernel.dk>
 <YTEeTK83KNBmuJLC@casper.infradead.org>
 <91af18d0-64cb-71ac-e9f4-4135fe02cb33@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91af18d0-64cb-71ac-e9f4-4135fe02cb33@kernel.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 12:59:33PM -0600, Jens Axboe wrote:
> On 9/2/21 12:56 PM, Matthew Wilcox wrote:
> > On Thu, Sep 02, 2021 at 10:22:23AM -0600, Jens Axboe wrote:
> >> Hi,
> >>
> >> Booting current -git yields the below splat. I'm assuming this is
> >> related to the new RT stuff, where spin_lock() can sleep. This obviously
> >> won't fly off IPI.
> > 
> > You want to turn off PROVE_RAW_LOCK_NESTING for the moment.
> 
> Because?

        help
         Enable the raw_spinlock vs. spinlock nesting checks which ensure
         that the lock nesting rules for PREEMPT_RT enabled kernels are
         not violated.

         NOTE: There are known nesting problems. So if you enable this
         option expect lockdep splats until these problems have been fully
         addressed which is work in progress. This config switch allows to
         identify and analyze these problems. It will be removed and the
         check permanently enabled once the main issues have been fixed.

         If unsure, select N.

