Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E52832151E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 12:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhBVL3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 06:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbhBVL2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 06:28:44 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF0FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 03:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AKMkOQRxL9OZt3xWljPnbeyEIC+Pe8fINfC5tAIFSyk=; b=l0RrpAdm85BLG2uw5wVe5Yfuqk
        oo83Ax1nhPHHmXR3bqNiC6JEx15qoq1uUqqkYvkqUKYGj8tLTtGlSgBWm4OCdGvy3hYwPnttcApbl
        RQqfxCD1hBY3H4JsGijkQTovC7daa1QNUqB9B/nCU+A7AjixOrKxyePpO6K59Mwa1sYh6K2tUTMzd
        v6LjPRr6I6TQ/KI1GCY8I/QSqkHrG2SGvX25Z4OIUxHlVIwsnwUmWG5h88DBFnUBxq5esX3+f5H3D
        jpla6Zd/btj6LjcLCXlwuxSNVS2LR9Yw8OtcPSUpGl95DfPUSE6mzyQU4tT7R8FB7KGfvqlWycwuJ
        Vg46Ao7w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lE9NM-0005OG-Oc; Mon, 22 Feb 2021 11:27:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 686B43013E5;
        Mon, 22 Feb 2021 12:27:36 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 52B422BC3285F; Mon, 22 Feb 2021 12:27:36 +0100 (CET)
Date:   Mon, 22 Feb 2021 12:27:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, tony.luck@intel.com, pjt@google.com,
        linux-kernel@vger.kernel.org, r.marek@assembler.cz,
        jpoimboe@redhat.com, jikos@kernel.org, andrew.cooper3@citrix.com
Subject: Re: [RFC][PATCH 2/2] x86/retpoline: Compress retpolines
Message-ID: <YDOVKBHDC3ish9k/@hirez.programming.kicks-ass.net>
References: <20210218165938.213678824@infradead.org>
 <20210218172151.942060087@infradead.org>
 <20210219071439.GA26778@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219071439.GA26778@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 08:14:39AM +0100, Borislav Petkov wrote:
> On Thu, Feb 18, 2021 at 05:59:40PM +0100, Peter Zijlstra wrote:
> > By using int3 as a speculation fence instead of lfence, we can shrink
> > the longest alternative to just 15 bytes:
> > 
> >   0:   e8 05 00 00 00          callq  a <.altinstr_replacement+0xa>
> >   5:   f3 90                   pause  
> >   7:   cc                      int3   
> >   8:   eb fb                   jmp    5 <.altinstr_replacement+0x5>
> >   a:   48 89 04 24             mov    %rax,(%rsp)
> >   e:   c3                      retq   
> > 
> > This means we can change the alignment from 32 to 16 bytes and get 4
> > retpolines per cacheline, $I win.
> 
> You mean I$ :)

Typin' so hard.

> In any case, for both:
> 
> Reviewed-by: Borislav Petkov <bp@suse.de>

Thanks, except I've been told there is a performance implication. But
since all that happened in sekrit, none of that is recorded :/

I was hoping for some people (Tony, Paul) to respond with more data.
Also, Andrew said that if we ditch the lfence we could also ditch the
pause.

So people, please speak up, and if possible share any data you still
might have from back when retpolines were developed such that we can
have it on record.
