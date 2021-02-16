Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D69F31C7E0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 10:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBPJPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 04:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhBPJOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 04:14:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9C2C061756
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 01:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RYyCsWjbE6xvbt/JL7kqtzZn8Gk0jXO1Dg9iiqvMK0Q=; b=HuPLkGFzr1Lu88Wta2oiCqzxfk
        twLUbjLjHQ9/T5U233NZLyk7UM/hplXuL/k7SZ6g9bpJkahnUsnO36EMTDJiz4hwDR9zTpCaQKHke
        +FV3aTHKF2f1A9R4+mSIO0OUHd3uHgL/iDuFlVxZ0khkMJ+1hbnoq4THvybHfMOotKugsXMRrG8n1
        3f9A5fRdjXHA2oW8iazQM3xQ10CGGcTJGXZ46QjizOs8W/MeQ74hVm+QVyfSJIPfVL7+kSFmBVTRu
        xV5i9a9S0gwnVo7h3Q7o1/5UqXVczmcECGJRJTlmTFumn7lG65gYndyzrrOsnRBsbu8IhPYaifpXK
        mfkgaANw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lBwOG-00GgRK-2C; Tue, 16 Feb 2021 09:11:40 +0000
Date:   Tue, 16 Feb 2021 09:11:28 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Yiwei Zhang <zzyiwei@android.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jens Axboe <axboe@kernel.dk>, Petr Mladek <pmladek@suse.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ilias Stamatis <stamatis.iliass@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Liang Chen <cl@rock-chips.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH] kthread: add kthread_mod_pending_delayed_work api
Message-ID: <20210216091128.GA3973504@infradead.org>
References: <20210214000611.2169820-1-zzyiwei@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210214000611.2169820-1-zzyiwei@android.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 14, 2021 at 12:06:11AM +0000, Yiwei Zhang wrote:
> The existing kthread_mod_delayed_work api will queue a new work if
> failing to cancel the current work due to no longer being pending.
> However, there's a case that the same work can be enqueued from both
> an async request and a delayed work, and a racing could happen if the
> async request comes right after the timeout delayed work gets scheduled,
> because the clean up work may not be safe to run twice.

Who is going to use this?  Please submit it together with the actual
user.
