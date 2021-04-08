Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76850358AE5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbhDHRJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:09:16 -0400
Received: from mga07.intel.com ([134.134.136.100]:20620 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232579AbhDHRJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:09:06 -0400
IronPort-SDR: UBjTY6qx9UU6usr+2YBCXlCA7kFYDPvWXWIkIpde9aBbmqcLh5AjFzq34YuYu2/OLiYn7nxmvu
 QqmIKMiRm5Jw==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="257571312"
X-IronPort-AV: E=Sophos;i="5.82,207,1613462400"; 
   d="scan'208";a="257571312"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 10:08:54 -0700
IronPort-SDR: tz+LG+piYZ1QaV9ddjqjj8a3FQgheeVJjVlGqyXxg50zJQ3UPcrbXJe4C05WlP57y1XzAB1QF7
 JnoiSDiaZDlw==
X-IronPort-AV: E=Sophos;i="5.82,207,1613462400"; 
   d="scan'208";a="422335435"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 10:08:53 -0700
Date:   Thu, 8 Apr 2021 10:08:52 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andy Lutomirski <luto@kernel.org>,
        Aili Yao <yaoaili@kingsoft.com>,
        HORIGUCHI =?utf-8?B?TkFPWUEoIOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
Subject: Re: [PATCH 3/4] mce/copyin: fix to not SIGBUS when copying from user
 hits poison
Message-ID: <20210408170852.GA485019@agluck-desk2.amr.corp.intel.com>
References: <20210326000235.370514-1-tony.luck@intel.com>
 <20210326000235.370514-4-tony.luck@intel.com>
 <20210407211816.GP25319@zn.tnic>
 <20210407214310.GA479383@agluck-desk2.amr.corp.intel.com>
 <20210408084958.GC10192@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408084958.GC10192@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 10:49:58AM +0200, Borislav Petkov wrote:
> On Wed, Apr 07, 2021 at 02:43:10PM -0700, Luck, Tony wrote:
> > On Wed, Apr 07, 2021 at 11:18:16PM +0200, Borislav Petkov wrote:
> > > On Thu, Mar 25, 2021 at 05:02:34PM -0700, Tony Luck wrote:
> > > > Andy Lutomirski pointed out that sending SIGBUS to tasks that
> > > > hit poison in the kernel copying syscall parameters from user
> > > > address space is not the right semantic.
> > > 
> > > What does that mean exactly?
> > 
> > Andy said that a task could check a memory range for poison by
> > doing:
> > 
> > 	ret = write(fd, buf, size);
> > 	if (ret == size) {
> > 		memory range is all good
> > 	}
> > 
> > That doesn't work if the kernel sends a SIGBUS.
> > 
> > It doesn't seem a likely scenario ... but Andy is correct that
> > the above ought to work.
> 
> We need to document properly what this is aiming to fix. He said
> something yesterday along the lines of kthread_use_mm() hitting a SIGBUS
> when a kthread "attaches" to an address space. I'm still unclear as to
> how exactly that happens - there are only a handful of kthread_use_mm()
> users in the tree...

Also not clear to me either ... but sending a SIGBUS to a kthread isn't
going to do anything useful. So avoiding doing that is another worthy
goal.

> > Yes. This is for kernel reading memory belongng to "current" task.
> 
> Provided "current" is really the task to which the poison page belongs.
> That kthread_use_mm() thing sounded like the wrong task gets killed. But that
> needs more details.

With these patches nothing gets killed when kernel touches user poison.
If this is in a regular system call then these patches will return EFAULT
to the user (but now that I see EHWPOISON exists that looks like a better
choice - so applications can distinguish the "I just used an invalid address in
a parameter to a syscall" from "This isn't my fault, the memory broke".

> > Same in that the page gets unmapped. Different in that there
> > is no SIGBUS if the kernel did the access for the user.
> 
> What is even the actual use case with sending tasks SIGBUS on poison
> consumption? KVM? Others?

KVM apparently passes a machine check into the guest. Though it seems
to be misisng the MCG_STATUS information to tell the guest whether this
is an "Action Required" machine check, or an "Action Optional" (i.e.
whether the poison was found synchonously by execution of the current
instruction, or asynchronously).

> Are we documenting somewhere: "if your process gets a SIGBUS and this
> and that, which means your page got offlined, you should do this and
> that to recover"?

There is the ancient Documentation/vm/hwpoison.rst from 2009 ... nothing
seems wrong in that, but could use some updates.  I don't know how much
detail we might want to go into on recovery stratgies for applications.
In terms of production s/w there was one ISV who prototyped recovery
for their application but last time I checked didn't enable it in the
production version.

Essentially it boils down to:
SIGBUS handler gets additional data giving virtual address that has gone away

1) Can the application replace the lost page?
	Use mmap(addr, MAP_FIXED, ...) to map a fresh page into the gap
	and fill with replacement data. This case can return from SIGBUS
	handler to re-execute failed instruction
2) Can the application continue in degraded mode w/o the lost page?
	Hunt down pointers to lost page and update structures to say
	"this data lost". Use siglongjmp() to go to preset recovery path
3) Can the application shut down gracefully?
	Record details of the lost page. Inform next-of-kin. Exit.
4) Default - just exit

-Tony
