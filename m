Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49F2357DA9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 09:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhDHHx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 03:53:56 -0400
Received: from server.lespinasse.org ([63.205.204.226]:42323 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhDHHxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 03:53:55 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617868424; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=Wculb6jHNxHFT1NPFrH00eMZhPzMfIJ/lXQBt4FvWDY=;
 b=cY8nm20t8S6Lk/q03f68dYSwJLTlY/tLBudnSuwx5ICtI/So/PXq5zz9VfPvs67OXtfI9
 CCWeyrYACiZ2W0xAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617868424; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=Wculb6jHNxHFT1NPFrH00eMZhPzMfIJ/lXQBt4FvWDY=;
 b=agZWXwP+zplT0eY6G7B62LayXa+AEyPxWaG++zb8gm5AeDgBPvl923CbpQPVEhR/p/p1P
 SEGZ/DGm8o+++EWUvEbDpAH+jWTrCv8Lko7x9NyJYtMAGM6Jt/YI2LzUpG9T5MMTwMRohqa
 HqA3NHDv0imxpmmewspsowtlXzb4LgXBahwb0jBgnciBTtcqyNPWt0Ely7B2VinQYKSNHZV
 fuxDf7hCG7+tllz/xN27Zcqxs+JLHPKTkAr1gmms7SqkQxXLIW5OxPjgzPtioFRXjdexO5c
 nbk+zPZx6q7oxZibyAHLb2NpW0eyNWKCT3oAjTw9AWD9naR5dsF8MVcLp1eQ==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id 48066160253; Thu,  8 Apr 2021 00:53:44 -0700 (PDT)
Date:   Thu, 8 Apr 2021 00:53:44 -0700
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        Linux-MM <linux-mm@kvack.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 34/37] mm: rcu safe vma freeing only for
 multithreaded user space
Message-ID: <20210408075344.GA27824@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
 <20210407014502.24091-35-michel@lespinasse.org>
 <20210407025006.GB2531743@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407025006.GB2531743@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 03:50:06AM +0100, Matthew Wilcox wrote:
> On Tue, Apr 06, 2021 at 06:44:59PM -0700, Michel Lespinasse wrote:
> > Performance tuning: as single threaded userspace does not use
> > speculative page faults, it does not require rcu safe vma freeing.
> > Turn this off to avoid the related (small) extra overheads.
> > 
> > For multi threaded userspace, we often see a performance benefit from
> > the rcu safe vma freeing - even in tests that do not have any frequent
> > concurrent page faults ! This is because rcu safe vma freeing prevents
> > recently released vmas from being immediately reused in a new thread.
> 
> Why does that provide a performance benefit?  Recently released
> VMAs are cache-hot, and NUMA-local.  I'd expect the RCU delay to be
> performance-negative.

I only have the observation and no full explanation for it.
Just try it on wis-mmap and wis-malloc threaded cases. Of course this
all washes away when dealing with more realistic macro benchmarks.
