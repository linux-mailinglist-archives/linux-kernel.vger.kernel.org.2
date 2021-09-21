Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B623B412F1B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 09:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhIUHLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 03:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhIUHLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 03:11:48 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1E8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 00:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9748AU+xv9yA5iRuoYyF3xyck6tGVCimuYrTFFAhqBg=; b=lkw9S7Sa4cMQ4ihC/d1kQfWe4d
        fblFF1DY0wE58ZnTjcyDlzFvW0mSPbW8cBOxmSunoQk4jzE8fPOBgoMt5s9Kodr48GiN3zpKkzmHT
        ZvKLeJnOA885zPfIfAEDP8qF0GL7oaW3GFgnu9SEcoo/4iw2tW8dtxd9ssPqPuPHsu+XxUGFxNHOV
        kokl9GffwGK0HZ9LNSoon6KpHYYn2/5dFfgAQbyawbCBr+o2xh3QSLzvNfab8JBR427wBC48Y1lhE
        IGi9PgbEtdiHepiLqxIweHAe0htfowNnyq3HaGkLZSD4pkvVc6Gm51c2T38jUG4PMK7+0un+fUhfs
        UFcnDnoA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSZut-004i1S-DH; Tue, 21 Sep 2021 07:10:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 218D5300252;
        Tue, 21 Sep 2021 09:10:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 117862C3EE3EB; Tue, 21 Sep 2021 09:10:10 +0200 (CEST)
Date:   Tue, 21 Sep 2021 09:10:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morse <james.morse@arm.com>,
        Quentin Perret <qperret@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/4] sched/preempt: Prepare for supporting
 !CONFIG_GENERIC_ENTRY dynamic preemption
Message-ID: <YUmFUkk4idIZENAk@hirez.programming.kicks-ass.net>
References: <20210920233237.90463-1-frederic@kernel.org>
 <20210920233237.90463-2-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920233237.90463-2-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 01:32:34AM +0200, Frederic Weisbecker wrote:
> There is no need to force dynamic preemption to depend on the generic
> entry code. The latter is convenient but not mandatory. An architecture
> that doesn't support it just need to provide a static call on its
> kernel IRQ exit preemption path.

True; but at the same time ARM64 is also moving to generic entry. Mark?
