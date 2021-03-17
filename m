Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFFCD33F040
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 13:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbhCQMXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 08:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbhCQMXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 08:23:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E4AC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 05:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2ZkxRS9uuiUK1+RNH2WUpgE2HIxkwu3ObL4/gE0/2DM=; b=fbexnuw1ZVeWYho+Ber9wygx42
        2nNZnZQvy2LQpcJ0WwHt76Aj0FETONbZAh2aoR6K+dQg7nVvbDAg5vcHWafvF7Al4GMASluh4lwIT
        6H0XtWf8yj59G5E4DHAMOF5hdSTLyq2MFH6cS4LRVxPLcoi/pEI2DKXteAxpjX2QD4gSTShrlS4O4
        kuWdkIhhhX35kZvvhHcWf/C2ca9fbtZWD8ooHv6+3q2gtENZoKs+wo7FxF2lZRU/Ovi8LbVwB3FFT
        VKfnLNYulLJDZq+adrY/XVaywfsCmUA7kmmMwNNMXC9biLzXBIJJhAh9G5M2Utlug+spOTuAhwDQV
        Y4/ZkyKQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMVCk-0035lh-F0; Wed, 17 Mar 2021 12:23:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B693B301324;
        Wed, 17 Mar 2021 13:23:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7C0CA2C3C235A; Wed, 17 Mar 2021 13:23:12 +0100 (CET)
Date:   Wed, 17 Mar 2021 13:23:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Ingo Molnar <mingo@kernel.org>, He Ying <heying24@huawei.com>,
        frederic@kernel.org, paulmck@kernel.org, clg@kaod.org,
        qais.yousef@arm.com, johnny.chenyi@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] smp: kernel/panic.c - silence warnings
Message-ID: <YFH0sDpUIUmdpNkQ@hirez.programming.kicks-ass.net>
References: <20210316084150.75201-1-heying24@huawei.com>
 <20210317094908.GB1724119@gmail.com>
 <9691919b-d014-7433-3345-812c9b19a677@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9691919b-d014-7433-3345-812c9b19a677@csgroup.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 12:00:29PM +0100, Christophe Leroy wrote:
> What do you mean ? 'extern' prototype is pointless for function prototypes
> and deprecated, no new function prototypes should be added with the 'extern'
> keyword.
> 
> checkpatch.pl tells you: "extern prototypes should be avoided in .h files"

I have a very strong preference for extern on function decls, to match
the extern on variable decl.

Checkpatch is just wrong here.
