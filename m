Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E23C3F7084
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 09:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239308AbhHYHhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 03:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239301AbhHYHhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 03:37:48 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAC3C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 00:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3uEKHtHIaZKrON6DnoPhOrv9fCzcWdgeFV8c5xRWWBo=; b=XKyU0wp5N3gmk6boCZ3EzMQVth
        ByFhjdQadehvps/EmcDaj9+JZe5PtMK7ZHRuOQn2qI2P8m835EnB7qEDF52qvkD1mJYZUOR+f0EUw
        CK1UFsjA7mPuEk/9N/Y7suV5fWHbZKyg5zAOVMUtE6kArxvN0semTzkDzk9Apf0cAb7i7X91pWual
        G+S8i5XiIXgASW0JuCN0YtbsAU6L+fBARB0zfr9GL2Qru1SlngBwhAYFMzkEdkpmRvfvTu6SsdLYw
        eZeHeS9yIxImUZlKVbiUrl7l4H5fLGCFYJYt/3z8jmDVlq+SSzvqcgVRbAVFjR0QuYwyrK/uIIzzi
        ++a9F+pQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mInSy-00Cqg1-Lv; Wed, 25 Aug 2021 07:36:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 64EAB300399;
        Wed, 25 Aug 2021 09:36:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 23DAC2BE7DC94; Wed, 25 Aug 2021 09:36:55 +0200 (CEST)
Date:   Wed, 25 Aug 2021 09:36:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Jones <davej@codemonkey.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: 5.14-rc breaks iotop swap io monitoring.
Message-ID: <YSXzF/svehIO8SzO@hirez.programming.kicks-ass.net>
References: <20210824031648.GA2725@codemonkey.org.uk>
 <YSSuVO47ieWDfWMQ@hirez.programming.kicks-ass.net>
 <20210824151943.GA386@codemonkey.org.uk>
 <CAHk-=wiRe=JBK85HG7xtXH1XbOWcO1KYW8csuWfLuFoHKTqF0w@mail.gmail.com>
 <20210824213342.GA1708@codemonkey.org.uk>
 <CAHk-=wg8XonsSN1SXjpSh3pO3-+EMZvdkb1xwJbLpZxCT2=thQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg8XonsSN1SXjpSh3pO3-+EMZvdkb1xwJbLpZxCT2=thQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 04:26:59PM -0700, Linus Torvalds wrote:
> I also assume the swap stats still show up in "vmstat" etc, and that
> it's just that iotop ended up using fancier interfaces?

vmstat still works; I just started a fair number of stupid large
programs and I see swpd si and so changing.
