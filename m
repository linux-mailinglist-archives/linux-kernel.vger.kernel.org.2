Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C79C359E0B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbhDIL4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:56:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21263 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231611AbhDIL4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617969349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iRJa8TFvtmvXz2BbVWf2leybWHb8YZANyyLewNghcak=;
        b=OCkh7thC1pXWWcck0qcPLan5jzVJYJ9WFhKWSAjOmySmx/N87d5W3/SZU74XAFcEOdXRHZ
        DhinSxYNO29/lIM66cKayK30aQHCyPknwmvYAvy+cb4l/ppcj3tfBSrXikaGTVEthHiHTz
        m51E4f8J7upcEIgGmiU36YmW1/OqIl8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-KAmZKu7gNBi7H3KMmJWkJw-1; Fri, 09 Apr 2021 07:55:45 -0400
X-MC-Unique: KAmZKu7gNBi7H3KMmJWkJw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 542BC1008061;
        Fri,  9 Apr 2021 11:55:44 +0000 (UTC)
Received: from t14s.localdomain (ovpn-112-65.phx2.redhat.com [10.3.112.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 735D85C1D5;
        Fri,  9 Apr 2021 11:55:43 +0000 (UTC)
Message-ID: <5f78b7e2f9ae937271ef52ee9e999a91c2719da9.camel@redhat.com>
Subject: Re: static_branch/jump_label vs branch merging
From:   David Malcolm <dmalcolm@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-toolchains@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Date:   Fri, 09 Apr 2021 07:55:42 -0400
In-Reply-To: <YHA2jPIaj0p23mv8@hirez.programming.kicks-ass.net>
References: <YG80wg/2iZjXfCDJ@hirez.programming.kicks-ass.net>
         <CAMj1kXGngxH0VCHyREKeLau=159sRkWYKVZwOV84r6dvCqXcig@mail.gmail.com>
         <YHA2jPIaj0p23mv8@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-04-09 at 13:12 +0200, Peter Zijlstra wrote:
> On Fri, Apr 09, 2021 at 11:57:22AM +0200, Ard Biesheuvel wrote:
> > On Thu, 8 Apr 2021 at 18:53, Peter Zijlstra <peterz@infradead.org>
> > wrote:
> 
> > > Is there *any* way in which we can have the compiler recognise
> > > that the
> > > asm_goto only depends on its arguments and have it merge the
> > > branches
> > > itself?
> > > 
> > > I do realize that asm-goto being volatile this is a fairly huge
> > > ask, but
> > > I figured I should at least raise the issue, if only to raise
> > > awareness.
> > > 
> > 
> > Wouldn't that require the compiler to interpret the contents of the
> > asm() block?
> 
> Yeah, this is more or less asking for ponies :-) One option would be
> some annotation that conveys the desired semantics without it having
> to
> untangle the mess in the asm block.
> 
> The thing the compiler needs to know is that the branch is constant
> for
> any @key, and hence allow the obvious optimizations. I'm not sure if
> this is something compiler folks would be even willing to consider,
> but
> I figured asking never hurts.
> 

Sorry if this is a dumb question, but does the function attribute:
  __attribute__ ((pure)) 
help here?  It's meant to allow multiple calls to a predicate to be
merged - though I'd be nervous of using it here, the predicate isn't
100% pure, since AIUI the whole point of what you've built is for
predicates that very rarely change - but can change occasionally.

Hope this is constructive
Dave


