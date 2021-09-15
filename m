Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9491240C469
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 13:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbhIOLf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 07:35:57 -0400
Received: from mga17.intel.com ([192.55.52.151]:17221 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232526AbhIOLfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 07:35:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10107"; a="202459706"
X-IronPort-AV: E=Sophos;i="5.85,295,1624345200"; 
   d="scan'208";a="202459706"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 04:34:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,295,1624345200"; 
   d="scan'208";a="544806413"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Sep 2021 04:34:36 -0700
Date:   Wed, 15 Sep 2021 04:34:10 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Marcus =?iso-8859-1?Q?R=FCckert?= <mrueckert@suse.com>
Subject: Re: [PATCH] x86/umip: Add a umip= cmdline switch
Message-ID: <20210915113410.GA7130@ranerica-svr.sc.intel.com>
References: <20210907200454.30458-1-bp@alien8.de>
 <20210911011459.GA11980@ranerica-svr.sc.intel.com>
 <YTx0+0pfyzHuX80L@zn.tnic>
 <20210913213836.GA10627@ranerica-svr.sc.intel.com>
 <YUDTCgEOZ3JOMSl7@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUDTCgEOZ3JOMSl7@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 06:51:22PM +0200, Borislav Petkov wrote:
> On Mon, Sep 13, 2021 at 02:38:36PM -0700, Ricardo Neri wrote:
> > That is right. Although, I am not sure programs you can have in
> > the same machine that also want to use UMIP-protected instructions.
> 
> Sure, another game. :-P
> 
> But srsly, looking at those two:
> 
>         umip_pr_warn(regs, "%s instruction cannot be used by applications.\n",
>                         umip_insns[umip_inst]);
> 
>         umip_pr_warn(regs, "For now, expensive software emulation returns the result.\n");
> 
> Why are they there at all?
> 
> I mean, I can hardly imagine userspace doing anything about them.

The goal at the time was encourage users to report bugs on the
applications and eventually have them fixed. It also meant to warn users
about degraded performance due to emulation. To my knowledge, no one has
reported the latter thus far.

> 
> They're all likely old, arcane applications or games run in wine which
> people have no access to the source code anyway so come to think of it,
> the once thing is starting to make more sense to me now.

Indeed, no one has reported "modern" application using these
instructions.

> 
> Sure, that:
> 
>         umip_pr_err(regs, "segfault in emulation. error%x\n",
>                     X86_PF_USER | X86_PF_WRITE);
> 
> should be issued unconditionally but I'm wondering if those warning
> messages are needed at all. And if not, I should probably simply rip
> them all out.
> 
> Or at least silence them by default and flip the cmdline switch logic to
> enable them for users who are interested in those things but they should
> be silent by defauilt.

Since after almost 4 years, performance degradation does not seem to be a
concern, I think it is sensible to remove the warnings.

> 
> I.e., you'd need to supply
> 
> 	umip=warnings_on
> 
> on the cmdline to actually see them.

They could also be salvaged by converting them to umiip_pr_debug(), just
to err on the cautious side without having to add a new command line
argument.

Thanks and BR,
Ricardo
