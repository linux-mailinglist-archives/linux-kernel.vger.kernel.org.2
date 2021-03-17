Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58AB33F576
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 17:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbhCQQ1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 12:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbhCQQ13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 12:27:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D40C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 09:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PzFjfcKU0dpOBkCrXALoP0tCUsX6Kj5eOf+Fi37sBwg=; b=ah0ZUGSFAMbhL5DjKcoTOfBu7v
        vU+ao9+sSBMiyPBjmx9ehweNqduLtcRrM08dGWhfFuh7F8g+GCi2XE7PW8IIlKAzCUm5qA6Lcaf27
        KFMiFLqSgtbSImMryp8FGne2n+aT4mSHqM54kP8MoFCg+zoeRKTwt86ZFQrZFGoNKr1lhNP58xyBS
        5HHMwVjxFyGzvCaYHiGwPTVdBiUtpN3KthfMr+teGoi0wIJcAcRsfL5PXMfLCemdl9jeWv/T7Zlx4
        L3YVJVwaAggxRQG3NLG4HzidLFkSleMothVJitdCqVmnNnLeuOIsZwdlEBQI88wyaFavmq7YKSLi0
        F19VSNDw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMZ0C-001ntD-Iz; Wed, 17 Mar 2021 16:26:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 79E463050F0;
        Wed, 17 Mar 2021 17:26:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5E4F92BB540E0; Wed, 17 Mar 2021 17:26:30 +0100 (CET)
Date:   Wed, 17 Mar 2021 17:26:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>, X86 ML <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH -tip 0/3] x86/kprobes: Remoev single-step trap from x86
 kprobes
Message-ID: <YFIttoNvw1TTMR3a@hirez.programming.kicks-ass.net>
References: <20210225112245.607c70ec13cf8d279390e89e@kernel.org>
 <161469871251.49483.9142858308048988638.stgit@devnote2>
 <20210317235522.f327f2a8f43af2e27e5bccea@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317235522.f327f2a8f43af2e27e5bccea@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 11:55:22PM +0900, Masami Hiramatsu wrote:
> Hi Andy,
> 
> Would you think you still need this series to remove iret to kernel?

They're an improvement anyway, let me queue them so that they don't get
lost.

I'll line them up for tip/x86/core unless anybody else thinks of a
better place for them and tells me in time ;-)
