Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE4039FE17
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbhFHRsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbhFHRsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:48:52 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7043C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 10:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DYpoxF8V5padVKMwBrEXiIPopPnsff439+NPdx91qIw=; b=kCl98kyPH+JxVLSKJfvdpIWvAA
        GSj+ov9Kkbcj/ByFCmB/vpzwUt4Ah1e3MdHRj5u90yFFmj8i91AjqxMqGbnqnvMdw0vqqGYUUkXxL
        aygzPkEv6Muk4lW3ftlfgQkSm5M4tln2tJHZHR9FcW7j9pbwmo5eBixCtVV07+an6peYXrVUl0YG9
        dW0f93RklivEdOE8qJYpA8z0K0Xip7T5fD5vjWP19Vi5DHB3WnEuBWnPqK0+10C7dhsK2g6HvXZxk
        pcbPF4FSkeUxX23IMnoDf7cQbKtZSf6NYJw4QHncFTeIDZ94YSgsSH2PwG8rdbiQ2da0KJ7TCGXl7
        nR6CllLA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lqfoN-004p8F-U9; Tue, 08 Jun 2021 17:46:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4217B3001E3;
        Tue,  8 Jun 2021 19:46:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1A2EF201E7EE3; Tue,  8 Jun 2021 19:46:54 +0200 (CEST)
Date:   Tue, 8 Jun 2021 19:46:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Beata Michalska <beata.michalska@arm.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <qperret@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: iowait boost is broken
Message-ID: <YL+tDv/EL5ogf/0w@hirez.programming.kicks-ass.net>
References: <CAEXW_YTcO=hbmdq3nOx2RJfT2yPyoFnQx5niB38R2Lzpsp38bA@mail.gmail.com>
 <20210607191031.GA12489@e120325.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607191031.GA12489@e120325.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 08:10:32PM +0100, Beata Michalska wrote:
> So back to the expectations.
> The main problem, as I see it, is what do we actually want to achieve with
> the I/O boosting? Is it supposed to compensate the time lost while waiting
> for the I/O request to be completed or is is supposed to optimize the rate
> at which I/O requests are being made. 

The latter, you want to increase the race of submission.

> Do we want to boost I/O bound tasks by
> default, no limits applied  or should we care about balancing performance
> vs power ? And unless those expectations are clearly stated, we might not
> get too far with any changes, really.

You want to not increase power beyond what is needed to match the rate
of processing I suppose.
