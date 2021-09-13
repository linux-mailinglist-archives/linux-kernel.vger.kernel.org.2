Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34EE3409F4E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 23:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346639AbhIMVks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 17:40:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:30216 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346827AbhIMVki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 17:40:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="244130580"
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="244130580"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 14:39:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="650510625"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 13 Sep 2021 14:39:00 -0700
Date:   Mon, 13 Sep 2021 14:38:36 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Marcus =?iso-8859-1?Q?R=FCckert?= <mrueckert@suse.com>
Subject: Re: [PATCH] x86/umip: Add a umip= cmdline switch
Message-ID: <20210913213836.GA10627@ranerica-svr.sc.intel.com>
References: <20210907200454.30458-1-bp@alien8.de>
 <20210911011459.GA11980@ranerica-svr.sc.intel.com>
 <YTx0+0pfyzHuX80L@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTx0+0pfyzHuX80L@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2021 at 11:20:59AM +0200, Borislav Petkov wrote:
> On Fri, Sep 10, 2021 at 06:14:59PM -0700, Ricardo Neri wrote:
> > If it is printing the same information again and again, wouldn't it be
> > simpler to have a umip_pr_warn_once()?
> 
> If you do a once thing, you're blocking any other programs from warning,
> output you probably wanna see.

That is right. Although, I am not sure programs you can have in
the same machine that also want to use UMIP-protected instructions.
> 
> With the command line switch you do the same but you're at least pushing
> the user to become active and do it first. I.e., with enabling that
> option, the user basically says that she/he is not interested in any of
> that output and that is ok.
> 
> The optimal thing would be to ratelimit it per process but that would be
> an overkill and not really needed.

Indeed.

Thanks and BR,
Ricardo
