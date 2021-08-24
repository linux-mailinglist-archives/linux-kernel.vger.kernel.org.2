Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850433F6880
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 19:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239900AbhHXR6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 13:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237947AbhHXR6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 13:58:36 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BE3C0DCB12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 10:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jGPNz1d1oh7DcrnhSplS+AVN5zxduqMoVYa9ZotWhAs=; b=Q6+bFYmwq8U7Vk+vRcaYzsfWJB
        B3AKK6w9Ke+fU8BZZgS1z8l3LkPp3EVlp93W0gQNgDGObrwnouFVUAou76dNFsGVOidIfkBnD0DFw
        sNg6zuzav6ds+Xw8trLwYeMCWieayhdpZwlVBNp50TDa0Zt5SOFKanS969ICYA5WKtzGeu6mynWu3
        3LjnUmxbyU5sOA0uaklQKlnHI32h6GhipRs2HkvTZm5QXZ0iQPJ27ZbeQ176P/tTGLYV5OFrvsJb+
        GhkR6i0ieHMNWInQcxgOIYDBIOUgDOvNWvwyJ4QI6CnIaImidmvYmJG2kQsSXOvbToFNvQ8mXC/EL
        D/hpYt8Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIaKe-00CeUi-3I; Tue, 24 Aug 2021 17:35:28 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A16D0981196; Tue, 24 Aug 2021 19:35:27 +0200 (CEST)
Date:   Tue, 24 Aug 2021 19:35:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Jones <davej@codemonkey.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: 5.14-rc breaks iotop swap io monitoring.
Message-ID: <20210824173527.GA17784@worktop.programming.kicks-ass.net>
References: <20210824031648.GA2725@codemonkey.org.uk>
 <YSSuVO47ieWDfWMQ@hirez.programming.kicks-ass.net>
 <20210824151943.GA386@codemonkey.org.uk>
 <CAHk-=wiRe=JBK85HG7xtXH1XbOWcO1KYW8csuWfLuFoHKTqF0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiRe=JBK85HG7xtXH1XbOWcO1KYW8csuWfLuFoHKTqF0w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 09:34:02AM -0700, Linus Torvalds wrote:

> Even if you enable it at run-time, processes that have been started
> before it was enabled won't actually have the 'tsk->delays'
> allocation. So I'm not sure how effective the run-time thing is.

Right; we *could* fix that by looping through the tasklist; grabbing a
task ref, doing the alloc and restarting until we've iterated the whole
tasklist and not found a task without a delays thing.

Didn't think it would be worth it, but can be done..
