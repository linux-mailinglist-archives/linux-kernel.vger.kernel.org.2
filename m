Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B3236AFA1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 10:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbhDZISf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 04:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbhDZIR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 04:17:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB6BC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 01:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e5zbhd5FOra33og2cxWQI3U5NZ9xjlJiC9hepolDJQg=; b=KNbpkhUIJArjGRxujTDEKG4Oa4
        lp2oqTJytuQFqbmxabC72ExchCq1QBaJ6fVgG49Tql8nu0nhgiNe+b/TLt4oe3ZYvIa2fTSCBWkxJ
        +YwDnBWIgtwtQrIdxR2Fvwa3MtPtSac3IuOulWo7i+JQccvZiYWePuckC6fc4UFzIdSK4TKptKz/p
        weQ/4xsiBtNX2zFj2H21S2EqAmj/TkIK8Kl27+fkICJEmZ3355dQWyuL0DTFU9A7xyDxdBZd7RXXo
        pOjbyZUE3bPpwZPz4DPWWGzGNvW5TdJTur79eHolSexu/k+x9MXa8k7lvROX1CRsZDJampYmqfR/0
        YsbK+ymQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lawQS-007C9B-9O; Mon, 26 Apr 2021 08:17:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6A6903002B1;
        Mon, 26 Apr 2021 10:17:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3D9C52C988F3B; Mon, 26 Apr 2021 10:17:03 +0200 (CEST)
Date:   Mon, 26 Apr 2021 10:17:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     jpoimboe@redhat.com, jbaron@akamai.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] static_call: Use single copy of static_call_return0
Message-ID: <YIZ2/2H4W1U5DNBm@hirez.programming.kicks-ass.net>
References: <20210425211140.3157580-1-ak@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210425211140.3157580-1-ak@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25, 2021 at 02:11:40PM -0700, Andi Kleen wrote:
> With the inline version of static calls it is trying to use
> all static call functions inline. But this doesn't work for
> __static_call_return0, because its address is always taken,
> which forces the compiler to generate a out of line copy.
> 
> If it only exists as a static inline this means there are
> many copies generated. Instead use the out of line in static_call.c
> for this.
> 
> This fixes another bug. When _INLINE is set static_inline.c was
> not compiled at all, which disabled the self test even when
> it was enabled in the configuration.
> 
> This fixes a build problem with gcc LTO. __static_call_return0
> is referenced from assembler, which requires making it global
> because the assembler can end in a different file than the other
> C code.  But that's not possible for a static inline function.

This is ARCH=i386 only afaict, why do we care?
