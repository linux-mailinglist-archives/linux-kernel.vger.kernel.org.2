Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067F944F202
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 08:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbhKMHeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 02:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhKMHeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 02:34:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32519C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 23:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gIFuCx8Z5d7zHxSEInIU+r5QCKyk2HEGRfEzX3OQVB0=; b=J96kvpFzbP7oEkKVwvzTns461T
        PKqUqXIUXEJZavva3dU37oQiUIoYmqGPUS57WImZWPM1R3RSQ2E06f5dMOYarzcdNDJvQTWETSGr/
        p8NWTz0yrP6N8usSobq+QV/LUMzyMdOCFG/t6Lqs9SP+zv4we4TIkTA6HI4CNGKpV39bppLiRWlbf
        6KI/Aznhw8/bO6m8T+IFRJFfKxUEB9+9Y52tBslBLHaBH84kHz+VLtskPzvxeHkBHheQaOF6t1lIt
        YsfxGRIqpIwc4wKLef4lN+aJ3RAtaJaXKlNV58n1XBSRcT7kbRXU0H07/V7Z64EqfeqivzMUGS5wL
        A+03UZiQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mlnVL-0047Ua-Tt; Sat, 13 Nov 2021 07:31:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5DC0630001B;
        Sat, 13 Nov 2021 08:31:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1BBE22133FB5B; Sat, 13 Nov 2021 08:31:15 +0100 (CET)
Date:   Sat, 13 Nov 2021 08:31:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: vmlinux.o: warning: objtool: kvm_spurious_fault()+0x22: call to
 ftrace_likely_update() leaves .noinstr.text section
Message-ID: <YY9pw6wrKsY5CrOo@hirez.programming.kicks-ass.net>
References: <202111131049.j3jDJJap-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202111131049.j3jDJJap-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2021 at 10:48:52AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   66f4beaa6c1d28161f534471484b2daa2de1dce0
> commit: 63b3f96e1a989846a5a521d4fbef4bc86406929d kvm: Select SCHED_INFO instead of TASK_DELAY_ACCT
> date:   6 months ago
> config: x86_64-buildonly-randconfig-r002-20211009 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=63b3f96e1a989846a5a521d4fbef4bc86406929d
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 63b3f96e1a989846a5a521d4fbef4bc86406929d
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> vmlinux.o: warning: objtool: kvm_spurious_fault()+0x22: call to ftrace_likely_update() leaves .noinstr.text section
> >> vmlinux.o: warning: objtool: vmx_update_host_rsp()+0x34: call to ftrace_likely_update() leaves .noinstr.text section

Yeah, that's CONFIG_TRACE_BRANCH_PROFILING and it is broken. It will
eventually explode once we push the PTI CR3 switcheroo into C due to
trying to access kernel data before kernel address space is mapped.


