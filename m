Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495AB3FFD06
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 11:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348715AbhICJ0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 05:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbhICJ0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 05:26:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7560AC061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 02:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F940qKPfPIDnCGZMGtAL4hahIDQqlWfP8bF/2Gf9mgM=; b=o1RV1mZEsx7CzIv7HOf9tyEbdL
        oi1u7FurLR+04xUsAmN5uuTle9oNpmbqFjSBp/SC89cAQEBVYxUlK9QKIfWm/BGv6lS8JVGy9m//N
        JgIRjyVrM2f0fZC7GY0gyn6Lv5CigBNZ4+2TSGAmPBPe1GXCwMxKnQd6JYTOR4cCcptzNT9N6H+Sz
        SrOaTcP1FDVi7kqvadOmTPVrP3VEfH0TPQFxjkPjs4gM1KYCL84/d9O4meSZmXqcELmOcQ5U/VzA1
        WbL+kZXwVBAvqvJv/6mTP7bmkJ0bpGxa/tPoxgBRfDktjo3NWY4NgS+g6RU3eLkI/H73+YJB/1WoQ
        eqbZ9/SQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mM5QC-004Jzq-0I; Fri, 03 Sep 2021 09:24:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 43DCC300299;
        Fri,  3 Sep 2021 11:23:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ED24D28B658E2; Fri,  3 Sep 2021 11:23:36 +0200 (CEST)
Date:   Fri, 3 Sep 2021 11:23:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, x86-ml <x86@kernel.org>
Subject: Re: vmlinux.o: warning: objtool: mce_wrmsrl.constprop.0()+0x6b: call
 to __sanitizer_cov_trace_pc() leaves .noinstr.text section
Message-ID: <YTHpmGmlo9N+1Rs7@hirez.programming.kicks-ass.net>
References: <202108221334.TiXxFSTZ-lkp@intel.com>
 <YTEncGj84Sj/IdDb@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTEncGj84Sj/IdDb@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 09:35:12PM +0200, Borislav Petkov wrote:
> On Sun, Aug 22, 2021 at 01:39:40PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   9ff50bf2f2ff5fab01cac26d8eed21a89308e6ef
> > commit: e100777016fdf6ec3a9d7c1773b15a2b5eca6c55 x86/mce: Annotate mce_rd/wrmsrl() with noinstr
> > date:   11 months ago
> > config: x86_64-buildonly-randconfig-r003-20210822 (attached as .config)
> > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> > reproduce (this is a W=1 build):
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e100777016fdf6ec3a9d7c1773b15a2b5eca6c55
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout e100777016fdf6ec3a9d7c1773b15a2b5eca6c55
> >         # save the attached .config to linux build tree
> >         mkdir build_dir
> >         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> vmlinux.o: warning: objtool: mce_wrmsrl.constprop.0()+0x6b: call to __sanitizer_cov_trace_pc() leaves .noinstr.text section
> >    vmlinux.o: warning: objtool: do_machine_check()+0xe1a: call to mce_panic.isra.0() leaves .noinstr.text section
> >    vmlinux.o: warning: objtool: exc_machine_check()+0x1af: call to __sanitizer_cov_trace_pc() leaves .noinstr.text section
> >    vmlinux.o: warning: objtool: lock_is_held_type()+0x3c: call to check_flags() leaves .noinstr.text section
> >    vmlinux.o: warning: objtool: __context_tracking_enter()+0x9d: call to __sanitizer_cov_trace_pc() leaves .noinstr.text section
> >    vmlinux.o: warning: objtool: __context_tracking_exit()+0x42: call to __sanitizer_cov_trace_pc() leaves .noinstr.text section
> 
> The sanitizer stuff is being NOPed out with newer compilers, says
> peterz. And I can confirm after testing with your .config and with
> gcc-11.

So I was wondering why they'd show up in any case, since objtool is
supposed to NOP them, but then I remembered I still have this patch
pending:

  https://lore.kernel.org/r/20210624095147.818783799@infradead.org

Which I suspect will cure that for older GCC.
