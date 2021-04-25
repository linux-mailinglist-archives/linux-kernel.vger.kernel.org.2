Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5F036A3EF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 03:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhDYBbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 21:31:38 -0400
Received: from mga09.intel.com ([134.134.136.24]:2384 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229687AbhDYBbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 21:31:37 -0400
IronPort-SDR: QGGNzWBJYDvMtTOMVdWU4wZUV5rwfUHif6L1RdcC6WWILmFB8Hr1ZJo90T4+jMgMsq706wNLom
 4BkCme41yCYw==
X-IronPort-AV: E=McAfee;i="6200,9189,9964"; a="196316936"
X-IronPort-AV: E=Sophos;i="5.82,249,1613462400"; 
   d="scan'208";a="196316936"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2021 18:30:58 -0700
IronPort-SDR: VERNXzieqiffuNkWMmdxlLF2JeDjc9IOthaXXepEVXPMUiWVL/L0oe3jvyhv7MtohcYM6XzE3s
 kLeTHCVX8BHg==
X-IronPort-AV: E=Sophos;i="5.82,249,1613462400"; 
   d="scan'208";a="428899909"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2021 18:30:56 -0700
Date:   Sun, 25 Apr 2021 09:48:16 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Harish Sriram <harish@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [mm/vunmap] e47110e905: WARNING:at_mm/vmalloc.c:#__vunmap
Message-ID: <20210425014816.GB5251@xsang-OptiPlex-9020>
References: <20210423063227.GA17429@xsang-OptiPlex-9020>
 <CAHk-=wg8iAG6bBB+zdoZvZx1XYmyAXrWL0gPs_eTrTt+tXN0Tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg8iAG6bBB+zdoZvZx1XYmyAXrWL0gPs_eTrTt+tXN0Tw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Fri, Apr 23, 2021 at 10:18:18AM -0700, Linus Torvalds wrote:
> On Thu, Apr 22, 2021 at 11:15 PM kernel test robot
> <oliver.sang@intel.com> wrote:
> >
> > commit: e47110e90584a22e9980510b00d0dfad3a83354e ("mm/vunmap: add cond_resched() in vunmap_pmd_range")
> 
> Funky. That commit doesn't seem to have anything to do with the oops.
> 
> The oops is odd too:
> 
> > [  198.731223] WARNING: CPU: 0 PID: 1948 at mm/vmalloc.c:2247 __vunmap (kbuild/src/consumer/mm/vmalloc.c:2247 (discriminator 1))
> 
> That's the warning for an unaligned vunmap():
> 
>   2247          if (WARN(!PAGE_ALIGNED(addr), "Trying to vfree() bad
> address (%p)\n",
>   2248                          addr))
>   2249                  return;
> 
> > [  198.744933] Call Trace:
> > [  198.745229] free_module (kbuild/src/consumer/kernel/module.c:2251)
> 
>   2248          /* This may be empty, but that's OK */
>   2249          module_arch_freeing_init(mod);
>   2250          module_memfree(mod->init_layout.base);
>   2251          kfree(mod->args);
> 
> That's the "module_memfree()" - the return address points to the
> return point, which is the next line.
> 
> And as far as I can tell, the only thing that assigns anything but
> NULL to that init_layout.base is
> 
>                 ptr = module_alloc(mod->init_layout.size);
> 
> which uses __vmalloc_node_range() for the allocation.
> 
> So absolutely nothing in this report makes sense to me. I suspect it's
> some odd memory corruption.
> 
> Oliver - how reliable is that bisection?

we will check further if any issue in our test env.

by bot auto tests, we saw 12 issue instances out of 74 runs. but not happen
out of 100 runs of parent.
f3f99d63a8156c7a e47110e90584a22e9980510b00d
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
          1:100         -1%            :74    dmesg.BUG:kernel_reboot-without-warning_in_test_stage
          2:100          0%           2:74    dmesg.BUG:unable_to_handle_page_fault_for_address
           :100         12%          12:74    dmesg.Kernel_panic-not_syncing:Fatal_exception
          2:100          0%           2:74    dmesg.Oops:#[##]
          1:100         -1%            :74    dmesg.RIP:__is_module_percpu_address
           :100         12%          12:74    dmesg.RIP:__vunmap  <-----
           :100         12%          12:74    dmesg.RIP:kfree
           :100          1%           1:74    dmesg.RIP:kobject_add_internal
          2:100         -1%           1:74    dmesg.RIP:print_modules
          1:100         -1%            :74    dmesg.RIP:skip_spaces
          1:100         -1%            :74    dmesg.RIP:usercopy_abort
           :100          1%           1:74    dmesg.WARNING:at_lib/kobject.c:#kobject_add_internal
           :100         12%          12:74    dmesg.WARNING:at_mm/vmalloc.c:#__vunmap
          3:100         10%          13:74    dmesg.boot_failures
          1:100         -1%            :74    dmesg.canonical_address#:#[##]
          2:100         -2%            :74    dmesg.invalid_opcode:#[##]
          2:100         -2%            :74    dmesg.kernel_BUG_at_mm/usercopy.c
           :100         11%          11:74    dmesg.stack_segment:#[##]



> 
> Does anybody else see what might be up?
> 
>             Linus
