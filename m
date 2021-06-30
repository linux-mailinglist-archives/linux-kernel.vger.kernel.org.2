Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10EA3B84A1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 16:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbhF3OGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 10:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbhF3OFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 10:05:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6257C061766
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 06:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L1x+KUBDu+pQNQroM2CacolCsjEtk/jUpjV5NXpjLGM=; b=rIVW6WGlDCGlZcjjtomWTCJK58
        kszRhsKEgikdaav4vC6m134gi2Ww/ZbLIqwR8R3KZKooEUSOsHxDwd5IcfxFQPRmC2spEfLizgpii
        KD/qZbMrTQZ9ppQ+9uQs5k3phiCSud1lCjpGUt151AechVCG3y3HIAkSIncwkyU8wstEpbdeXFfY2
        gwBVSMPUaIMOgfWOsz6rK3+l8I46bMbZcrQ6+l+wATDNdqVchYq5NiJ3H4i30j1bOP/E5/PjnA6jQ
        k1trot4ua0lEnhn4xfgvULGDy1JeElvJVl360527rokC6xmG9xnDHrHNEzxv4d/PYptxOZBvopl5k
        b/thshHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyahu-005Q5f-V0; Wed, 30 Jun 2021 13:56:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2BBB8300091;
        Wed, 30 Jun 2021 15:56:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0980D2C59D783; Wed, 30 Jun 2021 15:56:50 +0200 (CEST)
Date:   Wed, 30 Jun 2021 15:56:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <llong@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org,
        "Xu, Yanfei" <yanfei.xu@windriver.com>
Subject: Re: [PATCH] locking/mutex: Reduce chance of setting HANDOFF bit on
 unlocked mutex
Message-ID: <YNx4IWfE/wpFFh0h@hirez.programming.kicks-ass.net>
References: <20210629201138.31507-1-longman@redhat.com>
 <YNxFkD8qzex9MvQp@hirez.programming.kicks-ass.net>
 <ecc0cc97-23ca-5de3-2a12-ed50aa12548c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecc0cc97-23ca-5de3-2a12-ed50aa12548c@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 09:50:11AM -0400, Waiman Long wrote:

> The code looks good to me. It is an even better approach to make sure that
> the HANDOFF will never be set on an unlocked mutex.
> 
> Reviewed-by: Waiman Long <longman@redhat.com>

Thanks, what about that XXX? Should we not check sigpending before doing
the optimistic spinning thing?
