Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7DD1407084
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 19:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbhIJR3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 13:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbhIJR3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 13:29:11 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089E4C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 10:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OTxau3AdSN4tDFRUxI6gORGommmAmNVfMMPMQXzGUyU=; b=ij9GE29HqGaK2cB+L9akGPszYz
        BH0USb9JYW9ysF3DG/XwKg5eCllXYmpWkMphGbnaDpTMddkRHzhznyQPmOcGbovd3Y6g/B130n/QJ
        SBTvR9rchhIuT+tIjScZi5M1uRRREuLMOY+8JBAfc9Lxasxbpfat3FmK9JItatqJfnGvpwPiHxs/d
        SzBxye4rKXL0WRLYyNgpIZxZlhs7dsmldt7i+CB0OInqZ4CtgRrkX/ZH7TWRx1chkKdK+ulcnPz9l
        8jtaEIc7SZe0ZPafw+k73fuGiXWX7TZq26b8uXdzEhzldJQGxPDE/POSuI1jSv9f1+YA60upY73SU
        rUBwRj3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOkJc-002BEG-85; Fri, 10 Sep 2021 17:27:52 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 70C1698627A; Fri, 10 Sep 2021 19:27:51 +0200 (CEST)
Date:   Fri, 10 Sep 2021 19:27:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH v2] kernel/locking: Add context to ww_mutex_trylock.
Message-ID: <20210910172751.GB5106@worktop.programming.kicks-ass.net>
References: <20210907132044.157225-1-maarten.lankhorst@linux.intel.com>
 <YTiM/zf8BuNw7wes@hirez.programming.kicks-ass.net>
 <96ab9cf1-250a-8f34-51ec-4a7f66a87b39@linux.intel.com>
 <YTnETRSy9H0CRdpc@hirez.programming.kicks-ass.net>
 <a7e5d99d-39c4-6d27-3029-4689a2a1a17a@linux.intel.com>
 <YTtznr85mg5xXouP@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTtznr85mg5xXouP@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 05:02:54PM +0200, Peter Zijlstra wrote:

> That doesn't look right, how's this for you?

Full patch for the robots here:

https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=locking/core&id=826e7b8826f0af185bb93249600533c33fd69a95
