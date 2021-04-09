Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF8E35A86F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 23:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbhDIVlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 17:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbhDIVlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 17:41:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E975C061762;
        Fri,  9 Apr 2021 14:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P/s2Ue8tfUf8Zu4yN9wAj8vX3TNV9TrqTppYCfStYUo=; b=NwBfR88B939aVbdUd4cBDIJkvE
        lkUYFuPgXl3kUsRdPDUa8snafgqQ6RiPPmXv9tB/TGVwZ8bBKUncSGQJQ+7A3Y+rhj96J5aWMKo+n
        KC/NPmn8opCmHn5Op6jv3uaoxGc8t6e66pxky3AA2dnk5D485SxhylLEnSO4R2yGr8SgRxfS92yY1
        5clT21rnYe2f0IeIBYTyJS0grml3zhPdmkR/twnrKmQGkj+05rAwW5LlJMf6AmrggSDaOO8wHtGCU
        aLxdEdXTXsklja4KBFJUNFi/TLMux0hpdZ7c3gJ0IDyJXqdD9h8Dvoem3lwyDpZfuF2S3F+x3cM4Y
        6Yz/HyPQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUyr3-000ysO-Hi; Fri, 09 Apr 2021 21:40:12 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id BF5D998647F; Fri,  9 Apr 2021 23:39:49 +0200 (CEST)
Date:   Fri, 9 Apr 2021 23:39:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Malcolm <dmalcolm@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-toolchains@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: Re: static_branch/jump_label vs branch merging
Message-ID: <20210409213949.GA33256@worktop.programming.kicks-ass.net>
References: <YHA2jPIaj0p23mv8@hirez.programming.kicks-ass.net>
 <5f78b7e2f9ae937271ef52ee9e999a91c2719da9.camel@redhat.com>
 <YHBCoijoopbsDn29@hirez.programming.kicks-ass.net>
 <YHBQPr8q0cx4iUfN@hirez.programming.kicks-ass.net>
 <YHBS70ZQ6gOpMk2K@hirez.programming.kicks-ass.net>
 <3c062f70ffef2dcd48a661f7c8162fb8fbaf6869.camel@redhat.com>
 <YHCfgHwDtT7m4ffq@hirez.programming.kicks-ass.net>
 <0a9da587b0330bafdf612c3d51285e144b0b9e46.camel@redhat.com>
 <YHC0dgwhYS9hKcRT@hirez.programming.kicks-ass.net>
 <5a07bde1a9fa9a056a19637399b0635252ddb303.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a07bde1a9fa9a056a19637399b0635252ddb303.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 05:07:15PM -0400, David Malcolm wrote:

> You've built a very specific thing out of asm-goto to fulfil the tough
> requirements you outlined above - as well as the nops, there's a thing
> in another section to contend with.
> 
> How to merge these asm-goto constructs?

By calling the function less, you emit less of them. Which then brings
us back to the whole pure/const thing.

> Doing so feels very special-case to the kernel and not something that
> other GCC users would find useful.

Doesn't it boil down to 'fixing' the pure/const vs asm-goto interaction?
I could imagine that having that interaction fixed could allow other
creative uses.
