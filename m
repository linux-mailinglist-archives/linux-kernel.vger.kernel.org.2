Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26683321531
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 12:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhBVLhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 06:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbhBVLhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 06:37:33 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A3EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 03:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EEQvCQV49/AMZvFzjJj3SI49cboYpENekv5KWDAlwdQ=; b=CAJve6SWqgThcFBO6QJcWx1vzb
        Rol2SSN0wt+gFIfPvQVcDA2MRMa1yrvEibgMRsTGKPqpXVfCEzpDvDujL7SlkmR6Nz89NQ9xUCUAw
        Ml/7bvjcDimGm3USWe3cs8ZCmUNJGHcFUOBzIy8cKApgtX83PFA5Nh/g2CTTvMhF0DUDMbPv8LmrT
        1d/xTL3AnG7qyogfWEjKurW1mffXjpxgf0UP3AAntdFvZdOAPrk33S7q5ohCOH8Evu+Bz2JlVihlX
        PCvwEViXe/YOr0gx4lyJJIIj5+wjPr5wvK7yBhjEPS2mqu9Z0iWcxNSvevh+qrfyyX+udksDi47Pa
        8uScAuKw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lE9W8-0005x6-Pq; Mon, 22 Feb 2021 11:36:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5F577300DB4;
        Mon, 22 Feb 2021 12:36:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 31E482BC24B51; Mon, 22 Feb 2021 12:36:43 +0100 (CET)
Date:   Mon, 22 Feb 2021 12:36:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, tony.luck@intel.com, pjt@google.com
Cc:     linux-kernel@vger.kernel.org, r.marek@assembler.cz,
        jpoimboe@redhat.com, jikos@kernel.org
Subject: Re: [RFC][PATCH 1/2] x86/retpoline: Simplify retpolines
Message-ID: <YDOXSw2vNLzRNdPN@hirez.programming.kicks-ass.net>
References: <20210218165938.213678824@infradead.org>
 <20210218172151.835108198@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218172151.835108198@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 05:59:39PM +0100, Peter Zijlstra wrote:
> Currently out retpolines consist of 2 symbols,
> __x86_indirect_thunk_\reg, which is the compiler target, and
> __x86_retpoline_\reg, which is the actual retpoline. Both are
> consecutive in code and aligned such that for any one register they
> both live in the same cacheline:
> 
>   0000000000000000 <__x86_indirect_thunk_rax>:
>    0:   ff e0                   jmpq   *%rax
>    2:   90                      nop
>    3:   90                      nop
>    4:   90                      nop
> 
>   0000000000000005 <__x86_retpoline_rax>:
>    5:   e8 07 00 00 00          callq  11 <__x86_retpoline_rax+0xc>
>    a:   f3 90                   pause
>    c:   0f ae e8                lfence
>    f:   eb f9                   jmp    a <__x86_retpoline_rax+0x5>
>   11:   48 89 04 24             mov    %rax,(%rsp)
>   15:   c3                      retq
>   16:   66 2e 0f 1f 84 00 00 00 00 00   nopw   %cs:0x0(%rax,%rax,1)
> 
> The thunk is an alternative_2, where one option is a jmp to the
> retpoline.

So the reason I originally did that was because objtool could not deal
with alternatives with stack ops. But we've recently fixed that.
