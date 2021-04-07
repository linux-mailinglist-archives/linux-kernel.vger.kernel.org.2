Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FB035729E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354507AbhDGREo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343707AbhDGREi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:04:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A4EC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 10:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+ucIocfUJOD/WqCY/IrlLHx0lOy4Q71nzQX52UeWDRM=; b=X1jrNG4xH9GBL4HihaJXhBUjfb
        pgY8CIb6gfddO3FLokr5ZoNMCaKryYBj/P/eWzJ+OWk/lBQELrb5P0jPwjyjZ9Wtb46pdoqA1h/mj
        G2AvhEjOYg3oWa0that1iDcM+F+VhKMIxnv8XgusD0XFVkRiu9I/CQHBvUO53K2uZ1IQf90R8a8nk
        VjhpBmeSNtVYPp5X3FEBbCPfg6AaCromFZ8AnrroddO7crQn0q8aQhATAfsl3jNJuxZqWBxHGiciV
        Do+kr3LziSI9F/2jpUQ8BOZw7n/wOz+kasUSdjpXMZCm0KROid5ydz+U3pw/FPtVvd+e8KKK79j0/
        SJTaMkMQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUBXe-00EnlJ-CH; Wed, 07 Apr 2021 17:00:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 67979300BD2;
        Wed,  7 Apr 2021 19:00:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2EA9F2BC07BA8; Wed,  7 Apr 2021 19:00:33 +0200 (CEST)
Date:   Wed, 7 Apr 2021 19:00:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH 5/9] sched: prctl() core-scheduling interface
Message-ID: <YG3lMaqnH10s6JfN@hirez.programming.kicks-ass.net>
References: <20210401131012.395311786@infradead.org>
 <20210401133917.350276562@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401133917.350276562@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 03:10:17PM +0200, Peter Zijlstra wrote:

> Current hard-coded policies are:
> 
>  - a user can clear the cookie of any process they can set a cookie for.
>    Lack of a cookie *might* be a security issue if cookies are being used
>    for that.

ChromeOS people, what are you doing about this? syscall/prctl filtering?
