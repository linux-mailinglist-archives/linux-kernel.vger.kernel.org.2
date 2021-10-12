Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A9142A4C6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 14:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbhJLMol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 08:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236515AbhJLMoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 08:44:37 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE7EC061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 05:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VkuWaCPp6BdltJlLhzTBcs/gHZ5FzNB6mLBj77NOSJs=; b=GrJFt+4HATDHsWd98k5zzzBRTe
        ARPouQt/YJlyLUohFwApKyr67PVn2l8ciFFzkYPmAQRgqhiSfPjV9/Zr/rlCuCz/Wv4TpFogC4Cdf
        NPnfv8cx35dCaMh+gZwPXBUJVp+FJ1v5c0tbJehMfP6QKhvwFDIXdZJ4kzw5yhZRj/bjESEYaJ3sy
        /Tg2ly5c9qjlNmvxxJ30whmVc9bP7Q40YuSHxYQFwXjwiRv9c7UYozW/42VzRH7Y6mDO19aPdGalZ
        AfgOCRUa4hchTj6TJ02OeWNsWpw8BWD6R1zKmDQwjyYjtIqDrXFyr0EM7V4cxnxKt/TwxI+AzJLjB
        lK9ed9mQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maH6s-009Pee-Fi; Tue, 12 Oct 2021 12:42:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C071030032E;
        Tue, 12 Oct 2021 14:42:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 874532C856BA8; Tue, 12 Oct 2021 14:42:21 +0200 (CEST)
Date:   Tue, 12 Oct 2021 14:42:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, acme@kernel.org,
        mingo@redhat.com, Steven Rostedt <rostedt@goodmis.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH] perf/core: allow ftrace for functions in
 kernel/event/core.c
Message-ID: <YWWCrYM1I1MtmCkY@hirez.programming.kicks-ass.net>
References: <20211006210732.2826289-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006210732.2826289-1-songliubraving@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 02:07:32PM -0700, Song Liu wrote:
> It is useful to trace functions in kernel/event/core.c. Allow ftrace for
> them by removing $(CC_FLAGS_FTRACE) from Makefile.
> 
> ---
> We had some discussions about this last year [1]. Seems that enabling
> ftrace in kernel/events won't really cause fatal recursion in the tests.
> Shall we give it another try?

I suppose we can give it a go..
