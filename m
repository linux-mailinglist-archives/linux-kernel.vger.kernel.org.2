Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286613187DC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 11:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhBKKPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 05:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhBKKNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 05:13:21 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC90C06178A
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 02:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q+sf91FNv4zPGR7fd6sT4radZ3ocxofsvCCNV8w6BJ0=; b=Pfp8UP7T2GJK8WYcaE9Y/nE8Bq
        jPADSwUv8CNp6TmVR9Bmcg/tsT3wjXcEoq+2zqpd/r86z5zdkHtDhJcLLX+bpMjVZH0vvvNPdvcFA
        9wVs1YOXWi4wdLFmtbWHIUCthVsYf8UC6yl7GCbfagY4tDIEqBuavwl6cOIlYErc0SDaAZeZbJBwj
        ySbeB7jySC7LVqvAw90wNC9Z3g/Xg2anHZ4wc94KsfhN7EmHCdJQl1DD+ajuFKaOPwmcxoaQJWuRM
        qzL0bYeN08B7MbPf1xEASgIDxzXR0DcuoGH06I+tGj0Kw3EJDgymYfDe8q5ofEBlotW3+x5cn2njq
        AUwJjK5Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lA8wT-00020n-Lo; Thu, 11 Feb 2021 10:11:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1AB8330066E;
        Thu, 11 Feb 2021 11:11:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 065502B061B3C; Thu, 11 Feb 2021 11:11:20 +0100 (CET)
Date:   Thu, 11 Feb 2021 11:11:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH] perf: Replace lkml.org links with lore
Message-ID: <YCUCxyBVkWO0GTg0@hirez.programming.kicks-ass.net>
References: <20210210234220.2401035-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210234220.2401035-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 03:42:19PM -0800, Kees Cook wrote:
> As started by commit 05a5f51ca566 ("Documentation: Replace lkml.org
> links with lore"), replace lkml.org links with lore to better use a
> single source that's more likely to stay available long-term.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
