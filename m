Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24AE356172
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 04:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344018AbhDGCiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 22:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbhDGCix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 22:38:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5778CC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 19:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GXnM9RJclPMF2auKRyyoc6QRpWNTrxwbJZJDrLj/q3Q=; b=u5xtNjfCwgrRjHfJFl2ks8b29i
        KpDRU8ybuZnLRp+ML7Nlucf479s85Zm6Wbeujnujy09d3KrsfPHuYvmp/ofOeI7/JvCEg47vyuKSu
        MIRMQaWRdgxwfXix1EldTPNi14Z+52DgyzQfgwG47JFAoEylxg0MArfPQ3y94VPyqpL1hulY6N/jf
        PFaAPeVmgg5NeGIWHBS/Y/O7orrJ8MCzB/O3EKeRcuGLQXwJWnFnuhsfe2RgvBMfyAMoBlYNQTxlO
        j7E8fQ44qYZkYgLGOYevD5v49KsGiDKmyMEKT6J87EbheOtoB/NPkkwvBJWeGKL9KdWukRqnlLbbs
        6gxwkeuA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTy4i-00Dm4l-G2; Wed, 07 Apr 2021 02:37:53 +0000
Date:   Wed, 7 Apr 2021 03:37:48 +0100
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
Subject: Re: [RFC PATCH 27/37] mm: implement speculative handling in
 do_fault_around()
Message-ID: <20210407023748.GY2531743@casper.infradead.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
 <20210407014502.24091-28-michel@lespinasse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407014502.24091-28-michel@lespinasse.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 06:44:52PM -0700, Michel Lespinasse wrote:
> Change xfs_filemap_map_pages() account for the fact that it can not
> block anymore, as it is now running within an rcu read lock.

Better to just delete xfs_filemap_map_pages() and use filemap_map_pages
directly.
