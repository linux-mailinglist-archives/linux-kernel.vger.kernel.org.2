Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA8142A5CC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 15:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbhJLNiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 09:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbhJLNh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 09:37:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CC5C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 06:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tXNnx8LeK5vZDxn3FyZJdfp25+yJkUEyDS/Jbb2knQk=; b=U4jLcsSsGVTd9zx0Ykbqv4JBhU
        fz5hml3Qx8SKX3sKfiDE/Uu+bMqD27z4Ax6zvIejJhkeiUErggRBKpUyl0CAPu3PHGLNlbUzzJQ9j
        Mb+PYzo66/9jBgqbU9O0Ga0ZD24CM9zsnDqrkn84LryVYkWmgmwlszWrtS4dqiBitAJgCgbMMptDa
        FB8j1CDJqKYobfpKXRPugCqEJM+LRhrRwdSx0A35tTyRKCWtQqVwnXVqp4Jy/GlAfiO4RtCZLNbiw
        VzmbGFmsyo9z1a9tsWm7OC3hJqloh0t2x6SYkTdDFtQ5nNynvhSRwbJruTzameWCds6/tlFrzuaXC
        KNcxo8uQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maHwW-009Q3j-9p; Tue, 12 Oct 2021 13:35:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1CE1530032E;
        Tue, 12 Oct 2021 15:35:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 01E172C8434D1; Tue, 12 Oct 2021 15:35:42 +0200 (CEST)
Date:   Tue, 12 Oct 2021 15:35:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [tip:sched/core 14/47] kernel/sched/fair.c:893:22: error:
 variable 'p' set but not used
Message-ID: <YWWPLnaZGybHsTkv@hirez.programming.kicks-ass.net>
References: <202110121132.N2z9JrD0-lkp@intel.com>
 <YWVw/oVd5ztGZDAK@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWVw/oVd5ztGZDAK@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 01:26:54PM +0200, Peter Zijlstra wrote:

> Again, I have absolutely no intention of fixing this. IMO this is the
> compiler being a total pain in the arse.
> 
> Please stop reporting this.

How's this then?

diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 978fcfca5871..b0d9121c5dce 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -3,6 +3,10 @@ ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_clock.o = $(CC_FLAGS_FTRACE)
 endif
 
+# The compilers are complaining about unused variables inside an if(0) scope
+# block. This is daft, shut them up.
+ccflags-y += -Wno-unused-but-set-variable
+
 # These files are disabled because they produce non-interesting flaky coverage
 # that is not a function of syscall inputs. E.g. involuntary context switches.
 KCOV_INSTRUMENT := n
