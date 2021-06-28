Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7D03B5AEF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 11:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbhF1JMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 05:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbhF1JMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 05:12:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FC8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 02:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Iyb5mZF5174BuQ/wLwPRQPHruQ1RlQ1OorAWSVvBYUg=; b=QLw9x9rs5QivUUOKzJp/XQQ4d8
        Cam9ScNiafKvbwKqyJ64n66MTI/d+7VUkZmuZrr3G1ZRtshFY27T3pY07Tc4p/+XFv9cKZO6ymUr0
        3zPklOPyrxliilarOsbLBdPM4M2r0HZwSL+WWKrJcn04NekO/IqP5xRiVOL9AbYlFXhHaHMrhNgZr
        WFGwlRYxAz2A+xwbDWAeglD6ZL+1+hYfcRtS8IvIeyfVjZ+8FUTeHeBi/uxt4JMrZHGtsb/dgUDvH
        cXLAIsOeIE38Hd0Q76t2qbajcsJM2P4IP0WbbKZT8Jzgh5BhvUjV68fSH/0D6MnGCiZkVeY8kkcfD
        lLNOiF8g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxnF0-002lx1-Cx; Mon, 28 Jun 2021 09:08:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 36714300204;
        Mon, 28 Jun 2021 11:07:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0E8382028DBF4; Mon, 28 Jun 2021 11:07:41 +0200 (CEST)
Date:   Mon, 28 Jun 2021 11:07:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     jpoimboe@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, joro@8bytes.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, x86@kernel.org,
        mbenes@suse.com, rostedt@goodmis.org, dvyukov@google.com
Subject: Re: [PATCH v2 03/24] objtool: Handle __sanitize_cov*() tail calls
Message-ID: <YNmRXdFCGfoXw2zG@hirez.programming.kicks-ass.net>
References: <20210624094059.886075998@infradead.org>
 <20210624095147.818783799@infradead.org>
 <YNW4g8RxydgADtW5@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNW4g8RxydgADtW5@elver.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 01:05:39PM +0200, Marco Elver wrote:
> On Thu, Jun 24, 2021 at 11:41AM +0200, Peter Zijlstra wrote:
> > Turns out the compilers also generate tail calls to __sanitize_cov*(),
> > make sure to also patch those out in noinstr code.
> > 
> > Fixes: 0f1441b44e82 ("objtool: Fix noinstr vs KCOV")
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Acked-by: Marco Elver <elver@google.com>
> 
> Thanks! More reason to not even try to do the same for other
> architectures, and the compiler needing the attribute...

Agreed!
