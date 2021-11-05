Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9278044689D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 19:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbhKESsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 14:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbhKESsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 14:48:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B890C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 11:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FU/5WDp2+K9KX09DkFjUK8PWJVoij/2WiddvJIfmz0M=; b=G0IXXQGdqCkicVOIexpxNZX+l0
        GkVRgcJ9eZqiU8yO6pbViFHR5EDzIEtxfHhh2GEs4ZLZC3ddwy98FyBshd148iaSGFhyP7eRUoCJj
        lKRhClyJk9rrLtKqoryO0yWOIduVLadBq+DHnXwevhSPJ1EL9szdzr61YEhhHOqaiL1Nix2mzQcXS
        fybtI4F2KyILzdOiTFuI4CJayZinjsHZmW9FwPQz3iF2ljXRVKRl08KgRsmRcNuYeXDx68LL+NeWV
        6wk/cOKDPlDC9JjyZNE2NQKQUIFKlyYygOqGyEYoOFQN/JlwVS04Cye92+ScY4FnMf7A6i7HQJDFp
        pIZvjn3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mj4Du-00ENoF-0z; Fri, 05 Nov 2021 18:45:58 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id AC5719862D2; Fri,  5 Nov 2021 19:45:56 +0100 (CET)
Date:   Fri, 5 Nov 2021 19:45:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mark.rutland@arm.com, dvyukov@google.com, pbonzini@redhat.com,
        mbenes@suse.cz
Subject: Re: [RFC][PATCH 07/22] x86,extable: Extend extable functionality
Message-ID: <20211105184556.GN174703@worktop.programming.kicks-ass.net>
References: <20211104164729.226550532@infradead.org>
 <20211104165524.925401847@infradead.org>
 <YYVqnr+gql9RpL4C@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYVqnr+gql9RpL4C@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 05:32:14PM +0000, Sean Christopherson wrote:

> > +#define EX_IMM_MASK	0xFFFF0000

> > +	imm  = FIELD_GET(EX_IMM_MASK,  e->type);
> 
> FIELD_GET casts the result based on the type of the mask, but doesn't explicitly
> sign extend the masked field, i.e. there's no intermediate cast to tell the compiler
> that the imm is a 16-bit value that should be sign extended.
> 
> Modifying FIELD_GET to sign extended is probably a bad idea as I'm guessing the
> vast, vast majority of use cases don't want that behavior.  I'm not sure how that
> would even work with masks that are e.g. 5 bits or so.

So the way I was reading it was that typeof(_mask) is 'int', e->type is
also 'int', we mask out the top bits, and since it's all 'int' we do an
arith shift right (ie. preserves sign).

Where did that reading go wrong?
