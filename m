Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFDB145D7C3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 10:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354455AbhKYJ6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 04:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344828AbhKYJ4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 04:56:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151E6C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 01:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vUwMWVTx/HmaqUXSZ+idjksNrgXds/B9MKzyn7PI5sE=; b=YMuFWd9oNRjuAt7H86G6Ab4M05
        ccxWUhWOhjlcz83a5A0nzzGilDjdz/sLMHR9bwVfsUn7oQRlEVYrGsc+hpHoyvfr6uA8TMNlQRMpy
        gnZu21G0tPw56pOVvV6LJl/qCRTBTmIJX8XO2kYwT+bLcUaVly11HjZoRFBtFUlVRP2iy7BCW/3Oc
        7jSkx0dPLeX8r8AtyruV0KUR3aTOPhMC2StZvWtNg1RWgY/ymfqpsfO4rQN1cEsOIFSk/AajtlF5F
        +gvNPK3bXPKQg3bHujmqavpA7dTVbNcF23W3wK4d9RDGW95DmJLzLqJVe6nSxmAs3oA/ZEboTwL/i
        A9At9n/A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mqBRY-005nEy-FD; Thu, 25 Nov 2021 09:53:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CDF1D300093;
        Thu, 25 Nov 2021 10:53:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 741982027B00C; Thu, 25 Nov 2021 10:53:28 +0100 (CET)
Date:   Thu, 25 Nov 2021 10:53:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tang Yizhou <tangyizhou@huawei.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org
Subject: Re: [PATCH 1/2] sched/pelt: Remove redundant variable in
 __accumulate_pelt_segments
Message-ID: <YZ9dGGVphUpGnmI2@hirez.programming.kicks-ass.net>
References: <20211125030019.10447-1-tangyizhou@huawei.com>
 <20211125030019.10447-2-tangyizhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125030019.10447-2-tangyizhou@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 11:00:18AM +0800, Tang Yizhou wrote:
> As the comment of function accumulate_sum() describes the equation clearly,
> There is no need to use a redundant variable c3. Let's make a comment for
> d3 directly.

Why bother? Surely the compiler is clever enough to figure out the same
and avoid instantiating the variable. All you've done is made the code
less obvious.
