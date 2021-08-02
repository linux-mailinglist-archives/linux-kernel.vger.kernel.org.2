Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A067B3DD749
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 15:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbhHBNjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 09:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbhHBNjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 09:39:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4961C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 06:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C/x6fKZHiVM01KmO6LLWE61wFh45yoBcCRSh3IRFKZI=; b=j+AzJc9M/MXGg+PVxaZoBZ/Ekx
        7A5HuAlwTq1xn8C7JriWPV9bWD5zFA8GIPIiGyJzzMEVSKnhwWadqmwOfwVumoQgmZm3dAgFqbG86
        oQE4ilIo6ZIqLDkXtIoa+aZb+R4T9IFX/R5vsexn78g+dpqaXipVDTbkY8WxlHQNhQMvJNfFQWIY/
        ZGvP5W75kPLemDgbYljexrQ2ax5vNsP6twn1x9OLkcQNaYPBzdGDB0ZMoz/N2WrQYEIR/Cpngl74P
        GUzm0XIoySKGkEUe98ZpQ5C+zEGZ/m6UHyqcbXCnISlHOz7l/6tdvc1RSvUxMh2J7m+4GRUi4Adl6
        X9XPhYzA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mAY9e-005AFt-DO; Mon, 02 Aug 2021 13:38:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 75C0830027E;
        Mon,  2 Aug 2021 15:38:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3705C2CE2507E; Mon,  2 Aug 2021 15:38:53 +0200 (CEST)
Date:   Mon, 2 Aug 2021 15:38:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, bristot@redhat.com, bsegall@google.com,
        mgorman@suse.de, Mark Simmons <msimmons@redhat.com>
Subject: Re: [PATCH] sched/rt: Fix double enqueue caused by rt_effective_prio
Message-ID: <YQf1bT5Z3lrYQlBx@hirez.programming.kicks-ass.net>
References: <20210701091431.256457-1-juri.lelli@redhat.com>
 <YObOIwH7MbfagklQ@hirez.programming.kicks-ass.net>
 <YObS2Rudg4osS7Ic@hirez.programming.kicks-ass.net>
 <YOgJzqOrVHUvCpch@localhost.localdomain>
 <YQegVmIoVGOjt4w+@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQegVmIoVGOjt4w+@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 09:35:50AM +0200, Juri Lelli wrote:
> However, we managed to confirm your fix works great!
> 
> May I leave posting it again with changelog etc to you, or would you
> like I do that (making you the author)?

If you could (re)post a known working version with Changelog that would
be much appreciated.
