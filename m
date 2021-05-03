Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47983716D3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 16:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbhECOoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 10:44:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhECOoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 10:44:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 467766109E;
        Mon,  3 May 2021 14:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620052991;
        bh=QqpdAM9cyovRRjEPytf1AWzRpegSeHbXe6+ekzdkZJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=STgw8ExIEIdfplPWQyUKr3HQqR1xOwEXK87YvCmevPdXuiMYOK/9L7ZYj66Ouj0ew
         aKbZqDbpwizVnlNWkp2XZnqNo6GahOVoKdsPjWA7WhbCCsNpxRxG8M6VRqL9cZWh6y
         sCvYT0yHbYo8CkrtO27rGYvbgBbysyn0bir1e16JS05hvCWl+fyPAI5HL0T4nAu/8a
         BGpu+nKDWixABkXwy+9zX01QTvqXHCi4mguBvSywfXsvT8PSMkk9Jn7BA2nkc4H/Kd
         516Bx98PWVjOrurYs9ne2XYY0rNnZmVji9hV6X/qQJtAxbHqjZXBukkKbAdToa1z1p
         VWqzs28NVpvPg==
Date:   Mon, 3 May 2021 16:43:05 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oliver Sang <oliver.sang@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Harish Sriram <harish@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [mm/vunmap] e47110e905: WARNING:at_mm/vmalloc.c:#__vunmap
Message-ID: <YJAL+cxa3p2q5zOu@gunter>
References: <20210423063227.GA17429@xsang-OptiPlex-9020>
 <CAHk-=wg8iAG6bBB+zdoZvZx1XYmyAXrWL0gPs_eTrTt+tXN0Tw@mail.gmail.com>
 <20210425014816.GB5251@xsang-OptiPlex-9020>
 <CAHk-=wiW7xdHZTBgVOpVFM_7bek0HGvioQvCCyDXCbRa2fWdXQ@mail.gmail.com>
 <20210429075300.GA31265@xsang-OptiPlex-9020>
 <CAHk-=wh62h6XXgKqhHnb=LTrmbMcVsV8GhXJvEoceTyHKtdBJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHk-=wh62h6XXgKqhHnb=LTrmbMcVsV8GhXJvEoceTyHKtdBJA@mail.gmail.com>
X-OS:   Linux gunter 5.11.16-1-default x86_64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Linus Torvalds [29/04/21 10:31 -0700]:
>[ Backgroudn for Jessica:
>
>    https://lore.kernel.org/lkml/20210423063227.GA17429@xsang-OptiPlex-9020/
>
>  with some more emails in this thread ]
>
>On Thu, Apr 29, 2021 at 12:36 AM Oliver Sang <oliver.sang@intel.com> wrote:
>> >
>> > Oh, that's interesting. So only 12 out of 74 runs saw that __vunmap
>> > warning, but if I understand your table correctly, there were some
>> > _other_ issues in there?
>>
>> yes, there are.
>
>Yeah, so it really does look like the commit you bisected to changes
>timing - and thus just exposes an existing problem.
>
>And it's likely a race condition, and it exposes the existing problem
>not just in a new place, but much *MORE*.
>
>The fact that you see something like
>
>    Trying to vfree() bad address (0000000070935066)
>
>means that clearly something has corrupted the the module data in
>'struct module *'. Because that should have been a core_layout.base
>pointer that was allocated with moodule_alloc(), which is just a
>vmalloc wrapper on x86-64.
>
>The allocations in the module handling are somewhat odd (putting it
>mildly), with that 'struct module *' actually being a pointer *into*
>the module allocation itself, so I suspect there's some race with
>del_module() or something, and the reason you bisect to that commit
>e47110e90584a22e9980510b00d0dfad3a83354e is that the added
>cond_schedule() in the vfree path now exposes exactly that race of two
>things trying to free the same module at the same time.
>
>This all *should* be serialized by various subtle things
>
> - MODULE_STATE_UNFORMED means that modules are bypassed
>
> - the actual allocation/freeing functions use module_mutex to serialize
>
> - some lookup functions use RCU to look up a module but should then
>only look at things like the symbol arrays etc.
>
>but if somehow del_module() can race with do_init_module() creating a
>module halfway and then doing free_module() (or perhaps multiple
>module loads of the same module racing and aborting), then I can see
>one freeing the underlying module data, and the other one seeing
>corrupt 'struct module *' as a result.

The situation is bizarre to me. From the call trace:

[  198.744933] Call Trace:
[  198.745229] free_module (kbuild/src/consumer/kernel/module.c:2251)
[  198.745629] do_init_module (kbuild/src/consumer/kernel/module.c:3705)
[  198.746054] ? rcu_read_lock_bh_held (kbuild/src/consumer/kernel/rcu/update.c:131)
[  198.746576] load_module (kbuild/src/consumer/kernel/module.c:3968)

This tells me that we were in the middle of loading a module and hit one of the
error conditions in do_init_module() - either the kmalloc() call failed or the
module init function returned an error and now we've landed in the error path
of do_init_module(), hence the call to free_module().

But if we failed here, this also means the module never made it to the LIVE
state - it was COMING, then immediately GOING. There is a liveness check in
delete_module(), so any calls to delete_module() on this module should have
returned -EBUSY. So module removal operations should not even be touching this
module. Multiple module loads of the same name should have blocked while
waiting for this module to finish loading or fail loading.

Sorry I could not be more immediately helpful here, I will have to
stare at the error report a bit more and chew through some possible
race scenarios and get back to you on this..

