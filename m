Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593434046F1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 10:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhIIIX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 04:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhIIIXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 04:23:55 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175AAC061575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 01:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zXGn+KAsLSdghJDwAp3kCZ0yqN34x/izanZqsWV0Tjo=; b=lrdSDGIFyzKoKUkfK/+sinkOOL
        mLRB2xLXGBEFPHOt9tjdPdZGnlyPXfIVQFsavsBfesnVJYnDEcGOZt9tr6mZ8KZh5RgT5y3RvLL3S
        an54tLPcpBQK8VWgshAarcRYTajI79A9dyTqpHs96cf9u+0x/Y/6qAIbgWlf/2q1DE/eY7Kv+lsD5
        Dcx9QzjKnfe9pl2Xbl/iSBFJyXP6GMKH9IU+hCPXJZvkaLGvF+/Vb7k3DbbHRrnsWyip/eOAtzzL+
        CN7UnW9FvcJI7C/IIivsrR4rxdz3vkjJRQpiTbE2abnNOyTpc5gPX4V7cOkU34thb9ciIr8UrRQA1
        nXvymRog==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOFKQ-001pRn-7n; Thu, 09 Sep 2021 08:22:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 32D42300038;
        Thu,  9 Sep 2021 10:22:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1A37B2C83E2E7; Thu,  9 Sep 2021 10:22:37 +0200 (CEST)
Date:   Thu, 9 Sep 2021 10:22:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/locking: Add context to ww_mutex_trylock.
Message-ID: <YTnETRSy9H0CRdpc@hirez.programming.kicks-ass.net>
References: <20210907132044.157225-1-maarten.lankhorst@linux.intel.com>
 <YTiM/zf8BuNw7wes@hirez.programming.kicks-ass.net>
 <96ab9cf1-250a-8f34-51ec-4a7f66a87b39@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96ab9cf1-250a-8f34-51ec-4a7f66a87b39@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 07:38:06AM +0200, Maarten Lankhorst wrote:

> > You'll need a similar hunk in ww_rt_mutex.c
> 
> What tree has that file?

Linus' tree should have it. Per commit:

  f8635d509d80 ("locking/ww_mutex: Implement rtmutex based ww_mutex API functions")
