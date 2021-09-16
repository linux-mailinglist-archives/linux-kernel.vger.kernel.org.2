Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7877740D877
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 13:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237953AbhIPLYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 07:24:37 -0400
Received: from verein.lst.de ([213.95.11.211]:39732 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235686AbhIPLYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 07:24:36 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B8B8167373; Thu, 16 Sep 2021 13:23:13 +0200 (CEST)
Date:   Thu, 16 Sep 2021 13:23:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Will Deacon <will@kernel.org>,
        andreyknvl@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Mel Gorman <mgorman@suse.de>,
        keescook@chromium.org
Subject: Re: [PATCH] mm/vmalloc: Don't allow VM_NO_GUARD on vmap()
Message-ID: <20210916112313.GA32019@lst.de>
References: <YUMfdA36fuyZ+/xt@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUMfdA36fuyZ+/xt@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
