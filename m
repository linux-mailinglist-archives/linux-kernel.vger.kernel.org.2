Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5123347869
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 13:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhCXMYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 08:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbhCXMXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 08:23:53 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0479CC061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 05:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4W4nSNFoir5Yp+A6zyQO0RGkUWgdlE6idemxYmJ56sY=; b=HNa43HM8bjAIEOC8TuNxKpdvpJ
        RRngvoi5SAlttlGmdAU+RtEbVyWEywUKxsfoe5U7FgMeTpC6+yECLW3/qnBB76dIJNYnUhXyxnwZ4
        TkJfdGK8yVon0F13EwLmx6iyjynpuGqYCz3vOju9qnjG32f2Zx0VJSEMdtl1JqM/tEYZuAZW9JxzN
        so2l6sYGMS3lyhsXROmlkfhBRUinANkPT6NP/8h2Cz+9TslepJ7ZyCCMXLcZkDV3QNPcXWBPmeH2G
        80cJiamwG6DuQzw8CqPluG/1o6vg6U3IphWsgNnDu5ynrzUA1qEgkAEGTZ1yIMPRH5T3F2hvI+vGm
        nz4lQ2dg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lP2Y2-00H3X7-VM; Wed, 24 Mar 2021 12:23:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1343F3007CD;
        Wed, 24 Mar 2021 13:23:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EBBF92BF5B73E; Wed, 24 Mar 2021 13:23:41 +0100 (CET)
Date:   Wed, 24 Mar 2021 13:23:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     guoren@kernel.org, linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Anup Patel <anup@brainfault.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] riscv: locks: introduce ticket-based spinlock
 implementation
Message-ID: <YFsvTXg07U+Adsto@hirez.programming.kicks-ass.net>
References: <1616580892-80815-1-git-send-email-guoren@kernel.org>
 <CAM4kBBK7_s9U2vJbq68yC8WdDEfPQTaCOvn1xds3Si5B-Wpw+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM4kBBK7_s9U2vJbq68yC8WdDEfPQTaCOvn1xds3Si5B-Wpw+A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 12:15:47PM +0100, Vitaly Wool wrote:
> On Wed, Mar 24, 2021, 11:16 AM <guoren@kernel.org> wrote:
> 
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > This patch introduces a ticket lock implementation for riscv, along the
> > same lines as the implementation for arch/arm & arch/csky.
> >
> 
> Could you please provide a rationale for this? Like, what is wrong with the
> current implementation.

test-and-set spinlocks have terrible worst case behaviour.
