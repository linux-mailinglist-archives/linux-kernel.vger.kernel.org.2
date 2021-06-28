Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77EC33B65EC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 17:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237237AbhF1Poa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 11:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237046AbhF1PoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 11:44:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7F0C094246
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 08:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VB1DknrWVbY9Khq707YQZej2CCQ0Z5AyZ8g92XnuLGY=; b=eLBbjA+5vJeyt+CnksfQ3fboOY
        pe2Be/sjm6+fhtNUFj4L5obZ32R7c8SB65RJGT9scHvwkkc4X5Sp3XLJsRZUxZPFWhouj0PozxD5L
        ewEkcQU6dLqbiJwZx8v7nR/upAkYBnkI5rlfm3eXM2geNZQu7zkyetEn8uTEYRsmR91r5QnFS6rBu
        GTG3EdmnziVahU4uSxvkx8e5px2rTT01xdEbFu51r2NRSybuorNDDp//XQgWSJ4VBfJ9qH+mW4MtL
        YYKUHr7Z0KLmNXtjsWD/nP/I5SGbPUwzVElR8yVppORDOvquPC/6JwlJhi+rybE0lYi5WSK35VRP9
        Hsb/hODw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxsnH-00CaSU-E7; Mon, 28 Jun 2021 15:03:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 79FC33001DC;
        Mon, 28 Jun 2021 17:03:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 470612041E859; Mon, 28 Jun 2021 17:03:26 +0200 (CEST)
Date:   Mon, 28 Jun 2021 17:03:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     jpoimboe@redhat.com, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] kprobe/static_call: Restore missing
 static_call_text_reserved()
Message-ID: <YNnkvpLoDsql2mdq@hirez.programming.kicks-ass.net>
References: <20210628112409.233121975@infradead.org>
 <20210628113045.167127609@infradead.org>
 <YNmz4nvH84jzX1aB@hirez.programming.kicks-ass.net>
 <20210628232447.540fe9d53f0d2011d6590379@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628232447.540fe9d53f0d2011d6590379@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 11:24:47PM +0900, Masami Hiramatsu wrote:
> On Mon, 28 Jun 2021 13:34:58 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Mon, Jun 28, 2021 at 01:24:12PM +0200, Peter Zijlstra wrote:
> > > Restore two hunks from commit 6333e8f73b83 ("static_call: Avoid
> > > kprobes on inline static_call()s") that went walkabout.
> > > 
> > > Fixes: 76d4acf22b48 ("Merge tag 'perf-kprobes-2020-12-14' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")
> > 
> > FWIW, it was a royal pain in the arse to find that commit...
> 
> I think if this is a fix, that fixes static_call introduction commit,
> because anyway kprobes has to check the static_call site as a reserved
> area for another self code modifying.

Yeah, so 6333e8f73b83 has these two hunks, so the initial commit was
fine, but the merge commit from the Fixes: tag lost them again for some
reason. So this really is a fix for a merge commit afaict.
