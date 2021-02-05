Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C286431102E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 19:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbhBERB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 12:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbhBEQ7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 11:59:46 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EB9C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 10:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NbqZZlJBNKoRABcem6ibROJeY5SjBZsUTkMyZRNaBa0=; b=N0zcEeiwWV3DUHQdaWv4901O8v
        Emx0BQQZPxHFKSjZ8Elry8xva/MpZJQWF4cooTAUeAtniYn+UaLgg2NtLLVLj1f1ziz/xfrqs4szP
        22hWesDHZYYRIGwZVS7B6bnwaEFqWCACefhKXW9PuOl/URogTc2SzBmyFSnUWdmxTUaZeBSbat75q
        uNp5MnZ04hJOvX7VW3tgXGiuFSe7FbSp2fKQ4BJa4bXNuGYP3DyP7R/saBFeIVai2jur9+EzvdYEH
        OAPHKWLiezC+zUNjYh2Nw+lpbPdqlPDhDP7VtjBUlUWIXL6m/u3vZZUFvck8Tp09nP0MkWb7JAIHf
        LP1N5vdQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l81rE-0001N8-L9; Fri, 05 Feb 2021 14:13:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4FB7A3069B1;
        Fri,  5 Feb 2021 15:13:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 39DCA2138F7DD; Fri,  5 Feb 2021 15:13:10 +0100 (CET)
Date:   Fri, 5 Feb 2021 15:13:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, kbuild-all@lists.01.org,
        x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 06/12] x86/entry: Convert system vectors to irq stack
 macro
Message-ID: <YB1SdvRbHMY7IRrY@hirez.programming.kicks-ass.net>
References: <20210204211154.713523041@linutronix.de>
 <202102051148.WIj5O4Ry-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202102051148.WIj5O4Ry-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 11:52:40AM +0800, kernel test robot wrote:
> Hi Thomas,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on tip/x86/asm]
> [also build test WARNING on tip/master linus/master tip/x86/core v5.11-rc6 next-20210125]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Thomas-Gleixner/x86-irq-64-Inline-irq-stack-switching/20210205-091059
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 5c99720b28381bb400d4f546734c34ddaf608761
> config: x86_64-randconfig-r026-20210204 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/0day-ci/linux/commit/d91ff58e804175dd59e483c7cf236e1fe66c2187
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Thomas-Gleixner/x86-irq-64-Inline-irq-stack-switching/20210205-091059
>         git checkout d91ff58e804175dd59e483c7cf236e1fe66c2187
>         # save the attached .config to linux build tree
>         make W=1 ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> arch/x86/hyperv/hv_init.o: warning: objtool: sysvec_hyperv_reenlightenment()+0x7f: undefined stack state
> --
> >> arch/x86/kernel/cpu/mshyperv.o: warning: objtool: sysvec_hyperv_callback()+0x7f: undefined stack state
> >> arch/x86/kernel/cpu/mshyperv.o: warning: objtool: sysvec_hyperv_stimer0()+0x7f: undefined stack state

It would help if you'd actually applied the patches to a tree that had
the required objtool patches as described in 0/n. Or better yet, don't
scrape emails if the 0/n includes a git link which you'll run on anyway.
