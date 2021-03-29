Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90ECE34C50D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 09:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhC2HgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 03:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhC2HgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:36:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABA5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 00:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cP9TiUdhS95/o0i3gV2KAsK0VhJcx78QpoI3jrQSkYw=; b=DtzPiclobr22T2Iqa48D0kED37
        4D/72lBaaoMnB/pk+N3PW/6O1/y4j01XKO4BSk/UIlQglzok2j54bRLtX9TiwNl4K8yxbkp8ZPsBH
        iNjsAjlvS09lBtwr0dXGa00zd5WEYCW+Nq9i6PBVuELrMVgyAfg63egrQcoKWmm4RgePS56WKgBas
        OCMpPgnNq9okIYJn77a/Zp02v2DXuYl4m7e1mcA75Dap/0+c5FjU0qfYh0ccsxoP0yGnhEvg02eDZ
        jBfwv7u9nuPlzsCOOxiNBKCowXgkpX8cXt+ECea/xYtZPBRH5k8Xg1V5i+ou1g82Tur32hkvZv5w9
        dVJXGluQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lQmQx-001Bac-8r; Mon, 29 Mar 2021 07:35:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D6E1B3060EF;
        Mon, 29 Mar 2021 09:35:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BCDA02071899F; Mon, 29 Mar 2021 09:35:34 +0200 (CEST)
Date:   Mon, 29 Mar 2021 09:35:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Xie XiuQi <xiexiuqi@huawei.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, joe@perches.com
Subject: Re: [PATCH] sched,psi: fix typo in comment
Message-ID: <YGGDRtg7cMvQcLjm@hirez.programming.kicks-ass.net>
References: <20210327124610.7276-1-xiexiuqi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210327124610.7276-1-xiexiuqi@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2021 at 08:46:10PM +0800, Xie XiuQi wrote:
> s/exceution/execution/
> s/possibe/possible/
> s/manupulations/manipulations/
> 
> Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>

Xie, if you'd have bothered to check the development tree of the code
you're patching, you'd have found it's long since fixed.

Can we please get a MAINTAINERS entry that indicates the willingness to
suffer nonsense like this? Then checkpatch will tell people to bugger
off and I can stop blacklisting people on this.

I'm getting sick and tired of people wasting bandwidth with this
nonsense.
