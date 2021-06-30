Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C973B853E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 16:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbhF3OtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 10:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235345AbhF3OtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 10:49:17 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B423C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 07:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KjwCOuTmi8CUrJtJez24s7BgJwdIjA4AHyQ1AizC1g0=; b=bu77fQHkWnZaJr0mkBXBX68giI
        D/V3h+n3SyDxYmUopA2l5oTQSPdSXI9qHKlXtKiTJE9CGFKgBxidojmEbUfIgXrpOdrs6UQX/UbOU
        ELhSfGuLi9YPoFZw7qnR7Hdebl4lm0ng7Q/Sg+rbeMJM2BPQfFrGnEcwlp0n+/RtSmwe/Zhd0oGQ4
        G0Gn0VUkoDzCO5/vddm3SV5Q+k9/3Pi7ze6zgaZHLprKKNUsRLrdSLBbRW9FZZ6+WJMjgEhNFFIPm
        FZXbWiFgi2PBmBHB12RwdrzIpggXa6ud8y/um3ABaveHKMibrFg4VCa53sbLv2LvyqoFFE48D0www
        w+vZDeIg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lybU8-00DCF2-Lm; Wed, 30 Jun 2021 14:46:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 47A1D300091;
        Wed, 30 Jun 2021 16:46:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3651B2C59D783; Wed, 30 Jun 2021 16:46:39 +0200 (CEST)
Date:   Wed, 30 Jun 2021 16:46:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <llong@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org,
        "Xu, Yanfei" <yanfei.xu@windriver.com>
Subject: Re: [PATCH] locking/mutex: Reduce chance of setting HANDOFF bit on
 unlocked mutex
Message-ID: <YNyDz3F3w2EFZfQs@hirez.programming.kicks-ass.net>
References: <20210629201138.31507-1-longman@redhat.com>
 <YNxFkD8qzex9MvQp@hirez.programming.kicks-ass.net>
 <ecc0cc97-23ca-5de3-2a12-ed50aa12548c@redhat.com>
 <YNx4IWfE/wpFFh0h@hirez.programming.kicks-ass.net>
 <139a3dc2-1693-5e33-3d2d-77a5651d92e1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <139a3dc2-1693-5e33-3d2d-77a5651d92e1@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 10:13:06AM -0400, Waiman Long wrote:

> Sorry, I missed the XXX comment:-)
> 
> This is a generic problem as other waiters that go into the spinning loop
> also don't check for sigpending. On the other hand, I am fine with doing the
> pending signal check before doing the optimistic spinning.

True.. OK, lemme write changelogs for the 4 patches I've ended up with
and post them. Then we can look at that whole sigpending crud.
