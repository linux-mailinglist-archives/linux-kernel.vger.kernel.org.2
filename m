Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87653331310
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 17:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhCHQMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 11:12:19 -0500
Received: from mga11.intel.com ([192.55.52.93]:49959 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229737AbhCHQML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 11:12:11 -0500
IronPort-SDR: spigiwSSOnak251+RgI1AC3vegnV1fDSh+j/VHWcrCgIRn8+gJfX+ufHWGYVzLvSiJsJECXis3
 dah4wzs7iX7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="184694040"
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="184694040"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 08:11:46 -0800
IronPort-SDR: dBobVGOy4zQldOCGM+K1gTE9D4K5BZ7gDOmu8jL0SZY+SaeN0KHAuTU8p+ZNkEqSeV0CKiLPM6
 88zP1K3w7Kgg==
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="447180097"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.158.173])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 08:11:43 -0800
Date:   Tue, 9 Mar 2021 00:15:48 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Doug Smythies <dsmythies@telus.net>,
        youling257 <youling257@gmail.com>
Cc:     youling257 <youling257@gmail.com>, lenb@kernel.org,
        rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        Len Brown <len.brown@intel.com>, Chen Yu <yu.c.chen@intel.com>
Subject: Re: [3/3,v3] tools/power turbostat: Enable accumulate RAPL display
Message-ID: <20210308161548.GA37664@chenyu-desktop>
References: <1f6d32e14f121a8ccf8807b8343597c3ae88c7d2.1587196252.git.yu.c.chen@intel.com>
 <20210308134957.23852-1-youling257@gmail.com>
 <CAAYoRsXec2eq=t-pSn5TOqNt0G6kfZCKkDuEhCnX5SgL0zgkBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAYoRsXec2eq=t-pSn5TOqNt0G6kfZCKkDuEhCnX5SgL0zgkBg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Mon, Mar 08, 2021 at 07:37:07AM -0800, Doug Smythies wrote:
> On Mon, Mar 8, 2021 at 5:50 AM youling257 <youling257@gmail.com> wrote:
> >
> > this cause turbostat not work on amd cpu.
> >
> > root@localhost:~# /turbostat
> > turbostat version 20.09.30 - Len Brown <lenb@kernel.org>
> > CPUID(0): AuthenticAMD 0xd CPUID levels; 0x8000001f xlevels; family:model:stepping 0x17:18:1 (23:24:1)
> 
> There are already two fixes for this in the queue.
> https://marc.info/?l=linux-pm&m=161382097503925&w=2
> https://marc.info/?l=linux-pm&m=161141701219263&w=2
Thanks for reporting and pointing this out. I assume these two patches are both fixing the
same issue? It looks like these two patches should be merged into one:
1. Bingsong's patch access MSR_PKG_ENERGY_STAT only when RAPL_AMD_F17H is set,
   which is consistent with the original context.
2. Bas Nieuwenhuizen's patch also fixes the issue in idx_valid()
   in case RAPL_PKG was not set but with RAPL_AMD_F17H set.

thanks,
Chenyu
