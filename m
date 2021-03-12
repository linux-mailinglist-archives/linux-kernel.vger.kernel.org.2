Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56478338C74
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 13:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhCLMNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 07:13:13 -0500
Received: from mga09.intel.com ([134.134.136.24]:52245 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229587AbhCLMNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 07:13:11 -0500
IronPort-SDR: YzncO2AwEKjUgHlSL0Iy3bmPrDU17xD6MZYkdTiwZFNFwqm1/BFVt8Nb7fiofZy0HPFMt69RlR
 V+6NAlCuJlkA==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="188918695"
X-IronPort-AV: E=Sophos;i="5.81,243,1610438400"; 
   d="scan'208";a="188918695"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 04:13:10 -0800
IronPort-SDR: PUAPyjI0CW2jFqvzuEi+V2XS2XIQ2ixL78nyHUr6/gs8JoBU7OCTrO/NwVE9gLSHPh9+PmINry
 AZrDP3ua7MoA==
X-IronPort-AV: E=Sophos;i="5.81,243,1610438400"; 
   d="scan'208";a="404398155"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.158.173])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 04:13:08 -0800
Date:   Fri, 12 Mar 2021 20:17:17 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     bas@basnieuwenhuizen.nl, erwanaliasr1@gmail.com, owen.si@ucloud.cn,
        youling257 <youling257@gmail.com>, lenb@kernel.org,
        rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        Len Brown <len.brown@intel.com>
Subject: Re: [3/3,v3] tools/power turbostat: Enable accumulate RAPL display
Message-ID: <20210312121717.GA20019@chenyu-desktop>
References: <1f6d32e14f121a8ccf8807b8343597c3ae88c7d2.1587196252.git.yu.c.chen@intel.com>
 <20210308134957.23852-1-youling257@gmail.com>
 <CAAYoRsXec2eq=t-pSn5TOqNt0G6kfZCKkDuEhCnX5SgL0zgkBg@mail.gmail.com>
 <20210308161548.GA37664@chenyu-desktop>
 <CAAYoRsVkrHberSgM42dqYjdVwz8vumURJ1_DGeV1R5-=LMdjVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAYoRsVkrHberSgM42dqYjdVwz8vumURJ1_DGeV1R5-=LMdjVA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 04:03:31PM -0800, Doug Smythies wrote:
> Hi Yu,
> 
> I am just resending your e-mail, adjusting the "To:" list to
> include the 3 others that have submitted similar patches.
>
Thanks for adding the authors. I'll combine their patch with their credits and
send to Len for pulling.

thanks,
Chenyu 
> ... Doug
> 
> On Mon, Mar 8, 2021 at 8:11 AM Chen Yu <yu.c.chen@intel.com> wrote:
> >
> > Hi,
> > On Mon, Mar 08, 2021 at 07:37:07AM -0800, Doug Smythies wrote:
> > > On Mon, Mar 8, 2021 at 5:50 AM youling257 <youling257@gmail.com> wrote:
> > > >
> > > > this cause turbostat not work on amd cpu.
> > > >
> > > > root@localhost:~# /turbostat
> > > > turbostat version 20.09.30 - Len Brown <lenb@kernel.org>
> > > > CPUID(0): AuthenticAMD 0xd CPUID levels; 0x8000001f xlevels; family:model:stepping 0x17:18:1 (23:24:1)
> > >
> > > There are already two fixes for this in the queue.
> > > https://marc.info/?l=linux-pm&m=161382097503925&w=2
> > > https://marc.info/?l=linux-pm&m=161141701219263&w=2
> > Thanks for reporting and pointing this out. I assume these two patches are both fixing the
> > same issue? It looks like these two patches should be merged into one:
> > 1. Bingsong's patch access MSR_PKG_ENERGY_STAT only when RAPL_AMD_F17H is set,
> >    which is consistent with the original context.
> > 2. Bas Nieuwenhuizen's patch also fixes the issue in idx_valid()
> >    in case RAPL_PKG was not set but with RAPL_AMD_F17H set.
> >
> > thanks,
> > Chenyu
