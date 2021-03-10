Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2025334049
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 15:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbhCJOZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 09:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbhCJOY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 09:24:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98149C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 06:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=plOvh9vyCxI+W79dsawsRUqmt5nDXxIS3jse/b6xlb8=; b=P12Z1QOJ7Ys0pmztT9aYj3qM0T
        eeGReMBtFtdOaTIWJHIpmZN7wBuQ4L9uY02X4f9WZXO9WBMn1gsfEgg8qD0G0kgxBtF5LvLGu3C1I
        JTtMQdQB3zqjSyrsXkHZcn2pDrSpsqInvZ3l+iaJrpz7NmjXN9BBvT0BPMY3fTBn8PFtOpqFXYCbq
        AndpkJ/1F1qJ+sFNPrYod4TgJSvtTheoWby1wR17zcZ17UI/kir8jrYGvaHMDmAlNOFi9WzDimASd
        94EbYe/cni19rSsGrmHwKuQ0eTAvKQvlJ3kclzDVKGhtSkoIicjKswgpPNYuLhpXoDMCVco5XNJnd
        NUnbbLBg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lJzlY-003gZB-F1; Wed, 10 Mar 2021 14:24:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4FB063011F0;
        Wed, 10 Mar 2021 15:24:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 43A9C21ADDC04; Wed, 10 Mar 2021 15:24:47 +0100 (CET)
Date:   Wed, 10 Mar 2021 15:24:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: The killing of ideal_nops[]
Message-ID: <YEjWryS/9uB2y62O@hirez.programming.kicks-ass.net>
References: <YEepKVHc5kkDybu6@hirez.programming.kicks-ass.net>
 <20210309120519.7c6bbb97@gandalf.local.home>
 <YEfnnFUbizbJUQig@hirez.programming.kicks-ass.net>
 <362BD2A4-016D-4F6B-8974-92C84DC0DDB4@zytor.com>
 <YEiN+/Zp4uE/ISWD@hirez.programming.kicks-ass.net>
 <YEiS8Xws0tTFmMJp@hirez.programming.kicks-ass.net>
 <YEiZXtB74cnsLTx/@hirez.programming.kicks-ass.net>
 <YEid+HQnqgnt3iyY@hirez.programming.kicks-ass.net>
 <20210310091324.0c346d5f@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310091324.0c346d5f@oasis.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 09:13:24AM -0500, Steven Rostedt wrote:
> On Wed, 10 Mar 2021 11:22:48 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > After this FEATURE_NOPL is unused except for required-features for
> > x86_64. FEATURE_K8 is only used for PTI and FEATURE_K7 is unused.
> > 
> > AFAICT this negatively affects lots of 32bit (DONTCARE) and 32bit on
> > 64bit CPUs (CARELESS) and early AMD (K8) which is from 2003 and almost
> > 2 decades old by now (SHRUG).
> > 
> > Everything x86_64 since AMD K10 (2007) was using p6_nops.
> > 
> > And per FEATURE_NOPL being required for x86_64, all those CPUs can use
> > p6_nops. So stop caring about NOPs, simplify things and get on with life
> > :-)
> 
> Before ripping out all the ideal_nop logic, I wonder if we should just
> force the nops you want now (that is, don't change the selected
> ideal_nops, just "pretend" that the CPU wants p6_nops), and see if anyone
> complains. After a few releases, if there's no complaints, then we can
> rip out the ideal_nop logic.

Nah, just rip the entire thing out. You should be happy about
deterministic NOPs :-)

NOP encoding is not something CPUs should differentiate on, that's just
bollocks.
