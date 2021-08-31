Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD0B3FCEC4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 22:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241207AbhHaUrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 16:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241038AbhHaUrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 16:47:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A78AC061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 13:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H6ruDVsaIsM1Hzs8AONSwdIqugERhVl/USiKu5ee3bc=; b=krScGubuiI2Ym8HEJnSZNuXOlt
        0JKm8RLkVa9H6plpzBtkiZnG3wksu/Tb+18vhQZUJ+aFqw4QTe2tjRxih0UlmOqiv3aRPKmp59F6Y
        nF1WWHWfImBg5xu7y/SzDhViUGUHVC5EoNf3q2sUWdnqv+gK2kUjQtxPD2FqqPmz8IriGEKb9RWRn
        otI40G1cFYChEhvekdY1v+wm6A9VUp1rORF/DWYYkUsxAF74fpLfPaEEDVOm2z8CtMBOheQZ4us1O
        b7JqIbG4Wv5Nc3iG7wW0veM7j/0B7AwhBCyFbmmTeyCtmkYQ3mP+ZmVPvavcSx/q4joi2SrCldjAJ
        Ad0xW6cA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLAcy-001YSk-6Q; Tue, 31 Aug 2021 20:45:15 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3DF2098176D; Tue, 31 Aug 2021 22:44:59 +0200 (CEST)
Date:   Tue, 31 Aug 2021 22:44:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 00/24] x86/entry/64: Convert a bunch of ASM entry code
 into C code
Message-ID: <20210831204459.GM4353@worktop.programming.kicks-ass.net>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831175025.27570-1-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 01:50:01AM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> Many ASM code in entry_64.S can be rewritten in C if they can be written
> to be non-instrumentable and are called in the right order regarding to
> whether CR3/gsbase is changed to kernel CR3/gsbase.
> 
> The patchset covert some of them to C code.

Overall, very nice! There's a lot of details to verify, but I really
like where this ends up.

I'm not sure about moving traps.c, but whatever, that's simple stuff.
I'll try and put some more eyeballs on this later.

