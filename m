Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B655367FCA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 13:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbhDVLtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 07:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbhDVLtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 07:49:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1782DC06174A;
        Thu, 22 Apr 2021 04:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h4AVMm+Y3zmBUJJ9Lie4N/ArTZTC3WPpTqp9fKjAr1Y=; b=qJqAKnxJdl5z1xNr6KMz95RWtp
        YqQwKVb9aTVLxPGsDtEptzCZ04aiNNj0FG8tTQOr8ltdg+fh4HWGvZqM+XRwoTnl0vCEcNtcu4SUL
        GIIPznteonjrOLC79u/ycFIMbBVd22nUD1ksBeko6hlfl0Jkrbj9YymIArIqSUKvCD8y1Vy3sW5cv
        zsmhjQ37W2+tOm29DvDyJ0gyGvQMKJxNCtrSP9amZ0R7uJOSh/dgRb7qYzC9MLESxOAqK76WIh3sD
        fw/HZHAkGpyqav2VlEOXns/lSWkLFgk3zWfUG7FSf/MmP5PzQBMISU2K4RJd4mi2lv2PXikFop9vh
        7r1lqMmg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZXp3-00Gcoq-0t; Thu, 22 Apr 2021 11:48:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 97239300103;
        Thu, 22 Apr 2021 13:48:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7E08F2C1893EB; Thu, 22 Apr 2021 13:48:39 +0200 (CEST)
Date:   Thu, 22 Apr 2021 13:48:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Malcolm <dmalcolm@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-toolchains@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        yuanzhaoxiong@baidu.com
Subject: Re: static_branch/jump_label vs branch merging
Message-ID: <YIFilwwzWiSDZU6b@hirez.programming.kicks-ass.net>
References: <5f78b7e2f9ae937271ef52ee9e999a91c2719da9.camel@redhat.com>
 <YHBCoijoopbsDn29@hirez.programming.kicks-ass.net>
 <YHBQPr8q0cx4iUfN@hirez.programming.kicks-ass.net>
 <YHBS70ZQ6gOpMk2K@hirez.programming.kicks-ass.net>
 <3c062f70ffef2dcd48a661f7c8162fb8fbaf6869.camel@redhat.com>
 <YHCfgHwDtT7m4ffq@hirez.programming.kicks-ass.net>
 <0a9da587b0330bafdf612c3d51285e144b0b9e46.camel@redhat.com>
 <YHC0dgwhYS9hKcRT@hirez.programming.kicks-ass.net>
 <5a07bde1a9fa9a056a19637399b0635252ddb303.camel@redhat.com>
 <20210409213949.GA33256@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409213949.GA33256@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 11:39:49PM +0200, Peter Zijlstra wrote:
> On Fri, Apr 09, 2021 at 05:07:15PM -0400, David Malcolm wrote:
> 
> > You've built a very specific thing out of asm-goto to fulfil the tough
> > requirements you outlined above - as well as the nops, there's a thing
> > in another section to contend with.
> > 
> > How to merge these asm-goto constructs?
> 
> By calling the function less, you emit less of them. Which then brings
> us back to the whole pure/const thing.
> 
> > Doing so feels very special-case to the kernel and not something that
> > other GCC users would find useful.
> 
> Doesn't it boil down to 'fixing' the pure/const vs asm-goto interaction?
> I could imagine that having that interaction fixed could allow other
> creative uses.

Here is another variant:

  https://lore.kernel.org/lkml/830177B0-45E0-4768-80AB-A99B85D3A52F@baidu.com/

Can we please have a __pure__ attribute that is prescriptive and not a
hint the compiler is free to ignore for $raisins ?
