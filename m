Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD6D31F750
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 11:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhBSKcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 05:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhBSKcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 05:32:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BB1C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 02:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+EquK8bSN07/OaknMcvmJmBUh7h4jPsI6nqfokxx5e0=; b=oIFrPrHwjaQWB06vySuiwcC6Il
        tA6e1xCqk8V0ZnrW67cq6MCaZPkOYJ/KGRiwoxBxhgsGX/hB2pKNk3AZ+/nXiNEYKbCEOfn9ZQI7J
        TCcbmirg/kUSKAClh/7lXpuclYW8ARDo73pZFM48d+kmEQAH5GZNwoX5f9zX3uQvj81y8bhJcqP7x
        7SJM8jkChPZM51VolBtn6d1vSZGKoW/eEstcxtrBHQliaOBtcxKqlY+IThHZ/J7aA7EIXI2lXvLGR
        Jy8/82BMSeWG73xJk6WNlP90otJ39o7JfVdccsNDHjlKzuCQR3axD3IjLFq22bjxetH1QMxEzbyqi
        e3lutBwA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lD33T-002kud-A5; Fri, 19 Feb 2021 10:30:42 +0000
Date:   Fri, 19 Feb 2021 10:30:35 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Yiwei Zhang <zzyiwei@android.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jens Axboe <axboe@kernel.dk>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ilias Stamatis <stamatis.iliass@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Liang Chen <cl@rock-chips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH] kthread: add kthread_mod_pending_delayed_work api
Message-ID: <20210219103035.GA656626@infradead.org>
References: <20210214000611.2169820-1-zzyiwei@android.com>
 <20210216091128.GA3973504@infradead.org>
 <CAKB3++aXuCS3WRf1mfrM2oZ0KiJ4xP4ib-ZbJXr8cXVEkU-sXw@mail.gmail.com>
 <YCz6nz4i136z1+H1@alley>
 <CAKB3++b+n=VWuXZqZqyZJvAf1+Wqogvi07L21GqdRwThSRdf2w@mail.gmail.com>
 <YC+SgVZdm5gfSqFg@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC+SgVZdm5gfSqFg@alley>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 11:27:13AM +0100, Petr Mladek wrote:
> I am personally fine with adding this API. I am going to
> comment the original code. Well, there might be a push-back
> from other people because there will be no in-tree user.

Adding a new API without an intree user is a complete no-go.
