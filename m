Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2DB3FD10E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 04:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241435AbhIACIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 22:08:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241020AbhIACIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 22:08:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DEFE61059;
        Wed,  1 Sep 2021 02:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630462036;
        bh=GJgqsB7rRak8BqGGWdDbZ+413X80t/wSs8Tzi9ePzkI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YFMb8GVmeR9zAxxQLVVRZdaigiNXEhiW83TLn8G4TuqW3+wKvfdpnj9cHuRGdG5Ld
         z1+i6VkMqPmobycb8UjPrpa+79au/uu5pZOugDmHvmbHD5veHz/41gah/mvP3ukwpa
         Bzs0qX7py9dmneoE2hfxSKtawnPEfZaBbGUlLir2FJHhjpQH3E0M1PcvzXiUyP1FN8
         Mll1yKRx1tMjAaAwPdI1pvQUwUk9YPMs1xVNoGHSe9tBqkOT+uATWkvPUwD36PJ/+y
         3S2TT8Gv9/PkuFCASowWYS4ABOHeHdP5T0JwbAcaLo+MWXzqODmYmGSTjC87WQnJ77
         wZC13OWscBBZA==
Date:   Wed, 1 Sep 2021 11:07:13 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: Re: [kbuild] [trace:ftrace/core 35/39]
 kernel/trace/trace_boot.c:420 trace_boot_init_histograms() warn: curly
 braces intended?
Message-Id: <20210901110713.fed0ebd23c05033045953642@kernel.org>
In-Reply-To: <202109010207.nUISBZUN-lkp@intel.com>
References: <202109010207.nUISBZUN-lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Tue, 31 Aug 2021 21:45:11 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git  ftrace/core
> head:   3dc65994e3c1c999be3d991cdc96705e167cb3b1
> commit: 5d4648a0415efc239ffb377bce1d389723eda25d [35/39] tracing/boot: Show correct histogram error command
> config: x86_64-randconfig-m001-20210831 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> kernel/trace/trace_boot.c:420 trace_boot_init_histograms() warn: curly braces intended?
> kernel/trace/trace_boot.c:421 trace_boot_init_histograms() error: uninitialized symbol 'tmp'.
> kernel/trace/trace_boot.c:421 trace_boot_init_histograms() warn: passing freed memory 'tmp'
> kernel/trace/trace_boot.c:422 trace_boot_init_histograms() error: double free of 'tmp'
> 
> vim +420 kernel/trace/trace_boot.c
> 
> 30cb856e3067e5d Masami Hiramatsu 2021-08-06  396  static void __init
> 30cb856e3067e5d Masami Hiramatsu 2021-08-06  397  trace_boot_init_histograms(struct trace_event_file *file,
> 30cb856e3067e5d Masami Hiramatsu 2021-08-06  398  			   struct xbc_node *hnode, char *buf, size_t size)
> 30cb856e3067e5d Masami Hiramatsu 2021-08-06  399  {
> 30cb856e3067e5d Masami Hiramatsu 2021-08-06  400  	struct xbc_node *node;
> 30cb856e3067e5d Masami Hiramatsu 2021-08-06  401  	const char *p;
> 5d4648a0415efc2 Masami Hiramatsu 2021-08-06  402  	char *tmp;
> 30cb856e3067e5d Masami Hiramatsu 2021-08-06  403  
> 30cb856e3067e5d Masami Hiramatsu 2021-08-06  404  	xbc_node_for_each_subkey(hnode, node) {
> 30cb856e3067e5d Masami Hiramatsu 2021-08-06  405  		p = xbc_node_get_data(node);
> 30cb856e3067e5d Masami Hiramatsu 2021-08-06  406  		if (!isdigit(p[0]))
> 30cb856e3067e5d Masami Hiramatsu 2021-08-06  407  			continue;
> 30cb856e3067e5d Masami Hiramatsu 2021-08-06  408  		/* All digit started node should be instances. */
> 30cb856e3067e5d Masami Hiramatsu 2021-08-06  409  		if (trace_boot_compose_hist_cmd(node, buf, size) == 0) {
> 5d4648a0415efc2 Masami Hiramatsu 2021-08-06  410  			tmp = kstrdup(buf, GFP_KERNEL);
> 30cb856e3067e5d Masami Hiramatsu 2021-08-06  411  			if (trigger_process_regex(file, buf) < 0)
> 5d4648a0415efc2 Masami Hiramatsu 2021-08-06  412  				pr_err("Failed to apply hist trigger: %s\n", tmp);
> 5d4648a0415efc2 Masami Hiramatsu 2021-08-06  413  			kfree(tmp);
> 30cb856e3067e5d Masami Hiramatsu 2021-08-06  414  		}
> 30cb856e3067e5d Masami Hiramatsu 2021-08-06  415  	}
> 30cb856e3067e5d Masami Hiramatsu 2021-08-06  416  
> 30cb856e3067e5d Masami Hiramatsu 2021-08-06  417  	if (xbc_node_find_child(hnode, "keys")) {
> 30cb856e3067e5d Masami Hiramatsu 2021-08-06  418  		if (trace_boot_compose_hist_cmd(hnode, buf, size) == 0)
> 
> The missing curly braces here trigger a ball of static checker warnings.
> I'm so happy about that.  :)

The ftrace/core branch has a wrong version of the patch. ftrae/for-next has
correct one. I think Steve correct this mismatch after he comes back.

Thank you,



> 
> 5d4648a0415efc2 Masami Hiramatsu 2021-08-06  419  			tmp = kstrdup(buf, GFP_KERNEL);
> 30cb856e3067e5d Masami Hiramatsu 2021-08-06 @420  			if (trigger_process_regex(file, buf) < 0)
> 5d4648a0415efc2 Masami Hiramatsu 2021-08-06 @421  				pr_err("Failed to apply hist trigger: %s\n", tmp);
> 5d4648a0415efc2 Masami Hiramatsu 2021-08-06 @422  			kfree(tmp);
> 30cb856e3067e5d Masami Hiramatsu 2021-08-06  423  	}
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 
> 
> _______________________________________________
> kbuild mailing list -- kbuild@lists.01.org
> To unsubscribe send an email to kbuild-leave@lists.01.org
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
