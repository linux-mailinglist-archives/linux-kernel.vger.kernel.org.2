Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55F53DB48A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 09:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237780AbhG3Hcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 03:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237472AbhG3Hcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 03:32:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD0FC061765
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 00:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7heehBNik1PqStWJbc/QwvZU+LEALLlO102LtLzNzN8=; b=dO1+GXtZ30eoeb8GdhAZmNVgn+
        IrjTJ0+XksbmvQduzJtVvJHyc+rtZKy4t/z+EYk0BgQcaZxqMwo7nYEQJquASN7+QK0t7oE2q5ZIA
        u4dQJdKbcnkQgQlbx9/Qq1KNoOVB1BH1Uj2sSxw7NZhK9Um6Gp2/QDQmCYpfWDtYcw0U50isE4Sua
        mR5MD86ss4I+dSwFGhx9cKWLKJi2pb/hquZf4cjdB4+k2LCYAQhIzRELpUixx3ftut3Nq+RZ50bAE
        50AzY7R44FKIIK9fUcB+vc3+OKi4nZGeaYi+tcMk3YtTrSn7meJenTGiPsuhonTkynmHz3+rCiBZZ
        yq8sakSQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m9MzC-000Scy-Hl; Fri, 30 Jul 2021 07:31:37 +0000
Date:   Fri, 30 Jul 2021 08:31:14 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric B Munson <emunson@mgebm.net>,
        Eric Paris <eparis@redhat.com>,
        James Morris <jmorris@namei.org>,
        Mike Christie <michaelc@cs.wisc.edu>,
        Neil Brown <neilb@suse.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
        Trond Myklebust <Trond.Myklebust@netapp.com>,
        Xiaotian Feng <dfeng@redhat.com>,
        Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH] mm: delete unused get_kernel_page()
Message-ID: <YQOqwnu7ewZldkUN@infradead.org>
References: <20210729221847.1165665-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729221847.1165665-1-jhubbard@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 03:18:47PM -0700, John Hubbard wrote:
> get_kernel_page() was added in 2012 by [1]. It was used for a while for
> NFS, but then in 2014, a refactoring [2] removed all callers, and it has
> apparently not been used since.

Looks good, pinnining by kernel virtual address doesn't really make
much sense.

Reviewed-by: Christoph Hellwig <hch@lst.de>
