Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F70535617E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 04:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243384AbhDGCvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 22:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbhDGCvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 22:51:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29238C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 19:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dV1f1V+Do2hXUWRE6FICi+uU6gH6OPiZlIka5qV9wTc=; b=EveHe1q6JfT5AQikfGrlIYCz7m
        BZNqbrVTzWqjZ8zyTxsRk+hByPGSy9K0REt+n7eXSCiDrUAO/fJasjEVrC0Yh1jh/OjDLE3WTj9Sv
        XIWscA0NNiWr1s7BxhXWBibcNXmR9P6y8MR0MaSivH/T7cKmLeJb0J3S1Dic93w9DUQDRgr9kk8wP
        9EMOwPGAtiyrmYuCXsmTL6b4NHLWaK2WoHm+/x0SJcwjNfiYGEgVe/bbssgOBrjKSWOtJlK0A47Nn
        d4WPDk9idARg4jZ2lKEuZxwTJM3groRjYlGdtjFuZQREdgnsI2MRBhCh7DjUgvIRFXbq32Qtz0n/1
        ApQBq/5A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTyGc-00Dmua-LB; Wed, 07 Apr 2021 02:50:11 +0000
Date:   Wed, 7 Apr 2021 03:50:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
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
Message-ID: <20210407025006.GB2531743@casper.infradead.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
 <20210407014502.24091-35-michel@lespinasse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407014502.24091-35-michel@lespinasse.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 06:44:59PM -0700, Michel Lespinasse wrote:
> Performance tuning: as single threaded userspace does not use
> speculative page faults, it does not require rcu safe vma freeing.
> Turn this off to avoid the related (small) extra overheads.
> 
> For multi threaded userspace, we often see a performance benefit from
> the rcu safe vma freeing - even in tests that do not have any frequent
> concurrent page faults ! This is because rcu safe vma freeing prevents
> recently released vmas from being immediately reused in a new thread.

Why does that provide a performance benefit?  Recently released
VMAs are cache-hot, and NUMA-local.  I'd expect the RCU delay to be
performance-negative.
