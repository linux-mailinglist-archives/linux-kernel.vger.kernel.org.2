Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01867357710
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 23:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbhDGVnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 17:43:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:49808 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233811AbhDGVnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 17:43:22 -0400
IronPort-SDR: 1dbBq+EmEzE409Fl0e/BS0n0reYvMOgXk6qREwm+36FDYp4pXEL9vOgtHAzi4RJCIISYCqExrn
 9DWJwyVrlGyQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="213801178"
X-IronPort-AV: E=Sophos;i="5.82,204,1613462400"; 
   d="scan'208";a="213801178"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 14:43:12 -0700
IronPort-SDR: QXjxlGXW0x+9VPgS+tegkonZbDPU2J2BJiJlpNhJ738dpvwQA4hc+Qp14IZ42BoOBbh9NQt5ii
 6zwasOPyz85g==
X-IronPort-AV: E=Sophos;i="5.82,204,1613462400"; 
   d="scan'208";a="421890534"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 14:43:11 -0700
Date:   Wed, 7 Apr 2021 14:43:10 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andy Lutomirski <luto@kernel.org>,
        Aili Yao <yaoaili@kingsoft.com>,
        HORIGUCHI =?utf-8?B?TkFPWUEoIOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
Subject: Re: [PATCH 3/4] mce/copyin: fix to not SIGBUS when copying from user
 hits poison
Message-ID: <20210407214310.GA479383@agluck-desk2.amr.corp.intel.com>
References: <20210326000235.370514-1-tony.luck@intel.com>
 <20210326000235.370514-4-tony.luck@intel.com>
 <20210407211816.GP25319@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407211816.GP25319@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 11:18:16PM +0200, Borislav Petkov wrote:
> On Thu, Mar 25, 2021 at 05:02:34PM -0700, Tony Luck wrote:
> > Andy Lutomirski pointed out that sending SIGBUS to tasks that
> > hit poison in the kernel copying syscall parameters from user
> > address space is not the right semantic.
> 
> What does that mean exactly?

Andy said that a task could check a memory range for poison by
doing:

	ret = write(fd, buf, size);
	if (ret == size) {
		memory range is all good
	}

That doesn't work if the kernel sends a SIGBUS.

It doesn't seem a likely scenario ... but Andy is correct that
the above ought to work.

> 
> From looking at the code, that is this conditional:
> 
>         if (t == EX_HANDLER_UACCESS && regs && is_copy_from_user(regs)) {
>                 m->kflags |= MCE_IN_KERNEL_RECOV;
>                 m->kflags |= MCE_IN_KERNEL_COPYIN;
> 
> so what does the above have to do with syscall params?

Most "copy from user" instances are the result of a system call parameter
(e.g. "buf" in the write(2) example above).

> If it is about us being in ring 0 and touching user memory and eating
> poison in same *user* memory while doing so, then sure, that makes
> sense.

Yes. This is for kernel reading memory belongng to "current" task.

> > So stop doing that. Add a new kill_me_never() call back that
> > simply unmaps and offlines the poison page.
> 
> Right, that's the same as handling poisoned user memory.

Same in that the page gets unmapped. Different in that there
is no SIGBUS if the kernel did the access for the user.

-Tony
