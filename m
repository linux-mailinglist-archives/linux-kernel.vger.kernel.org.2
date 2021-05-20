Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437B438ADFF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbhETMVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbhETMVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:21:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F19C02801D
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 04:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j85zMe0/ctQ/R4wCa7ZURwMwH0NuHucxQ3izqol7/hQ=; b=b13lzJOvUZLlE9ImkNnV7t7Ojm
        C6Dpsc3b1B9xt8MsvW4vA3eK1DSLGl9BGHAd7RE+FlmyO7sGPvo2MK6aWn+CWO+C0Ozx1fO18vcj8
        IDWCDX7ZbIuvdJIJA4+XKwlW/PWORLguwglaxh6J7iuP9tfp1/jl/DMj7rUPMJDWhdJJtQHtRwNNK
        63fDsG9klLrQMcDBerhVgXm6YsAY7H8NdGT5q7aTR4sVbbMFRlb+4+26CZLHj3iAPMmKi2f+1Oh+c
        KhbnKTbZM4612Azh1JL7q0YBGd6GtNZNTI1NWYo2gyRNUlVyXPVqMXiJAaAqvBIQLST4wdSjvzZ1n
        RH2LAt7A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ljgYe-00FtLb-PS; Thu, 20 May 2021 11:11:06 +0000
Date:   Thu, 20 May 2021 12:09:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Aaron Tomlin <atomlin@redhat.com>, linux-mm@kvack.org,
        vbabka@suse.cz, mhocko@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/page_alloc: bail out on fatal signal during
 reclaim/compaction retry attempt
Message-ID: <YKZDdJb05ZHhZesn@casper.infradead.org>
References: <YKVn69o1UizH0kJD@casper.infradead.org>
 <20210519201743.3260890-1-atomlin@redhat.com>
 <20210519213455.97ff95f0124b4120787f8314@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519213455.97ff95f0124b4120787f8314@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 09:34:55PM -0700, Andrew Morton wrote:
> On Wed, 19 May 2021 21:17:43 +0100 Aaron Tomlin <atomlin@redhat.com> wrote:
> 
> > It does not make sense to retry compaction when a fatal signal is
> > pending.
> 
> Well, it might make sense.  Presumably it is beneficial to other tasks.

Apart from Vlastimil's point, if I hit ^C, I want the task to die,
as soon as possible.  I don't want it to do things which are beneficial
to other tasks, I want my shell prompt back, not spending seconds
trying to compact memory.  Some other task can do that if _it_ needs
large contiguous chunks.

