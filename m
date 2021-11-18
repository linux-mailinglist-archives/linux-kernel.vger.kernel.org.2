Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF464563E9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 21:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbhKRUQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 15:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbhKRUQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 15:16:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2882FC06173E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 12:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xo2XYeaJG/qqhus6xR68XLV0gSC7QREKL0tgA0/MUxM=; b=OfPlGetaBXOcfIqzevQMg0WA5P
        WEWD13XAg3Q/0HRWufPCK73JglB9MHnzThTrZg1vv1B6Pp3EGwjTNcEpJJzZsHXfP3qLCqZI/xEws
        iYdLmiiKeqRKIY4TMh319c8f6tQF6MMDCfXjkpL/7HIq/ulkK5geYN9BNXoHL85QjAR1KhZd7dxSa
        N+weEm22a7CD9dBbQbsDuxBiJstHHQT8GCTinD3kage6xZmuAxdNyJf1pc82LBvehLboNOdP4PRN1
        OzbW3tjWnMwZFWIqeB+eSpTlxp3p/awMWn4OR1oAzXgiz1v5WmQ0EJ3+srd8nrl7L+7jkxL0XzsSU
        A2rSoxww==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnnms-008mA0-2P; Thu, 18 Nov 2021 20:13:38 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6DD9A9863CD; Thu, 18 Nov 2021 21:13:38 +0100 (CET)
Date:   Thu, 18 Nov 2021 21:13:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH V5 14/50] x86/entry: Expose the address of .Lgs_change to
 entry64.c
Message-ID: <20211118201338.GN174703@worktop.programming.kicks-ass.net>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
 <20211110115736.3776-15-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110115736.3776-15-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 07:57:00PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> The address of .Lgs_change will be used in traps.c in later patch when
> some entry code is implemented in entry64.c.  So the address of .Lgs_change
> is exposed to traps.c for preparation.
> 
> The label .Lgs_change is still needed in ASM code for extable due to it
> can not use asm_load_gs_index_gs_change.  Otherwise:
> 
> 	warning: objtool: __ex_table+0x0: don't know how to handle
> 	non-section reloc symbol asm_load_gs_index_gs_change
> 

I'm thinking commits:

  24ff65257375 ("objtool: Teach get_alt_entry() about more relocation types")
  4d8b35968bbf ("objtool: Remove reloc symbol type checks in get_alt_entry()")

Might have cured that.
