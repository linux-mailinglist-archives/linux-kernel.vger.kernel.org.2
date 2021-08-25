Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43FF13F7C00
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 20:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbhHYSEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 14:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhHYSEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 14:04:00 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA281C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 11:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Zp6w6glVdR7AU7wqwEOZ1YXWoEKYHTmoZwp8Fkv4Ees=; b=edQt73ezfZEPy89A3qClEXcFAX
        a23RTfUuFQMQbVahY+y4fA/aqTbgebmWRWqbwp4D3xxqwxtlIFcxSrPss4Mz3ZaOB3pSEVMj3MboD
        ZJOiWfuIobVnaVkIYebVMr21kgR3ifv55z0SVkRXJQYthL31MTUq2by5rovLcrteHndihe6sWGvFO
        oJAq3t/sMiMQ9iFI3SCaKsJKki5bkHoGayMDTKzaX6/K/ZaQrn3THKXY1Fl7aK9xY+yJGtW7puSpX
        PXEv9f5jtkmQa4FJTVrBI3aZBn/rcgE0rrC8iG1JGVkSxDA3tP1Uk+3Pt+t5KO6RvAf/meRgqIgG2
        U+Wi5uFg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIxEt-00CyeV-7F; Wed, 25 Aug 2021 18:03:03 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3DCB1981362; Wed, 25 Aug 2021 19:18:50 +0200 (CEST)
Date:   Wed, 25 Aug 2021 19:18:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Li,Rongqing" <lirongqing@baidu.com>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        "dbueso@suse.de" <dbueso@suse.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSN?= =?utf-8?Q?=3A?= [PATCH] rbtree: stop
 iteration early in rb_find_first
Message-ID: <20210825171850.GD17784@worktop.programming.kicks-ass.net>
References: <1629885588-10590-1-git-send-email-lirongqing@baidu.com>
 <YSYr7nqql825rHol@hirez.programming.kicks-ass.net>
 <20210825115332.GA4645@lespinasse.org>
 <20210825115859.GB4645@lespinasse.org>
 <YSZD6suya8fR/2uY@hirez.programming.kicks-ass.net>
 <90ea3457ddc7485fbc8db5f7ca5b07ab@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90ea3457ddc7485fbc8db5f7ca5b07ab@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 04:01:53PM +0000, Li,Rongqing wrote:
> 
> >>
> >>
> >>                         10
> >>                       /
> >>                      5
> >>                       \
> >>                        10
> >>
> >> The search would stop after visiting node 5, and miss the leaf which
> >> is the expected node to be returned.
> 
> thanks for explanation.
> 
> >Just to clarify; the current code *does* work here. The proposed patch
> >breaks it.
> 
> 
> true, my patch is wrong.
> 
> but rb_find_first seems have other issue.  when the key is equal, we should search right leaf, not left leaf

That again breaks the above case.
