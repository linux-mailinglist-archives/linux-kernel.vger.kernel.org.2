Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E160033D044
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 10:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhCPJCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 05:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbhCPJBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 05:01:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DC6C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 02:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DmNY+6dWKZNKGNOlByNK9dvF7iFfEFOcLjrOq6DHoRA=; b=CYjrVp0p6ws6XN986oyLGIHnoz
        HArtugcJbvSPGS2+AV00oRNtB4u6tsQh4tW+tERtpAML2HH62298CWWMwNXZYbVv2VrgBdFSBHUT0
        6TnWFWnxwIYOLGNRRAJY78CHMpsEn/zBQpvb0nkvZ4zm1uH46kB92dsjYC50K0L1S2FPsDEqYGACl
        Zk6FnkGo4aF04IyxbFXyhSPk4BZdqAqoBXHW1s30yzRD5Zmc5wKdkbb1+h78l9k9UDxgQ7fn6jw/R
        51x7wxLsYPXr8OvbJ4I4Ku6oL9QMm+HF25K3eIChyRUWWO/XiRgpADDrWtqVBe9pHWk4BZCyIKr5H
        9v/+zY4A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lM5Zr-001hp2-Sb; Tue, 16 Mar 2021 09:01:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0B892300130;
        Tue, 16 Mar 2021 10:01:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E5ACE2B87B602; Tue, 16 Mar 2021 10:01:21 +0100 (CET)
Date:   Tue, 16 Mar 2021 10:01:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [tip:x86/cpu 2/3] arch/x86/kernel/alternative.c:96:10: warning:
 Undefined behaviour, pointer arithmetic 'x86nops+10' is out of bounds.
Message-ID: <YFBz4ZXSsdUoI9eS@hirez.programming.kicks-ass.net>
References: <202103160701.3uXlWiWM-lkp@intel.com>
 <20210316082703.GA18003@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316082703.GA18003@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 09:27:03AM +0100, Borislav Petkov wrote:
> Yet another useless report!
> 
> On Tue, Mar 16, 2021 at 07:50:10AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
> > head:   301cddc21a157a3072d789a3097857202e550a24
> > commit: a89dfde3dc3c2dbf56910af75e2d8b11ec5308f6 [2/3] x86: Remove dynamic NOP selection
> > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > 
> > cppcheck possible warnings: (new ones prefixed by >>, may not real problems)
> 
> What's cppcheck?
> 
> That?
> 
> Description-en: tool for static C/C++ code analysis (CLI)
>  Cppcheck is a command-line tool that tries to detect bugs that your
> 
> 
> > >> arch/x86/kernel/alternative.c:96:10: warning: Undefined behaviour, pointer arithmetic 'x86nops+10' is out of bounds. [pointerOutOfBounds]
> >     x86nops + 1 + 2 + 3 + 4,
> >             ^
> >    arch/x86/kernel/alternative.c:97:10: warning: Undefined behaviour, pointer arithmetic 'x86nops+15' is out of bounds. [pointerOutOfBounds]
> >     x86nops + 1 + 2 + 3 + 4 + 5,
> >             ^
> >    arch/x86/kernel/alternative.c:98:10: warning: Undefined behaviour, pointer arithmetic 'x86nops+21' is out of bounds. [pointerOutOfBounds]
> >     x86nops + 1 + 2 + 3 + 4 + 5 + 6,
> >             ^
> >    arch/x86/kernel/alternative.c:99:10: warning: Undefined behaviour, pointer arithmetic 'x86nops+28' is out of bounds. [pointerOutOfBounds]
> >     x86nops + 1 + 2 + 3 + 4 + 5 + 6 + 7,
> >             ^
> > >> arch/x86/kernel/ftrace.c:304:7: warning: union member 'ftrace_op_code_union::code' is never used. [unusedStructMember]
> >     char code[OP_REF_SIZE];
> >          ^
> 
> How do you trigger this?
> 
> /me ignores it until there's some info on how those things can be
> reproduced.

Just ignore, cppcheck is a load of crap. I don't know why they bother
running it.
